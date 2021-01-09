onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /SCCB_tb/clk
add wave -noupdate /SCCB_tb/rst_n
add wave -noupdate /SCCB_tb/data_in
add wave -noupdate /SCCB_tb/data_out
add wave -noupdate /SCCB_tb/addr_id
add wave -noupdate /SCCB_tb/addr_reg
add wave -noupdate /SCCB_tb/sio_d
add wave -noupdate /SCCB_tb/sio_c
add wave -noupdate -divider sccb
add wave -noupdate /SCCB_tb/S0/XCLK
add wave -noupdate /SCCB_tb/S0/RST_N
add wave -noupdate /SCCB_tb/S0/XCLK_FREQ
add wave -noupdate /SCCB_tb/S0/SCCB_CLK_FREQ
add wave -noupdate /SCCB_tb/S0/SCCB_CLK_PERIOD
add wave -noupdate /SCCB_tb/S0/SCCB_MID_AMT
add wave -noupdate /SCCB_tb/S0/SCCB_CLK_CNTR
add wave -noupdate /SCCB_tb/S0/SCCB_CLK
add wave -noupdate /SCCB_tb/S0/SCCB_MID_PULSE
add wave -noupdate -radix unsigned /SCCB_tb/S0/step
add wave -noupdate /SCCB_tb/S0/idle
add wave -noupdate /SCCB_tb/S0/data_send
add wave -noupdate /SCCB_tb/S0/sccb_clk_step
add wave -noupdate /SCCB_tb/S0/wait4start
add wave -noupdate /SCCB_tb/S0/RW
add wave -noupdate /SCCB_tb/S0/SIO_C
add wave -noupdate /SCCB_tb/S0/SIO_D
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {12550000 ps} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {136500 ns}
