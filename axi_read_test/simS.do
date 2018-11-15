write format wave -window .main_pane.wave.interior.cs.body.pw.wf F:/TEST/Graduation_Rectify/axi_read_test/waveS.do
quit -sim
vlog topS.v axi_ram.v CoordinateGen.v testS.v
vsim -voptargs=+acc work.test
source wave.do
run 1us