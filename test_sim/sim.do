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
vlog -F flist.f

# 有优化sim
vsim work.tb_disp_timing -voptargs=+acc=bcglnprst

# =========================<     添加波形     >===============================
# do {fsm.do}
do {wave.do}
# =========================<     仿真时间     >===============================
# 60hz; per frame time: 1/60s
# 3 frames
#run 18ms

#run -all
