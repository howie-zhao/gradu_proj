virtual type { {4'b0000 IDLE} {4'b0001 INIT} {4'b0010 I_ROW_DLY} {4'b0011 FRONT} {4'b0100 F_ROW_DLY} {4'b0101 NORMAL} {4'b0110 N_ROW_DLY} {4'b0111 FRM_DLY} {4'b1000 POST} {4'b1001 P_ROW_DLY} {4'b1010 V_START} } state_type
virtual function {(state_type)/tb_disp_timing/u_blk_extract/u_mem_ctrl/blk0_state} fsm_state

add wave -color pink /tb_disp_timing/u_blk_extract/u_mem_ctrl/fsm_state