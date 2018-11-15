#quit -sim
vlog topD.v axi_ram.v CoordinateGen.v testD.v
vsim -voptargs=+acc work.test
add wave -position insertpoint sim:/test/dut/*
run 1us
