onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/xclk
add wave -noupdate /testbench/resetn
add wave -noupdate /testbench/led1
add wave -noupdate /testbench/led2
add wave -noupdate /testbench/sio_c
add wave -noupdate /testbench/sio_d
add wave -noupdate -divider {New Divider}
add wave -noupdate -label resetn /testbench/design_0/config_sccb_0/coresccb_0/resetn
add wave -noupdate -label pwdn /testbench/design_0/config_sccb_0/coresccb_0/pwdn
add wave -noupdate -label start /testbench/design_0/config_sccb_0/coresccb_0/start
add wave -noupdate -label rw /testbench/design_0/config_sccb_0/coresccb_0/rw
add wave -noupdate -label ip_addr /testbench/design_0/config_sccb_0/coresccb_0/ip_addr
add wave -noupdate -label sub_addr /testbench/design_0/config_sccb_0/coresccb_0/sub_addr
add wave -noupdate -label data_in /testbench/design_0/config_sccb_0/coresccb_0/data_in
add wave -noupdate -label data_out /testbench/design_0/config_sccb_0/coresccb_0/data_out
add wave -noupdate -label sioc /testbench/design_0/config_sccb_0/coresccb_0/sioc
add wave -noupdate -label clk /testbench/design_0/config_sccb_0/coresccb_0/clk
add wave -noupdate -label siod_i /testbench/design_0/config_sccb_0/coresccb_0/siod_i
add wave -noupdate -label siod_o /testbench/design_0/config_sccb_0/coresccb_0/siod_o
add wave -noupdate -label done /testbench/design_0/config_sccb_0/coresccb_0/done
add wave -noupdate -label mid_pulse /testbench/design_0/config_sccb_0/coresccb_0/mid_pulse
add wave -noupdate -label siod_o_en /testbench/design_0/config_sccb_0/coresccb_0/siod_o_en
add wave -noupdate -label state /testbench/design_0/config_sccb_0/coresccb_0/state
add wave -noupdate -label count /testbench/design_0/config_sccb_0/coresccb_0/count
add wave -noupdate -label sioc_en /testbench/design_0/config_sccb_0/coresccb_0/sioc_en
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {497720010000 fs} 0}
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
configure wave -timelineunits fs
update
WaveRestoreZoom {454600997964 fs} {694807318753 fs}
