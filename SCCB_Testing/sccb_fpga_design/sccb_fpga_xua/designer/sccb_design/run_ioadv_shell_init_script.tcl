set_device \
    -family  IGLOO2 \
    -die     PA4MGL2500_N \
    -package vf256 \
    -speed   STD \
    -tempr   {COM} \
    -voltr   {COM}
set_def {VOLTAGE} {1.2}
set_def {VCCI_1.2_VOLTR} {COM}
set_def {VCCI_1.5_VOLTR} {COM}
set_def {VCCI_1.8_VOLTR} {COM}
set_def {VCCI_2.5_VOLTR} {COM}
set_def {VCCI_3.3_VOLTR} {COM}
set_def {PLL_SUPPLY} {PLL_SUPPLY_25}
set_def USE_CONSTRAINTS_FLOW 1
set_netlist -afl {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB_Testing\sccb_fpga_design\sccb_fpga_design\designer\sccb_design\sccb_design.afl} -adl {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB_Testing\sccb_fpga_design\sccb_fpga_design\designer\sccb_design\sccb_design.adl}
set_constraints   {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB_Testing\sccb_fpga_design\sccb_fpga_design\designer\sccb_design\sccb_design.tcml}
set_placement   {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB_Testing\sccb_fpga_design\sccb_fpga_design\designer\sccb_design\sccb_design.loc}
set_routing     {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB_Testing\sccb_fpga_design\sccb_fpga_design\designer\sccb_design\sccb_design.seg}
