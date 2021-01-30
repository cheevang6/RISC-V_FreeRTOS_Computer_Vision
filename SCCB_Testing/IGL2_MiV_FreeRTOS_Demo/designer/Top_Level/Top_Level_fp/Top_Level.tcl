open_project -project {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB Testing\IGL2_MiV_FreeRTOS_Demo\designer\Top_Level\Top_Level_fp\Top_Level.pro}
enable_device -name {M2GL025} -enable 1
set_programming_file -name {M2GL025} -file {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB Testing\IGL2_MiV_FreeRTOS_Demo\designer\Top_Level\Top_Level.ppd}
set_programming_action -action {PROGRAM} -name {M2GL025} 
run_selected_actions
save_project
close_project
