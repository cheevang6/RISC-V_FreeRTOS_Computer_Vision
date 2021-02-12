set_family {IGLOO2}
read_verilog -mode system_verilog {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB_Testing\sccb_fpga_design\sccb_jderobot\component\work\FCCC_C0\FCCC_C0_0\FCCC_C0_FCCC_C0_0_FCCC.v}
read_verilog -mode system_verilog {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB_Testing\sccb_fpga_design\sccb_jderobot\component\work\FCCC_C0\FCCC_C0.v}
read_verilog -mode system_verilog {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB_Testing\sccb_fpga_design\sccb_jderobot\component\work\OSC_C0\OSC_C0_0\OSC_C0_OSC_C0_0_OSC.v}
read_verilog -mode system_verilog {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB_Testing\sccb_fpga_design\sccb_jderobot\component\work\OSC_C0\OSC_C0.v}
read_verilog -mode system_verilog {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB_Testing\sccb_fpga_design\sccb_jderobot\hdl\ov7670_ctrl_reg.v}
read_verilog -mode system_verilog {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB_Testing\sccb_fpga_design\sccb_jderobot\hdl\sccb_master.v}
read_verilog -mode system_verilog {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB_Testing\sccb_fpga_design\sccb_jderobot\hdl\ov7670_top_ctrl.v}
read_verilog -mode system_verilog {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB_Testing\sccb_fpga_design\sccb_jderobot\hdl\top_ov7670.v}
read_verilog -mode system_verilog {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB_Testing\sccb_fpga_design\sccb_jderobot\component\work\sccb_desgin\sccb_desgin.v}
set_top_level {sccb_desgin}
map_netlist
check_constraints {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB_Testing\sccb_fpga_design\sccb_jderobot\constraint\synthesis_sdc_errors.log}
write_fdc {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB_Testing\sccb_fpga_design\sccb_jderobot\designer\sccb_desgin\synthesis.fdc}
