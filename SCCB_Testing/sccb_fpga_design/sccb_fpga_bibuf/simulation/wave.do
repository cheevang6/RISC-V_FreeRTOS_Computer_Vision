onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/xclk
add wave -noupdate /tb/sioc
add wave -noupdate /tb/siod
add wave -noupdate -divider Config
add wave -noupdate -label SIO_C /tb/sccb_design_0/SCCB_0/config_sccb_0/SIO_C
add wave -noupdate -label SIO_DI /tb/sccb_design_0/SCCB_0/config_sccb_0/SIO_DI
add wave -noupdate -label SIO_DO /tb/sccb_design_0/SCCB_0/config_sccb_0/SIO_DO
add wave -noupdate -label SIO_DE /tb/sccb_design_0/SCCB_0/config_sccb_0/SIO_DE
add wave -noupdate -label XCLK_FREQ -radix unsigned /tb/sccb_design_0/SCCB_0/config_sccb_0/XCLK_FREQ
add wave -noupdate -label SCCB_CLK_FREQ -radix unsigned /tb/sccb_design_0/SCCB_0/config_sccb_0/SCCB_CLK_FREQ
add wave -noupdate -label SCCB_CLK_PERIOD -radix unsigned /tb/sccb_design_0/SCCB_0/config_sccb_0/SCCB_CLK_PERIOD
add wave -noupdate -label SCCB_MID_AMT -radix unsigned /tb/sccb_design_0/SCCB_0/config_sccb_0/SCCB_MID_AMT
add wave -noupdate -label start /tb/sccb_design_0/SCCB_0/config_sccb_0/start
add wave -noupdate -label rw /tb/sccb_design_0/SCCB_0/config_sccb_0/rw
add wave -noupdate -label done /tb/sccb_design_0/SCCB_0/config_sccb_0/done
add wave -noupdate -label done /tb/sccb_design_0/SCCB_0/config_sccb_0/done
add wave -noupdate -divider coresccb
add wave -noupdate -label start /tb/sccb_design_0/SCCB_0/config_sccb_0/coresccb_c0/start
add wave -noupdate -label RW /tb/sccb_design_0/SCCB_0/config_sccb_0/coresccb_c0/RW
add wave -noupdate -label data_in /tb/sccb_design_0/SCCB_0/config_sccb_0/coresccb_c0/data_in
add wave -noupdate -label ip_addr /tb/sccb_design_0/SCCB_0/config_sccb_0/coresccb_c0/ip_addr
add wave -noupdate -label sub_addr /tb/sccb_design_0/SCCB_0/config_sccb_0/coresccb_c0/sub_addr
add wave -noupdate -label data_out /tb/sccb_design_0/SCCB_0/config_sccb_0/coresccb_c0/data_out
add wave -noupdate -label done /tb/sccb_design_0/SCCB_0/config_sccb_0/coresccb_c0/done
add wave -noupdate -label SIO_C /tb/sccb_design_0/SCCB_0/config_sccb_0/coresccb_c0/SIO_C
add wave -noupdate -label SIO_DI /tb/sccb_design_0/SCCB_0/config_sccb_0/coresccb_c0/SIO_DI
add wave -noupdate -label SIO_DO /tb/sccb_design_0/SCCB_0/config_sccb_0/coresccb_c0/SIO_DO
add wave -noupdate -label SIO_DE /tb/sccb_design_0/SCCB_0/config_sccb_0/coresccb_c0/SIO_DE
add wave -noupdate -label SCCB_MID_PULSE /tb/sccb_design_0/SCCB_0/config_sccb_0/coresccb_c0/SCCB_MID_PULSE
add wave -noupdate -label SCCB_CLK /tb/sccb_design_0/SCCB_0/config_sccb_0/coresccb_c0/SCCB_CLK
add wave -noupdate -label step -radix unsigned /tb/sccb_design_0/SCCB_0/config_sccb_0/coresccb_c0/step
add wave -noupdate -label data_send /tb/sccb_design_0/SCCB_0/config_sccb_0/coresccb_c0/data_send
add wave -noupdate -label sccb_clk_step /tb/sccb_design_0/SCCB_0/config_sccb_0/coresccb_c0/sccb_clk_step
add wave -noupdate -label delay_cntr /tb/sccb_design_0/SCCB_0/config_sccb_0/coresccb_c0/delay_cntr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1301725818544 fs} 0}
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
WaveRestoreZoom {1196713654366 fs} {1507019889511 fs}
