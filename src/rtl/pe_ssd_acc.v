module pe_ssd_acc (
    input   wire            clk, 
    input   wire            rst_n,
    input   wire            sqr_valid,
    input   wire    [15:0]  a0,
    input   wire    [15:0]  a1,
    input   wire    [15:0]  a2,
    input   wire    [15:0]  a3,
    output  wire    [19:0]  z,
    output  wire            z_valid
);
//************************************************************************//
    reg     [16:0]      a_temp0;
    reg     [16:0]      a_temp1;
    reg     [17:0]      a_temp;
    reg     [2:0]       sqr_valid_d;
    reg     [2:0]       srh_col_cnt;
    reg     [19:0]      acc_data;
    reg     [19:0]      acc_temp;
//************************************************************************//
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sqr_valid_d <= 'b0;
        end
        else begin
            sqr_valid_d <= {sqr_valid_d[1:0], sqr_valid};
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            a_temp0 <= 17'b0;
        end
        else if(sqr_valid) begin
            a_temp0 <= a0 + a1;
        end
        else begin
            a_temp0 <= 17'b0;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            a_temp1 <= 17'b0;
        end
        else if(sqr_valid) begin
            a_temp1 <= a2 + a3;
        end
        else begin
            a_temp1 <= 17'b0;
        end 
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            a_temp <= 18'b0;
        end
        else if(sqr_valid_d[0]) begin
            a_temp <= a_temp0 + a_temp1;
        end
        else begin
            a_temp <= 18'b0;
        end 
    end

    // output stage
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            srh_col_cnt <= 0;
        end
        else if(sqr_valid_d[1]) begin
            if (srh_col_cnt == 4) begin
                srh_col_cnt <= 1;
            end else begin
                srh_col_cnt <= srh_col_cnt + 1; 
            end
        end
        else begin
            srh_col_cnt <= 0;
        end 
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            acc_data <= 0;
        end
        else if(sqr_valid_d[1]) begin
            acc_data <= a_temp + acc_temp;
        end
        else begin
            acc_data <= 0;
        end 
    end

    always @(*) begin
        if (srh_col_cnt == 4) begin
            acc_temp = 0;
        end
        else begin
            acc_temp = acc_data;
        end
    end

    assign z = acc_data;
    assign z_valid = (srh_col_cnt == 4);
endmodule //pe_ssd_acc