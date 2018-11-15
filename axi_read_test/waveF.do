onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test/dut/start
add wave -noupdate /test/dut/m_axi_aclk
add wave -noupdate /test/dut/m_axi_aresetn
add wave -noupdate /test/dut/m_axi_arlen
add wave -noupdate /test/dut/m_axi_arsize
add wave -noupdate /test/dut/m_axi_arburst
add wave -noupdate -color Cyan /test/dut/m_axi_araddr
add wave -noupdate -color Salmon /test/dut/m_axi_arvalid
add wave -noupdate -color Gold /test/dut/m_axi_arready
add wave -noupdate -color Cyan /test/dut/m_axi_rdata
add wave -noupdate -color Cyan /test/dut/m_axi_rlast
add wave -noupdate -color Salmon /test/dut/m_axi_rvalid
add wave -noupdate -color Gold /test/dut/m_axi_rready
add wave -noupdate /test/dut/m_axis_tdata
add wave -noupdate -color Cyan /test/dut/m_axis_tlast
add wave -noupdate -color Coral /test/dut/m_axis_tvalid
add wave -noupdate -color Gold /test/dut/m_axis_tready
add wave -noupdate -color Cyan /test/dut/s_axis_tdata
add wave -noupdate -color Cyan /test/dut/s_axis_tlast
add wave -noupdate -color Salmon /test/dut/s_axis_tvalid
add wave -noupdate -color Gold /test/dut/s_axis_tready
add wave -noupdate -color {Blue Violet} /test/dut/state
add wave -noupdate /test/s_axis_tdata
add wave -noupdate -expand /test/dut/data_buf
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {561538 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 168
configure wave -valuecolwidth 85
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
WaveRestoreZoom {331335 ps} {835995 ps}
