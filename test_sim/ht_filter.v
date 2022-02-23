module ht_filter #(
    parameter  WIDTH0 = 13
)(
    input   wire                            clk,
    input   wire                            rst_n,

    input   wire            [WIDTH0-1:0]    hard_th,
    input   wire            [WIDTH0-1:0]    blk_i0,
    input   wire            [WIDTH0-1:0]    blk_i1,
    input   wire            [WIDTH0-1:0]    blk_i2,
    input   wire            [WIDTH0-1:0]    blk_i3,
    input   wire            [WIDTH0-1:0]    blk_i4,
    input   wire            [WIDTH0-1:0]    blk_i5,
    input   wire            [WIDTH0-1:0]    blk_i6,
    input   wire            [WIDTH0-1:0]    blk_i7,
    input   wire            [WIDTH0-1:0]    blk_i8,
    input   wire            [WIDTH0-1:0]    blk_i9,
    input   wire            [WIDTH0-1:0]    blk_i10,
    input   wire            [WIDTH0-1:0]    blk_i11,
    input   wire            [WIDTH0-1:0]    blk_i12,
    input   wire            [WIDTH0-1:0]    blk_i13,
    input   wire            [WIDTH0-1:0]    blk_i14,
    input   wire            [WIDTH0-1:0]    blk_i15,
    input   wire                            blk_ivalid,
    output  wire            [WIDTH0-1:0]    blk_o0,
    output  wire            [WIDTH0-1:0]    blk_o1,
    output  wire            [WIDTH0-1:0]    blk_o2,
    output  wire            [WIDTH0-1:0]    blk_o3,
    output  wire            [WIDTH0-1:0]    blk_o4,
    output  wire            [WIDTH0-1:0]    blk_o5,
    output  wire            [WIDTH0-1:0]    blk_o6,
    output  wire            [WIDTH0-1:0]    blk_o7,
    output  wire            [WIDTH0-1:0]    blk_o8,
    output  wire            [WIDTH0-1:0]    blk_o9,
    output  wire            [WIDTH0-1:0]    blk_o10,
    output  wire            [WIDTH0-1:0]    blk_o11,
    output  wire            [WIDTH0-1:0]    blk_o12,
    output  wire            [WIDTH0-1:0]    blk_o13,
    output  wire            [WIDTH0-1:0]    blk_o14,
    output  wire            [WIDTH0-1:0]    blk_o15,
    output  reg                             blk_ovalid
);
//************************************************************************//
//TODO add a pipeline stage?
    assign blk_o0 = (blk_o0 > hard_th) ? blk_o0 : 0;
    assign blk_o1 = (blk_o1 > hard_th) ? blk_o1 : 0;
    assign blk_o2 = (blk_o2 > hard_th) ? blk_o2 : 0;
    assign blk_o3 = (blk_o3 > hard_th) ? blk_o3 : 0;
    assign blk_o4 = (blk_o4 > hard_th) ? blk_o4 : 0;
    assign blk_o5 = (blk_o5 > hard_th) ? blk_o5 : 0;
    assign blk_o6 = (blk_o6 > hard_th) ? blk_o6 : 0;
    assign blk_o7 = (blk_o7 > hard_th) ? blk_o7 : 0;
    assign blk_o8 = (blk_o8 > hard_th) ? blk_o8 : 0;
    assign blk_o9 = (blk_o9 > hard_th) ? blk_o9 : 0;
    assign blk_o10 = (blk_o10 > hard_th) ? blk_o10 : 0;
    assign blk_o11 = (blk_o11 > hard_th) ? blk_o11 : 0;
    assign blk_o12 = (blk_o12 > hard_th) ? blk_o12 : 0;
    assign blk_o13 = (blk_o13 > hard_th) ? blk_o13 : 0;
    assign blk_o14 = (blk_o14 > hard_th) ? blk_o14 : 0;
    assign blk_o15 = (blk_o15 > hard_th) ? blk_o15 : 0;
    assign blk_ovalid = blk_ivalid;
//************************************************************************//

endmodule //ht_filter