module disp_timing_ctrl(
    input                   clk,
/*     input   [7:0]           r_i,
    input   [7:0]           g_i,
    input   [7:0]           b_i, */
    output  [7:0]           r_o,
    output  [7:0]           g_o,
    output  [7:0]           b_o,
    output                  de,
    output                  vsync,
    output                  hsync
);
//************************************************************************//
    reg     [11:0]  hcounter;
    reg     [11:0]  vcounter;
    wire    [15:0]  gray_tmp;
    wire    [7:0]   gray_o;
    reg     [23:0]  color;
    reg     [7:0]   R_reg;
    reg     [7:0]   G_reg;
    reg     [7:0]   B_reg;
//************************************************************************//
// Colours converted using The RGB

// Colours converted using The RGB -> YCbCr converter app found on Google Gadgets 
                                //   Y    Cb   Cr
   parameter C_BLACK = 24'h000000;  //  16   128  128
   `define C_RED   24'hFF0000;  //  81   90   240
   `define C_GREEN 24'h00FF00;  //  172  42   27
   `define C_BLUE  24'h0000FF;  //  32   240  118
   `define C_WHITE 24'hFFFFFF;  //  234  128  128
// Set the video mode to 1920x1080x60Hz (150MHz pixel clock needed)
    parameter hVisible   = 1920;
    parameter hStartSync = 1920+88;
    parameter hEndSync   = 1920+88+44;
    parameter hMax       = 1920+88+44+148;  //2200
    
    parameter vVisible   = 1080;
    parameter vStartSync = 1080+3;
    parameter vEndSync   = 1080+3+5;
    parameter vMax       = 1080+3+5+37;     //1125

    parameter h_sync     = 44;
    parameter h_back     = 148;
    parameter h_vld      = 1920;
    parameter h_front    = 88;
// vld + front + sync + back = 1920 + 88 + 44 + 148 = 2200
    parameter v_sync     = 5;
    parameter v_back     = 37;
    parameter v_vld      = 1080;
    parameter v_front    = 3;
// vld + front + sync + back = 1080 + 3 + 5 + 37 = 1125

//************************************************************************//
// Set the video mode to 1280x720x60Hz (75MHz pixel clock needed)
/*    parameter hVisible   = 1280;
   parameter hStartSync = 1280+72;
   parameter hEndSync   = 1280+72+80;
   parameter hMax       = 1280+72+80+216; //1647
   
   parameter vVisible    = 720;
   parameter vStartSync  = 720+3;
   parameter vEndSync    = 720+3+5;
   parameter vMax        = 720+3+5+22; //749
   
   parameter h_sync = 80;
   parameter h_back = 216;
   parameter h_vld = 1280;
   parameter h_front = 72;
   
   parameter v_sync = 5;
   parameter v_back = 22;
   parameter v_vld = 720;
   parameter v_front = 3;  */
//************************************************************************//
//v_sync counter & generator 
    always @(posedge clk) begin
        if(hcounter < hMax - 12'd1)        //line over
        	hcounter <= hcounter + 12'd1;
        else
        	hcounter <= 12'd0;
    end
 
    always @(posedge clk) begin
        if(hcounter == hMax - 12'd1) begin
        	if(vcounter < vMax - 12'd1)   //frame over
        		vcounter <= vcounter + 12'd1;
        	else
        		vcounter <= 12'd0;
        end
    end
// output color bar
    always @(posedge clk)
        if (hcounter <= hVisible/5)
            color <= C_BLACK;
        else if(hcounter <= 2*hVisible/5)
            color <= C_BLACK;
        else if(hcounter <= 3*hVisible/5)
            color <= C_BLACK;
        else if(hcounter <= 4*hVisible/5)
            color <= C_BLACK;
        else
            color <= C_BLACK;


    always @(*) begin
        R_reg = color[23:16];
        G_reg = color[15:8];
        B_reg = color[7:0];
    end

 
//************************************************************************//  
    assign gray_tmp = R_reg*77 + G_reg*151 + B_reg*28;
    assign gray_o = gray_tmp[15:8];
    assign r_o = de ? (hcounter[6:0] + vcounter[6:0]): 0; //r_i; //TODO
    assign g_o = gray_o; //g_i; 
    assign b_o = gray_o; //b_i;
//************************************************************************//
    assign hsync = ((hcounter >= hStartSync)&&(hcounter < hEndSync))? 1'b1:1'b0;  //Generate the hSync Pulses
    assign vsync = ((vcounter >= vStartSync)&&(vcounter < vEndSync))? 1'b1:1'b0;  //Generate the vSync Pulses
    assign de = (vcounter >= vVisible || hcounter >= hVisible) ? 1'b0 : 1'b1;  
endmodule
