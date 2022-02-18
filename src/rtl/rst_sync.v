module rst_sync (
    input       wire        clk,
    input       wire        rst_n,
    output      wire        srst_n
);
//************************************************************************//
    reg     [1:0]   rst_sync;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rst_sync <= 2'd0;
        end
        else begin
            rst_sync <= {rst_sync[0], 1'b1};
        end
    end

    assign srst_n = rst_sync[1];
endmodule //rst_sync