onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Testbench
add wave -noupdate -label pclk /SCCB_APB_tb/pclk
add wave -noupdate -label presetn /SCCB_APB_tb/presetn
add wave -noupdate -label psel /SCCB_APB_tb/psel
add wave -noupdate -label pwrite /SCCB_APB_tb/pwrite
add wave -noupdate -label penable /SCCB_APB_tb/penable
add wave -noupdate -label pwdata -radix hexadecimal /SCCB_APB_tb/pwdata
add wave -noupdate -label paddr -radix hexadecimal /SCCB_APB_tb/paddr
add wave -noupdate -label prdata -radix hexadecimal /SCCB_APB_tb/prdata
add wave -noupdate -label pready /SCCB_APB_tb/pready
add wave -noupdate -label pslverr /SCCB_APB_tb/pslverr
add wave -noupdate -label sio_c /SCCB_APB_tb/sio_c
add wave -noupdate -label sio_d /SCCB_APB_tb/sio_d
add wave -noupdate -label wdata_mem -radix hexadecimal -childformat {{{/SCCB_APB_tb/wdata_mem[9]} -radix hexadecimal} {{/SCCB_APB_tb/wdata_mem[8]} -radix hexadecimal} {{/SCCB_APB_tb/wdata_mem[7]} -radix hexadecimal} {{/SCCB_APB_tb/wdata_mem[6]} -radix hexadecimal} {{/SCCB_APB_tb/wdata_mem[5]} -radix hexadecimal} {{/SCCB_APB_tb/wdata_mem[4]} -radix hexadecimal} {{/SCCB_APB_tb/wdata_mem[3]} -radix hexadecimal} {{/SCCB_APB_tb/wdata_mem[2]} -radix hexadecimal} {{/SCCB_APB_tb/wdata_mem[1]} -radix hexadecimal} {{/SCCB_APB_tb/wdata_mem[0]} -radix hexadecimal}} -subitemconfig {{/SCCB_APB_tb/wdata_mem[9]} {-height 15 -radix hexadecimal} {/SCCB_APB_tb/wdata_mem[8]} {-height 15 -radix hexadecimal} {/SCCB_APB_tb/wdata_mem[7]} {-height 15 -radix hexadecimal} {/SCCB_APB_tb/wdata_mem[6]} {-height 15 -radix hexadecimal} {/SCCB_APB_tb/wdata_mem[5]} {-height 15 -radix hexadecimal} {/SCCB_APB_tb/wdata_mem[4]} {-height 15 -radix hexadecimal} {/SCCB_APB_tb/wdata_mem[3]} {-height 15 -radix hexadecimal} {/SCCB_APB_tb/wdata_mem[2]} {-height 15 -radix hexadecimal} {/SCCB_APB_tb/wdata_mem[1]} {-height 15 -radix hexadecimal} {/SCCB_APB_tb/wdata_mem[0]} {-height 15 -radix hexadecimal}} /SCCB_APB_tb/wdata_mem
add wave -noupdate -label index -radix hexadecimal /SCCB_APB_tb/index
add wave -noupdate -label done /SCCB_APB_tb/done
add wave -noupdate -divider CoreSCCB_APB
add wave -noupdate -label PCLK /SCCB_APB_tb/coresccb_c0/PCLK
add wave -noupdate -label PRESETN /SCCB_APB_tb/coresccb_c0/PRESETN
add wave -noupdate -label PSEL /SCCB_APB_tb/coresccb_c0/PSEL
add wave -noupdate -label PENABLE /SCCB_APB_tb/coresccb_c0/PENABLE
add wave -noupdate -label PWRITE /SCCB_APB_tb/coresccb_c0/PWRITE
add wave -noupdate -label PWDATA -radix hexadecimal /SCCB_APB_tb/coresccb_c0/PWDATA
add wave -noupdate -label PADDR -radix hexadecimal /SCCB_APB_tb/coresccb_c0/PADDR
add wave -noupdate -label PRDATA -radix hexadecimal /SCCB_APB_tb/coresccb_c0/PRDATA
add wave -noupdate -label PREADY /SCCB_APB_tb/coresccb_c0/PREADY
add wave -noupdate -label PSLVERR /SCCB_APB_tb/coresccb_c0/PSLVERR
add wave -noupdate -label SIO_C /SCCB_APB_tb/coresccb_c0/SIO_C
add wave -noupdate -label SIO_D /SCCB_APB_tb/coresccb_c0/SIO_D
add wave -noupdate -label pwdn /SCCB_APB_tb/coresccb_c0/pwdn
add wave -noupdate -label start /SCCB_APB_tb/coresccb_c0/start
add wave -noupdate -label rw /SCCB_APB_tb/coresccb_c0/rw
add wave -noupdate -label data_in -radix hexadecimal /SCCB_APB_tb/coresccb_c0/data_in
add wave -noupdate -label ip_addr -radix hexadecimal /SCCB_APB_tb/coresccb_c0/ip_addr
add wave -noupdate -label sub_addr -radix hexadecimal /SCCB_APB_tb/coresccb_c0/sub_addr
add wave -noupdate -label data_out -radix hexadecimal /SCCB_APB_tb/coresccb_c0/data_out
add wave -noupdate -label sio_c_o /SCCB_APB_tb/coresccb_c0/sio_c_o
add wave -noupdate -label state -radix unsigned /SCCB_APB_tb/coresccb_c0/state
add wave -noupdate -label SCCB_CLK_CNTR -radix unsigned /SCCB_APB_tb/coresccb_c0/SCCB_CLK_CNTR
add wave -noupdate -label SCCB_CLK /SCCB_APB_tb/coresccb_c0/SCCB_CLK
add wave -noupdate -label SCCB_MID_PULSE /SCCB_APB_tb/coresccb_c0/SCCB_MID_PULSE
add wave -noupdate -label done /SCCB_APB_tb/coresccb_c0/done
add wave -noupdate -divider CoreSCCB
add wave -noupdate -label XCLK /SCCB_APB_tb/coresccb_c0/coresccb_c0/XCLK
add wave -noupdate -label RST_N /SCCB_APB_tb/coresccb_c0/coresccb_c0/RST_N
add wave -noupdate -label PWDN /SCCB_APB_tb/coresccb_c0/coresccb_c0/PWDN
add wave -noupdate -label start /SCCB_APB_tb/coresccb_c0/coresccb_c0/start
add wave -noupdate -label RW /SCCB_APB_tb/coresccb_c0/coresccb_c0/RW
add wave -noupdate -label data_in -radix hexadecimal /SCCB_APB_tb/coresccb_c0/coresccb_c0/data_in
add wave -noupdate -label ip_addr -radix hexadecimal /SCCB_APB_tb/coresccb_c0/coresccb_c0/ip_addr
add wave -noupdate -label sub_addr -radix hexadecimal /SCCB_APB_tb/coresccb_c0/coresccb_c0/sub_addr
add wave -noupdate -label data_out -radix hexadecimal /SCCB_APB_tb/coresccb_c0/coresccb_c0/data_out
add wave -noupdate -label done /SCCB_APB_tb/coresccb_c0/coresccb_c0/done
add wave -noupdate -label SIO_D /SCCB_APB_tb/coresccb_c0/coresccb_c0/SIO_D
add wave -noupdate -label SIO_C /SCCB_APB_tb/coresccb_c0/coresccb_c0/SIO_C
add wave -noupdate -label SCCB_MID_PULSE /SCCB_APB_tb/coresccb_c0/coresccb_c0/SCCB_MID_PULSE
add wave -noupdate -label SCCB_CLK /SCCB_APB_tb/coresccb_c0/coresccb_c0/SCCB_CLK
add wave -noupdate -label step -radix unsigned /SCCB_APB_tb/coresccb_c0/coresccb_c0/step
add wave -noupdate -label data_send /SCCB_APB_tb/coresccb_c0/coresccb_c0/data_send
add wave -noupdate -label sccb_clk_step /SCCB_APB_tb/coresccb_c0/coresccb_c0/sccb_clk_step
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {20865000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 142
configure wave -valuecolwidth 63
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
WaveRestoreZoom {0 ps} {472500 ns}
