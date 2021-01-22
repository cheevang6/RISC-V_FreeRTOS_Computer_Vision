set_family {IGLOO2}
read_verilog -mode system_verilog {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB_Test\hdl\SCCB_CTRL.v}
read_verilog -mode system_verilog {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB_Test\component\work\sccb_design\sccb_design.v}
set_top_level {sccb_design}
map_netlist
check_constraints {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB_Test\constraint\synthesis_sdc_errors.log}
write_fdc {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB_Test\designer\sccb_design\synthesis.fdc}
