set_device \
    -fam IGLOO2 \
    -die PA4MGL2500_N \
    -pkg vf256
set_mddr_reg \
	-path {C:/Users/cheec/Desktop/Master/Creative-Eval-Board/IGL2_MiV_FreeRTOS_Demo/FPGA Design/IGL2_MiV_FreeRTOS_Demo_Custom_Core/component/work/MSS_SubSystem_sb_HPMS/MDDR_init.reg}
set_input_cfg \
	-path {C:/Users/cheec/Desktop/Master/Creative-Eval-Board/IGL2_MiV_FreeRTOS_Demo/FPGA Design/IGL2_MiV_FreeRTOS_Demo_Custom_Core/component/work/MSS_SubSystem_sb_HPMS/ENVM.cfg}
set_output_efc \
    -path {C:\Users\cheec\Desktop\Master\Creative-Eval-Board\IGL2_MiV_FreeRTOS_Demo\FPGA Design\IGL2_MiV_FreeRTOS_Demo_Custom_Core\designer\Top_Level\Top_Level.efc}
set_proj_dir \
    -path {C:\Users\cheec\Desktop\Master\Creative-Eval-Board\IGL2_MiV_FreeRTOS_Demo\FPGA Design\IGL2_MiV_FreeRTOS_Demo_Custom_Core}
gen_prg -use_init true
