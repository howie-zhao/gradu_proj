// input column by column
module wht_2d #(
    parameter  WIDTH0 = 8,// raw 8bit fixed integer
    parameter  WIDTH1 = 11,// 1 signed bit + 10bit fixed integer
    parameter  WIDTH2 = 13// 1 signed bit + 12bit fixed integer
)(
    input   wire                    clk,
    input   wire                    rst_n,
    input   wire    [4*WIDTH0-1:0]  blk_i,
    input   wire                    blk_valid,
    output  wire    [WIDTH2-1:0]    pix_out0,
    output  wire    [WIDTH2-1:0]    pix_out1,
    output  wire    [WIDTH2-1:0]    pix_out2,
    output  wire    [WIDTH2-1:0]    pix_out3,
    output  reg                     pix_ovalid
);
//************************************************************************//

    wire    [WIDTH0-1:0]    pix[3:0];
    reg     [WIDTH1-1:0]    cal_pix[3:0]; 
    reg     [1:0]           cal_cnt;
    reg                     blk_valid_d;
    reg                     blk_valid_d2;
    reg     [4*WIDTH1-1:0]  row_buffer0;
    reg     [4*WIDTH1-1:0]  row_buffer1;
    reg     [4*WIDTH1-1:0]  row_buffer2;
    reg     [4*WIDTH1-1:0]  row_buffer3;
    reg     [4*WIDTH1-1:0]  row_pix_buffer[3:0];
    reg                     row_pix_vld;

    reg     [WIDTH2-1:0]    cal_pix_final[3:0];
    wire    [WIDTH1-1:0]    row_pix[3:0];
    wire    [4*WIDTH1-1:0]  row_pix_i;
    reg     [1:0]           row_pix_cnt;
//************************************************************************//
    assign pix[0] = blk_i[1*WIDTH0-1:0];
    assign pix[1] = blk_i[2*WIDTH0-1:1*WIDTH0];
    assign pix[2] = blk_i[3*WIDTH0-1:2*WIDTH0];
    assign pix[3] = blk_i[4*WIDTH0-1:3*WIDTH0];
//************************************************************************//
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cal_pix[0] <= 0;
            cal_pix[1] <= 0;
            cal_pix[2] <= 0;
            cal_pix[3] <= 0;
        end
        else if (blk_valid) begin
            cal_pix[0] <= (pix[0] + pix[1]) + (pix[2] + pix[3]);
            cal_pix[1] <= (pix[0] - pix[1]) + (pix[2] - pix[3]);
            cal_pix[2] <= (pix[0] + pix[1]) - (pix[2] + pix[3]);
            cal_pix[3] <= (pix[0] - pix[1]) - (pix[2] - pix[3]);
        end
    end
//************************************************************************//
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cal_cnt <= 0;
        end
        else if (blk_valid_d) begin
            cal_cnt <= cal_cnt + 1;
        end
        else begin
            cal_cnt <= 0;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            blk_valid_d <= 0;
            blk_valid_d2 <= 0;
        end
        else begin
            blk_valid_d <= blk_valid;
            blk_valid_d2 <= blk_valid_d;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            row_buffer0 <= 0;
            row_buffer1 <= 0;
            row_buffer2 <= 0;
            row_buffer3 <= 0;
        end
        else if (blk_valid_d) begin
            row_buffer0 <= {row_buffer0[3*WIDTH1-1:0], cal_pix[0]};
            row_buffer1 <= {row_buffer1[3*WIDTH1-1:0], cal_pix[1]};
            row_buffer2 <= {row_buffer2[3*WIDTH1-1:0], cal_pix[2]};
            row_buffer3 <= {row_buffer3[3*WIDTH1-1:0], cal_pix[3]};
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            row_pix_vld <= 0;
            row_pix_buffer[0] <= 0;
            row_pix_buffer[1] <= 0;
            row_pix_buffer[2] <= 0;
            row_pix_buffer[3] <= 0;
        end
        else if(blk_valid_d2 && (cal_cnt == 0)) begin
            row_pix_vld <= 1;
            row_pix_buffer[0] <= row_buffer0;
            row_pix_buffer[1] <= row_buffer1;
            row_pix_buffer[2] <= row_buffer2;
            row_pix_buffer[3] <= row_buffer3;
        end
    end


//************************************************************************//
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            row_pix_cnt <= 0;
        end
        else if (row_pix_vld) begin
            row_pix_cnt <= row_pix_cnt + 1;
        end
        else begin
            row_pix_cnt <= 0;
        end
    end

    assign row_pix_i = row_pix_buffer[row_pix_cnt];

    assign row_pix[3] = row_pix_i[1*WIDTH1-1:0];
    assign row_pix[2] = row_pix_i[2*WIDTH1-1:1*WIDTH1];
    assign row_pix[1] = row_pix_i[3*WIDTH1-1:2*WIDTH1];
    assign row_pix[0] = row_pix_i[4*WIDTH1-1:3*WIDTH1];
//************************************************************************//
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cal_pix_final[0] <= 0;
            cal_pix_final[1] <= 0;
            cal_pix_final[2] <= 0;
            cal_pix_final[3] <= 0;
        end
        else if (row_pix_vld) begin
            cal_pix_final[0] <= (row_pix[0] + row_pix[1]) + (row_pix[2] + row_pix[3]);
            cal_pix_final[1] <= (row_pix[0] - row_pix[1]) + (row_pix[2] - row_pix[3]);
            cal_pix_final[2] <= (row_pix[0] + row_pix[1]) - (row_pix[2] + row_pix[3]);
            cal_pix_final[3] <= (row_pix[0] - row_pix[1]) - (row_pix[2] - row_pix[3]);
        end
    end

    assign pix_out0 = cal_pix_final[0];
    assign pix_out1 = cal_pix_final[1];
    assign pix_out2 = cal_pix_final[2];
    assign pix_out3 = cal_pix_final[3];

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pix_ovalid <= 0;
        end
        else begin
            pix_ovalid <= row_pix_vld;
        end
    end
endmodule //wht_2d