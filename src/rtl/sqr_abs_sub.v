// z = abs(a-b)*abs(a-b)
module sqr_abs_sub(
    input   wire            clk,
    input   wire            nrst,
    input   wire            en,
    input   wire    [ 7:0]  a,
    input   wire    [ 7:0]  b,
    output  reg     [15:0]  z
);
//************************************************************************//
    wire    [ 7:0]      in_a;
    wire    [ 7:0]      in_b;
    wire    [ 8:0]      sub;
    wire    [ 7:0]      abs_sub_tmp;
    reg                 en_d;
    reg     [ 7:0]      abs_sub;
    wire    [ 7:0]      tmp00;
    wire    [ 8:0]      tmp10;
    wire    [ 9:0]      tmp20;
    wire    [10:0]      tmp30;
    wire    [11:0]      tmp40;
    wire    [12:0]      tmp50;
    wire    [13:0]      tmp60;
    wire    [14:0]      tmp70;
    wire    [15:0]      squ;
//************************************************************************//
    assign in_a = en? a: 8'b0;
    assign in_b = en? b: 8'b0;
    assign sub = in_a-in_b;
    assign abs_sub_tmp = sub[8]? (~sub[7:0]+1): sub[7:0];
  
    always @(posedge clk or negedge nrst) begin
        if(!nrst) 
            en_d <= 1'b0;
        else if(en) 
            en_d <= en;
    end

    always @(posedge clk or negedge nrst) begin
        if(!nrst) 
            abs_sub <= 8'b0;
        else if(en)
            abs_sub <= abs_sub_tmp;
    end

    assign tmp00 = (abs_sub& {8{abs_sub[0]}});
    assign tmp10 = (abs_sub& {8{abs_sub[1]}})<<1;
    assign tmp20 = (abs_sub& {8{abs_sub[2]}})<<2;
    assign tmp30 = (abs_sub& {8{abs_sub[3]}})<<3;
    assign tmp40 = (abs_sub& {8{abs_sub[4]}})<<4;
    assign tmp50 = (abs_sub& {8{abs_sub[5]}})<<5;
    assign tmp60 = (abs_sub& {8{abs_sub[6]}})<<6;
    assign tmp70 = (abs_sub& {8{abs_sub[7]}})<<7;

    assign squ = ((tmp00+ tmp10)+ (tmp20+ tmp30))+ ((tmp40+ tmp50)+ (tmp60+ tmp70));

    always @(posedge clk or negedge nrst) begin
        if(!nrst) 
            z <= 16'b0;
        else if(en_d)
            z <= squ;
    end
endmodule
