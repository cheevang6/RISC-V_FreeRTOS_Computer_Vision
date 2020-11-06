create_clock -name { TCK } \
-period 166.67 \
-waveform { 0 83.33 } \
[ get_ports { TCK } ]

# PLL_GEN_CLK is the name applied to the "create_generated_clock" constraint derived
# from your Top Level timing in Constraint Manager

set_false_path -from [ get_clocks { TCK } ] \
-to [ get_clocks { MSS_SubSystem_sb_0/CCC_0/GL0 } ]
set_false_path -from [ get_clocks { MSS_SubSystem_sb_0/CCC_0/GL0 } ] \
-to [ get_clocks { TCK } ]