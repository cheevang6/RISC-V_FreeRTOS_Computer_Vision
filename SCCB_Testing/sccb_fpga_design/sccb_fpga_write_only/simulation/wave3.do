onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label xclk /testbench/xclk
add wave -noupdate -label resetn /testbench/resetn
add wave -noupdate -label led1 /testbench/led1
add wave -noupdate -label led2 /testbench/led2
add wave -noupdate -label sio_c /testbench/sio_c
add wave -noupdate -label sio_d /testbench/sio_d
add wave -noupdate -divider config
add wave -noupdate -label PCLK /testbench/design_0/config_sccb_0/PCLK
add wave -noupdate -label PRESETN /testbench/design_0/config_sccb_0/PRESETN
add wave -noupdate -label sioc /testbench/design_0/config_sccb_0/sioc
add wave -noupdate -label siod_i /testbench/design_0/config_sccb_0/siod_i
add wave -noupdate -label siod_o /testbench/design_0/config_sccb_0/siod_o
add wave -noupdate -label siod_o_en /testbench/design_0/config_sccb_0/siod_o_en
add wave -noupdate -label pwdn /testbench/design_0/config_sccb_0/pwdn
add wave -noupdate -label start /testbench/design_0/config_sccb_0/start
add wave -noupdate -label rw /testbench/design_0/config_sccb_0/rw
add wave -noupdate -label data_in /testbench/design_0/config_sccb_0/data_in
add wave -noupdate -label ip_addr /testbench/design_0/config_sccb_0/ip_addr
add wave -noupdate -label sub_addr /testbench/design_0/config_sccb_0/sub_addr
add wave -noupdate -label data_out -radix binary /testbench/design_0/config_sccb_0/data_out
add wave -noupdate -label done /testbench/design_0/config_sccb_0/done
add wave -noupdate -label sccb_clk /testbench/design_0/config_sccb_0/sccb_clk
add wave -noupdate -label mid_pulse /testbench/design_0/config_sccb_0/mid_pulse
add wave -noupdate -label state /testbench/design_0/config_sccb_0/state
add wave -noupdate -divider sccb
add wave -noupdate -label resetn /testbench/design_0/config_sccb_0/coresccb_0/resetn
add wave -noupdate -label pwdn /testbench/design_0/config_sccb_0/coresccb_0/pwdn
add wave -noupdate -label start /testbench/design_0/config_sccb_0/coresccb_0/start
add wave -noupdate -label rw /testbench/design_0/config_sccb_0/coresccb_0/rw
add wave -noupdate -label ip_addr /testbench/design_0/config_sccb_0/coresccb_0/ip_addr
add wave -noupdate -label sub_addr /testbench/design_0/config_sccb_0/coresccb_0/sub_addr
add wave -noupdate -label data_in /testbench/design_0/config_sccb_0/coresccb_0/data_in
add wave -noupdate -label data_out -radix binary /testbench/design_0/config_sccb_0/coresccb_0/data_out
add wave -noupdate -label clk /testbench/design_0/config_sccb_0/coresccb_0/clk
add wave -noupdate -label sioc /testbench/design_0/config_sccb_0/coresccb_0/sioc
add wave -noupdate -label siod_i /testbench/design_0/config_sccb_0/coresccb_0/siod_i
add wave -noupdate -label siod_o /testbench/design_0/config_sccb_0/coresccb_0/siod_o
add wave -noupdate -label done /testbench/design_0/config_sccb_0/coresccb_0/done
add wave -noupdate -label mid_pulse /testbench/design_0/config_sccb_0/coresccb_0/mid_pulse
add wave -noupdate -label siod_o_en /testbench/design_0/config_sccb_0/coresccb_0/siod_o_en
add wave -noupdate -label state -radix unsigned /testbench/design_0/config_sccb_0/coresccb_0/state
add wave -noupdate -label count_index /testbench/design_0/config_sccb_0/coresccb_0/count_index
add wave -noupdate -label sioc_en /testbench/design_0/config_sccb_0/coresccb_0/sioc_en
add wave -noupdate -label ip_addr_saved /testbench/design_0/config_sccb_0/coresccb_0/ip_addr_saved
add wave -noupdate -label sub_addr_saved /testbench/design_0/config_sccb_0/coresccb_0/sub_addr_saved
add wave -noupdate -label data_in_saved /testbench/design_0/config_sccb_0/coresccb_0/data_in_saved
add wave -noupdate -label rw_saved /testbench/design_0/config_sccb_0/coresccb_0/rw_saved
add wave -noupdate -label count_delay /testbench/design_0/config_sccb_0/coresccb_0/count_delay
add wave -noupdate -divider {sccb clock}
add wave -noupdate -label CLK_FREQ /testbench/design_0/config_sccb_0/sccb_clk_0/CLK_FREQ
add wave -noupdate -label SCCB_CLK_FREQ /testbench/design_0/config_sccb_0/sccb_clk_0/SCCB_CLK_FREQ
add wave -noupdate -label SCCB_AMT /testbench/design_0/config_sccb_0/sccb_clk_0/SCCB_AMT
add wave -noupdate -label MID_AMT /testbench/design_0/config_sccb_0/sccb_clk_0/MID_AMT
add wave -noupdate -label clk /testbench/design_0/config_sccb_0/sccb_clk_0/clk
add wave -noupdate -label resetn /testbench/design_0/config_sccb_0/sccb_clk_0/resetn
add wave -noupdate -label sccb_clk /testbench/design_0/config_sccb_0/sccb_clk_0/sccb_clk
add wave -noupdate -label mid_pulse /testbench/design_0/config_sccb_0/sccb_clk_0/mid_pulse
add wave -noupdate -label count /testbench/design_0/config_sccb_0/sccb_clk_0/count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {97470010000 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 125
configure wave -valuecolwidth 40
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
configure wave -timelineunits ns
update
WaveRestoreZoom {90528861154 fs} {222113461186 fs}
