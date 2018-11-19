onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test/dut/clk
add wave -noupdate /test/dut/rst
add wave -noupdate /test/dut/start
add wave -noupdate /test/dut/ltdata
add wave -noupdate /test/dut/ltvalid
add wave -noupdate /test/dut/ltlast
add wave -noupdate /test/dut/ltready
add wave -noupdate /test/dut/rd_addr
add wave -noupdate /test/dut/addr_updata_en
add wave -noupdate /test/dut/state
add wave -noupdate /test/dut/init_cnt
add wave -noupdate {/test/dut/mem[0]}
add wave -noupdate {/test/dut/mem[1]}
add wave -noupdate {/test/dut/mem[2]}
add wave -noupdate {/test/dut/mem[3]}
add wave -noupdate {/test/dut/mem[4]}
add wave -noupdate {/test/dut/mem[5]}
add wave -noupdate {/test/dut/mem[6]}
add wave -noupdate {/test/dut/mem[7]}
add wave -noupdate {/test/dut/mem[8]}
add wave -noupdate {/test/dut/mem[9]}
add wave -noupdate {/test/dut/mem[10]}
add wave -noupdate {/test/dut/mem[11]}
add wave -noupdate {/test/dut/mem[12]}
add wave -noupdate {/test/dut/mem[13]}
add wave -noupdate {/test/dut/mem[14]}
add wave -noupdate {/test/dut/mem[15]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {275000 ps} 0}
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
WaveRestoreZoom {11466 ps} {666697 ps}
