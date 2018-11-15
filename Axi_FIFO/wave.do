onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test/clk
add wave -noupdate /test/s_axis_tdata
add wave -noupdate /test/s_axis_tvalid
add wave -noupdate /test/s_axis_tready
add wave -noupdate /test/s_axis_tlast
add wave -noupdate /test/m_axis_tdata
add wave -noupdate /test/m_axis_tvalid
add wave -noupdate /test/m_axis_tready
add wave -noupdate /test/m_axis_tlast
add wave -noupdate /test/rst
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {189026 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {1050 ns}
