module mem_output (
    input   wire            clk,
    input   wire            nrst,
    input   wire            block0_oe,
    input   wire [7:0]      block0_ce,
    input   wire [7:0]      blk0_rdata0,
    input   wire [7:0]      blk0_rdata1,
    input   wire [7:0]      blk0_rdata2,
    input   wire [7:0]      blk0_rdata3,
    input   wire [7:0]      blk0_rdata4,
    input   wire [7:0]      blk0_rdata5,
    input   wire [7:0]      blk0_rdata6,
    input   wire [7:0]      blk0_rdata7,
    input   wire [3:0]      padding_en,
    
    output  reg             ref_vld,
    output  wire [7:0]      ref0,
    output  wire [7:0]      ref1,
    output  wire [7:0]      ref2,
    output  wire [7:0]      ref3,

    output  reg             srh_vld,
    output  wire [7:0]      srh0,
    output  wire [7:0]      srh1,
    output  wire [7:0]      srh2,
    output  wire [7:0]      srh3,
    output  wire [7:0]      srh4,
    output  wire [7:0]      srh5,
    output  wire [7:0]      srh6,

    output  reg             pix_vld,
    output  wire [7:0]      pix0,
    output  wire [7:0]      pix1,
    output  wire [7:0]      pix2,
    output  wire [7:0]      pix3,

    output  reg             nsy_vld,
    output  wire [7:0]      nsy_pix
);
//************************************************************************//
    localparam IDLE   = 2'b00;
    localparam INIT   = 2'b01;
    localparam BLK_OE = 2'b10;
    localparam POST   = 2'b11;
//************************************************************************//
    reg     [7:0]   block0_ce_1d;
    reg     [7:0]   rdata [0:6];
    reg     [7:0]   vld_data [0:6];
    wire            block_oe;
    reg             block_oe_1d;
    wire            block_oe_pos;
    wire            block_oe_neg;
    reg     [ 1:0]  srh_state;
    reg     [ 1:0]  srh_nxtstate;
    reg     [ 1:0]  ref_state;
    reg     [ 1:0]  ref_nxtstate;
    reg     [ 1:0]  pix_state;
    reg     [ 1:0]  pix_nxtstate;
/*     reg     [ 3:0]  ref_cnt;
    reg     [ 9:0]  srh_cnt;
    reg     [ 5:0]  pix_cnt;
 */
    reg     [ 7:0]  srh_buf0 [0:6];
    reg     [ 7:0]  srh_buf1 [0:6];
    reg     [ 7:0]  srh_buf2 [0:6];

    reg     [11:0]  col_cnt;
    reg     [ 3:0]  cnt;
//************************************************************************//
// ram_rdata select
    always @(posedge clk or negedge nrst) begin
        if(!nrst) begin
            block0_ce_1d <= 12'b0;
        end
        else begin
            block0_ce_1d <= block0_ce;
        end
    end

    always @(*) begin
        case(block0_ce_1d)
            8'b1111_1110: begin
                rdata[0]  = blk0_rdata0;
                rdata[1]  = blk0_rdata1;
                rdata[2]  = blk0_rdata2;
                rdata[3]  = blk0_rdata3;
                rdata[4]  = blk0_rdata4;
                rdata[5]  = blk0_rdata5;
                rdata[6]  = blk0_rdata6;
            end
            8'b0111_1111: begin
                rdata[0]  = blk0_rdata1;
                rdata[1]  = blk0_rdata2;
                rdata[2]  = blk0_rdata3;
                rdata[3]  = blk0_rdata4;
                rdata[4]  = blk0_rdata5;
                rdata[5]  = blk0_rdata6;
                rdata[6]  = blk0_rdata7;
            end
            8'b1011_1111: begin
                rdata[0]  = blk0_rdata2;
                rdata[1]  = blk0_rdata3;
                rdata[2]  = blk0_rdata4;
                rdata[3]  = blk0_rdata5;
                rdata[4]  = blk0_rdata6;
                rdata[5]  = blk0_rdata7;
                rdata[6]  = blk0_rdata0;
            end
            8'b1101_1111: begin
                rdata[0]  = blk0_rdata3;
                rdata[1]  = blk0_rdata4;
                rdata[2]  = blk0_rdata5;
                rdata[3]  = blk0_rdata6;
                rdata[4]  = blk0_rdata7;
                rdata[5]  = blk0_rdata0;
                rdata[6]  = blk0_rdata1;
            end
            8'b1110_1111: begin
                rdata[0]  = blk0_rdata4;
                rdata[1]  = blk0_rdata5;
                rdata[2]  = blk0_rdata6;
                rdata[3]  = blk0_rdata7;
                rdata[4]  = blk0_rdata0;
                rdata[5]  = blk0_rdata1;
                rdata[6]  = blk0_rdata2;
            end
            8'b1111_0111: begin
                rdata[0]  = blk0_rdata5;
                rdata[1]  = blk0_rdata6;
                rdata[2]  = blk0_rdata7;
                rdata[3]  = blk0_rdata0;
                rdata[4]  = blk0_rdata1;
                rdata[5]  = blk0_rdata2;
                rdata[6]  = blk0_rdata3;
            end
            8'b1111_1011: begin
                rdata[0]  = blk0_rdata6;
                rdata[1]  = blk0_rdata7;
                rdata[2]  = blk0_rdata0;
                rdata[3]  = blk0_rdata1;
                rdata[4]  = blk0_rdata2;
                rdata[5]  = blk0_rdata3;
                rdata[6]  = blk0_rdata4;
            end
            8'b1111_1101: begin
                rdata[0]  = blk0_rdata7;
                rdata[1]  = blk0_rdata0;
                rdata[2]  = blk0_rdata1;
                rdata[3]  = blk0_rdata2;
                rdata[4]  = blk0_rdata3;
                rdata[5]  = blk0_rdata4;
                rdata[6]  = blk0_rdata5;
            end

            default: begin
                rdata[0]  = blk0_rdata0;
                rdata[1]  = blk0_rdata1;
                rdata[2]  = blk0_rdata2;
                rdata[3]  = blk0_rdata3;
                rdata[4]  = blk0_rdata4;
                rdata[5]  = blk0_rdata5;
                rdata[6]  = blk0_rdata6;
            end
        endcase
    end

    always @(*) begin
        vld_data[0] = padding_en[3]? 8'd128: rdata[0];
        vld_data[1] = padding_en[2]? 8'd128: rdata[1];
        vld_data[2] = rdata[2];
        vld_data[3] = rdata[3];
        vld_data[4] = rdata[4];
        vld_data[5] = padding_en[1]? 8'd128: rdata[5];
        vld_data[6] = padding_en[0]? 8'd128: rdata[6];
    end
//************************************************************************//
// oe edge
    assign block_oe = block0_oe;

    always @(posedge clk or negedge nrst) begin
        if(!nrst) begin
            block_oe_1d <= 1'b0;
        end
        else begin
            block_oe_1d <= block_oe;
        end
    end

    assign block_oe_pos = block_oe & (~block_oe_1d);
    assign block_oe_neg = (~block_oe) & block_oe_1d;
//************************************************************************//
// ref ctrl state
    always @(posedge clk or negedge nrst) begin
        if(!nrst) 
            cnt <= 4'b00_01;
        else if((ref_nxtstate == POST)|(srh_nxtstate == POST)|(pix_nxtstate == POST)) 
            cnt <= {cnt[2:0], cnt[3]};
        else 
            cnt <= 4'b00_01;
    end

    always @(posedge clk or negedge nrst) begin
        if(!nrst) 
            ref_state <= IDLE;
        else 
            ref_state <= ref_nxtstate;
    end

    always @(*) begin
        case(ref_state)
            IDLE: begin
                if(block_oe_pos) 
                    ref_nxtstate = INIT;
                else
                    ref_nxtstate = IDLE;
            end
            INIT: begin
                ref_nxtstate = BLK_OE;
            end
            BLK_OE: begin
                if(block_oe_neg) 
                    ref_nxtstate = POST;
                else 
                    ref_nxtstate = BLK_OE;
            end
            POST: begin
                //if(ref_cnt == 4'b0001) ref_nxtstate = IDLE;
                if(cnt == 4'b10_00) //TODO
                    ref_nxtstate = IDLE;
                else 
                    ref_nxtstate = POST;
            end
            default: 
                ref_nxtstate = IDLE;
        endcase
    end

    always @(posedge clk or negedge nrst) begin
        if(!nrst)
            ref_vld <= 1'b0;
        //else if(ref_nxtstate != IDLE) ref_vld <= 1'b1;
        //else if((srh_nxtstate != IDLE)&(cnt[0]|cnt[1]|cnt[2]|cnt[3])) //TODO
        else if((srh_nxtstate == INIT)|(srh_nxtstate == BLK_OE)) 
            ref_vld <= 1'b1;
        else 
            ref_vld <= 1'b0;
    end

    assign ref0 = srh_buf0[2] & {32{ref_vld}};    //ref_buf2[0];
    assign ref1 = srh_buf0[3] & {32{ref_vld}};    //ref_buf2[1];
    assign ref2 = srh_buf0[4] & {32{ref_vld}};    //ref_buf2[2];
    assign ref3 = srh_buf0[5] & {32{ref_vld}};    //ref_buf2[3];
//************************************************************************//
// srh ctrl state
    always @(posedge clk or negedge nrst) begin
        if(!nrst) 
            srh_state <= IDLE;
        else 
            srh_state <= srh_nxtstate;
    end

    always @(*) begin
        case(srh_state)
            IDLE: begin
                if(block_oe_pos) 
                    srh_nxtstate = INIT;
                else 
                    srh_nxtstate = IDLE;
            end
            INIT: begin
                srh_nxtstate = BLK_OE;
            end
            BLK_OE: begin
                if(block_oe_neg) 
                    srh_nxtstate = POST;
                else 
                    srh_nxtstate = BLK_OE;
            end
            POST: begin
             //if(srh_cnt == 10'b0000_0000_01) srh_nxtstate = IDLE;
            if(cnt == 4'b00_01) //TODO
                srh_nxtstate = IDLE;
            else
                srh_nxtstate = POST;
            end
            default: srh_nxtstate = IDLE;
        endcase
    end

    always @(posedge clk or negedge nrst) begin
        if(!nrst)
            srh_vld <= 1'b0;
        else if(srh_nxtstate != IDLE)
            srh_vld <= 1'b1;
        else 
            srh_vld <= 1'b0;
    end

    generate
        genvar j;
        for(j=0; j<7; j=j+1) begin: srh_buf_gen
            always @(posedge clk or negedge nrst) begin
                if(!nrst) begin
                    srh_buf0[j] <= 8'b0;
                    srh_buf1[j] <= 8'b0;
                    srh_buf2[j] <= 8'b0;
                end
                else if(srh_nxtstate == IDLE) begin
                    srh_buf0[j] <= 8'b0;
                    srh_buf1[j] <= 8'b0;
                    srh_buf2[j] <= 8'b0;
                end
                else if(srh_nxtstate == INIT) begin
                    srh_buf0[j] <= vld_data[j];
                    srh_buf1[j] <= vld_data[j];
                    srh_buf2[j] <= vld_data[j];
                end
                else if(srh_nxtstate == BLK_OE) begin
                    srh_buf0[j] <= vld_data[j];
                    srh_buf1[j] <= srh_buf0[j];
                    srh_buf2[j] <= srh_buf1[j];
                end
                else if(srh_nxtstate == POST) begin
                    srh_buf0[j] <= srh_buf0[j]; //TODO行尾扩展2列，1列即可
                    srh_buf1[j] <= srh_buf0[j];
                    srh_buf2[j] <= srh_buf1[j];
                end
            end
        end
    endgenerate

    assign srh0 = srh_buf2[0];
    assign srh1 = srh_buf2[1];
    assign srh2 = srh_buf2[2];
    assign srh3 = srh_buf2[3];
    assign srh4 = srh_buf2[4];
    assign srh5 = srh_buf2[5];
    assign srh6 = srh_buf2[6];

//************************************************************************//
// pix ctrl state
    always @(posedge clk or negedge nrst) begin
        if(!nrst)
            pix_state <= IDLE;
        else
            pix_state <= pix_nxtstate;
    end

    always @(*) begin
        case(pix_state)
            IDLE: begin
                if(block_oe_pos)
                    pix_nxtstate = INIT;
                else
                    pix_nxtstate = IDLE;
            end
            INIT: begin
                pix_nxtstate = BLK_OE;
            end
            BLK_OE: begin
                if(block_oe_neg)
                    pix_nxtstate = POST;
                else
                    pix_nxtstate = BLK_OE;
            end
            POST: begin
                //if(pix_cnt == 6'b000001) pix_nxtstate = IDLE;
                if(cnt == 4'b1_000) //TODO 3个状态机的运行是相同的？
                    pix_nxtstate = IDLE;
                else
                    pix_nxtstate = POST;
                end
            default: pix_nxtstate = IDLE;
        endcase
    end

    always @(posedge clk or negedge nrst) begin
        if(!nrst)
            pix_vld <= 1'b0;
        //else if(pix_nxtstate != IDLE) pix_vld <= 1'b1;
        else if((srh_nxtstate != IDLE) & (cnt[0]|cnt[1])) //TODO
            pix_vld <= 1'b1;
        else
            pix_vld <= 1'b0;
    end

    assign pix0 = srh_buf2[0] & {32{pix_vld}};  //pix_buf3[0];
    assign pix1 = srh_buf2[1] & {32{pix_vld}};  //pix_buf3[1];
    assign pix2 = srh_buf2[2] & {32{pix_vld}};  //pix_buf3[2];
    assign pix3 = srh_buf2[3] & {32{pix_vld}};  //pix_buf3[3];
//************************************************************************//
// noise pix ctrl state
    always @(posedge clk or negedge nrst) begin
        if(!nrst)
            nsy_vld <= 1'b0;
        else if((srh_nxtstate == INIT)|(srh_nxtstate == BLK_OE)) 
            nsy_vld <= 1'b1;
        else
            nsy_vld <= 1'b0;
    end
  
    assign nsy_pix = srh_buf0[2];

endmodule
