set_device \
    -fam IGLOO2 \
    -die PA4MGL2500_N \
    -pkg vf256
set_mddr_reg \
	-path {C:/Users/cheec/Desktop/Master/IGL2_MiV_FreeRTOS_Demo/component/work/MSS_SubSystem_sb_HPMS/MDDR_init.reg}
set_input_cfg \
	-path {C:/Users/cheec/Desktop/Master/IGL2_MiV_FreeRTOS_Demo/component/work/MSS_SubSystem_sb_HPMS/ENVM.cfg}
set_output_efc \
    -path {C:\Users\cheec\Desktop\Master\IGL2_MiV_FreeRTOS_Demo\designer\Top_Level\Top_Level.efc}
set_proj_dir \
    -path {C:\Users\cheec\Desktop\Master\IGL2_MiV_FreeRTOS_Demo}
gen_prg -use_init true
