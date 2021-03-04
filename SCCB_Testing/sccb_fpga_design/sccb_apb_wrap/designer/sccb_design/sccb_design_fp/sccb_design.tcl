open_project -project {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB_Testing\sccb_fpga_design\sccb_apb_wrap\designer\sccb_design\sccb_design_fp\sccb_design.pro}\
         -connect_programmers {FALSE}
load_programming_data \
    -name {M2GL025} \
    -fpga {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB_Testing\sccb_fpga_design\sccb_apb_wrap\designer\sccb_design\sccb_design.map} \
    -header {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB_Testing\sccb_fpga_design\sccb_apb_wrap\designer\sccb_design\sccb_design.hdr} \
    -spm {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB_Testing\sccb_fpga_design\sccb_apb_wrap\designer\sccb_design\sccb_design.spm} \
    -dca {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB_Testing\sccb_fpga_design\sccb_apb_wrap\designer\sccb_design\sccb_design.dca}
export_single_ppd \
    -name {M2GL025} \
    -file {C:\Users\cheec\Desktop\Master\RISC-V_FreeRTOS_Computer_Vision\SCCB_Testing\sccb_fpga_design\sccb_apb_wrap\designer\sccb_design\sccb_design.ppd}

save_project
close_project
