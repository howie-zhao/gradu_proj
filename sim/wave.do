onerror {resume}
virtual type { IDLE INIT I_ROW_DLY FRONT F_ROW_DLY NORMAL N_ROW_DLY FRM_DLY POST P_ROW_DLY V_START} state_type
quietly virtual function -install /tb_disp_timing/u_blk_extract/u_mem_ctrl -env /tb_disp_timing { (state_type)/tb_disp_timing/u_blk_extract/u_mem_ctrl/blk0_state} fsm_state
quietly virtual function -install /tb_disp_timing/u_blk_extract/u_mem_ctrl -env /tb_disp_timing/u_disp_timing_ctrl { (state_type)/tb_disp_timing/u_blk_extract/u_mem_ctrl/blk0_state} fsm_state001
quietly WaveActivateNextPane {} 0
add wave -noupdate -group {display timing} /tb_disp_timing/u_blk_extract/vref
add wave -noupdate -group {display timing} /tb_disp_timing/u_blk_extract/href
add wave -noupdate -group {display timing} /tb_disp_timing/u_blk_extract/u_mem_ctrl/block0_oe
add wave -noupdate -group {display timing} /tb_disp_timing/u_blk_extract/u_mem_ctrl/block0_ce
add wave -noupdate -group {display timing} -radix binary /tb_disp_timing/u_blk_extract/u_mem_ctrl/block0_we
add wave -noupdate -group {display timing} -radix binary /tb_disp_timing/u_blk_extract/u_mem_ctrl/padding_en
add wave -noupdate -group {display timing} /tb_disp_timing/u_blk_extract/u_mem_ctrl/padding_cnt
add wave -noupdate -group {display timing} -radix unsigned /tb_disp_timing/u_blk_extract/u_mem_ctrl/col_cnt
add wave -noupdate -group {display timing} -radix unsigned /tb_disp_timing/u_blk_extract/u_mem_ctrl/row_cnt
add wave -noupdate -group {display timing} /tb_disp_timing/u_blk_extract/u_mem_ctrl/we0_cnt
add wave -noupdate -group {display timing} -radix unsigned /tb_disp_timing/u_blk_extract/u_mem_ctrl/init_cnt
add wave -noupdate -group {display timing} -color pink /tb_disp_timing/u_blk_extract/u_mem_ctrl/fsm_state
add wave -noupdate -divider {block mem}
add wave -noupdate -group {block mem} {/tb_disp_timing/u_blk_extract/u_block/gen_ram[0]/U0_RAM1920B/clk}
add wave -noupdate -group {block mem} -radix unsigned {/tb_disp_timing/u_blk_extract/u_block/gen_ram[0]/U0_RAM1920B/a}
add wave -noupdate -group {block mem} -radix unsigned -childformat {{{/tb_disp_timing/u_blk_extract/u_block/gen_ram[0]/U0_RAM1920B/d[7]} -radix unsigned} {{/tb_disp_timing/u_blk_extract/u_block/gen_ram[0]/U0_RAM1920B/d[6]} -radix unsigned} {{/tb_disp_timing/u_blk_extract/u_block/gen_ram[0]/U0_RAM1920B/d[5]} -radix unsigned} {{/tb_disp_timing/u_blk_extract/u_block/gen_ram[0]/U0_RAM1920B/d[4]} -radix unsigned} {{/tb_disp_timing/u_blk_extract/u_block/gen_ram[0]/U0_RAM1920B/d[3]} -radix unsigned} {{/tb_disp_timing/u_blk_extract/u_block/gen_ram[0]/U0_RAM1920B/d[2]} -radix unsigned} {{/tb_disp_timing/u_blk_extract/u_block/gen_ram[0]/U0_RAM1920B/d[1]} -radix unsigned} {{/tb_disp_timing/u_blk_extract/u_block/gen_ram[0]/U0_RAM1920B/d[0]} -radix unsigned}} -subitemconfig {{/tb_disp_timing/u_blk_extract/u_block/gen_ram[0]/U0_RAM1920B/d[7]} {-height 15 -radix unsigned} {/tb_disp_timing/u_blk_extract/u_block/gen_ram[0]/U0_RAM1920B/d[6]} {-height 15 -radix unsigned} {/tb_disp_timing/u_blk_extract/u_block/gen_ram[0]/U0_RAM1920B/d[5]} {-height 15 -radix unsigned} {/tb_disp_timing/u_blk_extract/u_block/gen_ram[0]/U0_RAM1920B/d[4]} {-height 15 -radix unsigned} {/tb_disp_timing/u_blk_extract/u_block/gen_ram[0]/U0_RAM1920B/d[3]} {-height 15 -radix unsigned} {/tb_disp_timing/u_blk_extract/u_block/gen_ram[0]/U0_RAM1920B/d[2]} {-height 15 -radix unsigned} {/tb_disp_timing/u_blk_extract/u_block/gen_ram[0]/U0_RAM1920B/d[1]} {-height 15 -radix unsigned} {/tb_disp_timing/u_blk_extract/u_block/gen_ram[0]/U0_RAM1920B/d[0]} {-height 15 -radix unsigned}} {/tb_disp_timing/u_blk_extract/u_block/gen_ram[0]/U0_RAM1920B/d}
add wave -noupdate -group {block mem} {/tb_disp_timing/u_blk_extract/u_block/gen_ram[0]/U0_RAM1920B/we}
add wave -noupdate -group {block mem} -radix unsigned {/tb_disp_timing/u_blk_extract/u_block/gen_ram[0]/U0_RAM1920B/spo}
add wave -noupdate -group {block mem} {/tb_disp_timing/u_blk_extract/u_block/gen_ram[1]/U0_RAM1920B/we}
add wave -noupdate -group {block mem} -radix unsigned {/tb_disp_timing/u_blk_extract/u_block/gen_ram[1]/U0_RAM1920B/spo}
add wave -noupdate -group {block mem} {/tb_disp_timing/u_blk_extract/u_block/gen_ram[2]/U0_RAM1920B/we}
add wave -noupdate -group {block mem} -radix unsigned {/tb_disp_timing/u_blk_extract/u_block/gen_ram[2]/U0_RAM1920B/spo}
add wave -noupdate -group {block mem} {/tb_disp_timing/u_blk_extract/u_block/gen_ram[3]/U0_RAM1920B/we}
add wave -noupdate -group {block mem} -radix unsigned {/tb_disp_timing/u_blk_extract/u_block/gen_ram[3]/U0_RAM1920B/spo}
add wave -noupdate -group {block mem} {/tb_disp_timing/u_blk_extract/u_block/gen_ram[4]/U0_RAM1920B/we}
add wave -noupdate -group {block mem} -radix unsigned {/tb_disp_timing/u_blk_extract/u_block/gen_ram[4]/U0_RAM1920B/spo}
add wave -noupdate -group {block mem} {/tb_disp_timing/u_blk_extract/u_block/gen_ram[5]/U0_RAM1920B/we}
add wave -noupdate -group {block mem} -radix unsigned {/tb_disp_timing/u_blk_extract/u_block/gen_ram[5]/U0_RAM1920B/spo}
add wave -noupdate -group {block mem} {/tb_disp_timing/u_blk_extract/u_block/gen_ram[6]/U0_RAM1920B/we}
add wave -noupdate -group {block mem} -radix unsigned {/tb_disp_timing/u_blk_extract/u_block/gen_ram[6]/U0_RAM1920B/spo}
add wave -noupdate -group {block mem} {/tb_disp_timing/u_blk_extract/u_block/gen_ram[7]/U0_RAM1920B/we}
add wave -noupdate -group {block mem} -radix unsigned {/tb_disp_timing/u_blk_extract/u_block/gen_ram[7]/U0_RAM1920B/spo}
add wave -noupdate -divider {mem out}
add wave -noupdate -group {mem out} /tb_disp_timing/u_blk_extract/u_mem_output/block0_oe
add wave -noupdate -group {mem out} /tb_disp_timing/u_blk_extract/u_mem_output/block_oe_1d
add wave -noupdate -group {mem out} -radix binary /tb_disp_timing/u_blk_extract/u_mem_output/block0_ce_1d
add wave -noupdate -group {mem out} /tb_disp_timing/u_blk_extract/u_mem_output/blk0_rdata0
add wave -noupdate -group {mem out} /tb_disp_timing/u_blk_extract/u_mem_output/blk0_rdata1
add wave -noupdate -group {mem out} /tb_disp_timing/u_blk_extract/u_mem_output/blk0_rdata2
add wave -noupdate -group {mem out} /tb_disp_timing/u_blk_extract/u_mem_output/blk0_rdata3
add wave -noupdate -group {mem out} /tb_disp_timing/u_blk_extract/u_mem_output/blk0_rdata4
add wave -noupdate -group {mem out} /tb_disp_timing/u_blk_extract/u_mem_output/blk0_rdata5
add wave -noupdate -group {mem out} /tb_disp_timing/u_blk_extract/u_mem_output/blk0_rdata6
add wave -noupdate -group {mem out} /tb_disp_timing/u_blk_extract/u_mem_output/blk0_rdata7
add wave -noupdate -group {mem out} /tb_disp_timing/u_blk_extract/u_mem_output/padding_en
add wave -noupdate -group {mem out} -radix unsigned {/tb_disp_timing/u_blk_extract/u_block/gen_ram[0]/U0_RAM1920B/a}
add wave -noupdate -group {mem out} /tb_disp_timing/u_blk_extract/u_mem_output/srh_vld
add wave -noupdate -group {mem out} /tb_disp_timing/u_blk_extract/u_mem_output/srh0
add wave -noupdate -group {mem out} /tb_disp_timing/u_blk_extract/u_mem_output/srh1
add wave -noupdate -group {mem out} /tb_disp_timing/u_blk_extract/u_mem_output/srh2
add wave -noupdate -group {mem out} /tb_disp_timing/u_blk_extract/u_mem_output/srh3
add wave -noupdate -group {mem out} /tb_disp_timing/u_blk_extract/u_mem_output/srh4
add wave -noupdate -group {mem out} /tb_disp_timing/u_blk_extract/u_mem_output/srh5
add wave -noupdate -group {mem out} /tb_disp_timing/u_blk_extract/u_mem_output/srh6
add wave -noupdate -group {mem out} /tb_disp_timing/u_blk_extract/u_mem_output/ref_vld
add wave -noupdate -group {mem out} /tb_disp_timing/u_blk_extract/u_mem_output/ref0
add wave -noupdate -group {mem out} /tb_disp_timing/u_blk_extract/u_mem_output/ref1
add wave -noupdate -group {mem out} /tb_disp_timing/u_blk_extract/u_mem_output/ref2
add wave -noupdate -group {mem out} /tb_disp_timing/u_blk_extract/u_mem_output/ref3
add wave -noupdate -group {mem out} /tb_disp_timing/u_blk_extract/u_mem_output/nsy_vld
add wave -noupdate -group {mem out} /tb_disp_timing/u_blk_extract/u_mem_output/nsy_pix
add wave -noupdate -group {mem out} /tb_disp_timing/u_blk_extract/u_mem_output/srh_state
add wave -noupdate -divider pe
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/clk}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/rst_n}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/en}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/ref0}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/ref1}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/ref2}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/ref3}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/srh0}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/srh1}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/srh2}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/srh3}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/srh4}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/srh5}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/srh6}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/en_o}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/ref0_o}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/ref1_o}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/ref2_o}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/ref3_o}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/srh0_o}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/srh1_o}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/srh2_o}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/srh3_o}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/srh4_o}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/srh5_o}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/srh6_o}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/en_sqr}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/sqr_valid}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/z0}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/z1}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/z2}
add wave -noupdate -expand -group pe00 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/z3}
add wave -noupdate -group pe10 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[1]/genblk1/u_pe/en}
add wave -noupdate -group pe10 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[1]/genblk1/u_pe/ref0}
add wave -noupdate -group pe10 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[1]/genblk1/u_pe/ref1}
add wave -noupdate -group pe10 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[1]/genblk1/u_pe/ref2}
add wave -noupdate -group pe10 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[1]/genblk1/u_pe/ref3}
add wave -noupdate -group pe10 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[1]/genblk1/u_pe/srh0}
add wave -noupdate -group pe10 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[1]/genblk1/u_pe/srh1}
add wave -noupdate -group pe10 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[1]/genblk1/u_pe/srh2}
add wave -noupdate -group pe10 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[1]/genblk1/u_pe/srh3}
add wave -noupdate -group pe10 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[1]/genblk1/u_pe/srh4}
add wave -noupdate -group pe10 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[1]/genblk1/u_pe/srh5}
add wave -noupdate -group pe10 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[1]/genblk1/u_pe/srh6}
add wave -noupdate -group pe10 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[1]/genblk1/u_pe/en_o}
add wave -noupdate -group pe10 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[1]/genblk1/u_pe/en_sqr}
add wave -noupdate -group pe10 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[1]/genblk1/u_pe/sqr_valid}
add wave -noupdate -group pe10 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[1]/genblk1/u_pe/z0}
add wave -noupdate -group pe10 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[1]/genblk1/u_pe/z1}
add wave -noupdate -group pe10 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[1]/genblk1/u_pe/z2}
add wave -noupdate -group pe10 {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[1]/genblk1/u_pe/z3}
add wave -noupdate -radix unsigned {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/ssd_o}
add wave -noupdate -radix unsigned {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[0]/genblk1/u_pe/ssd_ovalid}
add wave -noupdate -radix unsigned {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[1]/genblk1/u_pe/ssd_o}
add wave -noupdate -radix unsigned {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[1]/genblk1/u_pe/ssd_ovalid}
add wave -noupdate -expand -group pe20 -radix unsigned {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[2]/genblk1/u_pe/ssd_o}
add wave -noupdate -expand -group pe20 -radix unsigned {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[2]/genblk1/u_pe/ssd_ovalid}
add wave -noupdate -expand -group pe30 -radix unsigned {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[3]/genblk1/u_pe/ssd_o}
add wave -noupdate -expand -group pe30 -radix unsigned {/tb_disp_timing/u_pe_top/pe_col[0]/pe_row[3]/genblk1/u_pe/ssd_ovalid}
add wave -noupdate -expand -group pe01 -radix unsigned {/tb_disp_timing/u_pe_top/pe_col[1]/pe_row[0]/genblk1/u_pe/ssd_o}
add wave -noupdate -expand -group pe01 -radix unsigned {/tb_disp_timing/u_pe_top/pe_col[1]/pe_row[0]/genblk1/u_pe/ssd_ovalid}
add wave -noupdate -expand -group pe11 -radix unsigned {/tb_disp_timing/u_pe_top/pe_col[1]/pe_row[1]/genblk1/u_pe/ssd_o}
add wave -noupdate -expand -group pe11 -radix unsigned {/tb_disp_timing/u_pe_top/pe_col[1]/pe_row[1]/genblk1/u_pe/ssd_ovalid}
add wave -noupdate -expand -group pe21 -radix unsigned {/tb_disp_timing/u_pe_top/pe_col[1]/pe_row[2]/genblk1/u_pe/ssd_o}
add wave -noupdate -expand -group pe21 -radix unsigned {/tb_disp_timing/u_pe_top/pe_col[1]/pe_row[2]/genblk1/u_pe/ssd_ovalid}
add wave -noupdate -expand -group pe31 -radix unsigned {/tb_disp_timing/u_pe_top/pe_col[1]/pe_row[3]/genblk1/u_pe/ssd_o}
add wave -noupdate -expand -group pe31 -radix unsigned {/tb_disp_timing/u_pe_top/pe_col[1]/pe_row[3]/genblk1/u_pe/ssd_ovalid}
add wave -noupdate -divider output
add wave -noupdate -radix binary -childformat {{{/tb_disp_timing/u_pe_top/ssd_ovalid_d[15]} -radix unsigned} {{/tb_disp_timing/u_pe_top/ssd_ovalid_d[14]} -radix unsigned} {{/tb_disp_timing/u_pe_top/ssd_ovalid_d[13]} -radix unsigned} {{/tb_disp_timing/u_pe_top/ssd_ovalid_d[12]} -radix unsigned} {{/tb_disp_timing/u_pe_top/ssd_ovalid_d[11]} -radix unsigned} {{/tb_disp_timing/u_pe_top/ssd_ovalid_d[10]} -radix unsigned} {{/tb_disp_timing/u_pe_top/ssd_ovalid_d[9]} -radix unsigned} {{/tb_disp_timing/u_pe_top/ssd_ovalid_d[8]} -radix unsigned} {{/tb_disp_timing/u_pe_top/ssd_ovalid_d[7]} -radix unsigned} {{/tb_disp_timing/u_pe_top/ssd_ovalid_d[6]} -radix unsigned} {{/tb_disp_timing/u_pe_top/ssd_ovalid_d[5]} -radix unsigned} {{/tb_disp_timing/u_pe_top/ssd_ovalid_d[4]} -radix unsigned} {{/tb_disp_timing/u_pe_top/ssd_ovalid_d[3]} -radix unsigned} {{/tb_disp_timing/u_pe_top/ssd_ovalid_d[2]} -radix unsigned} {{/tb_disp_timing/u_pe_top/ssd_ovalid_d[1]} -radix unsigned} {{/tb_disp_timing/u_pe_top/ssd_ovalid_d[0]} -radix unsigned}} -subitemconfig {{/tb_disp_timing/u_pe_top/ssd_ovalid_d[15]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/ssd_ovalid_d[14]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/ssd_ovalid_d[13]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/ssd_ovalid_d[12]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/ssd_ovalid_d[11]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/ssd_ovalid_d[10]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/ssd_ovalid_d[9]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/ssd_ovalid_d[8]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/ssd_ovalid_d[7]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/ssd_ovalid_d[6]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/ssd_ovalid_d[5]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/ssd_ovalid_d[4]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/ssd_ovalid_d[3]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/ssd_ovalid_d[2]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/ssd_ovalid_d[1]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/ssd_ovalid_d[0]} {-height 15 -radix unsigned}} /tb_disp_timing/u_pe_top/ssd_ovalid_d
add wave -noupdate -radix unsigned {/tb_disp_timing/u_pe_top/ssd_ovalid_d[0]}
add wave -noupdate -radix unsigned -childformat {{{/tb_disp_timing/u_pe_top/ssd_o_d[15]} -radix unsigned} {{/tb_disp_timing/u_pe_top/ssd_o_d[14]} -radix unsigned} {{/tb_disp_timing/u_pe_top/ssd_o_d[13]} -radix unsigned} {{/tb_disp_timing/u_pe_top/ssd_o_d[12]} -radix unsigned} {{/tb_disp_timing/u_pe_top/ssd_o_d[11]} -radix unsigned} {{/tb_disp_timing/u_pe_top/ssd_o_d[10]} -radix unsigned} {{/tb_disp_timing/u_pe_top/ssd_o_d[9]} -radix unsigned} {{/tb_disp_timing/u_pe_top/ssd_o_d[8]} -radix unsigned} {{/tb_disp_timing/u_pe_top/ssd_o_d[7]} -radix unsigned} {{/tb_disp_timing/u_pe_top/ssd_o_d[6]} -radix unsigned} {{/tb_disp_timing/u_pe_top/ssd_o_d[5]} -radix unsigned} {{/tb_disp_timing/u_pe_top/ssd_o_d[4]} -radix unsigned} {{/tb_disp_timing/u_pe_top/ssd_o_d[3]} -radix unsigned} {{/tb_disp_timing/u_pe_top/ssd_o_d[2]} -radix unsigned} {{/tb_disp_timing/u_pe_top/ssd_o_d[1]} -radix unsigned} {{/tb_disp_timing/u_pe_top/ssd_o_d[0]} -radix unsigned}} -expand -subitemconfig {{/tb_disp_timing/u_pe_top/ssd_o_d[15]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/ssd_o_d[14]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/ssd_o_d[13]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/ssd_o_d[12]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/ssd_o_d[11]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/ssd_o_d[10]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/ssd_o_d[9]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/ssd_o_d[8]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/ssd_o_d[7]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/ssd_o_d[6]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/ssd_o_d[5]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/ssd_o_d[4]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/ssd_o_d[3]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/ssd_o_d[2]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/ssd_o_d[1]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/ssd_o_d[0]} {-height 15 -radix unsigned}} /tb_disp_timing/u_pe_top/ssd_o_d
add wave -noupdate -divider {sort result}
add wave -noupdate -childformat {{{/tb_disp_timing/u_pe_top/u_sort_parallel/score[16]} -radix unsigned} {{/tb_disp_timing/u_pe_top/u_sort_parallel/score[15]} -radix unsigned} {{/tb_disp_timing/u_pe_top/u_sort_parallel/score[14]} -radix unsigned} {{/tb_disp_timing/u_pe_top/u_sort_parallel/score[13]} -radix unsigned} {{/tb_disp_timing/u_pe_top/u_sort_parallel/score[12]} -radix unsigned} {{/tb_disp_timing/u_pe_top/u_sort_parallel/score[11]} -radix unsigned} {{/tb_disp_timing/u_pe_top/u_sort_parallel/score[10]} -radix unsigned} {{/tb_disp_timing/u_pe_top/u_sort_parallel/score[9]} -radix unsigned} {{/tb_disp_timing/u_pe_top/u_sort_parallel/score[8]} -radix unsigned} {{/tb_disp_timing/u_pe_top/u_sort_parallel/score[7]} -radix unsigned} {{/tb_disp_timing/u_pe_top/u_sort_parallel/score[6]} -radix unsigned} {{/tb_disp_timing/u_pe_top/u_sort_parallel/score[5]} -radix unsigned} {{/tb_disp_timing/u_pe_top/u_sort_parallel/score[4]} -radix unsigned} {{/tb_disp_timing/u_pe_top/u_sort_parallel/score[3]} -radix unsigned} {{/tb_disp_timing/u_pe_top/u_sort_parallel/score[2]} -radix unsigned} {{/tb_disp_timing/u_pe_top/u_sort_parallel/score[1]} -radix unsigned}} -expand -subitemconfig {{/tb_disp_timing/u_pe_top/u_sort_parallel/score[16]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/u_sort_parallel/score[15]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/u_sort_parallel/score[14]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/u_sort_parallel/score[13]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/u_sort_parallel/score[12]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/u_sort_parallel/score[11]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/u_sort_parallel/score[10]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/u_sort_parallel/score[9]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/u_sort_parallel/score[8]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/u_sort_parallel/score[7]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/u_sort_parallel/score[6]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/u_sort_parallel/score[5]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/u_sort_parallel/score[4]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/u_sort_parallel/score[3]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/u_sort_parallel/score[2]} {-height 15 -radix unsigned} {/tb_disp_timing/u_pe_top/u_sort_parallel/score[1]} {-height 15 -radix unsigned}} /tb_disp_timing/u_pe_top/u_sort_parallel/score
add wave -noupdate /tb_disp_timing/u_pe_top/score_done
add wave -noupdate /tb_disp_timing/u_pe_top/u_sort_parallel/sort_done
add wave -noupdate /tb_disp_timing/u_pe_top/srst
add wave -noupdate /tb_disp_timing/u_pe_top/wr_en
add wave -noupdate /tb_disp_timing/u_pe_top/rd_en
add wave -noupdate /tb_disp_timing/u_pe_top/read_en_ctrl
add wave -noupdate /tb_disp_timing/u_pe_top/full
add wave -noupdate /tb_disp_timing/u_pe_top/empty
add wave -noupdate -expand /tb_disp_timing/u_pe_top/blk_fifo_o
add wave -noupdate /tb_disp_timing/u_pe_top/out_valid
add wave -noupdate -expand /tb_disp_timing/u_pe_top/sort_blk
add wave -noupdate -expand -group {pe blk output} /tb_disp_timing/u_pe_top/blk_ovalid
add wave -noupdate -expand -group {pe blk output} /tb_disp_timing/u_pe_top/blk0_o
add wave -noupdate -expand -group {pe blk output} /tb_disp_timing/u_pe_top/blk1_o
add wave -noupdate -expand -group {pe blk output} /tb_disp_timing/u_pe_top/blk2_o
add wave -noupdate -expand -group {pe blk output} /tb_disp_timing/u_pe_top/blk3_o
add wave -noupdate -expand -group {pe blk output} /tb_disp_timing/u_pe_top/blk4_o
add wave -noupdate -expand -group {pe blk output} /tb_disp_timing/u_pe_top/blk5_o
add wave -noupdate -expand -group {pe blk output} /tb_disp_timing/u_pe_top/blk6_o
add wave -noupdate -expand -group {pe blk output} /tb_disp_timing/u_pe_top/blk7_o
add wave -noupdate -expand -group {pe blk output} /tb_disp_timing/u_pe_top/blk8_o
add wave -noupdate -expand -group {pe blk output} /tb_disp_timing/u_pe_top/blk9_o
add wave -noupdate -expand -group {pe blk output} /tb_disp_timing/u_pe_top/blk10_o
add wave -noupdate -expand -group {pe blk output} /tb_disp_timing/u_pe_top/blk11_o
add wave -noupdate -expand -group {pe blk output} /tb_disp_timing/u_pe_top/blk12_o
add wave -noupdate -expand -group {pe blk output} /tb_disp_timing/u_pe_top/blk13_o
add wave -noupdate -expand -group {pe blk output} /tb_disp_timing/u_pe_top/blk14_o
add wave -noupdate -expand -group {pe blk output} /tb_disp_timing/u_pe_top/blk15_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{normal begin} {16800025014 ps} 1} {1 {16694404181 ps} 1} {{normal end} {32680407162 ps} 1} {{we end} {17479588581 ps} 1} {{line begin} {19007405235 ps} 1} {{Cursor 6} {19005546651 ps} 1} {{blk fifo output begin} {16755730509 ps} 1} {{Cursor 8} {16755722681 ps} 0}
quietly wave cursor active 8
configure wave -namecolwidth 416
configure wave -valuecolwidth 102
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {16755536206 ps} {16755689818 ps}
