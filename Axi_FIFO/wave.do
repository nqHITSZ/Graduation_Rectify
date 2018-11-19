onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test/uf/clk
add wave -noupdate /test/uf/rst
add wave -noupdate /test/uf/s_axis_tdata
add wave -noupdate /test/uf/s_axis_tvalid
add wave -noupdate /test/uf/s_axis_tready
add wave -noupdate /test/uf/s_axis_tlast
add wave -noupdate /test/uf/status_overflow
add wave -noupdate /test/uf/status_bad_frame
add wave -noupdate /test/uf/status_good_frame
add wave -noupdate /test/uf/s_axis
add wave -noupdate /test/uf/wr_ptr_reg
add wave -noupdate /test/uf/wr_ptr_next
add wave -noupdate /test/uf/wr_ptr_cur_reg
add wave -noupdate /test/uf/wr_addr_reg
add wave -noupdate /test/uf/rd_ptr_reg
add wave -noupdate /test/uf/rd_ptr_next
add wave -noupdate /test/uf/rd_addr_reg
add wave -noupdate /test/uf/full
add wave -noupdate /test/uf/write
add wave -noupdate -divider read
add wave -noupdate -color {Medium Aquamarine} /test/uf/mem_read_data_valid_next
add wave -noupdate -color Aquamarine /test/uf/mem_read_data_valid_reg
add wave -noupdate -color Orange /test/uf/m_axis_tvalid_next
add wave -noupdate -color Coral /test/uf/m_axis_tvalid_reg
add wave -noupdate -color Coral /test/uf/m_axis_tvalid
add wave -noupdate -color Pink /test/uf/empty
add wave -noupdate -color Magenta /test/uf/read
add wave -noupdate /test/uf/mem_read_data_reg
add wave -noupdate /test/uf/m_axis_tdata
add wave -noupdate /test/uf/m_axis_reg
add wave -noupdate -color Yellow /test/uf/m_axis_tready
add wave -noupdate /test/uf/store_output
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {344764 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 254
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
WaveRestoreZoom {3488 ps} {462758 ps}
