onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test/dut/start
add wave -noupdate /test/dut/m_axis_aclk
add wave -noupdate /test/dut/m_axis_aresetn
add wave -noupdate -radix unsigned /test/dut/m_axis_tdata
add wave -noupdate /test/dut/m_axis_tlast
add wave -noupdate -color Salmon /test/dut/m_axis_tvalid
add wave -noupdate -color Gold /test/dut/m_axis_tready
add wave -noupdate -divider -height 30 {New Divider}
add wave -noupdate -radix unsigned /test/dut/col_cnt
add wave -noupdate -radix unsigned /test/dut/row_cnt
add wave -noupdate /test/dut/cnt_en
add wave -noupdate /test/dut/state
add wave -noupdate -childformat {{{/test/dut/data_delay[4]} -radix unsigned} {{/test/dut/data_delay[3]} -radix unsigned} {{/test/dut/data_delay[2]} -radix unsigned} {{/test/dut/data_delay[1]} -radix unsigned} {{/test/dut/data_delay[0]} -radix unsigned}} -expand -subitemconfig {{/test/dut/data_delay[4]} {-radix unsigned} {/test/dut/data_delay[3]} {-radix unsigned} {/test/dut/data_delay[2]} {-radix unsigned} {/test/dut/data_delay[1]} {-radix unsigned} {/test/dut/data_delay[0]} {-radix unsigned}} /test/dut/data_delay
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {380735 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 291
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
WaveRestoreZoom {292390 ps} {446864 ps}
