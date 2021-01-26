open_project -project {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\Custom Core from HDL\IGL2_MiV_FreeRTOS_Demo_Custom_Core\designer\Top_Level\Top_Level_fp\Top_Level.pro}\
         -connect_programmers {FALSE}
load_programming_data \
    -name {M2GL025} \
    -fpga {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\Custom Core from HDL\IGL2_MiV_FreeRTOS_Demo_Custom_Core\designer\Top_Level\Top_Level.map} \
    -header {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\Custom Core from HDL\IGL2_MiV_FreeRTOS_Demo_Custom_Core\designer\Top_Level\Top_Level.hdr} \
    -envm {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\Custom Core from HDL\IGL2_MiV_FreeRTOS_Demo_Custom_Core\designer\Top_Level\Top_Level.efc} \
    -spm {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\Custom Core from HDL\IGL2_MiV_FreeRTOS_Demo_Custom_Core\designer\Top_Level\Top_Level.spm} \
    -dca {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\Custom Core from HDL\IGL2_MiV_FreeRTOS_Demo_Custom_Core\designer\Top_Level\Top_Level.dca}
export_single_ppd \
    -name {M2GL025} \
    -file {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\Custom Core from HDL\IGL2_MiV_FreeRTOS_Demo_Custom_Core\designer\Top_Level\Top_Level.ppd}

save_project
close_project
