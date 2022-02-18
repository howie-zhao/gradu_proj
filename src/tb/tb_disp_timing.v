`include "defines.v"
module tb_disp_timing ();
//************************************************************************//
// signals
    // disp_timing_ctrl Inputs
    reg                 clk;
    // disp_timing_ctrl Outputs
    wire    [7:0]       r_o;
    wire    [7:0]       g_o;
    wire    [7:0]       b_o;
    wire                de;
    wire                vsync;
    wire                hsync;

    // ref_gen Inputs     
    //reg                 clk;    //TODO: common clock in vip and hdmi pix clk
    reg                 rst_n;
    reg     [11:0]      vref_p1;
    reg     [11:0]      vref_p2;
    reg     [11:0]      href_p1;
    reg     [11:0]      href_p2;

    // ref_gen Outputs
    wire                vref;
    wire                href;
    wire                vsync_start;

    // blk_extract Outputs
    wire                ref_vld;
    wire  [7:0]         ref0;
    wire  [7:0]         ref1;
    wire  [7:0]         ref2;
    wire  [7:0]         ref3;
    wire                srh_vld;
    wire  [7:0]         srh0;
    wire  [7:0]         srh1;
    wire  [7:0]         srh2;
    wire  [7:0]         srh3;
    wire  [7:0]         srh4;
    wire  [7:0]         srh5;
    wire  [7:0]         srh6;
    wire                pix_vld;
    wire  [7:0]         pix0;
    wire  [7:0]         pix1;
    wire  [7:0]         pix2;
    wire  [7:0]         pix3;
    wire  [7:0]         noise_pix;
    wire                noise_vld;

    wire                blk_ovalid;
    wire  [31:0]        blk0_o;
    wire  [31:0]        blk1_o;
    wire  [31:0]        blk2_o;
    wire  [31:0]        blk3_o;
    wire  [31:0]        blk4_o;
    wire  [31:0]        blk5_o;
    wire  [31:0]        blk6_o;
    wire  [31:0]        blk7_o;
    wire  [31:0]        blk8_o;
    wire  [31:0]        blk9_o;
    wire  [31:0]        blk10_o;
    wire  [31:0]        blk11_o;
    wire  [31:0]        blk12_o;
    wire  [31:0]        blk13_o;
    wire  [31:0]        blk14_o;
    wire  [31:0]        blk15_o;
//************************************************************************//
// clk
    initial begin
        clk = 0;
        rst_n = 1;
        #25 rst_n = 0;
        #200 rst_n = 1;
    end 
    
    glbl glbl();//global reset

    always #(500/`FREQ) clk = !clk;
//************************************************************************//
// instance
    disp_timing_ctrl #(
        .hVisible   ( 1920           ),
        .hStartSync ( 1920+88        ),
        .hEndSync   ( 1920+88+44     ),
        .hMax       ( 1920+88+44+148 ),
        .vVisible   ( 1080           ),
        .vStartSync ( 1080+3         ),
        .vEndSync   ( 1080+3+5       ),
        .vMax       ( 1080+3+5+37    ),
        .h_sync     ( 44             ),
        .h_back     ( 148            ),
        .h_vld      ( 1920           ),
        .h_front    ( 88             ),
        .v_sync     ( 5              ),
        .v_back     ( 37             ),
        .v_vld      ( 1080           ),
        .v_front    ( 3              ))
    u_disp_timing_ctrl (
        .clk    ( clk     ),
        .r_o    ( r_o     ),
        .g_o    ( g_o     ),
        .b_o    ( b_o     ),
        .de     ( de      ),
        .vsync  ( vsync   ),
        .hsync  ( hsync   )
    );
//************************************************************************//
    ref_gen  u_ref_gen (
        .clk    ( clk     ),
        .rst_n  ( rst_n   ),
        .vsync  ( ~vsync   ),
        .hsync  ( ~hsync   ),
        .vref_p1( 12'd37 ),
        .vref_p2( 12'd1117 ),   // 1080=37
        .href_p1( 12'd148 ),    // 148
        .href_p2( 12'd2068 ),   // 1920+148

        .vref   ( vref    ),
        .href   ( href    ),
        .vsync_start(vsync_start)
    );
//************************************************************************//
    blk_extract  u_blk_extract (
        .clk     ( clk         ),
        .rst_n   ( rst_n       ),
        .de      ( de          ),
        .vref    ( vref        ),
        .href    ( href        ),
        .vsync   ( ~vsync       ), // not used,negate the signal
        .hsync   ( ~hsync       ), // not used,negate the signal
        .data_in ( r_o     ), //TODO
        .vsync_start(vsync_start),

        .ref_vld  ( ref_vld     ),
        .ref0     ( ref0        ),
        .ref1     ( ref1        ),
        .ref2     ( ref2        ),
        .ref3     ( ref3        ),
        .srh_vld  ( srh_vld     ),
        .srh0     ( srh0        ),
        .srh1     ( srh1        ),
        .srh2     ( srh2        ),
        .srh3     ( srh3        ),
        .srh4     ( srh4        ),
        .srh5     ( srh5        ),
        .srh6     ( srh6        ),
        .pix_vld  ( pix_vld     ),
        .pix0     ( pix0        ),
        .pix1     ( pix1        ),
        .pix2     ( pix2        ),
        .pix3     ( pix3        ),
        .noise_pix( noise_pix   ),
        .noise_vld( noise_vld   )
    );
//************************************************************************//
    pe_top u_pe_top (
        .clk        ( clk       ),
        .rst_n      ( rst_n     ),
        .pe_en      ( ref_vld   ), //TODO
        .ref_vld    ( ref_vld   ),
        .ref0       ( ref0      ),
        .ref1       ( ref1      ),
        .ref2       ( ref2      ),
        .ref3       ( ref3      ),
        .srh_vld    ( srh_vld   ),
        .srh0       ( srh0      ),
        .srh1       ( srh1      ),
        .srh2       ( srh2      ),
        .srh3       ( srh3      ),
        .srh4       ( srh4      ),
        .srh5       ( srh5      ),
        .srh6       ( srh6      ),
        .blk_ovalid ( blk_ovalid),
        .blk0_o     ( blk0_o),
        .blk1_o     ( blk1_o),
        .blk2_o     ( blk2_o),
        .blk3_o     ( blk3_o),
        .blk4_o     ( blk4_o),
        .blk5_o     ( blk5_o),
        .blk6_o     ( blk6_o),
        .blk7_o     ( blk7_o),
        .blk8_o     ( blk8_o),
        .blk9_o     ( blk9_o),
        .blk10_o    ( blk10_o),
        .blk11_o    ( blk11_o),
        .blk12_o    ( blk12_o),
        .blk13_o    ( blk13_o),
        .blk14_o    ( blk14_o),
        .blk15_o    ( blk15_o)
    ); 
endmodule //tb_disp_timing