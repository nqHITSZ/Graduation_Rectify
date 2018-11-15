quit -sim
#vmap -del work
#vdel -all -lib work
.main clear

vlib work
vmap work ./work

vlog -work work interpolator_raw.v raw_test.v
vsim -voptargs=+acc    work.test
do wave.do
run 1us
