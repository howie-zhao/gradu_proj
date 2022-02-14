//`timescale 1ns/1ps

module block_extraction
  #(
    parameter IMG_COL = 1920,
    parameter IMG_ROW = 1080
  )
  (
    clk,
    nrst,
    de,
    href,
    vref,
    hsync,
    vsync,
    data_in,
    ref_vld,
    ref0,
    ref1,
    ref2,
    ref3,
    ref4,
    srh_vld,
    srh0,
    srh1,
    srh2,
    srh3,
    srh4,
    srh5,
    srh6,
    srh7,
    srh8,
    srh9,
    srh10,
    pix_vld,
    pix0,
    pix1,
    pix2,
    pix3,
    pix4,
    pix5,
    pix6,
    nsy_vld,
    nsy_pix
  );

  input  wire       clk;
  input  wire       nrst;
  input  wire       de;
  input  wire       href;
  input  wire       vref;
  input  wire       hsync;
  input  wire       vsync;
  input  wire [7:0] data_in;
  output wire       ref_vld;
  output wire [7:0] ref0;
  output wire [7:0] ref1;
  output wire [7:0] ref2;
  output wire [7:0] ref3;
  output wire [7:0] ref4;
  output wire       srh_vld;
  output wire [7:0] srh0;
  output wire [7:0] srh1;
  output wire [7:0] srh2;
  output wire [7:0] srh3;
  output wire [7:0] srh4;
  output wire [7:0] srh5;
  output wire [7:0] srh6;
  output wire [7:0] srh7;
  output wire [7:0] srh8;
  output wire [7:0] srh9;
  output wire [7:0] srh10;
  output wire       pix_vld;
  output wire [7:0] pix0;
  output wire [7:0] pix1;
  output wire [7:0] pix2;
  output wire [7:0] pix3;
  output wire [7:0] pix4;
  output wire [7:0] pix5;
  output wire [7:0] pix6;
  output wire       nsy_vld;
  output wire [7:0] nsy_pix;

  wire [11:0] block_addr;
  wire        block0_oe;
  wire [11:0] block0_ce;
  wire [11:0] block0_we;
  wire        block1_oe;
  wire [11:0] block1_ce;
  wire [11:0] block1_we;
  wire [ 9:0] padding_en;

  wire [ 7:0] blk0_rdata0;
  wire [ 7:0] blk0_rdata1;
  wire [ 7:0] blk0_rdata2;
  wire [ 7:0] blk0_rdata3;
  wire [ 7:0] blk0_rdata4;
  wire [ 7:0] blk0_rdata5;
  wire [ 7:0] blk0_rdata6;
  wire [ 7:0] blk0_rdata7;
  wire [ 7:0] blk0_rdata8;
  wire [ 7:0] blk0_rdata9;
  wire [ 7:0] blk0_rdata10;
  wire [ 7:0] blk0_rdata11;

  wire [ 7:0] blk1_rdata0;
  wire [ 7:0] blk1_rdata1;
  wire [ 7:0] blk1_rdata2;
  wire [ 7:0] blk1_rdata3;
  wire [ 7:0] blk1_rdata4;
  wire [ 7:0] blk1_rdata5;
  wire [ 7:0] blk1_rdata6;
  wire [ 7:0] blk1_rdata7;
  wire [ 7:0] blk1_rdata8;
  wire [ 7:0] blk1_rdata9;
  wire [ 7:0] blk1_rdata10;
  wire [ 7:0] blk1_rdata11;

  mem_ctrl #(
      .IMG_COL ( IMG_COL ),
      .IMG_ROW ( IMG_ROW )
    )
    U_mem_ctrl
    (
      .clk        ( clk ),
      .nrst       ( nrst ),
      .en         ( 1'b1 ),
      .de         ( de ),
      .href       ( href ),
      .vref       ( vref ),
      .hsync      ( hsync ),
      .vsync      ( vsync ),
      .block_addr ( block_addr ),
      .block0_oe  ( block0_oe ),
      .block0_ce  ( block0_ce ),
      .block0_we  ( block0_we ),
      .padding_en ( padding_en )
    );

  ram_block U0_block(
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
    .ram7_rdata  ( blk0_rdata7 ),
    .ram8_rdata  ( blk0_rdata8 ),
    .ram9_rdata  ( blk0_rdata9 ),
    .ram10_rdata ( blk0_rdata10 ),
    .ram11_rdata ( blk0_rdata11 )
  );
  /*
  ram_block U1_block(
    .clk         ( clk ),
    .ram_ce      ( block1_ce ),
    .ram_we      ( block1_we ),
    .ram_addr    ( block_addr ),
    .ram_wdata   ( data_in ),
    .ram0_rdata  ( blk1_rdata0 ),
    .ram1_rdata  ( blk1_rdata1 ),
    .ram2_rdata  ( blk1_rdata2 ),
    .ram3_rdata  ( blk1_rdata3 ),
    .ram4_rdata  ( blk1_rdata4 ),
    .ram5_rdata  ( blk1_rdata5 ),
    .ram6_rdata  ( blk1_rdata6 ),
    .ram7_rdata  ( blk1_rdata7 ),
    .ram8_rdata  ( blk1_rdata8 ),
    .ram9_rdata  ( blk1_rdata9 ),
    .ram10_rdata ( blk1_rdata10 ),
    .ram11_rdata ( blk1_rdata11 )
  );
  */
  mem_output #(
      .ref_half ( 2 ),
      .srh_half ( 3 )
    )
    U_mem_output(
      .clk          ( clk ),
      .nrst         ( nrst ),
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
      .blk0_rdata8  ( blk0_rdata8 ),
      .blk0_rdata9  ( blk0_rdata9 ),
      .blk0_rdata10 ( blk0_rdata10 ),
      .blk0_rdata11 ( blk0_rdata11 ),
      .padding_en   ( padding_en ),
      .ref_vld      ( ref_vld ),
      .ref0         ( ref0 ),
      .ref1         ( ref1 ),
      .ref2         ( ref2 ),
      .ref3         ( ref3 ),
      .ref4         ( ref4 ),
      .srh_vld      ( srh_vld ),
      .srh0         ( srh0 ),
      .srh1         ( srh1 ),
      .srh2         ( srh2 ),
      .srh3         ( srh3 ),
      .srh4         ( srh4 ),
      .srh5         ( srh5 ),
      .srh6         ( srh6 ),
      .srh7         ( srh7 ),
      .srh8         ( srh8 ),
      .srh9         ( srh9 ),
      .srh10        ( srh10 ),
      .pix_vld      ( pix_vld ),
      .pix0         ( pix0 ),
      .pix1         ( pix1 ),
      .pix2         ( pix2 ),
      .pix3         ( pix3 ),
      .pix4         ( pix4 ),
      .pix5         ( pix5 ),
      .pix6         ( pix6 ),
      .nsy_vld      ( nsy_vld ),
      .nsy_pix      ( nsy_pix )
    );

endmodule
