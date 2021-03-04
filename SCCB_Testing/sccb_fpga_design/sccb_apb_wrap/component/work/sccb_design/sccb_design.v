//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Thu Feb 25 01:54:55 2021
// Version: v12.3 12.800.0.16
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// sccb_design
module sccb_design(
    // Inputs
    DEVRST_N,
    // Outputs
    cam_pwdn,
    cam_rstn,
    sioc,
    xclk,
    // Inouts
    siod
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  DEVRST_N;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output cam_pwdn;
output cam_rstn;
output sioc;
output xclk;
//--------------------------------------------------------------------
// Inout
//--------------------------------------------------------------------
inout  siod;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   AND2_0_Y;
wire   cam_pwdn_net_0;
wire   cam_rstn_net_0;
wire   DEVRST_N;
wire   FCCC_C0_0_GL0_0;
wire   FCCC_C0_0_LOCK;
wire   OSC_C0_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC;
wire   sioc_net_0;
wire   siod;
wire   SYSRESET_0_POWER_ON_RESET_N;
wire   xclk_net_0;
wire   sioc_net_1;
wire   xclk_net_1;
wire   cam_rstn_net_1;
wire   cam_pwdn_net_1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign sioc_net_1     = sioc_net_0;
assign sioc           = sioc_net_1;
assign xclk_net_1     = xclk_net_0;
assign xclk           = xclk_net_1;
assign cam_rstn_net_1 = cam_rstn_net_0;
assign cam_rstn       = cam_rstn_net_1;
assign cam_pwdn_net_1 = cam_pwdn_net_0;
assign cam_pwdn       = cam_pwdn_net_1;
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

//--------config_sccb
config_sccb config_sccb_0(
        // Inputs
        .PCLK     ( FCCC_C0_0_GL0_0 ),
        .PRESETN  ( AND2_0_Y ),
        // Outputs
        .sioc     ( sioc_net_0 ),
        .xclk     ( xclk_net_0 ),
        .cam_rstn ( cam_rstn_net_0 ),
        .cam_pwdn ( cam_pwdn_net_0 ),
        // Inouts
        .siod     ( siod ) 
        );

//--------FCCC_C0
FCCC_C0 FCCC_C0_0(
        // Inputs
        .RCOSC_25_50MHZ ( OSC_C0_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC ),
        // Outputs
        .GL0            ( FCCC_C0_0_GL0_0 ),
        .LOCK           ( FCCC_C0_0_LOCK ) 
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
