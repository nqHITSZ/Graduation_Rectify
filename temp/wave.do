onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test/urec/uF/rst
add wave -noupdate /test/urec/uF/Fsync
add wave -noupdate -radix unsigned /test/urec/uF/wy_pointer
add wave -noupdate -radix unsigned /test/urec/uF/wx_pointer
add wave -noupdate -radix unsigned /test/urec/uF/vtdata
add wave -noupdate /test/urec/uF/vtvalid
add wave -noupdate /test/urec/uF/vtlast
add wave -noupdate /test/urec/uF/vtready
add wave -noupdate /test/urec/uF/ltdata
add wave -noupdate /test/urec/uF/ltvalid
add wave -noupdate /test/urec/uF/ltlast
add wave -noupdate /test/urec/uF/ltready
add wave -noupdate -divider {New Divider}
add wave -noupdate -radix unsigned /test/recpixel
add wave -noupdate -color Magenta /test/recvalid
add wave -noupdate /test/reclast
add wave -noupdate /test/urec/uF/yfrac
add wave -noupdate /test/urec/uF/xfrac
add wave -noupdate -radix unsigned /test/urec/uF/lu
add wave -noupdate -radix unsigned /test/urec/uF/ru
add wave -noupdate -radix unsigned /test/urec/uF/ld
add wave -noupdate -radix unsigned /test/urec/uF/rd
add wave -noupdate -color {Green Yellow} -radix unsigned /test/py
add wave -noupdate -color {Green Yellow} -radix unsigned /test/px
add wave -noupdate -color Orchid /test/urec/uF/ptvalid
add wave -noupdate /test/urec/uF/ptlast
add wave -noupdate -divider {New Divider}
add wave -noupdate /test/urec/uF/buf_we
add wave -noupdate -color Turquoise /test/urec/uF/ry_pointer
add wave -noupdate -color Turquoise /test/urec/uF/rx_pointer
add wave -noupdate -color {Dark Orchid} -radix decimal /test/urec/uF/yint
add wave -noupdate -color {Dark Orchid} -radix decimal /test/urec/uF/xint
add wave -noupdate /test/urec/uF/ry
add wave -noupdate /test/urec/uF/rx
add wave -noupdate /test/urec/uF/rp_inc_en
add wave -noupdate /test/urec/uF/rp_clr
add wave -noupdate -color Magenta /test/urec/uF/state
add wave -noupdate /test/urec/uF/temp_ry
add wave -noupdate /test/urec/uF/temp_rx
add wave -noupdate /test/urec/uF/bram_ren
add wave -noupdate -divider BRAM1
add wave -noupdate {/test/urec/uF/u_BUF/Bram1/mem[7]}
add wave -noupdate {/test/urec/uF/u_BUF/Bram1/mem[6]}
add wave -noupdate {/test/urec/uF/u_BUF/Bram1/mem[5]}
add wave -noupdate {/test/urec/uF/u_BUF/Bram1/mem[4]}
add wave -noupdate {/test/urec/uF/u_BUF/Bram1/mem[3]}
add wave -noupdate {/test/urec/uF/u_BUF/Bram1/mem[2]}
add wave -noupdate {/test/urec/uF/u_BUF/Bram1/mem[1]}
add wave -noupdate {/test/urec/uF/u_BUF/Bram1/mem[0]}
add wave -noupdate -divider BRAM2
add wave -noupdate {/test/urec/uF/u_BUF/Bram2/mem[7]}
add wave -noupdate {/test/urec/uF/u_BUF/Bram2/mem[6]}
add wave -noupdate {/test/urec/uF/u_BUF/Bram2/mem[5]}
add wave -noupdate {/test/urec/uF/u_BUF/Bram2/mem[4]}
add wave -noupdate {/test/urec/uF/u_BUF/Bram2/mem[3]}
add wave -noupdate {/test/urec/uF/u_BUF/Bram2/mem[2]}
add wave -noupdate {/test/urec/uF/u_BUF/Bram2/mem[1]}
add wave -noupdate {/test/urec/uF/u_BUF/Bram2/mem[0]}
add wave -noupdate -divider BRAM3
add wave -noupdate {/test/urec/uF/u_BUF/Bram3/mem[7]}
add wave -noupdate {/test/urec/uF/u_BUF/Bram3/mem[6]}
add wave -noupdate {/test/urec/uF/u_BUF/Bram3/mem[5]}
add wave -noupdate {/test/urec/uF/u_BUF/Bram3/mem[4]}
add wave -noupdate {/test/urec/uF/u_BUF/Bram3/mem[3]}
add wave -noupdate {/test/urec/uF/u_BUF/Bram3/mem[2]}
add wave -noupdate {/test/urec/uF/u_BUF/Bram3/mem[1]}
add wave -noupdate {/test/urec/uF/u_BUF/Bram3/mem[0]}
add wave -noupdate -divider BRAM4
add wave -noupdate {/test/urec/uF/u_BUF/Bram4/mem[7]}
add wave -noupdate {/test/urec/uF/u_BUF/Bram4/mem[6]}
add wave -noupdate {/test/urec/uF/u_BUF/Bram4/mem[5]}
add wave -noupdate {/test/urec/uF/u_BUF/Bram4/mem[4]}
add wave -noupdate {/test/urec/uF/u_BUF/Bram4/mem[3]}
add wave -noupdate {/test/urec/uF/u_BUF/Bram4/mem[2]}
add wave -noupdate {/test/urec/uF/u_BUF/Bram4/mem[1]}
add wave -noupdate {/test/urec/uF/u_BUF/Bram4/mem[0]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5004862309 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {5004817865 ps} {5005009587 ps}
