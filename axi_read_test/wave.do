onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test/dut/clk
add wave -noupdate /test/dut/rst
add wave -noupdate /test/dut/_tready
add wave -noupdate /test/dut/_tdata
add wave -noupdate /test/dut/_tvalid
add wave -noupdate /test/dut/_tlast
add wave -noupdate /test/dut/s_axi_awid
add wave -noupdate /test/dut/s_axi_awaddr
add wave -noupdate /test/dut/s_axi_awlen
add wave -noupdate /test/dut/s_axi_awsize
add wave -noupdate /test/dut/s_axi_awburst
add wave -noupdate /test/dut/s_axi_awvalid
add wave -noupdate /test/dut/s_axi_wdata
add wave -noupdate /test/dut/s_axi_wstrb
add wave -noupdate /test/dut/s_axi_wlast
add wave -noupdate /test/dut/s_axi_wvalid
add wave -noupdate /test/dut/s_axi_bready
add wave -noupdate /test/dut/s_axi_arid
add wave -noupdate /test/dut/s_axi_araddr
add wave -noupdate /test/dut/s_axi_arlen
add wave -noupdate /test/dut/s_axi_arsize
add wave -noupdate /test/dut/s_axi_arburst
add wave -noupdate /test/dut/s_axi_arlock
add wave -noupdate /test/dut/s_axi_arcache
add wave -noupdate /test/dut/s_axi_arprot
add wave -noupdate /test/dut/s_axi_arvalid
add wave -noupdate /test/dut/s_axi_rready
add wave -noupdate /test/dut/s_axi_awready
add wave -noupdate /test/dut/s_axi_wready
add wave -noupdate /test/dut/s_axi_bid
add wave -noupdate /test/dut/s_axi_bresp
add wave -noupdate /test/dut/s_axi_bvalid
add wave -noupdate /test/dut/s_axi_arready
add wave -noupdate /test/dut/s_axi_rid
add wave -noupdate /test/dut/s_axi_rdata
add wave -noupdate /test/dut/s_axi_rresp
add wave -noupdate /test/dut/s_axi_rlast
add wave -noupdate /test/dut/s_axi_rvalid
add wave -noupdate /test/dut/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {79878 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 179
configure wave -valuecolwidth 89
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ms
update
WaveRestoreZoom {0 ps} {406742 ps}
