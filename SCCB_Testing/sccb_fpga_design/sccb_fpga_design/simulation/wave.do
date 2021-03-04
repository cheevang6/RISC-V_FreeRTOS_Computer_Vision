onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/xclk
add wave -noupdate /testbench/resetn
add wave -noupdate /testbench/sioc
add wave -noupdate /testbench/siod
add wave -noupdate /testbench/cam_rstn
add wave -noupdate /testbench/cam_pwdn
add wave -noupdate -divider config
add wave -noupdate /testbench/design_0/config_sccb_0/PCLK
add wave -noupdate /testbench/design_0/config_sccb_0/PRESETN
add wave -noupdate /testbench/design_0/config_sccb_0/sioc
add wave -noupdate /testbench/design_0/config_sccb_0/siod
add wave -noupdate /testbench/design_0/config_sccb_0/cam_rstn
add wave -noupdate /testbench/design_0/config_sccb_0/cam_pwdn
add wave -noupdate /testbench/design_0/config_sccb_0/start
add wave -noupdate /testbench/design_0/config_sccb_0/rw
add wave -noupdate /testbench/design_0/config_sccb_0/data_in
add wave -noupdate /testbench/design_0/config_sccb_0/id_addr
add wave -noupdate /testbench/design_0/config_sccb_0/sub_addr
add wave -noupdate /testbench/design_0/config_sccb_0/data_out
add wave -noupdate /testbench/design_0/config_sccb_0/done
add wave -noupdate /testbench/design_0/config_sccb_0/sccb_clk
add wave -noupdate /testbench/design_0/config_sccb_0/mid_pulse
add wave -noupdate /testbench/design_0/config_sccb_0/pwdn
add wave -noupdate /testbench/design_0/config_sccb_0/state
add wave -noupdate -divider sccb
add wave -noupdate -radix unsigned /testbench/design_0/config_sccb_0/coresccb_0/DELAY
add wave -noupdate /testbench/design_0/config_sccb_0/coresccb_0/clk
add wave -noupdate /testbench/design_0/config_sccb_0/coresccb_0/resetn
add wave -noupdate /testbench/design_0/config_sccb_0/coresccb_0/start
add wave -noupdate /testbench/design_0/config_sccb_0/coresccb_0/rw
add wave -noupdate /testbench/design_0/config_sccb_0/coresccb_0/id_addr
add wave -noupdate /testbench/design_0/config_sccb_0/coresccb_0/sub_addr
add wave -noupdate /testbench/design_0/config_sccb_0/coresccb_0/data_in
add wave -noupdate /testbench/design_0/config_sccb_0/coresccb_0/data_out
add wave -noupdate /testbench/design_0/config_sccb_0/coresccb_0/sioc
add wave -noupdate /testbench/design_0/config_sccb_0/coresccb_0/siod
add wave -noupdate /testbench/design_0/config_sccb_0/coresccb_0/pwdn
add wave -noupdate /testbench/design_0/config_sccb_0/coresccb_0/cam_rstn
add wave -noupdate /testbench/design_0/config_sccb_0/coresccb_0/done
add wave -noupdate /testbench/design_0/config_sccb_0/coresccb_0/mid_pulse
add wave -noupdate /testbench/design_0/config_sccb_0/coresccb_0/state
add wave -noupdate /testbench/design_0/config_sccb_0/coresccb_0/count_index
add wave -noupdate /testbench/design_0/config_sccb_0/coresccb_0/sioc_en
add wave -noupdate /testbench/design_0/config_sccb_0/coresccb_0/bit_out
add wave -noupdate /testbench/design_0/config_sccb_0/coresccb_0/siod_en
add wave -noupdate /testbench/design_0/config_sccb_0/coresccb_0/id_addr_saved
add wave -noupdate /testbench/design_0/config_sccb_0/coresccb_0/sub_addr_saved
add wave -noupdate /testbench/design_0/config_sccb_0/coresccb_0/data_in_saved
add wave -noupdate /testbench/design_0/config_sccb_0/coresccb_0/rw_saved
add wave -noupdate -radix unsigned /testbench/design_0/config_sccb_0/coresccb_0/count_delay
add wave -noupdate -divider clock
add wave -noupdate -radix unsigned /testbench/design_0/config_sccb_0/sccb_clk_0/CLK_FREQ
add wave -noupdate -radix unsigned /testbench/design_0/config_sccb_0/sccb_clk_0/SCCB_CLK_FREQ
add wave -noupdate -radix unsigned /testbench/design_0/config_sccb_0/sccb_clk_0/SCCB_AMT
add wave -noupdate -radix unsigned /testbench/design_0/config_sccb_0/sccb_clk_0/MID_AMT
add wave -noupdate /testbench/design_0/config_sccb_0/sccb_clk_0/clk
add wave -noupdate /testbench/design_0/config_sccb_0/sccb_clk_0/resetn
add wave -noupdate /testbench/design_0/config_sccb_0/sccb_clk_0/sccb_clk
add wave -noupdate /testbench/design_0/config_sccb_0/sccb_clk_0/mid_pulse
add wave -noupdate -radix unsigned /testbench/design_0/config_sccb_0/sccb_clk_0/count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {296181968882 fs} 0}
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
WaveRestoreZoom {0 fs} {315 us}
