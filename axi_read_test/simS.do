write format wave -window .main_pane.wave.interior.cs.body.pw.wf F:/TEST/Graduation_Rectify/axi_read_test/wave.do
quit -sim
vlog top.v axi_ram.v CoordinateGen.v test.v
vsim -voptargs=+acc work.test
source wave.do
run 1us