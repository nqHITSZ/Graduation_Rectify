quit -sim
#vmap -del work
#vdel -all -lib work
.main clear

vlib work
vmap work ./work

vlog -work work *.v
#vlog -work work ./sim_video/sim_video.v
vsim -voptargs=+acc    work.test
do wave.do
run 1us
run 4us