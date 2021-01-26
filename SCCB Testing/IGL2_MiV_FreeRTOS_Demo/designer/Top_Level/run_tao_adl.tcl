set_family {IGLOO2}
read_adl {D:\Work\Libero\IGL2_MiV_FreeRTOS_Demo\designer\Top_Level\Top_Level.adl}
read_afl {D:\Work\Libero\IGL2_MiV_FreeRTOS_Demo\designer\Top_Level\Top_Level.afl}
map_netlist
read_sdc {D:\Work\Libero\IGL2_MiV_FreeRTOS_Demo\constraint\Top_Level_derived_constraints.sdc}
read_sdc {D:\Work\Libero\IGL2_MiV_FreeRTOS_Demo\constraint\JTAG_tck_constraint.sdc}
check_constraints {D:\Work\Libero\IGL2_MiV_FreeRTOS_Demo\constraint\placer_sdc_errors.log}
write_sdc -strict -afl {D:\Work\Libero\IGL2_MiV_FreeRTOS_Demo\designer\Top_Level\place_route.sdc}
