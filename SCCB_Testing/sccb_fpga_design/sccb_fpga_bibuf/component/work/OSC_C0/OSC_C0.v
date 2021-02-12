//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Thu Jan 28 01:47:28 2021
// Version: v12.3 12.800.0.16
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// OSC_C0
module OSC_C0(
    // Outputs
    RCOSC_25_50MHZ_CCC
);

//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output RCOSC_25_50MHZ_CCC;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC;
wire   RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire   GND_net;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net = 1'b0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC_net_0 = RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC;
assign RCOSC_25_50MHZ_CCC                              = RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC_net_0;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------OSC_C0_OSC_C0_0_OSC   -   Actel:SgCore:OSC:2.0.101
OSC_C0_OSC_C0_0_OSC OSC_C0_0(
        // Inputs
        .XTL                ( GND_net ), // tied to 1'b0 from definition
        // Outputs
        .RCOSC_25_50MHZ_CCC ( RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC ),
        .RCOSC_25_50MHZ_O2F (  ),
        .RCOSC_1MHZ_CCC     (  ),
        .RCOSC_1MHZ_O2F     (  ),
        .XTLOSC_CCC         (  ),
        .XTLOSC_O2F         (  ) 
        );


endmodule