onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test/u_interpo/clk
add wave -noupdate /test/u_interpo/rst
add wave -noupdate /test/u_interpo/clk_en
add wave -noupdate -radix unsigned /test/u_interpo/dx
add wave -noupdate -radix unsigned /test/u_interpo/dy
add wave -noupdate -radix unsigned /test/u_interpo/lu
add wave -noupdate -radix unsigned /test/u_interpo/ru
add wave -noupdate -radix unsigned /test/u_interpo/ld
add wave -noupdate -radix unsigned /test/u_interpo/rd
add wave -noupdate -radix unsigned /test/u_interpo/p
add wave -noupdate -radix unsigned /test/u_interpo/keep_dx
add wave -noupdate -radix unsigned /test/u_interpo/keep_dy
add wave -noupdate -radix unsigned /test/u_interpo/sub_dx
add wave -noupdate -radix unsigned /test/u_interpo/sub_dy
add wave -noupdate -radix unsigned /test/u_interpo/mul_1
add wave -noupdate -radix unsigned /test/u_interpo/mul_2
add wave -noupdate -radix unsigned /test/u_interpo/mul_3
add wave -noupdate -radix unsigned /test/u_interpo/mul_4
add wave -noupdate -radix unsigned /test/u_interpo/mul_lu
add wave -noupdate -radix unsigned /test/u_interpo/mul_ru
add wave -noupdate -radix unsigned /test/u_interpo/mul_ld
add wave -noupdate -radix unsigned /test/u_interpo/mul_rd
add wave -noupdate -radix unsigned /test/u_interpo/sum
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {93224 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 208
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
WaveRestoreZoom {20238 ps} {254152 ps}
