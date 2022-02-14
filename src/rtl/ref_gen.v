module ref_gen (
    input   wire            clk,
    input   wire            rst_n,
    input   wire            vsync,
    input   wire            hsync,
    input   wire [11:0]     vref_p1,
    input   wire [11:0]     vref_p2,
    input   wire [11:0]     href_p1,
    input   wire [11:0]     href_p2,
    output  reg             vref,
    output  reg             href,
    output  reg             vsync_start
);
//************************************************************************//
    reg     [11:0]          hcnt;
    reg     [11:0]          vcnt;
    reg                     hsync_1d;
    wire                    hsync_pos;
    reg                     vsync_1d;
    wire                    vsync_pos;
    //reg                     vsync_start;
    //wire                    hsync_neg;
//************************************************************************//
// href ctrl
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) 
            hcnt <= 12'b0;
        else if(~hsync) 
            hcnt <= 12'b0;
        else if(vsync_start)    //start when first valid frame comes
            hcnt <= hcnt + 12'b1;
    end

    always @(posedge clk) begin
        href <= (hcnt > href_p1-2) & (hcnt < href_p2-1);
    end

//************************************************************************//
// vref ctrl
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            hsync_1d <= 1'b0;
            vsync_1d <= 1'b0;
        end
        else begin 
            hsync_1d <= hsync;
            vsync_1d <= vsync;
        end
    end

    assign hsync_pos = hsync & (~hsync_1d);
    assign vsync_pos = vsync & (~vsync_1d);
    //assign hsync_neg = (~hsync) & hsync_1d;

    //start when first valid frame comes
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) 
            vsync_start <= 1'b0;
        else if (vsync_pos) begin
            vsync_start <= 1'b1;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) 
            vcnt <= 12'b0;
        else if(~vsync) 
            vcnt <= 12'b0;
        else if(vsync & hsync_pos & vsync_start)
            vcnt <= vcnt + 12'b1;
    end

    always @(posedge clk) begin
        vref = (vcnt > vref_p1-1) & (vcnt < vref_p2);
    end

endmodule
