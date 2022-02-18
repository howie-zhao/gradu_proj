module pe #(
    parameter offset = 2'd0    // 0~3
)(
    input   wire            clk,
    input   wire            rst_n,
    input   wire            en,
    //input   wire            ref_vld,
    input   wire    [7:0]   ref0,
    input   wire    [7:0]   ref1,
    input   wire    [7:0]   ref2,
    input   wire    [7:0]   ref3,
    //input   wire            srh_vld,
    input   wire    [7:0]   srh0,
    input   wire    [7:0]   srh1,
    input   wire    [7:0]   srh2,
    input   wire    [7:0]   srh3,
    input   wire    [7:0]   srh4,
    input   wire    [7:0]   srh5,
    input   wire    [7:0]   srh6,
    // hold_reg Outputs
    output  wire            en_o,
    output  wire    [7:0]   ref0_o,
    output  wire    [7:0]   ref1_o,
    output  wire    [7:0]   ref2_o,
    output  wire    [7:0]   ref3_o,

    output  wire    [7:0]   srh0_o,
    output  wire    [7:0]   srh1_o,
    output  wire    [7:0]   srh2_o,
    output  wire    [7:0]   srh3_o,
    output  wire    [7:0]   srh4_o,
    output  wire    [7:0]   srh5_o,
    output  wire    [7:0]   srh6_o,
    // ssd outputs to sort
    output  wire    [19:0]  ssd_o,
    output  wire            ssd_ovalid,
    output  wire    [31:0]  blk_col_o
);
//************************************************************************//
    wire    [7:0]   srh[6:0];
    // mat_sqrad Outputs
    wire            en_sqr;
    wire            sqr_valid;
    wire    [15:0]  z0;
    wire    [15:0]  z1;
    wire    [15:0]  z2;
    wire    [15:0]  z3;
//************************************************************************//
    assign srh[0] = srh0;
    assign srh[1] = srh1;
    assign srh[2] = srh2;
    assign srh[3] = srh3;
    assign srh[4] = srh4;
    assign srh[5] = srh5;
    assign srh[6] = srh6;
    // output column blk data to FIFO
    assign blk_col_o = {srh[offset+3], srh[offset+2], srh[offset+1], srh[offset+0]};
//************************************************************************//
// hold register, to next pe
    hold_reg u_hold_reg (
        .clk       (clk),
        .nrst      (rst_n),
        .en        (en),
        .ref0      (ref0),
        .ref1      (ref1),
        .ref2      (ref2),
        .ref3      (ref3),
        .srh0      (srh0),
        .srh1      (srh1),
        .srh2      (srh2),
        .srh3      (srh3),
        .srh4      (srh4),
        .srh5      (srh5),
        .srh6      (srh6),
        .en_o      (en_o),
        .ref0_o    (ref0_o),
        .ref1_o    (ref1_o),
        .ref2_o    (ref2_o),
        .ref3_o    (ref3_o),
        .srh0_o    (srh0_o),
        .srh1_o    (srh1_o),
        .srh2_o    (srh2_o),
        .srh3_o    (srh3_o),
        .srh4_o    (srh4_o),
        .srh5_o    (srh5_o),
        .srh6_o    (srh6_o)
    );
//************************************************************************//
// square difference
    mat_sqrad  u_mat_sqrad (
        .clk    ( clk   ),
        .nrst   ( rst_n ),
        .en     ( en    ),
        .a0     ( ref0  ),
        .a1     ( ref1  ),
        .a2     ( ref2  ),
        .a3     ( ref3  ),
        .b0     ( srh[offset+0] ),
        .b1     ( srh[offset+1] ),
        .b2     ( srh[offset+2] ),
        .b3     ( srh[offset+3] ),
        .sqr_valid (sqr_valid),
        .en_sqr ( en_sqr),  //not used
        .z0     ( z0    ),
        .z1     ( z1    ),
        .z2     ( z2    ),
        .z3     ( z3    )
    ); 
//************************************************************************//
// acc
    pe_ssd_acc u_pe_ssd_acc (
        .clk       (clk),
        .rst_n     (rst_n),
        //.en_sqr    (en_sqr),
        .sqr_valid (sqr_valid), // start accumulater
        .a0        (z0),
        .a1        (z1),
        .a2        (z2),
        .a3        (z3),
        .z         (ssd_o),
        .z_valid   (ssd_ovalid)
    );

endmodule //pe