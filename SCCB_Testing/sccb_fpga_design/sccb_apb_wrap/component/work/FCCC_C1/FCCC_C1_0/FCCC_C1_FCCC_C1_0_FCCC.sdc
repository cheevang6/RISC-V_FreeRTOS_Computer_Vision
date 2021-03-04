set_component FCCC_C1_FCCC_C1_0_FCCC
# Microsemi Corp.
# Date: 2021-Feb-25 02:10:12
#

create_clock -period 20 [ get_pins { CCC_INST/RCOSC_25_50MHZ } ]
create_generated_clock -multiply_by 2 -divide_by 2 -source [ get_pins { CCC_INST/RCOSC_25_50MHZ } ] -phase 0 [ get_pins { CCC_INST/GL0 } ]
