onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /SCCB_tb/clk
add wave -noupdate -radix unsigned /SCCB_tb/rst_n
add wave -noupdate -radix unsigned /SCCB_tb/data_in
add wave -noupdate -radix unsigned /SCCB_tb/data_out
add wave -noupdate -radix unsigned /SCCB_tb/addr_id
add wave -noupdate -radix unsigned /SCCB_tb/addr_reg
add wave -noupdate -radix unsigned /SCCB_tb/sio_d
add wave -noupdate -radix unsigned /SCCB_tb/sio_c
add wave -noupdate -divider ctrl
add wave -noupdate -radix unsigned /SCCB_tb/S0/XCLK
add wave -noupdate -radix unsigned /SCCB_tb/S0/RST_N
add wave -noupdate -radix unsigned /SCCB_tb/S0/XCLK_FREQ
add wave -noupdate -radix unsigned /SCCB_tb/S0/SCCB_CLK_FREQ
add wave -noupdate -radix unsigned /SCCB_tb/S0/SCCB_CLK_PERIOD
add wave -noupdate -radix unsigned /SCCB_tb/S0/SCCB_MID_AMT
add wave -noupdate -radix unsigned /SCCB_tb/S0/SCCB_CLK_CNT
add wave -noupdate -radix unsigned /SCCB_tb/S0/SCCB_CLK
add wave -noupdate -radix unsigned /SCCB_tb/S0/SCCB_MID_PULSE
add wave -noupdate -radix unsigned /SCCB_tb/S0/step
add wave -noupdate -radix unsigned /SCCB_tb/S0/idle
add wave -noupdate -radix unsigned /SCCB_tb/S0/data_send
add wave -noupdate -radix unsigned /SCCB_tb/S0/sccb_clk_step
add wave -noupdate -radix unsigned /SCCB_tb/S0/start
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {7550000000 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 225
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
WaveRestoreZoom {0 fs} {42 us}
