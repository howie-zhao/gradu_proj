`include "defines.v"
module blk_extract 
(
    input   wire            clk,
    input   wire            rst_n,
    input   wire            de,
    input   wire            vref,
    input   wire            href,
    input   wire            vsync,
    input   wire            hsync,
    input   wire    [7:0]   data_in,
    input   wire            vsync_start,
    //ref block size:4x4
    output  wire            ref_vld,
    output  wire    [7:0]   ref0,
    output  wire    [7:0]   ref1,
    output  wire    [7:0]   ref2,
    output  wire    [7:0]   ref3,
    //search window size:7x7
    output  wire            srh_vld,
    output  wire    [7:0]   srh0,
    output  wire    [7:0]   srh1,
    output  wire    [7:0]   srh2,
    output  wire    [7:0]   srh3,
    output  wire    [7:0]   srh4,
    output  wire    [7:0]   srh5,
    output  wire    [7:0]   srh6,
    //match block central pixel:4x4 = 16
/*     output wire           matchp_vld,
    output wire   [7:0]   matchp0,
    output wire   [7:0]   matchp1,
    output wire   [7:0]   matchp2,
    output wire   [7:0]   matchp3, */
    output  wire            pix_vld,
    output  wire    [7:0]   pix0,
    output  wire    [7:0]   pix1,
    output  wire    [7:0]   pix2,
    output  wire    [7:0]   pix3,
    // for method noise
    output  wire    [7:0]   noise_pix,
    output  wire            noise_vld
);
//************************************************************************//
    wire  [10:0]    block_addr;
    wire            block0_oe;
    wire  [7:0]     block0_ce;
    wire  [7:0]     block0_we;
    wire  [3:0]     padding_en;
//************************************************************************//
    wire  [7:0]     blk0_rdata0;
    wire  [7:0]     blk0_rdata1;
    wire  [7:0]     blk0_rdata2;
    wire  [7:0]     blk0_rdata3;
    wire  [7:0]     blk0_rdata4;
    wire  [7:0]     blk0_rdata5;
    wire  [7:0]     blk0_rdata6;
    wire  [7:0]     blk0_rdata7;
//************************************************************************//
    mem_ctrl #(
        .IMG_COL ( `IMG_COL ),
        .IMG_ROW ( `IMG_ROW )
    )
    u_mem_ctrl
    (
        .clk        ( clk ),
        .rst_n      ( rst_n ),
        .en         ( 1'b1 ),
        .de         ( de ),
        .href       ( href ),
        .vref       ( vref ),
        .hsync      ( hsync ),
        .vsync      ( vsync ),
        .vsync_start(vsync_start),
        .block_addr ( block_addr ),
        .block0_oe  ( block0_oe ),
        .block0_ce  ( block0_ce ),
        .block0_we  ( block0_we ),
        .padding_en ( padding_en )
    );

    ram_block u_block(
        .clk         ( clk ),
        .ram_ce      ( block0_ce ),
        .ram_we      ( block0_we ),
        .ram_addr    ( block_addr ),
        .ram_wdata   ( data_in ),
        .ram0_rdata  ( blk0_rdata0 ),
        .ram1_rdata  ( blk0_rdata1 ),
        .ram2_rdata  ( blk0_rdata2 ),
        .ram3_rdata  ( blk0_rdata3 ),
        .ram4_rdata  ( blk0_rdata4 ),
        .ram5_rdata  ( blk0_rdata5 ),
        .ram6_rdata  ( blk0_rdata6 ),
        .ram7_rdata  ( blk0_rdata7 )
    );

    mem_output u_mem_output(
        .clk          ( clk ),
        .nrst         ( rst_n ),
        .block0_oe    ( block0_oe ),
        .block0_ce    ( block0_ce),
        .blk0_rdata0  ( blk0_rdata0 ),
        .blk0_rdata1  ( blk0_rdata1 ),
        .blk0_rdata2  ( blk0_rdata2 ),
        .blk0_rdata3  ( blk0_rdata3 ),
        .blk0_rdata4  ( blk0_rdata4 ),
        .blk0_rdata5  ( blk0_rdata5 ),
        .blk0_rdata6  ( blk0_rdata6 ),
        .blk0_rdata7  ( blk0_rdata7 ),
        .padding_en   ( padding_en ),

        .ref_vld      ( ref_vld ),
        .ref0         ( ref0 ),
        .ref1         ( ref1 ),
        .ref2         ( ref2 ),
        .ref3         ( ref3 ),

        .srh_vld      ( srh_vld ),
        .srh0         ( srh0 ),
        .srh1         ( srh1 ),
        .srh2         ( srh2 ),
        .srh3         ( srh3 ),
        .srh4         ( srh4 ),
        .srh5         ( srh5 ),
        .srh6         ( srh6 ),

        .pix_vld      ( pix_vld ),
        .pix0         ( pix0 ),
        .pix1         ( pix1 ),
        .pix2         ( pix2 ),
        .pix3         ( pix3 ),

        .nsy_vld      ( noise_vld ),
        .nsy_pix      ( noise_pix )
    );
endmodule //blk_extract