onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test/uf/clk
add wave -noupdate /test/uf/rst
add wave -noupdate -divider {in slave}
add wave -noupdate /test/uf/s_axis_tdata
add wave -noupdate -color Magenta /test/uf/s_axis_tvalid
add wave -noupdate -color Yellow /test/uf/s_axis_tready
add wave -noupdate -divider {out master}
add wave -noupdate /test/uf/m_axis_tdata
add wave -noupdate -color Magenta /test/uf/m_axis_tvalid
add wave -noupdate -color Gold /test/uf/m_axis_tready
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {227103 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 274
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
WaveRestoreZoom {0 ps} {630 ns}
