# Written by Synplify Pro version mapact2018q4p1, Build 026R. Synopsys Run ID: sid1611270328 
# Top Level Design Parameters 

# Clocks 
create_clock -period 166.670 -waveform {0.000 83.330} -name {TCK} [get_ports {TCK}] 
create_clock -period 20.000 -waveform {0.000 10.000} -name {MSS_SubSystem_sb_0/FABOSC_0/I_RCOSC_25_50MHZ/CLKOUT} [get_pins {MSS_SubSystem_sb_0/FABOSC_0/I_RCOSC_25_50MHZ/CLKOUT}] 
create_clock -period 80.000 -waveform {0.000 40.000} -name {MSS_SubSystem_sb_0/MSS_SubSystem_sb_HPMS_0/CLK_CONFIG_APB} [get_pins {MSS_SubSystem_sb_0/MSS_SubSystem_sb_HPMS_0/MSS_ADLIB_INST/CLK_CONFIG_APB}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {COREJTAGDEBUG_UJTAG_WRAPPER|UDRCK_inferred_clock} [get_pins {JTAG_0/JTAG_0/genblk1.genblk1.genblk1.UJTAG_inst/UJTAG_inst/UDRCK}] 

# Virtual Clocks 

# Generated Clocks 
create_generated_clock -name {MSS_SubSystem_sb_0/CCC_0/GL0} -multiply_by {4} -divide_by {4} -source [get_pins {MSS_SubSystem_sb_0/FABOSC_0/I_RCOSC_25_50MHZ/CLKOUT}]  [get_pins {MSS_SubSystem_sb_0/CCC_0/CCC_INST/GL0}] 

# Paths Between Clocks 

# Multicycle Constraints 

# Point-to-point Delay Constraints 

# False Path Constraints 
set_false_path -through [get_pins {MSS_SubSystem_sb_0/CORERESETP_0/INIT_DONE_int/Q}] 
set_false_path -through [get_pins {MSS_SubSystem_sb_0/CORECONFIGP_0/soft_reset_reg[1]/Q MSS_SubSystem_sb_0/CORECONFIGP_0/control_reg_1[0]/Q MSS_SubSystem_sb_0/CORECONFIGP_0/control_reg_1[1]/Q MSS_SubSystem_sb_0/CORECONFIGP_0/soft_reset_reg[3]/Q}] 
set_false_path -through [get_pins {MSS_SubSystem_sb_0/CORERESETP_0/count_ddr_enable/Q MSS_SubSystem_sb_0/CORERESETP_0/ddr_settled/Q MSS_SubSystem_sb_0/CORERESETP_0/release_sdif0_core/Q MSS_SubSystem_sb_0/CORERESETP_0/release_sdif1_core/Q MSS_SubSystem_sb_0/CORERESETP_0/release_sdif2_core/Q MSS_SubSystem_sb_0/CORERESETP_0/release_sdif3_core/Q}] 

# Output Load Constraints 

# Driving Cell Constraints 

# Input Delay Constraints 

# Output Delay Constraints 

# Wire Loads 

# Other Constraints 

# syn_hier Attributes 

# set_case Attributes 

# Clock Delay Constraints 
set_clock_groups -asynchronous -group [get_clocks {COREJTAGDEBUG_UJTAG_WRAPPER|UDRCK_inferred_clock}]

# syn_mode Attributes 

# Cells 

# Port DRC Rules 

# Input Transition Constraints 

# Unused constraints (intentionally commented out) 
# set_false_path -from [get_cells { MSS_SubSystem_sb_0.CORERESETP_0.MSS_HPMS_READY_int }] -to [get_cells { MSS_SubSystem_sb_0.CORERESETP_0.sm0_areset_n_rcosc MSS_SubSystem_sb_0.CORERESETP_0.sm0_areset_n_rcosc_q1 }]
# set_false_path -from [get_cells { MSS_SubSystem_sb_0.CORERESETP_0.MSS_HPMS_READY_int MSS_SubSystem_sb_0.CORERESETP_0.SDIF*_PERST_N_re }] -to [get_cells { MSS_SubSystem_sb_0.CORERESETP_0.sdif*_areset_n_rcosc* }]
# set_false_path -through [get_pins { MSS_SubSystem_sb_0.MSS_SubSystem_sb_HPMS_0.MSS_ADLIB_INST.CONFIG_PRESET_N }]
# set_false_path -through [get_pins { MSS_SubSystem_sb_0.SYSRESET_POR.POWER_ON_RESET_N }]
# set_false_path -from [get_clocks { TCK }] -to [get_clocks { MSS_SubSystem_sb_0/CCC_0/GL0 }]
# set_false_path -from [get_clocks { MSS_SubSystem_sb_0/CCC_0/GL0 }] -to [get_clocks { TCK }]
# set_max_delay 0 -through [get_nets { MSS_SubSystem_sb_0.CORECONFIGP_0.FIC_2_APB_M_PSEL MSS_SubSystem_sb_0.CORECONFIGP_0.FIC_2_APB_M_PENABLE }] -to [get_cells { MSS_SubSystem_sb_0.CORECONFIGP_0.FIC_2_APB_M_PREADY* MSS_SubSystem_sb_0.CORECONFIGP_0.state[0] }]
# set_min_delay -24 -through [get_nets { MSS_SubSystem_sb_0.CORECONFIGP_0.FIC_2_APB_M_PWRITE MSS_SubSystem_sb_0.CORECONFIGP_0.FIC_2_APB_M_PADDR[*] MSS_SubSystem_sb_0.CORECONFIGP_0.FIC_2_APB_M_PWDATA[*] MSS_SubSystem_sb_0.CORECONFIGP_0.FIC_2_APB_M_PSEL MSS_SubSystem_sb_0.CORECONFIGP_0.FIC_2_APB_M_PENABLE }]

# Non-forward-annotatable constraints (intentionally commented out) 

# Block Path constraints 

