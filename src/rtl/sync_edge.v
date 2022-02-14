//************************************************************************//
// edge detect 
module sync_edge (
    input   wire        clk,
    input   wire        rst_n,
    input   wire        data_in,
    output  wire        data_out_pos,
    output  wire        data_out_neg
);
//************************************************************************//
    reg     [0:0]       data_sync;
//************************************************************************//
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_sync <= 1'b0;
        end
        else begin
            data_sync <= data_in;
        end
    end

    assign data_out_pos = data_in & !data_sync;
    assign data_out_neg = !data_in & data_sync;
endmodule //sync_edge
