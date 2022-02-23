// input column by column
module wht_1d #(
    parameter  WIDTH0 = 13, // 1 signed bit + 12bit fixed integer
    //parameter  WIDTH1 = 11,// 1 signed bit + 10bit fixed integer
    parameter  WIDTH2 = 17 // 1 signed bit + 16bit fixed integer
)(
    input   wire                            clk,
    input   wire                            rst_n,
    input   wire            [WIDTH2-1:0]    hard_th,//TODO signed?
    input   wire    signed  [WIDTH0-1:0]    blk_i0,
    input   wire    signed  [WIDTH0-1:0]    blk_i1,
    input   wire    signed  [WIDTH0-1:0]    blk_i2,
    input   wire    signed  [WIDTH0-1:0]    blk_i3,
    input   wire    signed  [WIDTH0-1:0]    blk_i4,
    input   wire    signed  [WIDTH0-1:0]    blk_i5,
    input   wire    signed  [WIDTH0-1:0]    blk_i6,
    input   wire    signed  [WIDTH0-1:0]    blk_i7,
    input   wire    signed  [WIDTH0-1:0]    blk_i8,
    input   wire    signed  [WIDTH0-1:0]    blk_i9,
    input   wire    signed  [WIDTH0-1:0]    blk_i10,
    input   wire    signed  [WIDTH0-1:0]    blk_i11,
    input   wire    signed  [WIDTH0-1:0]    blk_i12,
    input   wire    signed  [WIDTH0-1:0]    blk_i13,
    input   wire    signed  [WIDTH0-1:0]    blk_i14,
    input   wire    signed  [WIDTH0-1:0]    blk_i15,
    input   wire                            blk_ivalid,
    output  wire            [WIDTH2-1:0]    blk_o0,
    output  wire            [WIDTH2-1:0]    blk_o1,
    output  wire            [WIDTH2-1:0]    blk_o2,
    output  wire            [WIDTH2-1:0]    blk_o3,
    output  wire            [WIDTH2-1:0]    blk_o4,
    output  wire            [WIDTH2-1:0]    blk_o5,
    output  wire            [WIDTH2-1:0]    blk_o6,
    output  wire            [WIDTH2-1:0]    blk_o7,
    output  wire            [WIDTH2-1:0]    blk_o8,
    output  wire            [WIDTH2-1:0]    blk_o9,
    output  wire            [WIDTH2-1:0]    blk_o10,
    output  wire            [WIDTH2-1:0]    blk_o11,
    output  wire            [WIDTH2-1:0]    blk_o12,
    output  wire            [WIDTH2-1:0]    blk_o13,
    output  wire            [WIDTH2-1:0]    blk_o14,
    output  wire            [WIDTH2-1:0]    blk_o15,
    output  reg                             blk_ovalid
);
//************************************************************************//
    //wire    signed  [WIDTH0-1:0]    pix[3:0];
    // 1st stage
    reg     signed          [WIDTH0  :0]    cal_pix00[15:0]; 
    reg     signed          [WIDTH0  :0]    cal_pix01[15:0]; 
    reg     signed          [WIDTH0  :0]    cal_pix02[15:0]; 
    reg     signed          [WIDTH0  :0]    cal_pix03[15:0]; 
    reg     signed          [WIDTH0  :0]    cal_pix04[15:0]; 
    reg     signed          [WIDTH0  :0]    cal_pix05[15:0]; 
    reg     signed          [WIDTH0  :0]    cal_pix06[15:0]; 
    reg     signed          [WIDTH0  :0]    cal_pix07[15:0];
    // 2nd stage
    reg     signed          [WIDTH0+1:0]    cal_pix10[15:0]; 
    reg     signed          [WIDTH0+1:0]    cal_pix11[15:0]; 
    reg     signed          [WIDTH0+1:0]    cal_pix12[15:0]; 
    reg     signed          [WIDTH0+1:0]    cal_pix13[15:0]; 
    // 3rd stage
    reg     signed          [WIDTH0+2:0]    cal_pix20[15:0]; 
    reg     signed          [WIDTH0+2:0]    cal_pix21[15:0];
    // 4th stage
    reg     signed          [WIDTH0+3:0]    cal_pix30[15:0]; 

    reg                                     blk_ivalid_s1;
    reg                                     blk_ivalid_s2;
    reg                                     blk_ivalid_s3;
//************************************************************************//
// 1 stage of 16 blk
    always @(posedge clk or negedge rst_n) begin:blk0
        if (!rst_n) begin
            cal_pix00[0] <= 0;
            cal_pix01[0] <= 0;
            cal_pix02[0] <= 0;
            cal_pix03[0] <= 0;
            cal_pix04[0] <= 0;
            cal_pix05[0] <= 0;
            cal_pix06[0] <= 0;
            cal_pix07[0] <= 0;
        end
        else if (blk_ivalid) begin
            cal_pix00[0] <= blk_i0 + blk_i1;
            cal_pix01[0] <= blk_i2 + blk_i3;
            cal_pix02[0] <= blk_i4 + blk_i5;
            cal_pix03[0] <= blk_i6 + blk_i7;
            cal_pix04[0] <= blk_i8 + blk_i9;
            cal_pix05[0] <= blk_i10 + blk_i11;
            cal_pix06[0] <= blk_i12 + blk_i13;
            cal_pix07[0] <= blk_i14 + blk_i15;
        end
    end
    always @(posedge clk or negedge rst_n) begin:blk1
        if (!rst_n) begin
            cal_pix00[1] <= 0;
            cal_pix01[1] <= 0;
            cal_pix02[1] <= 0;
            cal_pix03[1] <= 0;
            cal_pix04[1] <= 0;
            cal_pix05[1] <= 0;
            cal_pix06[1] <= 0;
            cal_pix07[1] <= 0;
        end
        else if (blk_ivalid) begin
            cal_pix00[1] <= blk_i0 + blk_i1;
            cal_pix01[1] <= blk_i2 + blk_i3;
            cal_pix02[1] <= blk_i4 + blk_i5;
            cal_pix03[1] <= blk_i6 + blk_i7;
            cal_pix04[1] <= (-blk_i8) + (-blk_i9);
            cal_pix05[1] <= (-blk_i10) + (-blk_i11);
            cal_pix06[1] <= (-blk_i12) + (-blk_i13);
            cal_pix07[1] <= (-blk_i14) + (-blk_i15);
        end
    end
    always @(posedge clk or negedge rst_n) begin:blk2
        if (!rst_n) begin
            cal_pix00[2] <= 0;
            cal_pix01[2] <= 0;
            cal_pix02[2] <= 0;
            cal_pix03[2] <= 0;
            cal_pix04[2] <= 0;
            cal_pix05[2] <= 0;
            cal_pix06[2] <= 0;
            cal_pix07[2] <= 0;
        end
        else if (blk_ivalid) begin
            cal_pix00[2] <= blk_i0 + blk_i1;
            cal_pix01[2] <= blk_i2 + blk_i3;
            cal_pix02[2] <= (-blk_i4) + (-blk_i5);
            cal_pix03[2] <= (-blk_i6) + (-blk_i7);
            cal_pix04[2] <= blk_i8 + blk_i9;
            cal_pix05[2] <= blk_i10 + blk_i11;
            cal_pix06[2] <= (-blk_i12) + (-blk_i13);
            cal_pix07[2] <= (-blk_i14) + (-blk_i15);
        end
    end
    always @(posedge clk or negedge rst_n) begin:blk3
        if (!rst_n) begin
            cal_pix00[3] <= 0;
            cal_pix01[3] <= 0;
            cal_pix02[3] <= 0;
            cal_pix03[3] <= 0;
            cal_pix04[3] <= 0;
            cal_pix05[3] <= 0;
            cal_pix06[3] <= 0;
            cal_pix07[3] <= 0;
        end
        else if (blk_ivalid) begin
            cal_pix00[3] <= blk_i0 + blk_i1;
            cal_pix01[3] <= blk_i2 + blk_i3;
            cal_pix02[3] <= (-blk_i4) + (-blk_i5);
            cal_pix03[3] <= (-blk_i6) + (-blk_i7);
            cal_pix04[3] <= (-blk_i8) + (-blk_i9);
            cal_pix05[3] <= (-blk_i10) + (-blk_i11);
            cal_pix06[3] <= blk_i12 + blk_i13;
            cal_pix07[3] <= blk_i14 + blk_i15;
        end
    end
    always @(posedge clk or negedge rst_n) begin:blk4
        if (!rst_n) begin
            cal_pix00[4] <= 0;
            cal_pix01[4] <= 0;
            cal_pix02[4] <= 0;
            cal_pix03[4] <= 0;
            cal_pix04[4] <= 0;
            cal_pix05[4] <= 0;
            cal_pix06[4] <= 0;
            cal_pix07[4] <= 0;
        end
        else if (blk_ivalid) begin
            cal_pix00[4] <= blk_i0 + blk_i1;
            cal_pix01[4] <= (-blk_i2) + (-blk_i3);
            cal_pix02[4] <= blk_i4 + blk_i5;
            cal_pix03[4] <= (-blk_i6) + (-blk_i7);
            cal_pix04[4] <= blk_i8 + blk_i9;
            cal_pix05[4] <= (-blk_i10) + (-blk_i11);
            cal_pix06[4] <= blk_i12 + blk_i13;
            cal_pix07[4] <= (-blk_i14) + (-blk_i15);
        end
    end
    always @(posedge clk or negedge rst_n) begin:blk5
        if (!rst_n) begin
            cal_pix00[5] <= 0;
            cal_pix01[5] <= 0;
            cal_pix02[5] <= 0;
            cal_pix03[5] <= 0;
            cal_pix04[5] <= 0;
            cal_pix05[5] <= 0;
            cal_pix06[5] <= 0;
            cal_pix07[5] <= 0;
        end
        else if (blk_ivalid) begin
            cal_pix00[5] <= blk_i0 + blk_i1;
            cal_pix01[5] <= (-blk_i2) + (-blk_i3);
            cal_pix02[5] <= blk_i4 + blk_i5;
            cal_pix03[5] <= (-blk_i6) + (-blk_i7);
            cal_pix04[5] <= (-blk_i8) + (-blk_i9);
            cal_pix05[5] <= blk_i10 + blk_i11;
            cal_pix06[5] <= (-blk_i12) + (-blk_i13);
            cal_pix07[5] <= blk_i14 + blk_i15;
        end
    end
    always @(posedge clk or negedge rst_n) begin:blk6
        if (!rst_n) begin
            cal_pix00[6] <= 0;
            cal_pix01[6] <= 0;
            cal_pix02[6] <= 0;
            cal_pix03[6] <= 0;
            cal_pix04[6] <= 0;
            cal_pix05[6] <= 0;
            cal_pix06[6] <= 0;
            cal_pix07[6] <= 0;
        end
        else if (blk_ivalid) begin
            cal_pix00[6] <= blk_i0 + blk_i1;
            cal_pix01[6] <= (-blk_i2) + (-blk_i3);
            cal_pix02[6] <= (-blk_i4) + (-blk_i5);
            cal_pix03[6] <= blk_i6 + blk_i7;
            cal_pix04[6] <= blk_i8 + blk_i9;
            cal_pix05[6] <= (-blk_i10) + (-blk_i11);
            cal_pix06[6] <= (-blk_i12) + (-blk_i13);
            cal_pix07[6] <= blk_i14 + blk_i15;
        end
    end
    always @(posedge clk or negedge rst_n) begin:blk7
        if (!rst_n) begin
            cal_pix00[7] <= 0;
            cal_pix01[7] <= 0;
            cal_pix02[7] <= 0;
            cal_pix03[7] <= 0;
            cal_pix04[7] <= 0;
            cal_pix05[7] <= 0;
            cal_pix06[7] <= 0;
            cal_pix07[7] <= 0;
        end
        else if (blk_ivalid) begin
            cal_pix00[7] <= blk_i0 + blk_i1;
            cal_pix01[7] <= (-blk_i2) + (-blk_i3);
            cal_pix02[7] <= (-blk_i4) + (-blk_i5);
            cal_pix03[7] <= blk_i6 + blk_i7;
            cal_pix04[7] <= (-blk_i8) + (-blk_i9);
            cal_pix05[7] <= blk_i10 + blk_i11;
            cal_pix06[7] <= blk_i12 + blk_i13;
            cal_pix07[7] <= (-blk_i14) + (-blk_i15);
        end
    end
    always @(posedge clk or negedge rst_n) begin:blk8
        if (!rst_n) begin
            cal_pix00[8] <= 0;
            cal_pix01[8] <= 0;
            cal_pix02[8] <= 0;
            cal_pix03[8] <= 0;
            cal_pix04[8] <= 0;
            cal_pix05[8] <= 0;
            cal_pix06[8] <= 0;
            cal_pix07[8] <= 0;
        end
        else if (blk_ivalid) begin
            cal_pix00[8] <= blk_i0 + (-blk_i1);
            cal_pix01[8] <= blk_i2 + (-blk_i3);
            cal_pix02[8] <= blk_i4 + (-blk_i5);
            cal_pix03[8] <= blk_i6 + (-blk_i7);
            cal_pix04[8] <= blk_i8 + (-blk_i9);
            cal_pix05[8] <= blk_i10 + (-blk_i11);
            cal_pix06[8] <= blk_i12 + (-blk_i13);
            cal_pix07[8] <= blk_i14 + (-blk_i15);
        end
    end
    always @(posedge clk or negedge rst_n) begin:blk9
        if (!rst_n) begin
            cal_pix00[9] <= 0;
            cal_pix01[9] <= 0;
            cal_pix02[9] <= 0;
            cal_pix03[9] <= 0;
            cal_pix04[9] <= 0;
            cal_pix05[9] <= 0;
            cal_pix06[9] <= 0;
            cal_pix07[9] <= 0;
        end
        else if (blk_ivalid) begin
            cal_pix00[9] <= blk_i0 + (-blk_i1);
            cal_pix01[9] <= blk_i2 + (-blk_i3);
            cal_pix02[9] <= blk_i4 + (-blk_i5);
            cal_pix03[9] <= blk_i6 + (-blk_i7);
            cal_pix04[9] <= (-blk_i8) + blk_i9;
            cal_pix05[9] <= (-blk_i10) + blk_i11;
            cal_pix06[9] <= (-blk_i12) + blk_i13;
            cal_pix07[9] <= (-blk_i14) + blk_i15;
        end
    end
    always @(posedge clk or negedge rst_n) begin:blk10
        if (!rst_n) begin
            cal_pix00[10] <= 0;
            cal_pix01[10] <= 0;
            cal_pix02[10] <= 0;
            cal_pix03[10] <= 0;
            cal_pix04[10] <= 0;
            cal_pix05[10] <= 0;
            cal_pix06[10] <= 0;
            cal_pix07[10] <= 0;
        end
        else if (blk_ivalid) begin
            cal_pix00[10] <= blk_i0 + (-blk_i1);
            cal_pix01[10] <= blk_i2 + (-blk_i3);
            cal_pix02[10] <= (-blk_i4) + blk_i5;
            cal_pix03[10] <= (-blk_i6) + blk_i7;
            cal_pix04[10] <= blk_i8 + (-blk_i9);
            cal_pix05[10] <= blk_i10 + (-blk_i11);
            cal_pix06[10] <= (-blk_i12) + blk_i13;
            cal_pix07[10] <= (-blk_i14) + blk_i15;
        end
    end
    always @(posedge clk or negedge rst_n) begin:blk11
        if (!rst_n) begin
            cal_pix00[11] <= 0;
            cal_pix01[11] <= 0;
            cal_pix02[11] <= 0;
            cal_pix03[11] <= 0;
            cal_pix04[11] <= 0;
            cal_pix05[11] <= 0;
            cal_pix06[11] <= 0;
            cal_pix07[11] <= 0;
        end
        else if (blk_ivalid) begin
            cal_pix00[11] <= blk_i0 + (-blk_i1);
            cal_pix01[11] <= blk_i2 + (-blk_i3);
            cal_pix02[11] <= (-blk_i4) + blk_i5;
            cal_pix03[11] <= (-blk_i6) + blk_i7;
            cal_pix04[11] <= (-blk_i8) + blk_i9;
            cal_pix05[11] <= (-blk_i10) + blk_i11;
            cal_pix06[11] <= blk_i12 + (-blk_i13);
            cal_pix07[11] <= blk_i14 + (-blk_i15);
        end
    end
    always @(posedge clk or negedge rst_n) begin:blk12
        if (!rst_n) begin
            cal_pix00[12] <= 0;
            cal_pix01[12] <= 0;
            cal_pix02[12] <= 0;
            cal_pix03[12] <= 0;
            cal_pix04[12] <= 0;
            cal_pix05[12] <= 0;
            cal_pix06[12] <= 0;
            cal_pix07[12] <= 0;
        end
        else if (blk_ivalid) begin
            cal_pix00[12] <= blk_i0 + (-blk_i1);
            cal_pix01[12] <= (-blk_i2) + blk_i3;
            cal_pix02[12] <= blk_i4 + (-blk_i5);
            cal_pix03[12] <= (-blk_i6) + blk_i7;
            cal_pix04[12] <= blk_i8 + (-blk_i9);
            cal_pix05[12] <= (-blk_i10) + blk_i11;
            cal_pix06[12] <= blk_i12 + (-blk_i13);
            cal_pix07[12] <= (-blk_i14) + blk_i15;
        end
    end
    always @(posedge clk or negedge rst_n) begin:blk13
        if (!rst_n) begin
            cal_pix00[13] <= 0;
            cal_pix01[13] <= 0;
            cal_pix02[13] <= 0;
            cal_pix03[13] <= 0;
            cal_pix04[13] <= 0;
            cal_pix05[13] <= 0;
            cal_pix06[13] <= 0;
            cal_pix07[13] <= 0;
        end
        else if (blk_ivalid) begin
            cal_pix00[13] <= blk_i0 + (-blk_i1);
            cal_pix01[13] <= (-blk_i2) + blk_i3;
            cal_pix02[13] <= blk_i4 + (-blk_i5);
            cal_pix03[13] <= (-blk_i6) + blk_i7;
            cal_pix04[13] <= (-blk_i8) + blk_i9;
            cal_pix05[13] <= blk_i10 + (-blk_i11);
            cal_pix06[13] <= (-blk_i12) + blk_i13;
            cal_pix07[13] <= blk_i14 + (-blk_i15);
        end
    end
    always @(posedge clk or negedge rst_n) begin:blk14
        if (!rst_n) begin
            cal_pix00[14] <= 0;
            cal_pix01[14] <= 0;
            cal_pix02[14] <= 0;
            cal_pix03[14] <= 0;
            cal_pix04[14] <= 0;
            cal_pix05[14] <= 0;
            cal_pix06[14] <= 0;
            cal_pix07[14] <= 0;
        end
        else if (blk_ivalid) begin
            cal_pix00[14] <= blk_i0 + (-blk_i1);
            cal_pix01[14] <= (-blk_i2) + blk_i3;
            cal_pix02[14] <= (-blk_i4) + blk_i5;
            cal_pix03[14] <= blk_i6 + (-blk_i7);
            cal_pix04[14] <= blk_i8 + (-blk_i9);
            cal_pix05[14] <= (-blk_i10) + blk_i11;
            cal_pix06[14] <= (-blk_i12) + blk_i13;
            cal_pix07[14] <= blk_i14 + (-blk_i15);
        end
    end
    always @(posedge clk or negedge rst_n) begin:blk15
        if (!rst_n) begin
            cal_pix00[15] <= 0;
            cal_pix01[15] <= 0;
            cal_pix02[15] <= 0;
            cal_pix03[15] <= 0;
            cal_pix04[15] <= 0;
            cal_pix05[15] <= 0;
            cal_pix06[15] <= 0;
            cal_pix07[15] <= 0;
        end
        else if (blk_ivalid) begin
            cal_pix00[15] <= blk_i0 + (-blk_i1);
            cal_pix01[15] <= (-blk_i2) + blk_i3;
            cal_pix02[15] <= (-blk_i4) + blk_i5;
            cal_pix03[15] <= blk_i6 + (-blk_i7);
            cal_pix04[15] <= (-blk_i8) + blk_i9;
            cal_pix05[15] <= blk_i10 + (-blk_i11);
            cal_pix06[15] <= blk_i12 + (-blk_i13);
            cal_pix07[15] <= (-blk_i14) + blk_i15;
        end
    end
//************************************************************************//
// 2-3-4 stage
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            blk_ivalid_s1 <= 0;
            blk_ivalid_s2 <= 0;
            blk_ivalid_s3 <= 0;
        end
        else begin
            blk_ivalid_s1 <= blk_ivalid;
            blk_ivalid_s2 <= blk_ivalid_s1;
            blk_ivalid_s3 <= blk_ivalid_s2;
        end
    end

    generate
        genvar i;
        for (i=0; i<16; i=i+1) begin:gen_calpix
            always @(posedge clk or negedge rst_n) begin
                if (!rst_n) begin
                    cal_pix10[i] <= 0;
                    cal_pix11[i] <= 0;
                    cal_pix12[i] <= 0;
                    cal_pix13[i] <= 0;
                end
                else if (blk_ivalid_s1) begin
                    cal_pix10[i] <= cal_pix00[i] + cal_pix01[i];
                    cal_pix11[i] <= cal_pix02[i] + cal_pix03[i];
                    cal_pix12[i] <= cal_pix04[i] + cal_pix05[i];
                    cal_pix13[i] <= cal_pix06[i] + cal_pix07[i];
                end
            end

            always @(posedge clk or negedge rst_n) begin
                if (!rst_n) begin
                    cal_pix20[i] <= 0;
                    cal_pix21[i] <= 0;
                end
                else if (blk_ivalid_s2) begin
                    cal_pix20[i] <= cal_pix10[i] + cal_pix11[i];
                    cal_pix21[i] <= cal_pix12[i] + cal_pix13[i];
                end
            end

            always @(posedge clk or negedge rst_n) begin
                if (!rst_n) begin
                    cal_pix30[i] <= 0;
                end
                else if (blk_ivalid_s3) begin
                    cal_pix30[i] <= cal_pix20[i] + cal_pix21[i];
                end
            end
        end
    endgenerate
//************************************************************************//
// output stage
//TODO add a pipeline stage?
//signed comp? unsigned
    assign blk_o0 = (cal_pix30[0] > hard_th) ? cal_pix30[0] : 0;
    assign blk_o1 = (cal_pix30[1] > hard_th) ? cal_pix30[1] : 0;
    assign blk_o2 = (cal_pix30[2] > hard_th) ? cal_pix30[2] : 0;
    assign blk_o3 = (cal_pix30[3] > hard_th) ? cal_pix30[3] : 0;
    assign blk_o4 = (cal_pix30[4] > hard_th) ? cal_pix30[4] : 0;
    assign blk_o5 = (cal_pix30[5] > hard_th) ? cal_pix30[5] : 0;
    assign blk_o6 = (cal_pix30[6] > hard_th) ? cal_pix30[6] : 0;
    assign blk_o7 = (cal_pix30[7] > hard_th) ? cal_pix30[7] : 0;
    assign blk_o8 = (cal_pix30[8] > hard_th) ? cal_pix30[8] : 0;
    assign blk_o9 = (cal_pix30[9] > hard_th) ? cal_pix30[9] : 0;
    assign blk_o10 = (cal_pix30[10] > hard_th) ? cal_pix30[10] : 0;
    assign blk_o11 = (cal_pix30[11] > hard_th) ? cal_pix30[11] : 0;
    assign blk_o12 = (cal_pix30[12] > hard_th) ? cal_pix30[12] : 0;
    assign blk_o13 = (cal_pix30[13] > hard_th) ? cal_pix30[13] : 0;
    assign blk_o14 = (cal_pix30[14] > hard_th) ? cal_pix30[14] : 0;
    assign blk_o15 = (cal_pix30[15] > hard_th) ? cal_pix30[15] : 0;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            blk_ovalid <= 0;
        end
        else begin
            blk_ovalid <= blk_ivalid_s3;
        end
    end
endmodule //wht_1d