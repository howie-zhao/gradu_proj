//************************************************************************//
module bm3d_top 
(
    input   wire            clk,
    input   wire            rst_n,
    input   wire            vsync,
    input   wire            href,
    input   wire            cmos_de,
    input   wire    [7:0]   data_in,// 8bit 

    output  wire            o_vsync,
    output  wire            o_href,
    output  wire    [7:0]   data_out
);
//************************************************************************//

endmodule //bm3d_top