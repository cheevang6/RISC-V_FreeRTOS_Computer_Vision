new_project \
         -name {sccb_desgin} \
         -location {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB_Testing\sccb_fpga_design\sccb_jderobot\designer\sccb_desgin\sccb_desgin_fp} \
         -mode {chain} \
         -connect_programmers {FALSE}
add_actel_device \
         -device {M2GL025} \
         -name {M2GL025}
enable_device \
         -name {M2GL025} \
         -enable {TRUE}
save_project
close_project
