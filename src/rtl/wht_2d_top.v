module wht_2d_top (
    input  wire             clk,
    input  wire             rst_n,
    input  wire             blk_ovalid,
    input  wire    [31:0]   blk0_o,
    input  wire    [31:0]   blk1_o,
    input  wire    [31:0]   blk2_o,
    input  wire    [31:0]   blk3_o,
    input  wire    [31:0]   blk4_o,
    input  wire    [31:0]   blk5_o,
    input  wire    [31:0]   blk6_o,
    input  wire    [31:0]   blk7_o,
    input  wire    [31:0]   blk8_o,
    input  wire    [31:0]   blk9_o,
    input  wire    [31:0]   blk10_o,
    input  wire    [31:0]   blk11_o,
    input  wire    [31:0]   blk12_o,
    input  wire    [31:0]   blk13_o,
    input  wire    [31:0]   blk14_o,
    input  wire    [31:0]   blk15_o
);
//************************************************************************//
    wire    [31:0]      blk_i[15:0];
//************************************************************************//
    assign blk_i[0] = blk0_o;
    assign blk_i[1] = blk1_o;
    assign blk_i[2] = blk2_o;
    assign blk_i[3] = blk3_o;
    assign blk_i[4] = blk4_o;
    assign blk_i[5] = blk5_o;
    assign blk_i[6] = blk6_o;
    assign blk_i[7] = blk7_o;
    assign blk_i[8] = blk8_o;
    assign blk_i[9] = blk9_o;
    assign blk_i[10] = blk10_o;
    assign blk_i[11] = blk11_o;
    assign blk_i[12] = blk12_o;
    assign blk_i[13] = blk13_o;
    assign blk_i[14] = blk14_o;
    assign blk_i[15] = blk15_o;
//************************************************************************//
    generate
        genvar i;
        for (i=0; i<16; i=i+1) begin:gen_wht_2d_forward
            wht_2d #(
                .
            )u_wht_2d(
                .clk        (clk),
                .rst_n      (rst_n),
                .blk_i      (blk_i[i]),
                .blk_valid  (blk_ovalid)
            );
        end
    endgenerate
//************************************************************************//

endmodule //wht_2d_top