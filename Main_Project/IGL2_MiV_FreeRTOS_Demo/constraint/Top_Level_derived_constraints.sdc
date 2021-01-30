# Microsemi Corp.
# Date: 2019-Apr-24 09:13:01
# This file was generated based on the following SDC source files:
#   D:/Work/Libero/IGL2_MiV_FreeRTOS_Demo/component/work/BasicIO_Interface/BasicIO_Interface.sdc
#   D:/Work/Libero/IGL2_MiV_FreeRTOS_Demo/component/work/MSS_SubSystem_sb/CCC_0/MSS_SubSystem_sb_CCC_0_FCCC.sdc
#   C:/Microsemi/Libero_SoC_v12.1/Designer/data/aPA4M/cores/constraints/PA4M2500/coreconfigp.sdc
#   C:/Microsemi/Libero_SoC_v12.1/Designer/data/aPA4M/cores/constraints/coreresetp.sdc
#   D:/Work/Libero/IGL2_MiV_FreeRTOS_Demo/component/work/MSS_SubSystem_sb/FABOSC_0/MSS_SubSystem_sb_FABOSC_0_OSC.sdc
#   D:/Work/Libero/IGL2_MiV_FreeRTOS_Demo/component/work/MSS_SubSystem_sb_HPMS/MSS_SubSystem_sb_HPMS.sdc
#   C:/Microsemi/Libero_SoC_v12.1/Designer/data/aPA4M/cores/constraints/sysreset.sdc
#

create_clock -name {MSS_SubSystem_sb_0/FABOSC_0/I_RCOSC_25_50MHZ/CLKOUT} -period 20 [ get_pins { MSS_SubSystem_sb_0/FABOSC_0/I_RCOSC_25_50MHZ/CLKOUT } ]
create_clock -name {MSS_SubSystem_sb_0/MSS_SubSystem_sb_HPMS_0/CLK_CONFIG_APB} -period 80 [ get_pins { MSS_SubSystem_sb_0/MSS_SubSystem_sb_HPMS_0/MSS_ADLIB_INST/CLK_CONFIG_APB } ]
create_generated_clock -name {MSS_SubSystem_sb_0/CCC_0/GL0} -multiply_by 4 -divide_by 4 -source [ get_pins { MSS_SubSystem_sb_0/CCC_0/CCC_INST/RCOSC_25_50MHZ } ] -phase 0 [ get_pins { MSS_SubSystem_sb_0/CCC_0/CCC_INST/GL0 } ]
set_false_path -ignore_errors -through [ get_nets { MSS_SubSystem_sb_0/CORECONFIGP_0/INIT_DONE MSS_SubSystem_sb_0/CORECONFIGP_0/SDIF_RELEASED } ]
set_false_path -ignore_errors -through [ get_nets { MSS_SubSystem_sb_0/CORERESETP_0/ddr_settled MSS_SubSystem_sb_0/CORERESETP_0/count_ddr_enable MSS_SubSystem_sb_0/CORERESETP_0/release_sdif*_core MSS_SubSystem_sb_0/CORERESETP_0/count_sdif*_enable } ]
set_false_path -ignore_errors -from [ get_cells { MSS_SubSystem_sb_0/CORERESETP_0/MSS_HPMS_READY_int } ] -to [ get_cells { MSS_SubSystem_sb_0/CORERESETP_0/sm0_areset_n_rcosc MSS_SubSystem_sb_0/CORERESETP_0/sm0_areset_n_rcosc_q1 } ]
set_false_path -ignore_errors -from [ get_cells { MSS_SubSystem_sb_0/CORERESETP_0/MSS_HPMS_READY_int MSS_SubSystem_sb_0/CORERESETP_0/SDIF*_PERST_N_re } ] -to [ get_cells { MSS_SubSystem_sb_0/CORERESETP_0/sdif*_areset_n_rcosc* } ]
set_false_path -ignore_errors -through [ get_nets { MSS_SubSystem_sb_0/CORERESETP_0/CONFIG1_DONE MSS_SubSystem_sb_0/CORERESETP_0/CONFIG2_DONE MSS_SubSystem_sb_0/CORERESETP_0/SDIF*_PERST_N MSS_SubSystem_sb_0/CORERESETP_0/SDIF*_PSEL MSS_SubSystem_sb_0/CORERESETP_0/SDIF*_PWRITE MSS_SubSystem_sb_0/CORERESETP_0/SDIF*_PRDATA[*] MSS_SubSystem_sb_0/CORERESETP_0/SOFT_EXT_RESET_OUT MSS_SubSystem_sb_0/CORERESETP_0/SOFT_RESET_F2M MSS_SubSystem_sb_0/CORERESETP_0/SOFT_M3_RESET MSS_SubSystem_sb_0/CORERESETP_0/SOFT_MDDR_DDR_AXI_S_CORE_RESET MSS_SubSystem_sb_0/CORERESETP_0/SOFT_FDDR_CORE_RESET MSS_SubSystem_sb_0/CORERESETP_0/SOFT_SDIF*_PHY_RESET MSS_SubSystem_sb_0/CORERESETP_0/SOFT_SDIF*_CORE_RESET MSS_SubSystem_sb_0/CORERESETP_0/SOFT_SDIF0_0_CORE_RESET MSS_SubSystem_sb_0/CORERESETP_0/SOFT_SDIF0_1_CORE_RESET } ]
set_false_path -ignore_errors -through [ get_pins { MSS_SubSystem_sb_0/MSS_SubSystem_sb_HPMS_0/MSS_ADLIB_INST/CONFIG_PRESET_N } ]
set_false_path -ignore_errors -through [ get_pins { MSS_SubSystem_sb_0/SYSRESET_POR/POWER_ON_RESET_N } ]
set_max_delay 0 -through [ get_nets { MSS_SubSystem_sb_0/CORECONFIGP_0/FIC_2_APB_M_PSEL MSS_SubSystem_sb_0/CORECONFIGP_0/FIC_2_APB_M_PENABLE } ] -to [ get_cells { MSS_SubSystem_sb_0/CORECONFIGP_0/FIC_2_APB_M_PREADY* MSS_SubSystem_sb_0/CORECONFIGP_0/state[0] } ]
set_min_delay -24 -through [ get_nets { MSS_SubSystem_sb_0/CORECONFIGP_0/FIC_2_APB_M_PWRITE MSS_SubSystem_sb_0/CORECONFIGP_0/FIC_2_APB_M_PADDR[*] MSS_SubSystem_sb_0/CORECONFIGP_0/FIC_2_APB_M_PWDATA[*] MSS_SubSystem_sb_0/CORECONFIGP_0/FIC_2_APB_M_PSEL MSS_SubSystem_sb_0/CORECONFIGP_0/FIC_2_APB_M_PENABLE } ]
