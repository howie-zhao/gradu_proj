onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_disp_timing/u_wht_2d_forward/clk
add wave -noupdate /tb_disp_timing/u_wht_2d_forward/rst_n
add wave -noupdate /tb_disp_timing/u_wht_2d_forward/blk_i
add wave -noupdate /tb_disp_timing/u_wht_2d_forward/blk_valid
add wave -noupdate -radix sfixed /tb_disp_timing/u_wht_2d_forward/pix_out0
add wave -noupdate -radix sfixed /tb_disp_timing/u_wht_2d_forward/pix_out1
add wave -noupdate -radix sfixed /tb_disp_timing/u_wht_2d_forward/pix_out2
add wave -noupdate -radix sfixed /tb_disp_timing/u_wht_2d_forward/pix_out3
add wave -noupdate /tb_disp_timing/u_wht_2d_forward/pix_ovalid
add wave -noupdate -radix sfixed {/tb_disp_timing/u_wht_2d_forward/pix[0]}
add wave -noupdate -radix sfixed {/tb_disp_timing/u_wht_2d_forward/pix[1]}
add wave -noupdate -radix sfixed {/tb_disp_timing/u_wht_2d_forward/pix[2]}
add wave -noupdate -radix sfixed {/tb_disp_timing/u_wht_2d_forward/pix[3]}
add wave -noupdate -childformat {{{/tb_disp_timing/u_wht_2d_forward/cal_pix[3]} -radix sfixed} {{/tb_disp_timing/u_wht_2d_forward/cal_pix[2]} -radix sfixed} {{/tb_disp_timing/u_wht_2d_forward/cal_pix[1]} -radix sfixed} {{/tb_disp_timing/u_wht_2d_forward/cal_pix[0]} -radix sfixed}} -expand -subitemconfig {{/tb_disp_timing/u_wht_2d_forward/cal_pix[3]} {-height 15 -radix sfixed} {/tb_disp_timing/u_wht_2d_forward/cal_pix[2]} {-height 15 -radix sfixed} {/tb_disp_timing/u_wht_2d_forward/cal_pix[1]} {-height 15 -radix sfixed} {/tb_disp_timing/u_wht_2d_forward/cal_pix[0]} {-height 15 -radix sfixed}} /tb_disp_timing/u_wht_2d_forward/cal_pix
add wave -noupdate /tb_disp_timing/u_wht_2d_forward/cal_cnt
add wave -noupdate /tb_disp_timing/u_wht_2d_forward/blk_valid_d
add wave -noupdate /tb_disp_timing/u_wht_2d_forward/blk_valid_d2
add wave -noupdate /tb_disp_timing/u_wht_2d_forward/row_buffer0
add wave -noupdate /tb_disp_timing/u_wht_2d_forward/row_buffer1
add wave -noupdate /tb_disp_timing/u_wht_2d_forward/row_buffer2
add wave -noupdate /tb_disp_timing/u_wht_2d_forward/row_buffer3
add wave -noupdate /tb_disp_timing/u_wht_2d_forward/row_pix_vld
add wave -noupdate -childformat {{{/tb_disp_timing/u_wht_2d_forward/row_pix[3]} -radix sfixed} {{/tb_disp_timing/u_wht_2d_forward/row_pix[2]} -radix sfixed} {{/tb_disp_timing/u_wht_2d_forward/row_pix[1]} -radix sfixed} {{/tb_disp_timing/u_wht_2d_forward/row_pix[0]} -radix sfixed}} -expand -subitemconfig {{/tb_disp_timing/u_wht_2d_forward/row_pix[3]} {-height 15 -radix sfixed} {/tb_disp_timing/u_wht_2d_forward/row_pix[2]} {-height 15 -radix sfixed} {/tb_disp_timing/u_wht_2d_forward/row_pix[1]} {-height 15 -radix sfixed} {/tb_disp_timing/u_wht_2d_forward/row_pix[0]} {-height 15 -radix sfixed}} /tb_disp_timing/u_wht_2d_forward/row_pix
add wave -noupdate /tb_disp_timing/u_wht_2d_forward/row_pix_i
add wave -noupdate /tb_disp_timing/u_wht_2d_forward/row_pix_cnt
add wave -noupdate /tb_disp_timing/f_pix_ovalid
add wave -noupdate /tb_disp_timing/pix_i
add wave -noupdate -expand -group reverse /tb_disp_timing/u_wht_2d_reverse/clk
add wave -noupdate -expand -group reverse /tb_disp_timing/u_wht_2d_reverse/rst_n
add wave -noupdate -expand -group reverse /tb_disp_timing/u_wht_2d_reverse/blk_i
add wave -noupdate -expand -group reverse /tb_disp_timing/u_wht_2d_reverse/blk_valid
add wave -noupdate -expand -group reverse -radix sfixed -childformat {{{/tb_disp_timing/u_wht_2d_reverse/pix[3]} -radix sfixed} {{/tb_disp_timing/u_wht_2d_reverse/pix[2]} -radix sfixed} {{/tb_disp_timing/u_wht_2d_reverse/pix[1]} -radix sfixed} {{/tb_disp_timing/u_wht_2d_reverse/pix[0]} -radix sfixed}} -expand -subitemconfig {{/tb_disp_timing/u_wht_2d_reverse/pix[3]} {-height 15 -radix sfixed} {/tb_disp_timing/u_wht_2d_reverse/pix[2]} {-height 15 -radix sfixed} {/tb_disp_timing/u_wht_2d_reverse/pix[1]} {-height 15 -radix sfixed} {/tb_disp_timing/u_wht_2d_reverse/pix[0]} {-height 15 -radix sfixed}} /tb_disp_timing/u_wht_2d_reverse/pix
add wave -noupdate -expand -group reverse -childformat {{{/tb_disp_timing/u_wht_2d_reverse/cal_pix[3]} -radix sfixed} {{/tb_disp_timing/u_wht_2d_reverse/cal_pix[2]} -radix sfixed} {{/tb_disp_timing/u_wht_2d_reverse/cal_pix[1]} -radix sfixed} {{/tb_disp_timing/u_wht_2d_reverse/cal_pix[0]} -radix sfixed}} -expand -subitemconfig {{/tb_disp_timing/u_wht_2d_reverse/cal_pix[3]} {-height 15 -radix sfixed} {/tb_disp_timing/u_wht_2d_reverse/cal_pix[2]} {-height 15 -radix sfixed} {/tb_disp_timing/u_wht_2d_reverse/cal_pix[1]} {-height 15 -radix sfixed} {/tb_disp_timing/u_wht_2d_reverse/cal_pix[0]} {-height 15 -radix sfixed}} /tb_disp_timing/u_wht_2d_reverse/cal_pix
add wave -noupdate -expand -group reverse /tb_disp_timing/u_wht_2d_reverse/cal_cnt
add wave -noupdate -expand -group reverse /tb_disp_timing/u_wht_2d_reverse/blk_valid_d
add wave -noupdate -expand -group reverse /tb_disp_timing/u_wht_2d_reverse/blk_valid_d2
add wave -noupdate -expand -group reverse /tb_disp_timing/u_wht_2d_reverse/row_buffer0
add wave -noupdate -expand -group reverse /tb_disp_timing/u_wht_2d_reverse/row_buffer1
add wave -noupdate -expand -group reverse /tb_disp_timing/u_wht_2d_reverse/row_buffer2
add wave -noupdate -expand -group reverse /tb_disp_timing/u_wht_2d_reverse/row_buffer3
add wave -noupdate -expand -group reverse /tb_disp_timing/u_wht_2d_reverse/row_pix_vld
add wave -noupdate -expand -group reverse /tb_disp_timing/u_wht_2d_reverse/row_pix
add wave -noupdate -expand -group reverse /tb_disp_timing/u_wht_2d_reverse/row_pix_i
add wave -noupdate -expand -group reverse /tb_disp_timing/u_wht_2d_reverse/row_pix_cnt
add wave -noupdate /tb_disp_timing/r_pix_ovalid
add wave -noupdate /tb_disp_timing/u_wht_2d_reverse/pix_ovalid
add wave -noupdate -radix unsigned /tb_disp_timing/u_wht_2d_reverse/pix_out0
add wave -noupdate -radix sfixed /tb_disp_timing/u_wht_2d_reverse/pix_out1
add wave -noupdate -radix sfixed /tb_disp_timing/u_wht_2d_reverse/pix_out2
add wave -noupdate -radix sfixed /tb_disp_timing/u_wht_2d_reverse/pix_out3
add wave -noupdate /tb_disp_timing/pix_rev0
add wave -noupdate /tb_disp_timing/pix_rev1
add wave -noupdate /tb_disp_timing/pix_rev2
add wave -noupdate /tb_disp_timing/pix_rev3
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2423 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 162
configure wave -valuecolwidth 238
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {0 ns} {3150 ns}
