# Written by Synplify Pro version mapact2018q4p1, Build 026R. Synopsys Run ID: sid1608240282 
# Top Level Design Parameters 

# Clocks 
create_clock -period 10.000 -waveform {0.000 5.000} -name {sccb_design|xclk} [get_ports {xclk}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {SCCB_CTRL|SCCB_CLK_inferred_clock} [get_pins {SCCB_CTRL_0/SCCB_CLK/Q}] 

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
set Inferred_clkgroup_0 [list sccb_design|xclk]
set Inferred_clkgroup_1 [list SCCB_CTRL|SCCB_CLK_inferred_clock]
set_clock_groups -asynchronous -group $Inferred_clkgroup_0
set_clock_groups -asynchronous -group $Inferred_clkgroup_1


# syn_mode Attributes 

# Cells 

# Port DRC Rules 

# Input Transition Constraints 

# Unused constraints (intentionally commented out) 

# Non-forward-annotatable constraints (intentionally commented out) 

# Block Path constraints 

