onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label xclk /testbench/xclk
add wave -noupdate -label sio_c /testbench/sio_c
add wave -noupdate -label sio_d /testbench/sio_d
add wave -noupdate -label test /testbench/test
add wave -noupdate -divider Config
add wave -noupdate -label XCLK_FREQ -radix unsigned /testbench/sccb_design_0/config_sccb_0/XCLK_FREQ
add wave -noupdate -label SCCB_CLK_FREQ -radix unsigned /testbench/sccb_design_0/config_sccb_0/SCCB_CLK_FREQ
add wave -noupdate -label SCCB_CLK_PERIOD -radix unsigned /testbench/sccb_design_0/config_sccb_0/SCCB_CLK_PERIOD
add wave -noupdate -label SCCB_MID_AMT -radix unsigned /testbench/sccb_design_0/config_sccb_0/SCCB_MID_AMT
add wave -noupdate -label PCLK /testbench/sccb_design_0/config_sccb_0/PCLK
add wave -noupdate -label PRESETN /testbench/sccb_design_0/config_sccb_0/PRESETN
add wave -noupdate -label SIO_C /testbench/sccb_design_0/config_sccb_0/SIO_C
add wave -noupdate -label SIO_D /testbench/sccb_design_0/config_sccb_0/SIO_D
add wave -noupdate -label rw /testbench/sccb_design_0/config_sccb_0/rw
add wave -noupdate -label start /testbench/sccb_design_0/config_sccb_0/start
add wave -noupdate -label data_in /testbench/sccb_design_0/config_sccb_0/data_in
add wave -noupdate -label ip_addr /testbench/sccb_design_0/config_sccb_0/ip_addr
add wave -noupdate -label sub_addr /testbench/sccb_design_0/config_sccb_0/sub_addr
add wave -noupdate -label data_out /testbench/sccb_design_0/config_sccb_0/data_out
add wave -noupdate -label done /testbench/sccb_design_0/config_sccb_0/done
add wave -noupdate -label SCCB_CLK_CNTR /testbench/sccb_design_0/config_sccb_0/SCCB_CLK_CNTR
add wave -noupdate -label SCCB_CLK /testbench/sccb_design_0/config_sccb_0/SCCB_CLK
add wave -noupdate -label SCCB_MID_PULSE /testbench/sccb_design_0/config_sccb_0/SCCB_MID_PULSE
add wave -noupdate -label state /testbench/sccb_design_0/config_sccb_0/state
add wave -noupdate -divider coresccb
add wave -noupdate -label XCLK_FREQ -radix unsigned /testbench/sccb_design_0/config_sccb_0/coresccb_c0/XCLK_FREQ
add wave -noupdate -label DELAY_FREQ -radix unsigned /testbench/sccb_design_0/config_sccb_0/coresccb_c0/DELAY_FREQ
add wave -noupdate -label DELAY -radix unsigned /testbench/sccb_design_0/config_sccb_0/coresccb_c0/DELAY
add wave -noupdate -label XCLK /testbench/sccb_design_0/config_sccb_0/coresccb_c0/XCLK
add wave -noupdate -format Literal -label RST_N /testbench/sccb_design_0/config_sccb_0/coresccb_c0/RST_N
add wave -noupdate -label PWDN /testbench/sccb_design_0/config_sccb_0/coresccb_c0/PWDN
add wave -noupdate -label start /testbench/sccb_design_0/config_sccb_0/coresccb_c0/start
add wave -noupdate -label RW /testbench/sccb_design_0/config_sccb_0/coresccb_c0/RW
add wave -noupdate -label data_in /testbench/sccb_design_0/config_sccb_0/coresccb_c0/data_in
add wave -noupdate -label ip_addr /testbench/sccb_design_0/config_sccb_0/coresccb_c0/ip_addr
add wave -noupdate -label sub_addr /testbench/sccb_design_0/config_sccb_0/coresccb_c0/sub_addr
add wave -noupdate -label data_out -radix binary /testbench/sccb_design_0/config_sccb_0/coresccb_c0/data_out
add wave -noupdate -label done /testbench/sccb_design_0/config_sccb_0/coresccb_c0/done
add wave -noupdate -label SIO_D /testbench/sccb_design_0/config_sccb_0/coresccb_c0/SIO_D
add wave -noupdate -label SIO_C /testbench/sccb_design_0/config_sccb_0/coresccb_c0/SIO_C
add wave -noupdate -label SCCB_MID_PULSE /testbench/sccb_design_0/config_sccb_0/coresccb_c0/SCCB_MID_PULSE
add wave -noupdate -label SCCB_CLK /testbench/sccb_design_0/config_sccb_0/coresccb_c0/SCCB_CLK
add wave -noupdate -label step -radix unsigned /testbench/sccb_design_0/config_sccb_0/coresccb_c0/step
add wave -noupdate -label data_send /testbench/sccb_design_0/config_sccb_0/coresccb_c0/data_send
add wave -noupdate -label sccb_clk_step /testbench/sccb_design_0/config_sccb_0/coresccb_c0/sccb_clk_step
add wave -noupdate -label delay_cntr /testbench/sccb_design_0/config_sccb_0/coresccb_c0/delay_cntr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {636239551142 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 143
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
configure wave -timelineunits ns
update
WaveRestoreZoom {635305749834 fs} {638017232150 fs}
