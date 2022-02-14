module mem_ctrl #(
    parameter IMG_COL = 1920,
    parameter IMG_ROW = 1080)
(
    input   wire                clk,
    input   wire                rst_n,
    input   wire                en,
    input   wire                de,
    input   wire                href,
    input   wire                vref,
    input   wire                hsync,  // not used,negate the signal 
    input   wire                vsync,  // not used,negate the signal
    input   wire                vsync_start,
    output  wire    [10:0]      block_addr, // 0-1919 (2047 max)
    output  reg                 block0_oe,
    output  wire    [7:0]       block0_ce,
    output  wire    [7:0]       block0_we,
    output  reg     [3:0]       padding_en  //TODO pre 2line + back 2line 
);
//************************************************************************//
// param
    localparam IDLE      = 4'b0000;
    localparam INIT      = 4'b0001;
    localparam I_ROW_DLY = 4'b0010;
    localparam FRONT     = 4'b0011;
    localparam F_ROW_DLY = 4'b0100;
    localparam NORMAL    = 4'b0101;
    localparam N_ROW_DLY = 4'b0110;
    localparam FRM_DLY   = 4'b0111;
    localparam POST      = 4'b1000;
    localparam P_ROW_DLY = 4'b1001;
    localparam V_START   = 4'b1010;
//************************************************************************//
// signals
    reg                 vsync_1d;
    reg                 hsync_1d;
    reg                 vref_1d;
    reg                 href_1d;
    wire                vsync_pos;
    wire                vsync_neg;
    wire                hsync_pos;
    wire                hsync_neg;
    wire                vref_pos;
    wire                vref_neg;
    wire                href_pos;
    wire                href_neg;
    reg     [3:0]       blk0_state;
    reg     [3:0]       blk0_nxtstate;
    reg     [3:0]       init_cnt;
    reg     [5:0]       padding_cnt;
    reg     [3:0]       front_cnt;
    reg     [3:0]       post_cnt;
    reg     [11:0]      col_cnt;
    reg     [11:0]      row_cnt;
    reg     [7:0]       we0_cnt;
    //reg     [7:0]      we0;
    reg     [7:0]       ce0;
    
    reg     [10:0]      normal_cnt;
//************************************************************************//
// sync edge
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            vsync_1d <= 1'b0;
            hsync_1d <= 1'b0;
            vref_1d <= 1'b0;
            href_1d <= 1'b0;
        end
        else begin
            vsync_1d <= vsync;
            hsync_1d <= hsync;
            vref_1d <= vref;
            href_1d <= href;
        end
    end

    assign vsync_pos = vsync & (~vsync_1d);
    assign vsync_neg = (~vsync) & vsync_1d;
    assign hsync_pos = hsync & (~hsync_1d);
    assign hsync_neg = (~hsync) & hsync_1d;
    assign vref_pos = vref & (~vref_1d);
    assign vref_neg = (~vref) & vref_1d;
    assign href_pos = href & (~href_1d);
    assign href_neg = (~href) & href_1d;
//************************************************************************//
// block ctrl
// main state
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) 
            blk0_state <= IDLE;
        else if(!en) 
            blk0_state <= IDLE;
        else 
            blk0_state <= blk0_nxtstate;
    end
// state change
    always @(*) begin
        case(blk0_state)
            IDLE: begin
                if(vref_pos&en) 
                    blk0_nxtstate = V_START;
                else 
                    blk0_nxtstate = IDLE;
            end
            V_START: begin
                if(href_pos) 
                    blk0_nxtstate = INIT;
                else 
                    blk0_nxtstate = V_START;
            end
            INIT: begin
                if(href_neg) 
                    blk0_nxtstate = I_ROW_DLY;
                else 
                    blk0_nxtstate = INIT;
            end
            I_ROW_DLY: begin
                if(href_pos) begin
                    if(init_cnt == 4'd4)    // mod: initial 5 line buffer
                        blk0_nxtstate = FRONT;
                    else 
                        blk0_nxtstate = INIT;
                end
                else 
                    blk0_nxtstate = I_ROW_DLY;
            end
            FRONT: begin
                if(href_neg) 
                    blk0_nxtstate = F_ROW_DLY;
                else
                    blk0_nxtstate = FRONT;
            end
            F_ROW_DLY: begin
                if(href_pos) begin
                    if(padding_cnt[5:3] == 0) //TODO
                        blk0_nxtstate = NORMAL;
                    else 
                        blk0_nxtstate = FRONT;
                end
                else 
                    blk0_nxtstate = F_ROW_DLY;
            end
            NORMAL: begin
                if(href_neg) 
                    blk0_nxtstate = N_ROW_DLY;
                else 
                    blk0_nxtstate = NORMAL;
            end
            N_ROW_DLY: begin
                if(vref_neg) 
                    blk0_nxtstate = P_ROW_DLY; //FRM_DLY;
                else if(href_pos)
                    blk0_nxtstate = NORMAL;
                else 
                    blk0_nxtstate = N_ROW_DLY;
            end
            FRM_DLY: begin  // not used
                if(!en) 
                    blk0_nxtstate = IDLE;
                else if(vsync_pos) 
                    blk0_nxtstate = POST;
                else 
                    blk0_nxtstate = FRM_DLY;
            end
            POST: begin
                if(href_neg) 
                    blk0_nxtstate = P_ROW_DLY;
                else 
                    blk0_nxtstate = POST;
            end
            P_ROW_DLY: begin
                if(href_pos) begin
                    if(padding_cnt[2:0] == 0) //TODO
                        blk0_nxtstate = IDLE;
                    else 
                        blk0_nxtstate = POST;
                end
                else 
                    blk0_nxtstate = P_ROW_DLY;
            end
            default: blk0_nxtstate = IDLE;
        endcase
    end
//************************************************************************//
// cnt ctrl
    always @(posedge clk or negedge rst_n) begin: init_cnt_ctrl
        if(!rst_n) 
            init_cnt <= 4'b0;
        else if(((blk0_state==I_ROW_DLY)&(blk0_nxtstate==INIT)))
            init_cnt <= init_cnt + 4'b1;
        else if((blk0_nxtstate==NORMAL))
            init_cnt <= 4'b0;
    end

    always @(posedge clk or negedge rst_n) begin: padding_cnt_ctrl
        if(!rst_n) 
            padding_cnt <= 6'b011_000;
        else if(blk0_nxtstate==IDLE) 
            padding_cnt <= 6'b011_000;
        else if(((blk0_state==FRONT) & (blk0_nxtstate==F_ROW_DLY))|
            ((blk0_state==POST) & (blk0_nxtstate==P_ROW_DLY)))
            padding_cnt <= {padding_cnt[4:0], padding_cnt[5]};
    end

    always @(posedge clk or negedge rst_n) begin: front_cnt_ctrl
        if(!rst_n) 
            front_cnt <= 4'b0;
        else if(((blk0_state==F_ROW_DLY)&(blk0_nxtstate==FRONT)))
            front_cnt <= front_cnt + 4'b1;
        else if((blk0_nxtstate==IDLE))
            front_cnt <= 4'b0;
    end

    always @(posedge clk or negedge rst_n) begin: post_cnt_ctrl
        if(!rst_n) 
            post_cnt <= 4'b0;
        else if(((blk0_state==P_ROW_DLY)&(blk0_nxtstate==POST)))
            post_cnt <= post_cnt + 4'b1;
        else if((blk0_nxtstate==IDLE))
            post_cnt <= 4'b0;
    end

    always @(posedge clk or negedge rst_n) begin: col_cnt_ctrl
        if(!rst_n) 
            col_cnt <= 12'b0;
        else if(((blk0_nxtstate == INIT)|(blk0_nxtstate == FRONT)|
             (blk0_nxtstate == NORMAL)|(blk0_nxtstate == POST)))
            if (col_cnt < IMG_COL - 1) begin
                col_cnt <= col_cnt + 12'b1;
            end
        else col_cnt <= 12'b0;
    end

  
    always @(posedge clk or negedge rst_n) begin: row_cnt_ctrl
        if(!rst_n) 
            row_cnt <= 12'b0;
        else if(blk0_nxtstate == FRM_DLY)
            row_cnt <= 12'b0;
        else if(((blk0_state == I_ROW_DLY)&(blk0_nxtstate == INIT))|
            ((blk0_state != NORMAL)&(blk0_nxtstate == NORMAL)))
            row_cnt <= row_cnt + 12'd1;
    end
  

    always @(posedge clk or negedge rst_n) begin: we0_cnt_ctrl
        if(!rst_n) 
            we0_cnt <= 8'b1000_0000;
        else if(blk0_nxtstate==IDLE)
            we0_cnt <= 8'b1000_0000;
        else if(((blk0_state==INIT)&(blk0_nxtstate==I_ROW_DLY))|
            ((blk0_state==FRONT)&(blk0_nxtstate==F_ROW_DLY))|
            ((blk0_state==NORMAL)&(blk0_nxtstate==N_ROW_DLY))|
            ((blk0_state==POST)&(blk0_nxtstate==P_ROW_DLY))) begin
            we0_cnt <= {we0_cnt[0], we0_cnt[7:1]};
        end
    end

//************************************************************************//
// padding en output
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            padding_en <= 4'b0000;
        else if(blk0_nxtstate==FRONT)
            padding_en <= {padding_cnt[4:3], 2'b0};
        else if(blk0_nxtstate==POST)
            padding_en <= {2'b0, ~padding_cnt[1:0]};
        else 
            padding_en <= 4'b0000;
    end

//************************************************************************//
// block en output
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) 
            block0_oe <= 1'b0;
        else if(((blk0_nxtstate==FRONT)|(blk0_nxtstate==NORMAL)|(blk0_nxtstate==POST)))
            block0_oe <= 1'b1;
        else 
            block0_oe <= 1'b0;
    end
//************************************************************************//
// we and ce output
    always @(*) begin
        if((blk0_nxtstate == FRONT)|(blk0_nxtstate == NORMAL)|(blk0_nxtstate == POST))
            ce0 = ~we0_cnt;   // reverse bits
        else
            ce0 = 8'b0;
    end

    assign block_addr = col_cnt;
    assign block0_we = vsync_start&de ? we0_cnt : 0; //we0;
    assign block0_ce = ce0;   // read enable?
//************************************************************************//
// test signals
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) 
            normal_cnt <= 11'b0;
        else if((blk0_state==NORMAL)&(blk0_nxtstate==N_ROW_DLY))
            normal_cnt <= normal_cnt + 11'b1;
        else if(blk0_state==P_ROW_DLY)
            normal_cnt <= 11'b0;
    end
endmodule
