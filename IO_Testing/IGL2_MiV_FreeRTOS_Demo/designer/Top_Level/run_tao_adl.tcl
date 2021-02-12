set_family {IGLOO2}
read_adl {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\IGL2_MiV_FreeRTOS_Demo\designer\Top_Level\Top_Level.adl}
read_afl {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\IGL2_MiV_FreeRTOS_Demo\designer\Top_Level\Top_Level.afl}
map_netlist
read_sdc {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\IGL2_MiV_FreeRTOS_Demo\constraint\Top_Level_derived_constraints.sdc}
read_sdc {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\IGL2_MiV_FreeRTOS_Demo\constraint\JTAG_tck_constraint.sdc}
check_constraints {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\IGL2_MiV_FreeRTOS_Demo\constraint\placer_sdc_errors.log}
write_sdc -strict -afl {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\IO_Testing\IGL2_MiV_FreeRTOS_Demo\designer\Top_Level\place_route.sdc}
