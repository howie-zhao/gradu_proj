module ram_block
(
    input   wire            clk,
    input   wire    [7:0]   ram_ce, //not used
    input   wire    [7:0]   ram_we,
    input   wire    [10:0]  ram_addr,   //0-1919
    input   wire    [7:0]   ram_wdata,

    output  wire    [7:0]   ram0_rdata,
    output  wire    [7:0]   ram1_rdata,
    output  wire    [7:0]   ram2_rdata,
    output  wire    [7:0]   ram3_rdata,
    output  wire    [7:0]   ram4_rdata,
    output  wire    [7:0]   ram5_rdata,
    output  wire    [7:0]   ram6_rdata,
    output  wire    [7:0]   ram7_rdata
);
//************************************************************************//
// signals
    wire    [7:0]   ram_rdata[7:0];
//************************************************************************//
    assign ram0_rdata = ram_rdata[0];
    assign ram1_rdata = ram_rdata[1];
    assign ram2_rdata = ram_rdata[2];
    assign ram3_rdata = ram_rdata[3];
    assign ram4_rdata = ram_rdata[4];
    assign ram5_rdata = ram_rdata[5];
    assign ram6_rdata = ram_rdata[6];
    assign ram7_rdata = ram_rdata[7];
//************************************************************************//
    // 7 line buffer + 1 line ping-pong buffer
    // distributed ram, non-registered read, outputs when gives address
    generate
        genvar i;
        for(i=0; i<8; i=i+1) begin: gen_ram
            ram1920x8 U0_RAM1920B(
                .a( ram_addr ),
                .d( ram_wdata ),
                .clk( clk ),
                .we( ram_we[7-i] ),
                .spo( ram_rdata[i] )
            );
        end
    endgenerate

endmodule
