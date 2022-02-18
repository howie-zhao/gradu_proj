module hold_reg(
    input  wire         clk,
    input  wire         nrst,
    input  wire         en,
    input  wire [ 7:0]  ref0,
    input  wire [ 7:0]  ref1,
    input  wire [ 7:0]  ref2,
    input  wire [ 7:0]  ref3,
    input  wire [ 7:0]  srh0,
    input  wire [ 7:0]  srh1,
    input  wire [ 7:0]  srh2,
    input  wire [ 7:0]  srh3,
    input  wire [ 7:0]  srh4,
    input  wire [ 7:0]  srh5,
    input  wire [ 7:0]  srh6,

    output reg          en_o,
    output reg  [ 7:0]  ref0_o,
    output reg  [ 7:0]  ref1_o,
    output reg  [ 7:0]  ref2_o,
    output reg  [ 7:0]  ref3_o,
    output reg  [ 7:0]  srh0_o,
    output reg  [ 7:0]  srh1_o,
    output reg  [ 7:0]  srh2_o,
    output reg  [ 7:0]  srh3_o,
    output reg  [ 7:0]  srh4_o,
    output reg  [ 7:0]  srh5_o,
    output reg  [ 7:0]  srh6_o
);
//************************************************************************//
    always @(posedge clk or negedge nrst) begin
        if(!nrst) begin
            en_o    <= 1'b0;
            ref0_o  <= 8'b0;
            ref1_o  <= 8'b0;
            ref2_o  <= 8'b0;
            ref3_o  <= 8'b0;
            srh0_o  <= 8'b0;
            srh1_o  <= 8'b0;
            srh2_o  <= 8'b0;
            srh3_o  <= 8'b0;
            srh4_o  <= 8'b0;
            srh5_o  <= 8'b0;
            srh6_o  <= 8'b0;
        end
        //else if(en) begin
        else begin
            en_o    <= en;
            ref0_o  <= ref0;
            ref1_o  <= ref1;
            ref2_o  <= ref2;
            ref3_o  <= ref3;
            srh0_o  <= srh0;
            srh1_o  <= srh1;
            srh2_o  <= srh2;
            srh3_o  <= srh3;
            srh4_o  <= srh4;
            srh5_o  <= srh5;
            srh6_o  <= srh6;
        end
    end
endmodule
