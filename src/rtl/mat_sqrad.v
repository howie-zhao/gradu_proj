// zi = abs(ai-bi)*abs(ai-bi)
module mat_sqrad(
    input   wire            clk,
    input   wire            nrst,
    input   wire            en,
    input   wire    [ 7:0]  a0,
    input   wire    [ 7:0]  a1,
    input   wire    [ 7:0]  a2,
    input   wire    [ 7:0]  a3,
    input   wire    [ 7:0]  b0,
    input   wire    [ 7:0]  b1,
    input   wire    [ 7:0]  b2,
    input   wire    [ 7:0]  b3,
    output  reg             en_sqr,
    output  wire            sqr_valid,
    output  wire    [15:0]  z0,
    output  wire    [15:0]  z1,
    output  wire    [15:0]  z2,
    output  wire    [15:0]  z3
  );
//************************************************************************//
    reg             en_sqr_d;

//************************************************************************//
    always @(posedge clk or negedge nrst) begin
        if(!nrst) begin
            en_sqr <= 1'b0;
            en_sqr_d <= 1'b0;
            //sqr_valid <= 0;
        end
        else begin
            en_sqr <= en;
            en_sqr_d <= en_sqr;
            //sqr_valid <= en_sqr & (!en_sqr_d);
        end
    end

    assign sqr_valid = en_sqr_d;

    sqr_abs_sub U0_sqr_abs_sub (
        .clk  ( clk ),
        .nrst ( nrst ),
        .en   ( en ),
        .a    ( a0 ),
        .b    ( b0 ),
        .z    ( z0 )
    );

    sqr_abs_sub U1_sqr_abs_sub (
        .clk  ( clk ),
        .nrst ( nrst ),
        .en   ( en ),
        .a    ( a1 ),
        .b    ( b1 ),
        .z    ( z1 )
    );

    sqr_abs_sub U2_sqr_abs_sub (
        .clk  ( clk ),
        .nrst ( nrst ),
        .en   ( en ),
        .a    ( a2 ),
        .b    ( b2 ),
        .z    ( z2 )
    );

    sqr_abs_sub U3_sqr_abs_sub (
        .clk  ( clk ),
        .nrst ( nrst ),
        .en   ( en ),
        .a    ( a3 ),
        .b    ( b3 ),
        .z    ( z3 )
    );
endmodule
