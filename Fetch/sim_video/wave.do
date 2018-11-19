onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test/dut/clk
add wave -noupdate /test/dut/rst
add wave -noupdate /test/dut/start
add wave -noupdate /test/dut/vtdata
add wave -noupdate /test/dut/vtvalid
add wave -noupdate /test/dut/vtlast
add wave -noupdate /test/dut/vtready
add wave -noupdate /test/dut/wx
add wave -noupdate /test/dut/wy
add wave -noupdate /test/dut/cnt_en
add wave -noupdate /test/dut/cnt_rstn
add wave -noupdate /test/dut/state
add wave -noupdate /test/dut/init_cnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {99875 ps} 0}
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
WaveRestoreZoom {20683 ps} {221411 ps}
