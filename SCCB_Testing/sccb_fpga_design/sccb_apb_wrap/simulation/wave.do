onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench_apb/xclk
add wave -noupdate /testbench_apb/resetn
add wave -noupdate /testbench_apb/sioc
add wave -noupdate /testbench_apb/siod
add wave -noupdate /testbench_apb/cam_pwdn
add wave -noupdate /testbench_apb/cam_rstn
add wave -noupdate -divider config
add wave -noupdate /testbench_apb/design_0/config_sccb_0/init_w
add wave -noupdate /testbench_apb/design_0/config_sccb_0/write
add wave -noupdate /testbench_apb/design_0/config_sccb_0/init_r1
add wave -noupdate /testbench_apb/design_0/config_sccb_0/read1
add wave -noupdate /testbench_apb/design_0/config_sccb_0/init_r2
add wave -noupdate /testbench_apb/design_0/config_sccb_0/read2
add wave -noupdate /testbench_apb/design_0/config_sccb_0/idle
add wave -noupdate /testbench_apb/design_0/config_sccb_0/PCLK
add wave -noupdate /testbench_apb/design_0/config_sccb_0/PRESETN
add wave -noupdate /testbench_apb/design_0/config_sccb_0/xclk
add wave -noupdate /testbench_apb/design_0/config_sccb_0/sioc
add wave -noupdate /testbench_apb/design_0/config_sccb_0/siod
add wave -noupdate /testbench_apb/design_0/config_sccb_0/cam_rstn
add wave -noupdate /testbench_apb/design_0/config_sccb_0/cam_pwdn
add wave -noupdate /testbench_apb/design_0/config_sccb_0/pwdn
add wave -noupdate /testbench_apb/design_0/config_sccb_0/start
add wave -noupdate /testbench_apb/design_0/config_sccb_0/rw
add wave -noupdate /testbench_apb/design_0/config_sccb_0/data_in
add wave -noupdate /testbench_apb/design_0/config_sccb_0/id_addr
add wave -noupdate /testbench_apb/design_0/config_sccb_0/sub_addr
add wave -noupdate /testbench_apb/design_0/config_sccb_0/data_out
add wave -noupdate /testbench_apb/design_0/config_sccb_0/done
add wave -noupdate /testbench_apb/design_0/config_sccb_0/sccb_clk
add wave -noupdate /testbench_apb/design_0/config_sccb_0/mid_pulse
add wave -noupdate /testbench_apb/design_0/config_sccb_0/state
add wave -noupdate -divider {sccb clock}
add wave -noupdate -radix unsigned /testbench_apb/design_0/config_sccb_0/sccb_clk_0/APB_CLK_FREQ
add wave -noupdate -radix unsigned /testbench_apb/design_0/config_sccb_0/sccb_clk_0/XCLK_FREQ
add wave -noupdate -radix unsigned /testbench_apb/design_0/config_sccb_0/sccb_clk_0/SCCB_CLK_FREQ
add wave -noupdate -radix unsigned /testbench_apb/design_0/config_sccb_0/sccb_clk_0/SCCB_CLK_PERIOD
add wave -noupdate -radix unsigned /testbench_apb/design_0/config_sccb_0/sccb_clk_0/SCCB_MID_AMT
add wave -noupdate -radix unsigned /testbench_apb/design_0/config_sccb_0/sccb_clk_0/APB_CLK_PERIOD
add wave -noupdate /testbench_apb/design_0/config_sccb_0/sccb_clk_0/xclk
add wave -noupdate /testbench_apb/design_0/config_sccb_0/sccb_clk_0/clk
add wave -noupdate /testbench_apb/design_0/config_sccb_0/sccb_clk_0/resetn
add wave -noupdate /testbench_apb/design_0/config_sccb_0/sccb_clk_0/sccb_clk
add wave -noupdate /testbench_apb/design_0/config_sccb_0/sccb_clk_0/mid_pulse
add wave -noupdate /testbench_apb/design_0/config_sccb_0/sccb_clk_0/count_sccb
add wave -noupdate /testbench_apb/design_0/config_sccb_0/sccb_clk_0/count_xclk
add wave -noupdate -divider sccb
add wave -noupdate -radix unsigned /testbench_apb/design_0/config_sccb_0/coresccb_0/XCLK_FREQ
add wave -noupdate -radix unsigned /testbench_apb/design_0/config_sccb_0/coresccb_0/DELAY_FREQ
add wave -noupdate -radix unsigned /testbench_apb/design_0/config_sccb_0/coresccb_0/DELAY
add wave -noupdate /testbench_apb/design_0/config_sccb_0/coresccb_0/xclk
add wave -noupdate /testbench_apb/design_0/config_sccb_0/coresccb_0/resetn
add wave -noupdate /testbench_apb/design_0/config_sccb_0/coresccb_0/cam_rstn
add wave -noupdate /testbench_apb/design_0/config_sccb_0/coresccb_0/cam_pwdn
add wave -noupdate /testbench_apb/design_0/config_sccb_0/coresccb_0/start
add wave -noupdate /testbench_apb/design_0/config_sccb_0/coresccb_0/rw
add wave -noupdate /testbench_apb/design_0/config_sccb_0/coresccb_0/id_addr
add wave -noupdate /testbench_apb/design_0/config_sccb_0/coresccb_0/sub_addr
add wave -noupdate /testbench_apb/design_0/config_sccb_0/coresccb_0/data_in
add wave -noupdate /testbench_apb/design_0/config_sccb_0/coresccb_0/data_out
add wave -noupdate /testbench_apb/design_0/config_sccb_0/coresccb_0/sioc
add wave -noupdate /testbench_apb/design_0/config_sccb_0/coresccb_0/siod
add wave -noupdate /testbench_apb/design_0/config_sccb_0/coresccb_0/done
add wave -noupdate /testbench_apb/design_0/config_sccb_0/coresccb_0/mid_pulse
add wave -noupdate /testbench_apb/design_0/config_sccb_0/coresccb_0/sccb_clk
add wave -noupdate /testbench_apb/design_0/config_sccb_0/coresccb_0/step
add wave -noupdate /testbench_apb/design_0/config_sccb_0/coresccb_0/bit_send
add wave -noupdate /testbench_apb/design_0/config_sccb_0/coresccb_0/sccb_clk_step
add wave -noupdate /testbench_apb/design_0/config_sccb_0/coresccb_0/ack_id
add wave -noupdate /testbench_apb/design_0/config_sccb_0/coresccb_0/ack_sub
add wave -noupdate /testbench_apb/design_0/config_sccb_0/coresccb_0/ack_wr
add wave -noupdate -radix unsigned /testbench_apb/design_0/config_sccb_0/coresccb_0/delay_cntr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {60780010000 fs} 0}
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 fs} {815346958175 fs}
