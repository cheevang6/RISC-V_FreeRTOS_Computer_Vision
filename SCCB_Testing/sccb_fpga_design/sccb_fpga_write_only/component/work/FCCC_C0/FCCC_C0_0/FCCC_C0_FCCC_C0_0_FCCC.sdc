set_component FCCC_C0_FCCC_C0_0_FCCC
# Microsemi Corp.
# Date: 2021-Feb-04 14:37:36
#

create_clock -period 20 [ get_pins { CCC_INST/RCOSC_25_50MHZ } ]
create_generated_clock -multiply_by 12 -divide_by 75 -source [ get_pins { CCC_INST/RCOSC_25_50MHZ } ] -phase 0 [ get_pins { CCC_INST/GL0 } ]
