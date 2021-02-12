open_project -project {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB_Testing\sccb_fpga_design\sccb_jderobot\designer\sccb_desgin\sccb_desgin_fp\sccb_desgin.pro}
enable_device -name {M2GL025} -enable 1
set_programming_file -name {M2GL025} -file {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB_Testing\sccb_fpga_design\sccb_jderobot\designer\sccb_desgin\sccb_desgin.ppd}
set_programming_action -action {PROGRAM} -name {M2GL025} 
run_selected_actions
save_project
close_project
