module pe_out_dly #(
    parameter dly_cycle = 1
)(
    input   wire                clk,
    input   wire                rst_n,
    input   wire   [19:0]       ssd_i,
    input   wire                ssd_ivalid,
    output  wire   [19:0]       ssd_o,
    output  wire                ssd_ovalid
);
//************************************************************************//
    reg     [19:0]      ssd_dly [dly_cycle - 1:0];
    reg                 ssd_valid_dly [dly_cycle - 1:0];
//************************************************************************//
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            ssd_valid_dly[0] <= 0;
        end
        else begin
            ssd_valid_dly[0] <= ssd_ivalid;
        end
    end

    genvar i;
    generate
        for(i=1; i<dly_cycle; i=i+1) begin:dly_ssd_valid
            always @(posedge clk or negedge rst_n) begin
                if (!rst_n) begin
                    ssd_valid_dly[i] <= 0;
                end
                else begin
                    ssd_valid_dly[i] <= ssd_valid_dly[i-1];
                end
            end
        end
    endgenerate

    assign ssd_ovalid = ssd_valid_dly[dly_cycle - 1];
//************************************************************************//
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            ssd_dly[0] <= 0;
        end
        else begin
            ssd_dly[0] <= ssd_i;
        end
    end

    genvar j;
    generate
        for(j=1; j<dly_cycle; j=j+1) begin:dly_ssd
            always @(posedge clk or negedge rst_n) begin
                if (!rst_n) begin
                    ssd_dly[j] <= 0;
                end
                else begin
                    ssd_dly[j] <= ssd_dly[j-1];
                end
            end
        end
    endgenerate

    assign ssd_o = ssd_dly[dly_cycle - 1];

endmodule //pe_out_dly