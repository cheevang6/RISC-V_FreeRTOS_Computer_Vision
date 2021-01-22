set_component MSS_SubSystem_sb_FABOSC_0_OSC
# Microsemi Corp.
# Date: 2019-Mar-27 14:26:26
#

create_clock -ignore_errors -period 20 [ get_pins { I_RCOSC_25_50MHZ/CLKOUT } ]
