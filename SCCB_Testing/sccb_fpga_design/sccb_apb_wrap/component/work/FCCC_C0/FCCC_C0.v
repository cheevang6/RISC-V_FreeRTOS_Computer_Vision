//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Fri Feb 12 11:24:46 2021
// Version: v12.3 12.800.0.16
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// FCCC_C0
module FCCC_C0(
    // Inputs
    RCOSC_25_50MHZ,
    // Outputs
    GL0,
    LOCK
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  RCOSC_25_50MHZ;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output GL0;
output LOCK;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   GL0_net_0;
wire   LOCK_net_0;
wire   RCOSC_25_50MHZ;
wire   GL0_net_1;
wire   LOCK_net_1;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire   GND_net;
wire   [7:2]PADDR_const_net_0;
wire   [7:0]PWDATA_const_net_0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net            = 1'b0;
assign PADDR_const_net_0  = 6'h00;
assign PWDATA_const_net_0 = 8'h00;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign GL0_net_1  = GL0_net_0;
assign GL0        = GL0_net_1;
assign LOCK_net_1 = LOCK_net_0;
assign LOCK       = LOCK_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------FCCC_C0_FCCC_C0_0_FCCC   -   Actel:SgCore:FCCC:2.0.201
FCCC_C0_FCCC_C0_0_FCCC FCCC_C0_0(
        // Inputs
        .RCOSC_25_50MHZ ( RCOSC_25_50MHZ ),
        // Outputs
        .GL0            ( GL0_net_0 ),
        .LOCK           ( LOCK_net_0 ) 
        );


endmodule
