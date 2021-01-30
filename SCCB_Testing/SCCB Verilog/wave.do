onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /SCCB_tb/clk
add wave -noupdate /SCCB_tb/rst_n
add wave -noupdate /SCCB_tb/start
add wave -noupdate /SCCB_tb/data_in
add wave -noupdate /SCCB_tb/data_out
add wave -noupdate /SCCB_tb/rw
add wave -noupdate /SCCB_tb/ip_addr
add wave -noupdate /SCCB_tb/reg_addr
add wave -noupdate /SCCB_tb/sio_d_s0
add wave -noupdate /SCCB_tb/sio_d_s1
add wave -noupdate /SCCB_tb/sio_c_s0
add wave -noupdate /SCCB_tb/sio_c_s1
add wave -noupdate /SCCB_tb/done_s0
add wave -noupdate -divider {SO - Chee}
add wave -noupdate /SCCB_tb/S0/XCLK_FREQ
add wave -noupdate /SCCB_tb/S0/SCCB_CLK_FREQ
add wave -noupdate /SCCB_tb/S0/SCCB_CLK_PERIOD
add wave -noupdate /SCCB_tb/S0/SCCB_MID_AMT
add wave -noupdate /SCCB_tb/S0/XCLK
add wave -noupdate /SCCB_tb/S0/RST_N
add wave -noupdate /SCCB_tb/S0/PWDN
add wave -noupdate /SCCB_tb/S0/start
add wave -noupdate /SCCB_tb/S0/RW
add wave -noupdate /SCCB_tb/S0/data_in
add wave -noupdate /SCCB_tb/S0/ip_addr
add wave -noupdate /SCCB_tb/S0/reg_addr
add wave -noupdate /SCCB_tb/S0/data_out
add wave -noupdate /SCCB_tb/S0/done
add wave -noupdate /SCCB_tb/S0/SIO_D
add wave -noupdate /SCCB_tb/S0/SIO_C
add wave -noupdate /SCCB_tb/S0/SCCB_CLK_CNTR
add wave -noupdate /SCCB_tb/S0/SCCB_CLK
add wave -noupdate /SCCB_tb/S0/SCCB_MID_PULSE
add wave -noupdate /SCCB_tb/S0/step
add wave -noupdate /SCCB_tb/S0/data_send
add wave -noupdate /SCCB_tb/S0/sccb_clk_step
add wave -noupdate -divider {S1 - Github}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {627424888 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 224
configure wave -valuecolwidth 78
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
WaveRestoreZoom {0 ps} {735 us}
