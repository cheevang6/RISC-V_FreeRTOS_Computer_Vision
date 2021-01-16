onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /SCCB_tb/XCLK_FREQ
add wave -noupdate -radix unsigned /SCCB_tb/SCCB_CLK_FREQ
add wave -noupdate -radix unsigned /SCCB_tb/SCCB_CLK_PERIOD
add wave -noupdate -radix unsigned /SCCB_tb/SCCB_MID_AMT
add wave -noupdate -radix unsigned /SCCB_tb/clk
add wave -noupdate -radix unsigned /SCCB_tb/rst_n
add wave -noupdate -radix unsigned /SCCB_tb/start
add wave -noupdate -radix hexadecimal /SCCB_tb/data_in
add wave -noupdate -radix hexadecimal /SCCB_tb/data_out
add wave -noupdate -radix hexadecimal /SCCB_tb/addr_id
add wave -noupdate -radix hexadecimal /SCCB_tb/addr_reg
add wave -noupdate -radix unsigned /SCCB_tb/data_i
add wave -noupdate -radix unsigned /SCCB_tb/rw_i
add wave -noupdate -radix unsigned /SCCB_tb/data_o
add wave -noupdate -radix unsigned /SCCB_tb/ack_error_o
add wave -noupdate -radix unsigned /SCCB_tb/done_o
add wave -noupdate -radix unsigned /SCCB_tb/SCCB_CLK_CNTR
add wave -noupdate -radix unsigned /SCCB_tb/SCCB_CLK
add wave -noupdate -radix unsigned /SCCB_tb/SCCB_MID_PULSE
add wave -noupdate -divider S0
add wave -noupdate -radix unsigned /SCCB_tb/S0/XCLK_FREQ
add wave -noupdate -radix unsigned /SCCB_tb/S0/SCCB_CLK_FREQ
add wave -noupdate -radix unsigned /SCCB_tb/S0/SCCB_CLK_PERIOD
add wave -noupdate -radix unsigned /SCCB_tb/S0/SCCB_MID_AMT
add wave -noupdate -radix unsigned /SCCB_tb/S0/XCLK
add wave -noupdate -radix unsigned /SCCB_tb/S0/RST_N
add wave -noupdate -radix unsigned /SCCB_tb/S0/start
add wave -noupdate -radix unsigned /SCCB_tb/S0/data_in
add wave -noupdate -radix hexadecimal /SCCB_tb/S0/addr_id
add wave -noupdate -radix hexadecimal /SCCB_tb/S0/addr_reg
add wave -noupdate -radix unsigned /SCCB_tb/S0/data_out
add wave -noupdate -radix unsigned /SCCB_tb/S0/SCCB_CLK_CNTR
add wave -noupdate -radix unsigned /SCCB_tb/S0/SCCB_CLK
add wave -noupdate -radix unsigned /SCCB_tb/S0/SCCB_MID_PULSE
add wave -noupdate -radix unsigned /SCCB_tb/S0/step
add wave -noupdate -radix unsigned /SCCB_tb/S0/data_send
add wave -noupdate -radix unsigned /SCCB_tb/S0/sccb_clk_step
add wave -noupdate -radix unsigned /SCCB_tb/S0/RW
add wave -noupdate -radix unsigned /SCCB_tb/S0/SIO_C
add wave -noupdate -radix unsigned /SCCB_tb/S0/SIO_D
add wave -noupdate -divider S1
add wave -noupdate -radix unsigned /SCCB_tb/S1/clk_i
add wave -noupdate -radix unsigned /SCCB_tb/S1/rst_i
add wave -noupdate -radix unsigned /SCCB_tb/S1/sccb_clk_i
add wave -noupdate -radix unsigned /SCCB_tb/S1/data_pulse_i
add wave -noupdate -radix hexadecimal /SCCB_tb/S1/addr_i
add wave -noupdate -radix hexadecimal /SCCB_tb/S1/data_i
add wave -noupdate -radix unsigned -childformat {{{/SCCB_tb/S1/data_o[7]} -radix unsigned} {{/SCCB_tb/S1/data_o[6]} -radix unsigned} {{/SCCB_tb/S1/data_o[5]} -radix unsigned} {{/SCCB_tb/S1/data_o[4]} -radix unsigned} {{/SCCB_tb/S1/data_o[3]} -radix unsigned} {{/SCCB_tb/S1/data_o[2]} -radix unsigned} {{/SCCB_tb/S1/data_o[1]} -radix unsigned} {{/SCCB_tb/S1/data_o[0]} -radix unsigned}} -subitemconfig {{/SCCB_tb/S1/data_o[7]} {-height 15 -radix unsigned} {/SCCB_tb/S1/data_o[6]} {-height 15 -radix unsigned} {/SCCB_tb/S1/data_o[5]} {-height 15 -radix unsigned} {/SCCB_tb/S1/data_o[4]} {-height 15 -radix unsigned} {/SCCB_tb/S1/data_o[3]} {-height 15 -radix unsigned} {/SCCB_tb/S1/data_o[2]} {-height 15 -radix unsigned} {/SCCB_tb/S1/data_o[1]} {-height 15 -radix unsigned} {/SCCB_tb/S1/data_o[0]} {-height 15 -radix unsigned}} /SCCB_tb/S1/data_o
add wave -noupdate -radix unsigned /SCCB_tb/S1/rw_i
add wave -noupdate -radix unsigned /SCCB_tb/S1/start_i
add wave -noupdate -radix unsigned /SCCB_tb/S1/done_o
add wave -noupdate -radix unsigned /SCCB_tb/S1/sccb_stm_clk
add wave -noupdate -radix unsigned /SCCB_tb/S1/stm
add wave -noupdate -radix unsigned /SCCB_tb/S1/bit_out
add wave -noupdate -radix unsigned /SCCB_tb/S1/ack_error_o
add wave -noupdate -radix unsigned /SCCB_tb/S1/ack_err1
add wave -noupdate -radix unsigned /SCCB_tb/S1/ack_err2
add wave -noupdate -radix unsigned /SCCB_tb/S1/ack_err3
add wave -noupdate -radix unsigned /SCCB_tb/S1/sioc_o
add wave -noupdate -radix unsigned /SCCB_tb/S1/siod_io
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {406636115 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 231
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
WaveRestoreZoom {1 us} {421 us}
