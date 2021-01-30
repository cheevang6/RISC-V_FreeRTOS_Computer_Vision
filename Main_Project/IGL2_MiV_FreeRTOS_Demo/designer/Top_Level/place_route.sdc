# Microsemi Corp.
# Date: 2020-Oct-29 14:54:17
# This file was generated based on the following SDC source files:
#   C:/Users/cheec/Desktop/Master/IGL2_MiV_FreeRTOS_Demo/constraint/Top_Level_derived_constraints.sdc
#   C:/Users/cheec/Desktop/Master/IGL2_MiV_FreeRTOS_Demo/constraint/JTAG_tck_constraint.sdc
#

create_clock -name {MSS_SubSystem_sb_0/FABOSC_0/I_RCOSC_25_50MHZ/CLKOUT} -period 20 [ get_pins { MSS_SubSystem_sb_0/FABOSC_0/I_RCOSC_25_50MHZ/CLKOUT } ]
create_clock -name {MSS_SubSystem_sb_0/MSS_SubSystem_sb_HPMS_0/CLK_CONFIG_APB} -period 80 [ get_pins { MSS_SubSystem_sb_0/MSS_SubSystem_sb_HPMS_0/MSS_ADLIB_INST/INST_MSS_025_IP/CLK_CONFIG_APB } ]
create_clock -name {TCK} -period 166.67 -waveform {0 83.33 } [ get_ports { TCK } ]
create_generated_clock -name {MSS_SubSystem_sb_0/CCC_0/GL0} -multiply_by 4 -divide_by 4 -source [ get_pins { MSS_SubSystem_sb_0/CCC_0/CCC_INST/INST_CCC_IP/RCOSC_25_50MHZ } ] -phase 0 [ get_pins { MSS_SubSystem_sb_0/CCC_0/CCC_INST/INST_CCC_IP/GL0 } ]
set_false_path -through [ get_pins { MSS_SubSystem_sb_0/CORECONFIGP_0/INIT_DONE_q1/D } ]
set_false_path -through [ get_nets { MSS_SubSystem_sb_0/CORERESETP_0/ddr_settled MSS_SubSystem_sb_0/CORERESETP_0/count_ddr_enable MSS_SubSystem_sb_0/CORERESETP_0/release_sdif*_core } ]
set_false_path -from [ get_cells { MSS_SubSystem_sb_0/CORERESETP_0/MSS_HPMS_READY_int } ] -to [ get_cells { MSS_SubSystem_sb_0/CORERESETP_0/sm0_areset_n_rcosc MSS_SubSystem_sb_0/CORERESETP_0/sm0_areset_n_rcosc_q1 } ]
set_false_path -from [ get_cells { MSS_SubSystem_sb_0/CORERESETP_0/MSS_HPMS_READY_int } ] -to [ get_cells { MSS_SubSystem_sb_0/CORERESETP_0/sdif*_areset_n_rcosc* } ]
set_false_path -through [ get_pins { MSS_SubSystem_sb_0/CORERESETP_0/CONFIG1_DONE_q1/D MSS_SubSystem_sb_0/CORERESETP_0/CONFIG2_DONE_q1/D MSS_SubSystem_sb_0/CORERESETP_0/SOFT_RESET_F2M_keep_RNIH69D/A MSS_SubSystem_sb_0/CORERESETP_0/MDDR_DDR_AXI_S_CORE_RESET_N/B } ]
set_false_path -through [ get_pins { MSS_SubSystem_sb_0/MSS_SubSystem_sb_HPMS_0/MSS_ADLIB_INST/INST_MSS_025_IP/CONFIG_PRESET_N } ]
set_false_path -from [ get_clocks { TCK } ] -to [ get_clocks { MSS_SubSystem_sb_0/CCC_0/GL0 } ]
set_false_path -from [ get_clocks { MSS_SubSystem_sb_0/CCC_0/GL0 } ] -to [ get_clocks { TCK } ]
set_max_delay 0 -through [ get_pins { MSS_SubSystem_sb_0/CORECONFIGP_0/next_state4/B MSS_SubSystem_sb_0/CORECONFIGP_0/next_state4/A MSS_SubSystem_sb_0/CORECONFIGP_0/soft_reset_reg5/A MSS_SubSystem_sb_0/CORECONFIGP_0/control_reg_14_1/A } ] -to [ get_cells { MSS_SubSystem_sb_0/CORECONFIGP_0/FIC_2_APB_M_PREADY* MSS_SubSystem_sb_0/CORECONFIGP_0/state[0] } ]
set_min_delay -24 -through [ get_pins { MSS_SubSystem_sb_0/CORECONFIGP_0/control_reg_14_1/B MSS_SubSystem_sb_0/CORECONFIGP_0/pwrite/D MSS_SubSystem_sb_0/CORECONFIGP_0/soft_reset_reg5/B MSS_SubSystem_sb_0/CORECONFIGP_0/paddr[6]/D MSS_SubSystem_sb_0/CORECONFIGP_0/paddr[7]/D MSS_SubSystem_sb_0/CORECONFIGP_0/paddr[8]/D MSS_SubSystem_sb_0/CORECONFIGP_0/paddr[15]/D MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[8]/A MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[11]/A MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[13]/A MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[4]/A MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[12]/A MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[6]/A MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[2]/A MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[3]/A MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[14]/A MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[9]/A MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[7]/A MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[15]/A MSS_SubSystem_sb_0/CORECONFIGP_0/int_prdata_1[1]/A MSS_SubSystem_sb_0/CORECONFIGP_0/int_prdata_1[16]/A MSS_SubSystem_sb_0/CORECONFIGP_0/int_prdata_1_0[0]/A MSS_SubSystem_sb_0/CORECONFIGP_0/FIC_2_APB_M_PADDR_keep_RNI8JIB1[3]/C MSS_SubSystem_sb_0/CORECONFIGP_0/FIC_2_APB_M_PRDATA_RNO[17]/A MSS_SubSystem_sb_0/CORECONFIGP_0/control_reg_14/A MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[5]/A MSS_SubSystem_sb_0/CORECONFIGP_0/int_prdata[1]/A MSS_SubSystem_sb_0/CORECONFIGP_0/paddr[2]/D MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[10]/A MSS_SubSystem_sb_0/CORECONFIGP_0/paddr[5]/D MSS_SubSystem_sb_0/CORECONFIGP_0/paddr[12]/D MSS_SubSystem_sb_0/CORECONFIGP_0/paddr[9]/D MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[10]/B MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[8]/B MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[11]/B MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[13]/B MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[4]/B MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[12]/B MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[6]/B MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[2]/B MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[3]/B MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[14]/B MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[9]/B MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[7]/B MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[15]/B MSS_SubSystem_sb_0/CORECONFIGP_0/int_prdata_1[1]/B MSS_SubSystem_sb_0/CORECONFIGP_0/int_prdata_1[16]/C MSS_SubSystem_sb_0/CORECONFIGP_0/FIC_2_APB_M_PRDATA_RNO[16]/B MSS_SubSystem_sb_0/CORECONFIGP_0/FIC_2_APB_M_PADDR_keep_RNI8JIB1[3]/B MSS_SubSystem_sb_0/CORECONFIGP_0/FIC_2_APB_M_PRDATA_RNO[17]/D MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[5]/D MSS_SubSystem_sb_0/CORECONFIGP_0/paddr[3]/D MSS_SubSystem_sb_0/CORECONFIGP_0/control_reg_14_2/A MSS_SubSystem_sb_0/CORECONFIGP_0/paddr[13]/D MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[10]/C MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[8]/C MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[11]/C MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[13]/C MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[4]/C MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[12]/C MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[6]/C MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[2]/C MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[3]/C MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[14]/C MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[9]/C MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[7]/C MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[15]/C MSS_SubSystem_sb_0/CORECONFIGP_0/int_prdata_1[1]/C MSS_SubSystem_sb_0/CORECONFIGP_0/int_prdata_1[16]/B MSS_SubSystem_sb_0/CORECONFIGP_0/control_reg_14_2/B MSS_SubSystem_sb_0/CORECONFIGP_0/FIC_2_APB_M_PADDR_keep_RNI8JIB1[3]/A MSS_SubSystem_sb_0/CORECONFIGP_0/FIC_2_APB_M_PRDATA_RNO[17]/C MSS_SubSystem_sb_0/CORECONFIGP_0/prdata_0_iv_RNO[5]/C MSS_SubSystem_sb_0/CORECONFIGP_0/paddr[4]/D MSS_SubSystem_sb_0/CORECONFIGP_0/FIC_2_APB_M_PRDATA_RNO[16]/A MSS_SubSystem_sb_0/CORECONFIGP_0/paddr[10]/D MSS_SubSystem_sb_0/CORECONFIGP_0/pwdata[4]/D MSS_SubSystem_sb_0/CORECONFIGP_0/soft_reset_reg[4]/D MSS_SubSystem_sb_0/CORECONFIGP_0/pwdata[5]/D MSS_SubSystem_sb_0/CORECONFIGP_0/soft_reset_reg[5]/D MSS_SubSystem_sb_0/CORECONFIGP_0/pwdata[6]/D MSS_SubSystem_sb_0/CORECONFIGP_0/soft_reset_reg[6]/D MSS_SubSystem_sb_0/CORECONFIGP_0/pwdata[8]/D MSS_SubSystem_sb_0/CORECONFIGP_0/soft_reset_reg[8]/D MSS_SubSystem_sb_0/CORECONFIGP_0/pwdata[9]/D MSS_SubSystem_sb_0/CORECONFIGP_0/soft_reset_reg[9]/D MSS_SubSystem_sb_0/CORECONFIGP_0/pwdata[11]/D MSS_SubSystem_sb_0/CORECONFIGP_0/soft_reset_reg[11]/D MSS_SubSystem_sb_0/CORECONFIGP_0/pwdata[12]/D MSS_SubSystem_sb_0/CORECONFIGP_0/soft_reset_reg[12]/D MSS_SubSystem_sb_0/CORECONFIGP_0/pwdata[13]/D MSS_SubSystem_sb_0/CORECONFIGP_0/soft_reset_reg[13]/D MSS_SubSystem_sb_0/CORECONFIGP_0/pwdata[14]/D MSS_SubSystem_sb_0/CORECONFIGP_0/soft_reset_reg[14]/D MSS_SubSystem_sb_0/CORECONFIGP_0/pwdata[15]/D MSS_SubSystem_sb_0/CORECONFIGP_0/soft_reset_reg[15]/D MSS_SubSystem_sb_0/CORECONFIGP_0/soft_reset_reg[16]/D MSS_SubSystem_sb_0/CORECONFIGP_0/pwdata[10]/D MSS_SubSystem_sb_0/CORECONFIGP_0/soft_reset_reg[10]/D MSS_SubSystem_sb_0/CORECONFIGP_0/pwdata[7]/D MSS_SubSystem_sb_0/CORECONFIGP_0/soft_reset_reg[7]/D MSS_SubSystem_sb_0/CORECONFIGP_0/soft_reset_reg[0]/D MSS_SubSystem_sb_0/CORECONFIGP_0/control_reg_1[0]/D MSS_SubSystem_sb_0/CORECONFIGP_0/pwdata[0]/D MSS_SubSystem_sb_0/CORECONFIGP_0/pwdata[2]/D MSS_SubSystem_sb_0/CORECONFIGP_0/soft_reset_reg[2]/D MSS_SubSystem_sb_0/CORECONFIGP_0/soft_reset_reg[1]/D MSS_SubSystem_sb_0/CORECONFIGP_0/control_reg_1[1]/D MSS_SubSystem_sb_0/CORECONFIGP_0/pwdata[1]/D MSS_SubSystem_sb_0/CORECONFIGP_0/pwdata[3]/D MSS_SubSystem_sb_0/CORECONFIGP_0/soft_reset_reg[3]/D MSS_SubSystem_sb_0/CORECONFIGP_0/next_state4/B MSS_SubSystem_sb_0/CORECONFIGP_0/next_state4/A MSS_SubSystem_sb_0/CORECONFIGP_0/soft_reset_reg5/A MSS_SubSystem_sb_0/CORECONFIGP_0/control_reg_14_1/A } ]