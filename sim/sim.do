# ========================< 清空软件残留信息 >==============================
# 退出之前仿真
quit -sim
# 清空信息
.main clear
# =========================< 建立工程并仿真 >===============================
# 建立新的工程库
vlib work
# 映射逻辑库到物理目录
vmap work work

# 编译仿真文件(testbench)
vlog -F D:/backup/workspace/gradu_proj/src/flist/flist.f

# 无优化sim
# vsim -novopt -L lpm -L altera_mf -L cyclone -L altera_primitive work.testbench # altera devices
# vsim -novopt work.tb_disp_timing 

# 有优化sim
vsim work.tb_disp_timing -voptargs=+acc=bcglnprst -L D:/questasim64_10.7c/vivado201901_lib/unisims_ver

# =========================<     添加波形     >===============================
# do {fsm.do}
do {wave.do}
# =========================<     仿真时间     >===============================
# 60hz; per frame time: 1/60s
# 3 frames
#run 18ms

#run -all
