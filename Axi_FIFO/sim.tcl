quit -sim
.main clear

vlib work
vmap work ./work

vlog -work work *.v
vsim -voptargs=+acc    work.test
do wave.do
run 1us
