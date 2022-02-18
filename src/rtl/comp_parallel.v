//主要功能，计算一个数据在这个序列中的顺序得分
module comp_parallel #( 	
	parameter  	COL_WIDTH = 16
)(
	input	    wire						clk,
	input	    wire						rst_n,
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
	input	    wire						valid_i,	  	 	
	input	    wire		[7:0]			col,
	
	output		reg	    	[7:0]			score,
	output		reg	    	[19:0]		    data_o,
	output		reg						    valid_o,
	output		reg						    busy
);
//--------------------------------------------------------------------------------
	reg										comp_valid_f;					    
	reg										comp_valid_i	[COL_WIDTH:1];
	reg			[7:0]						score_i			[COL_WIDTH:1];
	//reg			[7:0]						count;
	reg			[7:0]						add_cnt;
    reg         [19:0]                      comp_data		[COL_WIDTH:1];
//--------------------------------------------------------------------------------
//----------------------------------------------------------
//--------------------------忙信号--------------------------
	always@(posedge	clk	or negedge	rst_n) begin
		if(!rst_n)
			busy <= 0;
		else if(comp_valid_f)
			busy <= 1;
		else if(valid_o)
			busy <= 0;
	end
//-----------------------------------------------------------
//--------------------------读取数据--------------------------
	always@(posedge	clk	or negedge	rst_n) begin
		if(!rst_n) begin
			comp_valid_f <= 0;
			comp_data[1] <= 0;
			comp_data[2] <= 0;
			comp_data[3] <= 0;
			comp_data[4] <= 0;
			comp_data[5] <= 0;
			comp_data[6] <= 0;
			comp_data[7] <= 0;
			comp_data[8] <= 0;
			comp_data[9] <= 0;
			comp_data[10] <= 0;
			comp_data[11] <= 0;
			comp_data[12] <= 0;
			comp_data[13] <= 0;
			comp_data[14] <= 0;
			comp_data[15] <= 0;
			comp_data[16] <= 0;
			//count <= 1;
		end
		else if(valid_i && (~busy)) begin
			//comp_data[count] <= comp_data_i;
			//count <= count + 1;
			comp_valid_f <= 1;
			comp_data[1] <= comp_data_i1;
			comp_data[2] <= comp_data_i2;
			comp_data[3] <= comp_data_i3;
			comp_data[4] <= comp_data_i4;
			comp_data[5] <= comp_data_i5;
			comp_data[6] <= comp_data_i6;
			comp_data[7] <= comp_data_i7;
			comp_data[8] <= comp_data_i8;
			comp_data[9] <= comp_data_i9;
			comp_data[10] <= comp_data_i10;
			comp_data[11] <= comp_data_i11;
			comp_data[12] <= comp_data_i12;
			comp_data[13] <= comp_data_i13;
			comp_data[14] <= comp_data_i14;
			comp_data[15] <= comp_data_i15;
			comp_data[16] <= comp_data_i16;
/*             if(count == COL_WIDTH)
                comp_valid_f <= 1;
			else
                comp_valid_f <= 0; */
		end
		else begin
			comp_valid_f <= 0;
			//count <= 1;
		end
	end
//------------------------------------------------------------
//--------------------------计算得分--------------------------
	generate
		genvar i;
		for(i=1; i<=COL_WIDTH; i=i+1) begin:unfold_i
			always@(posedge	clk	or	negedge	rst_n) begin
				if(!rst_n) begin	
					comp_valid_i[i] <= 0;
					score_i[i] <= 0;	
				end
				else if(comp_valid_f) begin
                    comp_valid_i[i] <= comp_valid_f;

					if(comp_data[col] > comp_data[i])
						score_i[i] <= 0;
					else if(comp_data[col] == comp_data[i]) begin
						if(col <= i) //如果有两个相同的数据，其中若输入顺序在前面则排序就靠前
							score_i[i] <= 0;
						else
							score_i[i] <= 1;
					end
					else
						score_i[i] <= 1;	
				end
				else begin
					score_i[i] <= 0;
					comp_valid_i[i] <= 0;
				end
			end
		end
	endgenerate
	
//-------------------------------------------------------------------
//--------------------------缓冲一个周期------------------------------
/* 	generate
		genvar j;
			for(j=1; j<=COL_WIDTH; j=j+1) begin:unfold_j
				always @(posedge clk	or negedge rst_n) begin
					if(!rst_n) begin
						score_j[j] <= 0;
						comp_valid_j[j] <= 0;
					end
					else if(comp_valid_i[j]) begin
						score_j[j]	<= score_i[j];
						comp_valid_j[j] <= comp_valid_i[j]; 
					end
					else
						comp_valid_j[j] <= 0;
				end
			end
	endgenerate */
//-------------------------------------------------------------------
//------------------------	此处需要改动长度	----------------------
	always@(posedge	clk	or negedge rst_n) begin
		if(!rst_n) begin
			score <= 0;
			//location <= 0;
			add_cnt <= 0;
			data_o <= 0;
			valid_o <= 0;
		end
		else if(comp_valid_i[1] == 1) begin
			add_cnt <= 0;
			score <= ( ( score_i[1]+score_i[2] ) + ( score_i[3]+score_i[4] ) ) +
					( ( score_i[5]+score_i[6] ) + ( score_i[7]+score_i[8] ) ) +
					( ( score_i[9]+score_i[10] ) + ( score_i[11]+score_i[12] ) ) +
					( ( score_i[13]+score_i[14] ) + ( score_i[15]+score_i[16] ) ) + 1;
			//location <= {row[7:0], col[7:0]};//行,列
			data_o <= comp_data[col];//数据
			valid_o <= 1;
		end
		else begin	
			case(add_cnt)
				0: begin
					add_cnt <= 0;
					data_o <= 0;
					valid_o <= 0;
					//location <= 0;
				end
			endcase
		end
	end
endmodule
