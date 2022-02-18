module pe_top (
    input   wire            clk,
    input   wire            rst_n,
    input   wire            pe_en, //ref_vld
    input   wire            ref_vld,
    input   wire    [7:0]   ref0,
    input   wire    [7:0]   ref1,
    input   wire    [7:0]   ref2,
    input   wire    [7:0]   ref3,
    input   wire            srh_vld,
    input   wire    [7:0]   srh0,
    input   wire    [7:0]   srh1,
    input   wire    [7:0]   srh2,
    input   wire    [7:0]   srh3,
    input   wire    [7:0]   srh4,
    input   wire    [7:0]   srh5,
    input   wire    [7:0]   srh6,

    output  reg             blk_ovalid,
    output  wire    [31:0]  blk0_o,
    output  wire    [31:0]  blk1_o,
    output  wire    [31:0]  blk2_o,
    output  wire    [31:0]  blk3_o,
    output  wire    [31:0]  blk4_o,
    output  wire    [31:0]  blk5_o,
    output  wire    [31:0]  blk6_o,
    output  wire    [31:0]  blk7_o,
    output  wire    [31:0]  blk8_o,
    output  wire    [31:0]  blk9_o,
    output  wire    [31:0]  blk10_o,
    output  wire    [31:0]  blk11_o,
    output  wire    [31:0]  blk12_o,
    output  wire    [31:0]  blk13_o,
    output  wire    [31:0]  blk14_o,
    output  wire    [31:0]  blk15_o
);
//************************************************************************//
    wire    [15:0]          en_o;
    wire    [7:0]           ref0_o[15:0];
    wire    [7:0]           ref1_o[15:0];
    wire    [7:0]           ref2_o[15:0];
    wire    [7:0]           ref3_o[15:0];
    wire    [7:0]           srh0_o[15:0];
    wire    [7:0]           srh1_o[15:0];
    wire    [7:0]           srh2_o[15:0];
    wire    [7:0]           srh3_o[15:0];
    wire    [7:0]           srh4_o[15:0];
    wire    [7:0]           srh5_o[15:0];
    wire    [7:0]           srh6_o[15:0];

    wire    [15:0]          ssd_ovalid;
    wire    [15:0]          ssd_ovalid_d;
    wire    [19:0]          ssd_o[15:0];
    wire    [19:0]          ssd_o_d[15:0];
    wire    [31:0]          blk_col_o[15:0];
    wire    [31:0]          blk_fifo_o[15:0];
    reg     [31:0]          sort_blk[15:0];
    // sort_parallel Outputs
    wire                    sort_done;
    wire    [7:0]           score[15:0];
	wire  			        score_done;
    // fifo64x32 Inputs
    wire                    srst;        
    wire    [15:0]          wr_en;       
    reg     [15:0]          rd_en;
    reg                     read_en_ctrl;
    // fifo64x32 Outputs
    wire    [15:0]          full;
    wire    [15:0]          empty;
    reg                     out_valid;
//************************************************************************//
    generate
        genvar i,j;
        for (i=0; i<4; i=i+1) begin:pe_col
            for (j=0; j<4; j=j+1) begin:pe_row
                if (i+j==0) begin
                    pe #(
                        .offset ( 2'd0 )
                    ) u_pe(
                        .clk     ( clk   ),
                        .rst_n   ( rst_n ),
                        .en      ( pe_en ),
                        .ref0    ( ref0  ),
                        .ref1    ( ref1  ),
                        .ref2    ( ref2  ),
                        .ref3    ( ref3  ),
                        .srh0    ( srh0  ),
                        .srh1    ( srh1  ),
                        .srh2    ( srh2  ),
                        .srh3    ( srh3  ),
                        .srh4    ( srh4  ),
                        .srh5    ( srh5  ),
                        .srh6    ( srh6  ),

                        .en_o       ( en_o[0]         ),
                        .ref0_o     ( ref0_o[0]       ),
                        .ref1_o     ( ref1_o[0]       ),
                        .ref2_o     ( ref2_o[0]       ),
                        .ref3_o     ( ref3_o[0]       ),
                        .srh0_o     ( srh0_o[0]       ),
                        .srh1_o     ( srh1_o[0]       ),
                        .srh2_o     ( srh2_o[0]       ),
                        .srh3_o     ( srh3_o[0]       ),
                        .srh4_o     ( srh4_o[0]       ),
                        .srh5_o     ( srh5_o[0]       ),
                        .srh6_o     ( srh6_o[0]       ),
                        .ssd_o      ( ssd_o[0]        ),
                        .ssd_ovalid ( ssd_ovalid[0]   ),
                        .blk_col_o  ( blk_col_o[0]    )
                    ); 
                end
                else if ((i!=0)&(j==0)) begin
                    pe #(
                        .offset ( j )
                    ) u_pe(
                        .clk     ( clk   ),
                        .rst_n   ( rst_n ),
                        .en      ( en_o[i*4+j-1] ),
                        .ref0    ( ref0_o[i*4+j-1]  ),
                        .ref1    ( ref1_o[i*4+j-1]  ),
                        .ref2    ( ref2_o[i*4+j-1]  ),
                        .ref3    ( ref3_o[i*4+j-1]  ),
                        .srh0    ( srh0_o[i*4+j-2]  ),
                        .srh1    ( srh1_o[i*4+j-2]  ),
                        .srh2    ( srh2_o[i*4+j-2]  ),
                        .srh3    ( srh3_o[i*4+j-2]  ),
                        .srh4    ( srh4_o[i*4+j-2]  ),
                        .srh5    ( srh5_o[i*4+j-2]  ),
                        .srh6    ( srh6_o[i*4+j-2]  ),

                        .en_o       ( en_o[i*4+j]         ),
                        .ref0_o     ( ref0_o[i*4+j]       ),
                        .ref1_o     ( ref1_o[i*4+j]       ),
                        .ref2_o     ( ref2_o[i*4+j]       ),
                        .ref3_o     ( ref3_o[i*4+j]       ),
                        .srh0_o     ( srh0_o[i*4+j]       ),
                        .srh1_o     ( srh1_o[i*4+j]       ),
                        .srh2_o     ( srh2_o[i*4+j]       ),
                        .srh3_o     ( srh3_o[i*4+j]       ),
                        .srh4_o     ( srh4_o[i*4+j]       ),
                        .srh5_o     ( srh5_o[i*4+j]       ),
                        .srh6_o     ( srh6_o[i*4+j]       ),
                        .ssd_o      ( ssd_o[i*4+j]        ),
                        .ssd_ovalid ( ssd_ovalid[i*4+j]   ),
                        .blk_col_o  ( blk_col_o[i*4+j]    )
                    );
                end
                else begin
                    pe #(
                        .offset ( j )
                    ) u_pe(
                        .clk     ( clk   ),
                        .rst_n   ( rst_n ),
                        .en      ( en_o[i*4+j-1] ),
                        .ref0    ( ref0_o[i*4+j-1]  ),
                        .ref1    ( ref1_o[i*4+j-1]  ),
                        .ref2    ( ref2_o[i*4+j-1]  ),
                        .ref3    ( ref3_o[i*4+j-1]  ),
                        .srh0    ( srh0_o[i*4+j-1]  ),
                        .srh1    ( srh1_o[i*4+j-1]  ),
                        .srh2    ( srh2_o[i*4+j-1]  ),
                        .srh3    ( srh3_o[i*4+j-1]  ),
                        .srh4    ( srh4_o[i*4+j-1]  ),
                        .srh5    ( srh5_o[i*4+j-1]  ),
                        .srh6    ( srh6_o[i*4+j-1]  ),

                        .en_o       ( en_o[i*4+j]      ),
                        .ref0_o     ( ref0_o[i*4+j]    ),
                        .ref1_o     ( ref1_o[i*4+j]    ),
                        .ref2_o     ( ref2_o[i*4+j]    ),
                        .ref3_o     ( ref3_o[i*4+j]    ),
                        .srh0_o     ( srh0_o[i*4+j]    ),
                        .srh1_o     ( srh1_o[i*4+j]    ),
                        .srh2_o     ( srh2_o[i*4+j]    ),
                        .srh3_o     ( srh3_o[i*4+j]    ),
                        .srh4_o     ( srh4_o[i*4+j]    ),
                        .srh5_o     ( srh5_o[i*4+j]    ),
                        .srh6_o     ( srh6_o[i*4+j]    ),
                        .ssd_o      ( ssd_o[i*4+j]     ),
                        .ssd_ovalid ( ssd_ovalid[i*4+j]),
                        .blk_col_o  ( blk_col_o[i*4+j] )
                    );
                end
            end
        end
    endgenerate
//************************************************************************//
    generate
        genvar k;
        for (k=0; k<15; k=k+1) begin:gen_pe_out_dly
            pe_out_dly #(
                .dly_cycle ( 15-k ))
            u_pe_out_dly (
                .clk         ( clk           ),
                .rst_n       ( rst_n         ),
                .ssd_i       ( ssd_o[k]      ),
                .ssd_ivalid  ( ssd_ovalid[k]),

                .ssd_o       ( ssd_o_d[k]    ),
                .ssd_ovalid  ( ssd_ovalid_d[k])
            ); 
        end

        assign ssd_o_d[15] = ssd_o[15];
        assign ssd_ovalid_d[15] = ssd_ovalid[15];
    endgenerate
//************************************************************************//
    sort_parallel #(
        .COL_WIDTH ( 16 )
    ) u_sort_parallel (
        .clk                     ( clk        ),
        .rst_n                   ( rst_n      ),
        .comp_data_i1            ( ssd_o_d[0] ),
        .comp_data_i2            ( ssd_o_d[1] ),
        .comp_data_i3            ( ssd_o_d[2] ),
        .comp_data_i4            ( ssd_o_d[3] ),
        .comp_data_i5            ( ssd_o_d[4] ),
        .comp_data_i6            ( ssd_o_d[5] ),
        .comp_data_i7            ( ssd_o_d[6] ),
        .comp_data_i8            ( ssd_o_d[7] ),
        .comp_data_i9            ( ssd_o_d[8] ),
        .comp_data_i10           ( ssd_o_d[9] ),
        .comp_data_i11           ( ssd_o_d[10]),
        .comp_data_i12           ( ssd_o_d[11]),
        .comp_data_i13           ( ssd_o_d[12]),
        .comp_data_i14           ( ssd_o_d[13]),
        .comp_data_i15           ( ssd_o_d[14]),
        .comp_data_i16           ( ssd_o_d[15]),
        .valid_i                 ( ssd_ovalid_d[0] ),
        .sort_done               ( sort_done       ),
        .score0                  ( score[0] ),
        .score1                  ( score[1] ),
        .score2                  ( score[2] ),
        .score3                  ( score[3] ),
        .score4                  ( score[4] ),
        .score5                  ( score[5] ),
        .score6                  ( score[6] ),
        .score7                  ( score[7] ),
        .score8                  ( score[8] ),
        .score9                  ( score[9] ),
        .score10                 ( score[10] ),
        .score11                 ( score[11] ),
        .score12                 ( score[12] ),
        .score13                 ( score[13] ),
        .score14                 ( score[14] ),
        .score15                 ( score[15] ),
        .score_done              ( score_done )
    );
//************************************************************************//
/*     generate
        genvar m;
        for (m=0; m<15; m=m+1) begin:gen_blk_col_out_dly
            blk_out_dly #(
                .dly_cycle ( 15-m ))
            u_blk_out_dly (
                .clk             ( clk           ),
                .rst_n           ( rst_n         ),
                .blk_col_i       ( blk_col_o[m]  ),
                .blk_col_ivalid  ( en_o[m]),

                .blk_col_o       ( blk_col_o_d[m]    ),
                .blk_col_ovalid  ( blk_col_ovalid_d[m])
            ); 
        end
        assign ssd_o_d[15] = ssd_o[15];
        assign ssd_ovalid_d[15] = ssd_ovalid[15];
    endgenerate */
//************************************************************************//
    rst_sync  u_rst_sync (
        .clk      ( clk    ),
        .rst_n    ( !rst_n ),
        .srst_n   ( srst   )
    ); 

    generate
        genvar m;
        for (m=0; m<16; m=m+1) begin:gen_blk_col_fifo
            fifo64x32  u_fifo64x32 (
                .clk    ( clk     ),
                .srst   ( srst    ),
                .wr_en  ( wr_en[m]),
                .rd_en  ( rd_en[m]),
                .din    ( blk_col_o[m]),
                .dout   ( blk_fifo_o[m]),
                .full   ( full[m]    ),
                .empty  ( empty[m]   )
            );
        end
    endgenerate
//************************************************************************//
// fifo wr en
    assign wr_en[0] = pe_en;
    assign wr_en[15:1] = en_o[14:0];
//************************************************************************//
// fifo rd en
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            read_en_ctrl <= 0;
        end
        else begin
            read_en_ctrl <= ssd_ovalid_d[0];
        end
    end// delay a cycle

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rd_en <= 0;
        end
        else if(read_en_ctrl) begin
            rd_en <= 16'hffff;//TODO disable read
        end
    end
//************************************************************************//
// fifo out stage
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            out_valid <= 0;
            blk_ovalid <= 0;
        end
        else begin
            out_valid <= rd_en[0];
            blk_ovalid <= out_valid;
        end
    end
// sort original blk data
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sort_blk[0] <= 0;
            sort_blk[1] <= 0;
            sort_blk[2] <= 0;
            sort_blk[3] <= 0;
            sort_blk[4] <= 0;
            sort_blk[5] <= 0;
            sort_blk[6] <= 0;
            sort_blk[7] <= 0;
            sort_blk[8] <= 0;
            sort_blk[9] <= 0;
            sort_blk[10] <= 0;
            sort_blk[11] <= 0;
            sort_blk[12] <= 0;
            sort_blk[13] <= 0;
            sort_blk[14] <= 0;
            sort_blk[15] <= 0;
        end
        else if(out_valid) begin // score: 1~16
            sort_blk[score[0] - 1] <= blk_fifo_o[0];
            sort_blk[score[1] - 1] <= blk_fifo_o[1];
            sort_blk[score[2] - 1] <= blk_fifo_o[2];
            sort_blk[score[3] - 1] <= blk_fifo_o[3];
            sort_blk[score[4] - 1] <= blk_fifo_o[4];
            sort_blk[score[5] - 1] <= blk_fifo_o[5];
            sort_blk[score[6] - 1] <= blk_fifo_o[6];
            sort_blk[score[7] - 1] <= blk_fifo_o[7];
            sort_blk[score[8] - 1] <= blk_fifo_o[8];
            sort_blk[score[9] - 1] <= blk_fifo_o[9];
            sort_blk[score[10] - 1] <= blk_fifo_o[10];
            sort_blk[score[11] - 1] <= blk_fifo_o[11];
            sort_blk[score[12] - 1] <= blk_fifo_o[12];
            sort_blk[score[13] - 1] <= blk_fifo_o[13];
            sort_blk[score[14] - 1] <= blk_fifo_o[14];
            sort_blk[score[15] - 1] <= blk_fifo_o[15];
        end
    end
// sorted blk data
    assign blk0_o =  sort_blk[0 ];
    assign blk1_o =  sort_blk[1 ];
    assign blk2_o =  sort_blk[2 ];
    assign blk3_o =  sort_blk[3 ];
    assign blk4_o =  sort_blk[4 ];
    assign blk5_o =  sort_blk[5 ];
    assign blk6_o =  sort_blk[6 ];
    assign blk7_o =  sort_blk[7 ];
    assign blk8_o =  sort_blk[8 ];
    assign blk9_o =  sort_blk[9 ];
    assign blk10_o = sort_blk[10];
    assign blk11_o = sort_blk[11];
    assign blk12_o = sort_blk[12];
    assign blk13_o = sort_blk[13];
    assign blk14_o = sort_blk[14];
    assign blk15_o = sort_blk[15];
/*     pe #(
        .offset ( 2'd0 )
    ) u_pe(
        .clk     ( clk   ),
        .rst_n   ( rst_n ),
        .en      ( pe_en ),
        .ref0    ( ref0  ),
        .ref1    ( ref1  ),
        .ref2    ( ref2  ),
        .ref3    ( ref3  ),
        .srh0    ( srh0  ),
        .srh1    ( srh1  ),
        .srh2    ( srh2  ),
        .srh3    ( srh3  ),
        .srh4    ( srh4  ),
        .srh5    ( srh5  ),
        .srh6    ( srh6  ),

        .en_o       ( en_o         ),
        .ref0_o     ( ref0_o       ),
        .ref1_o     ( ref1_o       ),
        .ref2_o     ( ref2_o       ),
        .ref3_o     ( ref3_o       ),
        .srh0_o     ( srh0_o       ),
        .srh1_o     ( srh1_o       ),
        .srh2_o     ( srh2_o       ),
        .srh3_o     ( srh3_o       ),
        .srh4_o     ( srh4_o       ),
        .srh5_o     ( srh5_o       ),
        .srh6_o     ( srh6_o       ),
        .ssd_o      ( ssd_o        ),
        .ssd_ovalid ( ssd_ovalid   )
    );  */ 
endmodule //pe_top