quit -sim
.main clear
vlib ./work
vmap work ./work
vlog -work work coor_warper.v test.v
vsim -voptargs=+acc work.test
do wave.do
run 1us
