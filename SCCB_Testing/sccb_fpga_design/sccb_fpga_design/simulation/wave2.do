onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/reset
add wave -noupdate /tb/sioc
add wave -noupdate /tb/xclk
add wave -noupdate /tb/siod
add wave -noupdate -divider config
add wave -noupdate -label init_w /tb/sccb_design_0/config_sccb_0/init_w
add wave -noupdate -label write /tb/sccb_design_0/config_sccb_0/write
add wave -noupdate -label init_r /tb/sccb_design_0/config_sccb_0/init_r
add wave -noupdate -label read /tb/sccb_design_0/config_sccb_0/read
add wave -noupdate -label idle /tb/sccb_design_0/config_sccb_0/idle
add wave -noupdate -label PCLK /tb/sccb_design_0/config_sccb_0/PCLK
add wave -noupdate -label PRESETN /tb/sccb_design_0/config_sccb_0/PRESETN
add wave -noupdate -label sioc /tb/sccb_design_0/config_sccb_0/sioc
add wave -noupdate -label siod_i /tb/sccb_design_0/config_sccb_0/siod_i
add wave -noupdate -label siod_o /tb/sccb_design_0/config_sccb_0/siod_o
add wave -noupdate -label siod_o_en /tb/sccb_design_0/config_sccb_0/siod_o_en
add wave -noupdate -label pwdn /tb/sccb_design_0/config_sccb_0/pwdn
add wave -noupdate -label start /tb/sccb_design_0/config_sccb_0/start
add wave -noupdate -label rw /tb/sccb_design_0/config_sccb_0/rw
add wave -noupdate -label data_in /tb/sccb_design_0/config_sccb_0/data_in
add wave -noupdate -label ip_addr /tb/sccb_design_0/config_sccb_0/ip_addr
add wave -noupdate -label sub_addr /tb/sccb_design_0/config_sccb_0/sub_addr
add wave -noupdate -label data_out /tb/sccb_design_0/config_sccb_0/data_out
add wave -noupdate -label done /tb/sccb_design_0/config_sccb_0/done
add wave -noupdate -label sccb_clk /tb/sccb_design_0/config_sccb_0/sccb_clk
add wave -noupdate -label mid_pulse /tb/sccb_design_0/config_sccb_0/mid_pulse
add wave -noupdate -label ready /tb/sccb_design_0/config_sccb_0/ready
add wave -noupdate -label state /tb/sccb_design_0/config_sccb_0/state
add wave -noupdate -divider sccb
add wave -noupdate -label clk /tb/sccb_design_0/config_sccb_0/coresccb_0/clk
add wave -noupdate -label resetn /tb/sccb_design_0/config_sccb_0/coresccb_0/resetn
add wave -noupdate -label pwdn /tb/sccb_design_0/config_sccb_0/coresccb_0/pwdn
add wave -noupdate -label start /tb/sccb_design_0/config_sccb_0/coresccb_0/start
add wave -noupdate -label rw /tb/sccb_design_0/config_sccb_0/coresccb_0/rw
add wave -noupdate -label ip_addr /tb/sccb_design_0/config_sccb_0/coresccb_0/ip_addr
add wave -noupdate -label sub_addr /tb/sccb_design_0/config_sccb_0/coresccb_0/sub_addr
add wave -noupdate -label data_in /tb/sccb_design_0/config_sccb_0/coresccb_0/data_in
add wave -noupdate -label data_out /tb/sccb_design_0/config_sccb_0/coresccb_0/data_out
add wave -noupdate -label sioc /tb/sccb_design_0/config_sccb_0/coresccb_0/sioc
add wave -noupdate -label siod_i /tb/sccb_design_0/config_sccb_0/coresccb_0/siod_i
add wave -noupdate -label siod_o /tb/sccb_design_0/config_sccb_0/coresccb_0/siod_o
add wave -noupdate -label ready /tb/sccb_design_0/config_sccb_0/coresccb_0/ready
add wave -noupdate -label done /tb/sccb_design_0/config_sccb_0/coresccb_0/done
add wave -noupdate -label mid_pulse /tb/sccb_design_0/config_sccb_0/coresccb_0/mid_pulse
add wave -noupdate -label state -radix unsigned /tb/sccb_design_0/config_sccb_0/coresccb_0/state
add wave -noupdate -label count /tb/sccb_design_0/config_sccb_0/coresccb_0/count
add wave -noupdate -label sioc_en /tb/sccb_design_0/config_sccb_0/coresccb_0/sioc_en
add wave -noupdate -label ip_addr_saved /tb/sccb_design_0/config_sccb_0/coresccb_0/ip_addr_saved
add wave -noupdate -label sub_addr_saved /tb/sccb_design_0/config_sccb_0/coresccb_0/sub_addr_saved
add wave -noupdate -label data_in_saved /tb/sccb_design_0/config_sccb_0/coresccb_0/data_in_saved
add wave -noupdate -label rw_saved /tb/sccb_design_0/config_sccb_0/coresccb_0/rw_saved
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {395294117647 fs} 0}
quietly wave cursor active 1
configure wave -namecolwidth 136
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
WaveRestoreZoom {0 fs} {735 us}
