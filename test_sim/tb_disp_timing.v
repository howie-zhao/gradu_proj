module tb_disp_timing ();
//************************************************************************//
// signals
    parameter  WIDTH0 = 8;// raw 8bit fixed integer
    parameter  WIDTH1 = 11;// 1 signed bit + 10bit fixed integer
    parameter  WIDTH2 = 13;// 1 signed bit + 12bit fixed integer
    // disp_timing_ctrl Inputs
    reg                 clk;
    reg                 rst_n;
    reg                 blk_valid;
    reg  [31:0]         blk_i;
    reg  [2:0]          cnt;
    reg  [31:0]         buffer[7:0];

    wire [4*WIDTH2-1:0] pix_i;
    wire                f_pix_ovalid;
    wire                r_pix_ovalid;

    wire                f_blk_ovalid;

    wire [35:0]         blk_s_i;

    wire [16:0]         pix_out0;
    wire [16:0]         pix_out1;
    wire [16:0]         pix_out2;
    wire [16:0]         pix_out3;
    wire [7:0]          pix_rev0;
    wire [7:0]          pix_rev1;
    wire [7:0]          pix_rev2;
    wire [7:0]          pix_rev3;
    reg  [16:0]         hard_th = 0;//2.4 * sigma * sqrt(4) = 4.8 * 20 = 96
        
    wire [16:0]         blk_o0;
    wire [16:0]         blk_o1;
    wire [16:0]         blk_o2;
    wire [16:0]         blk_o3;
    wire [16:0]         blk_o4;
    wire [16:0]         blk_o5;
    wire [16:0]         blk_o6;
    wire [16:0]         blk_o7;
    wire [16:0]         blk_o8;
    wire [16:0]         blk_o9;
    wire [16:0]         blk_o10;
    wire [16:0]         blk_o11;
    wire [16:0]         blk_o12;
    wire [16:0]         blk_o13;
    wire [16:0]         blk_o14;
    wire [16:0]         blk_o15;
//************************************************************************//
// clk
    initial begin
        clk = 0;
        rst_n = 1;
        #25 rst_n = 0;
        #200 rst_n = 1;
    end 

    always #50 clk = !clk;
//************************************************************************//
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            blk_valid <= 0;
            cnt <= 0;
        end
        else begin
            blk_valid <= 1;
            cnt <= cnt + 1;
        end
    end

    initial begin
        buffer[0] = 32'h01008080;
        buffer[1] = 32'h01008080;
        buffer[2] = 32'h01008080;
        buffer[3] = 32'h02018080;
        buffer[4] = 32'h03028080;
        buffer[5] = 32'h04038080;
        buffer[6] = 32'h05048080;
        buffer[7] = 32'h06058080;
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            blk_i <= 0;
        end
        else begin
            blk_i <= buffer[cnt];
        end
    end
//************************************************************************//
    assign blk_s_i[35:0] = {1'b0,blk_i[31:24],1'b0,blk_i[23:16],1'b0,blk_i[15:8],1'b0,blk_i[7:0]};

// wht forward
    wht_2d #(
        .WIDTH0(9),//Extended symbol bit
        .WIDTH1(11),
        .WIDTH2(13)
    )u_wht_2d_forward(
        .clk(clk),
        .rst_n(rst_n),
        .blk_i(blk_s_i),
        .blk_valid(blk_valid),
        .pix_out0(pix_i[1*WIDTH2-1:0*WIDTH2]),
        .pix_out1(pix_i[2*WIDTH2-1:1*WIDTH2]),
        .pix_out2(pix_i[3*WIDTH2-1:2*WIDTH2]),
        .pix_out3(pix_i[4*WIDTH2-1:3*WIDTH2]),
        .pix_ovalid(f_pix_ovalid)
    );

//************************************************************************//
    wht_1d #(
        .WIDTH0(13),// 1 signed bit + 12bit fixed integer
        .WIDTH2(17) 
    )u_wht_1d_forward(
        .clk(clk),
        .rst_n(rst_n),
        .hard_th(hard_th),
        .blk_i0(pix_i[1*WIDTH2-1:0*WIDTH2]),
        .blk_i1(1),
        .blk_i2(2),
        .blk_i3(3),
        .blk_i4(4),
        .blk_i5(5),
        .blk_i6(6),
        .blk_i7(7),
        .blk_i8(8),
        .blk_i9(9),
        .blk_i10(0),
        .blk_i11(1),
        .blk_i12(2),
        .blk_i13(3),
        .blk_i14(4),
        .blk_i15(5),
        .blk_ivalid(f_pix_ovalid),
        .blk_o0(blk_o0),
        .blk_o1(blk_o1),
        .blk_o2(blk_o2),
        .blk_o3(blk_o3),
        .blk_o4(blk_o4),
        .blk_o5(blk_o5),
        .blk_o6(blk_o6),
        .blk_o7(blk_o7),
        .blk_o8(blk_o8),
        .blk_o9(blk_o9),
        .blk_o10(blk_o10),
        .blk_o11(blk_o11),
        .blk_o12(blk_o12),
        .blk_o13(blk_o13),
        .blk_o14(blk_o14),
        .blk_o15(blk_o15),
        .blk_ovalid(f_blk_ovalid)
    );



//************************************************************************//
//************************************************************************//
// wht reverse
    wht_2d #(
        .WIDTH0(13), //1 + 12integer
        .WIDTH1(15), //1 + 14integer
        .WIDTH2(17)  //1 + 16integer
    )u_wht_2d_reverse(
        .clk(clk),
        .rst_n(rst_n),
        .blk_i(pix_i),
        .blk_valid(f_pix_ovalid),
        .pix_out0(pix_out0),
        .pix_out1(pix_out1),
        .pix_out2(pix_out2),
        .pix_out3(pix_out3),
        .pix_ovalid(r_pix_ovalid)
    );

    assign pix_rev0 = pix_out0[11:4];// ¡Â 16, take first 8-bit
    assign pix_rev1 = pix_out1[11:4];// ¡Â 16
    assign pix_rev2 = pix_out2[11:4];// ¡Â 16
    assign pix_rev3 = pix_out3[11:4];// ¡Â 16

endmodule //tb_disp_timing