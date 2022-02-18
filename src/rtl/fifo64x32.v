module fifo64x32 (
    input       wire                clk,
    input       wire                srst,
    input       wire                wr_en,
    input       wire                rd_en,
    input       wire    [31:0]      din,
    output      wire    [31:0]      dout,
    output      wire                full,
    output      wire                empty
);
//************************************************************************//
    design_1_fifo_generator_0_0 u_fifo64x32(
        .clk        (clk),
        .srst       (srst),
        .din        (din),
        .wr_en      (wr_en),
        .rd_en      (rd_en),
        .dout       (dout),
        .full       (full),
        .empty      (empty)
    );
endmodule //fifo64x32