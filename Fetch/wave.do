onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test/uF/clk
add wave -noupdate /test/uF/rst
add wave -noupdate /test/uF/yint
add wave -noupdate /test/uF/xint
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
add wave -noupdate -color Pink /test/uF/ry_pointer
add wave -noupdate -color Pink /test/uF/rx_pointer
add wave -noupdate -divider mem1
add wave -noupdate {/test/uF/u_BUF/Bram1/mem[7]}
add wave -noupdate {/test/uF/u_BUF/Bram1/mem[6]}
add wave -noupdate {/test/uF/u_BUF/Bram1/mem[5]}
add wave -noupdate {/test/uF/u_BUF/Bram1/mem[4]}
add wave -noupdate {/test/uF/u_BUF/Bram1/mem[3]}
add wave -noupdate {/test/uF/u_BUF/Bram1/mem[2]}
add wave -noupdate {/test/uF/u_BUF/Bram1/mem[1]}
add wave -noupdate {/test/uF/u_BUF/Bram1/mem[0]}
add wave -noupdate -divider mem2
add wave -noupdate {/test/uF/u_BUF/Bram2/mem[7]}
add wave -noupdate {/test/uF/u_BUF/Bram2/mem[6]}
add wave -noupdate {/test/uF/u_BUF/Bram2/mem[5]}
add wave -noupdate {/test/uF/u_BUF/Bram2/mem[4]}
add wave -noupdate {/test/uF/u_BUF/Bram2/mem[3]}
add wave -noupdate {/test/uF/u_BUF/Bram2/mem[2]}
add wave -noupdate {/test/uF/u_BUF/Bram2/mem[1]}
add wave -noupdate {/test/uF/u_BUF/Bram2/mem[0]}
add wave -noupdate -divider mem3
add wave -noupdate {/test/uF/u_BUF/Bram3/mem[7]}
add wave -noupdate {/test/uF/u_BUF/Bram3/mem[6]}
add wave -noupdate {/test/uF/u_BUF/Bram3/mem[5]}
add wave -noupdate {/test/uF/u_BUF/Bram3/mem[4]}
add wave -noupdate {/test/uF/u_BUF/Bram3/mem[3]}
add wave -noupdate {/test/uF/u_BUF/Bram3/mem[2]}
add wave -noupdate {/test/uF/u_BUF/Bram3/mem[1]}
add wave -noupdate {/test/uF/u_BUF/Bram3/mem[0]}
add wave -noupdate -divider mem4
add wave -noupdate {/test/uF/u_BUF/Bram4/mem[7]}
add wave -noupdate {/test/uF/u_BUF/Bram4/mem[6]}
add wave -noupdate {/test/uF/u_BUF/Bram4/mem[5]}
add wave -noupdate {/test/uF/u_BUF/Bram4/mem[4]}
add wave -noupdate {/test/uF/u_BUF/Bram4/mem[3]}
add wave -noupdate {/test/uF/u_BUF/Bram4/mem[2]}
add wave -noupdate {/test/uF/u_BUF/Bram4/mem[1]}
add wave -noupdate {/test/uF/u_BUF/Bram4/mem[0]}
add wave -noupdate /test/uF/u_BUF/ry
add wave -noupdate -radix ufixed /test/uF/u_BUF/temp_addr_a
add wave -noupdate -radix ufixed /test/uF/u_BUF/temp_addr_b
add wave -noupdate -radix ufixed /test/uF/u_BUF/temp_addr_c
add wave -noupdate -radix ufixed /test/uF/u_BUF/temp_addr_d
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1265925 ps} 0}
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
WaveRestoreZoom {992120 ps} {1585226 ps}
