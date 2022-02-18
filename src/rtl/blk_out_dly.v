module blk_out_dly #(
    parameter dly_cycle = 1
)(
    input   wire                clk,
    input   wire                rst_n,
    input   wire   [31:0]       blk_col_i,  //1 column block data = 4 pix = 32bits
    input   wire                blk_col_ivalid,
    output  wire   [31:0]       blk_col_o,
    output  wire                blk_col_ovalid
);
//************************************************************************//
    reg     [31:0]      blk_col_dly [dly_cycle - 1:0];
    reg                 blk_col_valid_dly [dly_cycle - 1:0];
//************************************************************************//
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            blk_col_valid_dly[0] <= 0;
        end
        else begin
            blk_col_valid_dly[0] <= blk_col_ivalid;
        end
    end

    genvar i;
    generate
        for(i=1; i<dly_cycle; i=i+1) begin:dly_blk_col_valid
            always @(posedge clk or negedge rst_n) begin
                if (!rst_n) begin
                    blk_col_valid_dly[i] <= 0;
                end
                else begin
                    blk_col_valid_dly[i] <= blk_col_valid_dly[i-1];
                end
            end
        end
    endgenerate

    assign blk_col_ovalid = blk_col_valid_dly[dly_cycle - 1];
//************************************************************************//
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            blk_col_dly[0] <= 0;
        end
        else begin
            blk_col_dly[0] <= blk_col_i;
        end
    end

    genvar j;
    generate
        for(j=1; j<dly_cycle; j=j+1) begin:dly_blk_col
            always @(posedge clk or negedge rst_n) begin
                if (!rst_n) begin
                    blk_col_dly[j] <= 0;
                end
                else begin
                    blk_col_dly[j] <= blk_col_dly[j-1];
                end
            end
        end
    endgenerate

    assign blk_col_o = blk_col_dly[dly_cycle - 1];

endmodule //blk_out_dly