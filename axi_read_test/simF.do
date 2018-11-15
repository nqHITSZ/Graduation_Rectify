
write format wave -window .main_pane.wave.interior.cs.body.pw.wf F:/TEST/Graduation_Rectify/axi_read_test/waveF.do
quit -sim
vlog fetch.v axi_ram.v CoordinateGen.v fetch_tb.v
vsim -voptargs=+acc work.test
source waveF.do
run 1us
