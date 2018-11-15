onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test/u_fetch/start
add wave -noupdate /test/u_fetch/m_axi_aclk
add wave -noupdate /test/u_fetch/m_axi_aresetn
add wave -noupdate /test/u_fetch/state_out
add wave -noupdate /test/u_fetch/m_axi_arsize
add wave -noupdate /test/u_fetch/m_axi_araddr
add wave -noupdate /test/u_fetch/m_axi_arvalid
add wave -noupdate -color Yellow /test/u_fetch/m_axi_rready
add wave -noupdate -color Yellow /test/u_fetch/m_axi_arready
add wave -noupdate /test/u_fetch/m_axi_rdata
add wave -noupdate /test/u_fetch/m_axi_rresp
add wave -noupdate /test/u_fetch/m_axi_rlast
add wave -noupdate /test/u_fetch/m_axi_rvalid
add wave -noupdate -divider m_axis
add wave -noupdate -color Coral /test/u_fetch/m_axis_tvalid
add wave -noupdate /test/u_fetch/m_axis_tdata
add wave -noupdate -color Yellow /test/u_fetch/m_axis_tready
add wave -noupdate -divider s_axis
add wave -noupdate -color Salmon /test/u_fetch/s_axis_tvalid
add wave -noupdate /test/u_fetch/s_axis_tdata
add wave -noupdate /test/u_fetch/s_axis_tlast
add wave -noupdate -color Yellow /test/u_fetch/s_axis_tready
add wave -noupdate /test/u_fetch/data_buf
add wave -noupdate -divider {New Divider}
add wave -noupdate /test/u_fetch/state
add wave -noupdate /test/u_fetch/m_axi_arburst
add wave -noupdate /test/u_fetch/m_axi_arsize
add wave -noupdate /test/u_fetch/m_axi_arlen
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {249572 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 207
configure wave -valuecolwidth 95
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
WaveRestoreZoom {14697 ps} {629287 ps}
