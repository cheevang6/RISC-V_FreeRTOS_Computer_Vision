//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Sun Feb  7 22:37:09 2021
// Version: v12.3 12.800.0.16
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// sccb_design
module sccb_design(
    // Inputs
    DEVRST_N,
    // Outputs
    led1,
    led2,
    sio_c,
    xclk,
    // Inouts
    sio_d
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  DEVRST_N;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output led1;
output led2;
output sio_c;
output xclk;
//--------------------------------------------------------------------
// Inout
//--------------------------------------------------------------------
inout  sio_d;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   AND2_0_Y;
wire   BIBUF_0_Y;
wire   config_sccb_0_siod_o_0;
wire   DEVRST_N;
wire   FCCC_C0_0_GL0_1;
wire   FCCC_C0_0_LOCK;
wire   INV_1_Y;
wire   led1_net_0;
wire   led2_net_0;
wire   OSC_C0_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC;
wire   sio_d;
wire   sio_c_net_0;
wire   SYSRESET_0_POWER_ON_RESET_N;
wire   xclk_net_0;
wire   sio_c_net_1;
wire   led1_net_1;
wire   xclk_net_1;
wire   led2_net_1;
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
assign sio_c_net_1 = sio_c_net_0;
assign sio_c       = sio_c_net_1;
assign led1_net_1  = led1_net_0;
assign led1        = led1_net_1;
assign xclk_net_1  = xclk_net_0;
assign xclk        = xclk_net_1;
assign led2_net_1  = led2_net_0;
assign led2        = led2_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------AND2
AND2 AND2_0(
        // Inputs
        .A ( FCCC_C0_0_LOCK ),
        .B ( SYSRESET_0_POWER_ON_RESET_N ),
        // Outputs
        .Y ( AND2_0_Y ) 
        );

//--------BIBUF
BIBUF BIBUF_0(
        // Inputs
        .D   ( GND_net ),
        .E   ( INV_1_Y ),
        // Outputs
        .Y   ( BIBUF_0_Y ),
        // Inouts
        .PAD ( sio_d ) 
        );

//--------config_sccb
config_sccb config_sccb_0(
        // Inputs
        .PCLK      ( FCCC_C0_0_GL0_1 ),
        .PRESETN   ( AND2_0_Y ),
        .siod_i    ( BIBUF_0_Y ),
        // Outputs
        .sioc      ( sio_c_net_0 ),
        .siod_o    ( config_sccb_0_siod_o_0 ),
        .siod_o_en (  ) 
        );

//--------FCCC_C0
FCCC_C0 FCCC_C0_0(
        // Inputs
        .RCOSC_25_50MHZ ( OSC_C0_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC ),
        // Outputs
        .GL0            ( FCCC_C0_0_GL0_1 ),
        .LOCK           ( FCCC_C0_0_LOCK ) 
        );

//--------INV
INV INV_0(
        // Inputs
        .A ( FCCC_C0_0_GL0_1 ),
        // Outputs
        .Y ( xclk_net_0 ) 
        );

//--------INV
INV INV_1(
        // Inputs
        .A ( config_sccb_0_siod_o_0 ),
        // Outputs
        .Y ( INV_1_Y ) 
        );

//--------LIVE_PROBE_FB
LIVE_PROBE_FB LIVE_PROBE_FB_0(
        // Outputs
        .PROBE_A ( led1_net_0 ),
        .PROBE_B ( led2_net_0 ) 
        );

//--------OSC_C0
OSC_C0 OSC_C0_0(
        // Outputs
        .RCOSC_25_50MHZ_CCC ( OSC_C0_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC ) 
        );

//--------SYSRESET
SYSRESET SYSRESET_0(
        // Inputs
        .DEVRST_N         ( DEVRST_N ),
        // Outputs
        .POWER_ON_RESET_N ( SYSRESET_0_POWER_ON_RESET_N ) 
        );


endmodule
