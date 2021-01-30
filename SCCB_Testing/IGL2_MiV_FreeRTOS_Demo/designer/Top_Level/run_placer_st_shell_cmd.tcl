
read_sdc -scenario "place_and_route" -netlist "optimized" -pin_separator "/" -ignore_errors {C:/Users/cheec/Desktop/Master/RISC-V_FreeRTOS_Computer_Vision/SCCB Testing/IGL2_MiV_FreeRTOS_Demo/designer/Top_Level/place_route.sdc}
set_options -tdpr_scenario "place_and_route" 
save
set_options -analysis_scenario "place_and_route"
report -type combinational_loops -format xml {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB Testing\IGL2_MiV_FreeRTOS_Demo\designer\Top_Level\Top_Level_layout_combinational_loops.xml}
report -type slack {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB Testing\IGL2_MiV_FreeRTOS_Demo\designer\Top_Level\pinslacks.txt}
set coverage [report \
    -type     constraints_coverage \
    -format   xml \
    -slacks   no \
    {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB Testing\IGL2_MiV_FreeRTOS_Demo\designer\Top_Level\Top_Level_place_and_route_constraint_coverage.xml}]
set reportfile {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB Testing\IGL2_MiV_FreeRTOS_Demo\designer\Top_Level\coverage_placeandroute}
set fp [open $reportfile w]
puts $fp $coverage
close $fp