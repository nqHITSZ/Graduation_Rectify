onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test/uF/clk
add wave -noupdate /test/uF/rst
add wave -noupdate /test/uF/Flast
add wave -noupdate /test/uF/tdata
add wave -noupdate /test/uF/tvalid
add wave -noupdate /test/uF/lu
add wave -noupdate /test/uF/ru
add wave -noupdate /test/uF/ld
add wave -noupdate /test/uF/rd
add wave -noupdate -divider write_pointer
add wave -noupdate /test/uF/wy_pointer
add wave -noupdate /test/uF/wx_pointer
add wave -noupdate -divider read_pointer
add wave -noupdate /test/uF/rp_clr
add wave -noupdate /test/uF/rp_inc_en
add wave -noupdate -color Pink /test/uF/ry_pointer
add wave -noupdate -color Pink /test/uF/rx_pointer
add wave -noupdate -divider FSM
add wave -noupdate /test/uF/state
add wave -noupdate -divider {New Divider}
add wave -noupdate -color Pink /test/uF/ry_pointer
add wave -noupdate -color Pink /test/uF/rx_pointer
add wave -noupdate -radix decimal /test/uF/yint
add wave -noupdate -radix decimal /test/uF/xint
add wave -noupdate -color Aquamarine -radix decimal /test/uF/temp_ry
add wave -noupdate -color Aquamarine -radix decimal /test/uF/temp_rx
add wave -noupdate /test/uF/ry
add wave -noupdate /test/uF/rx
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {658996 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 338
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
WaveRestoreZoom {0 ps} {2100 ns}
