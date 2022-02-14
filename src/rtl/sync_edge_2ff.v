//************************************************************************//
// edge detect with 2ff sync 
module sync_edge_2ff (
    input   wire        clk,
    input   wire        rst_n,
    input   wire        data_in,
    output  wire        data_out_pos,
    output  wire        data_out_neg
);
//************************************************************************//
    reg     [2:0]       data_sync;
//************************************************************************//
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            data_sync <= 3'b000;
        end
        else begin
            data_sync <= {data_sync[1:0], data_in};
        end
    end

    assign data_out_pos = data_sync[1] & !data_sync[2];
    assign data_out_neg = !data_sync[1] & data_sync[2];
endmodule //sync_edge_2ff
