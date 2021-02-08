# Written by Synplify Pro version mapact2018q4p1, Build 026R. Synopsys Run ID: sid1612766242 
# Top Level Design Parameters 

# Clocks 
create_clock -period 10.000 -waveform {0.000 5.000} -name {FCCC_C0_FCCC_C0_0_FCCC|GL0_net_inferred_clock} [get_pins {FCCC_C0_0/FCCC_C0_0/CCC_INST/GL0}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {clock_divider_10000000s_300000s_15s_7s|mid_pulse_inferred_clock} [get_pins {config_sccb_0/sccb_clk_0/mid_pulse/Q}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {clock_divider_10000000s_300000s_15s_7s|sccb_clk_inferred_clock} [get_pins {config_sccb_0/sccb_clk_0/sccb_clk/Q}] 

# Virtual Clocks 

# Generated Clocks 

# Paths Between Clocks 

# Multicycle Constraints 

# Point-to-point Delay Constraints 

# False Path Constraints 

# Output Load Constraints 

# Driving Cell Constraints 

# Input Delay Constraints 

# Output Delay Constraints 

# Wire Loads 

# Other Constraints 

# syn_hier Attributes 

# set_case Attributes 

# Clock Delay Constraints 
set Inferred_clkgroup_0 [list FCCC_C0_FCCC_C0_0_FCCC|GL0_net_inferred_clock]
set Inferred_clkgroup_1 [list clock_divider_10000000s_300000s_15s_7s|mid_pulse_inferred_clock]
set Inferred_clkgroup_2 [list clock_divider_10000000s_300000s_15s_7s|sccb_clk_inferred_clock]
set_clock_groups -asynchronous -group $Inferred_clkgroup_0
set_clock_groups -asynchronous -group $Inferred_clkgroup_1
set_clock_groups -asynchronous -group $Inferred_clkgroup_2


# syn_mode Attributes 

# Cells 

# Port DRC Rules 

# Input Transition Constraints 

# Unused constraints (intentionally commented out) 

# Non-forward-annotatable constraints (intentionally commented out) 

# Block Path constraints 

