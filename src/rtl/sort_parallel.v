module sort_parallel #( 	
	//parameter  	ROW_WIDTH = 8, //行
	parameter  	COL_WIDTH = 16	//列
)(
	input		wire						clk,
	input		wire						rst_n,
	input	    wire		[19:0]		    comp_data_i1, 
	input	    wire		[19:0]		    comp_data_i2, 
	input	    wire		[19:0]		    comp_data_i3, 
	input	    wire		[19:0]		    comp_data_i4, 
	input	    wire		[19:0]		    comp_data_i5, 
	input	    wire		[19:0]		    comp_data_i6, 
	input	    wire		[19:0]		    comp_data_i7, 
	input	    wire		[19:0]		    comp_data_i8, 
	input	    wire		[19:0]		    comp_data_i9, 
	input	    wire		[19:0]		    comp_data_i10, 
	input	    wire		[19:0]		    comp_data_i11, 
	input	    wire		[19:0]		    comp_data_i12, 
	input	    wire		[19:0]		    comp_data_i13,
	input	    wire		[19:0]		    comp_data_i14,
	input	    wire		[19:0]		    comp_data_i15,
	input	    wire		[19:0]		    comp_data_i16,
	input		wire						valid_i,
	output		reg							sort_done,
	output      wire        [7:0]			score0,
	output      wire        [7:0]			score1,
	output      wire        [7:0]			score2,
	output      wire        [7:0]			score3,
	output      wire        [7:0]			score4,
	output      wire        [7:0]			score5,
	output      wire        [7:0]			score6,
	output      wire        [7:0]			score7,
	output      wire        [7:0]			score8,
	output      wire        [7:0]			score9,
	output      wire        [7:0]			score10,
	output      wire        [7:0]			score11,
	output      wire        [7:0]			score12,
	output      wire        [7:0]			score13,
	output      wire        [7:0]			score14,
	output      wire        [7:0]			score15,
	output   	wire  						score_done
);
//************************************************************************//

	wire	[7:0]		score		[COL_WIDTH:1]; //得分，得分越低证明越大
	wire	[19:0]		data_o		[COL_WIDTH:1]; 
	wire				valid_o		[COL_WIDTH:1];
	wire				busy		[COL_WIDTH:1]; 
	reg		[19:0]		chn			[COL_WIDTH:1]; 
//************************************************************************//

	generate  //col
		genvar col;
			for(col=1; col<=COL_WIDTH; col=col+1) begin:Comp1
				comp_parallel u_comp_parallel (
					.clk		(	clk			), 
					.rst_n		(	rst_n		), 

					.comp_data_i1( comp_data_i1 ), 
					.comp_data_i2( comp_data_i2 ), 
					.comp_data_i3( comp_data_i3 ), 
					.comp_data_i4( comp_data_i4 ), 
					.comp_data_i5( comp_data_i5 ), 
					.comp_data_i6( comp_data_i6 ), 
					.comp_data_i7( comp_data_i7 ), 
					.comp_data_i8( comp_data_i8 ), 
					.comp_data_i9( comp_data_i9 ), 
					.comp_data_i10( comp_data_i10 ),
					.comp_data_i11( comp_data_i11 ),
					.comp_data_i12( comp_data_i12 ),
					.comp_data_i13( comp_data_i13 ),
					.comp_data_i14( comp_data_i14 ),
					.comp_data_i15( comp_data_i15 ),
					.comp_data_i16( comp_data_i16 ),

					//.comp_data_i( comp_data_i ), 
					.valid_i	( valid_i ), 
					//.row		( 1	), 
					.col		( col ), 
					.score		( score[col] ), 
					//.location	( location[col]	),
					.data_o		( data_o[col]	),
					.valid_o	( valid_o[col]	),
					.busy		( busy[col]		)
				);
					
			end
	endgenerate
//************************************************************************//

	always@(posedge	clk	or negedge rst_n) begin //TODO delete
		if(!rst_n) begin
			sort_done <= 0;
			chn[1] <=  0;
			chn[2] <=  0;
			chn[3] <=  0;
			chn[4] <=  0;
			chn[5] <=  0;
			chn[6] <=  0;
			chn[7] <=  0;
			chn[8] <=  0;
			chn[9] <=  0;
			chn[10] <= 0;
			chn[11] <= 0;
			chn[12] <= 0;
			chn[13] <= 0;
			chn[14] <= 0;
			chn[15] <= 0;
			chn[16] <= 0;
		end
		else if(valid_o[1]) begin
			chn[score[1]] <= data_o[1];	
			chn[score[2]] <= data_o[2];
			chn[score[3]] <= data_o[3];
			chn[score[4]] <= data_o[4];
			chn[score[5]] <= data_o[5];
			chn[score[6]] <= data_o[6];
			chn[score[7]] <= data_o[7];
			chn[score[8]] <= data_o[8];
			chn[score[9]] <= data_o[9];
			chn[score[10]] <= data_o[10];
			chn[score[11]] <= data_o[11];
			chn[score[12]] <= data_o[12];
			chn[score[13]] <= data_o[13];
			chn[score[14]] <= data_o[14];
			chn[score[15]] <= data_o[15];
			chn[score[16]] <= data_o[16];
			sort_done <= 1;
		end
		else begin
			sort_done <= 0;
		end
	end
//************************************************************************//
	assign score0 = score[1];
	assign score1 = score[2];
	assign score2 = score[3];
	assign score3 = score[4];
	assign score4 = score[5];
	assign score5 = score[6];
	assign score6 = score[7];
	assign score7 = score[8];
	assign score8 = score[9];
	assign score9 = score[10];
	assign score10 = score[11];
	assign score11 = score[12];
	assign score12 = score[13];
	assign score13 = score[14];
	assign score14 = score[15];
	assign score15 = score[16];

	assign score_done = valid_o[1];
endmodule
