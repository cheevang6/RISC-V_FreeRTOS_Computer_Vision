//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Tue Feb  9 18:56:52 2021
// Version: v12.3 12.800.0.16
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// sccb_desgin
module sccb_desgin(
    // Inputs
    DEVRST_N,
    // Outputs
    done,
    ov7670_pwdn,
    ov7670_rst_n,
    sioc,
    siod,
    xclk
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  DEVRST_N;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output done;
output ov7670_pwdn;
output ov7670_rst_n;
output sioc;
output siod;
output xclk;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   AND2_0_Y;
wire   DEVRST_N;
wire   done_net_0;
wire   FCCC_C0_0_GL0;
wire   FCCC_C0_0_LOCK;
wire   OSC_C0_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC;
wire   ov7670_pwdn_net_0;
wire   ov7670_rst_n_net_0;
wire   sioc_net_0;
wire   siod_net_0;
wire   SYSRESET_0_POWER_ON_RESET_N;
wire   xclk_net_0;
wire   done_net_1;
wire   sioc_net_1;
wire   siod_net_1;
wire   ov7670_rst_n_net_1;
wire   xclk_net_1;
wire   ov7670_pwdn_net_1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign done_net_1         = done_net_0;
assign done               = done_net_1;
assign sioc_net_1         = sioc_net_0;
assign sioc               = sioc_net_1;
assign siod_net_1         = siod_net_0;
assign siod               = siod_net_1;
assign ov7670_rst_n_net_1 = ov7670_rst_n_net_0;
assign ov7670_rst_n       = ov7670_rst_n_net_1;
assign xclk_net_1         = xclk_net_0;
assign xclk               = xclk_net_1;
assign ov7670_pwdn_net_1  = ov7670_pwdn_net_0;
assign ov7670_pwdn        = ov7670_pwdn_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------AND2
AND2 AND2_0(
        // Inputs
        .A ( SYSRESET_0_POWER_ON_RESET_N ),
        .B ( FCCC_C0_0_LOCK ),
        // Outputs
        .Y ( AND2_0_Y ) 
        );

//--------FCCC_C0
FCCC_C0 FCCC_C0_0(
        // Inputs
        .RCOSC_25_50MHZ ( OSC_C0_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC ),
        // Outputs
        .GL0            ( FCCC_C0_0_GL0 ),
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

//--------top_ov7670
top_ov7670 top_ov7670_0(
        // Inputs
        .rst          ( AND2_0_Y ),
        .clk          ( FCCC_C0_0_GL0 ),
        // Outputs
        .ov7670_sioc  ( sioc_net_0 ),
        .ov7670_siod  ( siod_net_0 ),
        .ov7670_rst_n ( ov7670_rst_n_net_0 ),
        .ov7670_pwdn  ( ov7670_pwdn_net_0 ),
        .ov7670_xclk  ( xclk_net_0 ),
        .done         ( done_net_0 ) 
        );


endmodule
