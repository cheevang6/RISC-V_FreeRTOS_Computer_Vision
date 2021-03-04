//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Wed Mar  3 17:53:22 2021
// Version: v12.3 12.800.0.16
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// sccb_apb
module sccb_apb(
    // Inputs
    DEVRST_N,
    PADDR,
    PWDATA,
    PWRITE,
    // Outputs
    PRDATA,
    PREADY,
    PSLVERR,
    cam_pwdn,
    cam_rstn,
    sioc,
    siod,
    xclk
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input        DEVRST_N;
input  [7:0] PADDR;
input  [7:0] PWDATA;
input        PWRITE;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [7:0] PRDATA;
output       PREADY;
output       PSLVERR;
output       cam_pwdn;
output       cam_rstn;
output       sioc;
output       siod;
output       xclk;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire         AND2_0_Y;
wire         cam_pwdn_net_0;
wire         cam_rstn_net_0;
wire         DEVRST_N;
wire         FCCC_C1_0_GL0;
wire         FCCC_C1_0_LOCK;
wire         OSC_C1_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC;
wire   [7:0] PADDR;
wire   [7:0] PRDATA_net_0;
wire         PREADY_net_0;
wire         PSLVERR_net_0;
wire   [7:0] PWDATA;
wire         PWRITE;
wire         sioc_net_0;
wire         siod_net_0;
wire         SYSRESET_0_POWER_ON_RESET_N;
wire         xclk_net_0;
wire         PSLVERR_net_1;
wire         PREADY_net_1;
wire         sioc_net_1;
wire         cam_pwdn_net_1;
wire         cam_rstn_net_1;
wire         xclk_net_1;
wire   [7:0] PRDATA_net_1;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire         VCC_net;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign VCC_net = 1'b1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign PSLVERR_net_1  = PSLVERR_net_0;
assign PSLVERR        = PSLVERR_net_1;
assign PREADY_net_1   = PREADY_net_0;
assign PREADY         = PREADY_net_1;
assign sioc_net_1     = sioc_net_0;
assign sioc           = sioc_net_1;
assign cam_pwdn_net_1 = cam_pwdn_net_0;
assign cam_pwdn       = cam_pwdn_net_1;
assign cam_rstn_net_1 = cam_rstn_net_0;
assign cam_rstn       = cam_rstn_net_1;
assign xclk_net_1     = xclk_net_0;
assign xclk           = xclk_net_1;
assign PRDATA_net_1   = PRDATA_net_0;
assign PRDATA[7:0]    = PRDATA_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------AND2
AND2 AND2_0(
        // Inputs
        .A ( FCCC_C1_0_LOCK ),
        .B ( SYSRESET_0_POWER_ON_RESET_N ),
        // Outputs
        .Y ( AND2_0_Y ) 
        );

//--------CoreSCCB_APB
CoreSCCB_APB #( 
        .DONE_REG      ( 20 ),
        .IDADDR_RW_REG ( 0 ),
        .IDLE          ( 24 ),
        .RDATA_REG     ( 12 ),
        .START_REG     ( 16 ),
        .SUBADDR_REG   ( 4 ),
        .WDATA_REG     ( 8 ) )
CoreSCCB_APB_0(
        // Inputs
        .PCLK     ( FCCC_C1_0_GL0 ),
        .PRESETN  ( AND2_0_Y ),
        .PSEL     ( VCC_net ),
        .PENABLE  ( VCC_net ),
        .PWRITE   ( PWRITE ),
        .PADDR    ( PADDR ),
        .PWDATA   ( PWDATA ),
        // Outputs
        .PSLVERR  ( PSLVERR_net_0 ),
        .PREADY   ( PREADY_net_0 ),
        .sioc     ( sioc_net_0 ),
        .cam_pwdn ( cam_pwdn_net_0 ),
        .cam_rstn ( cam_rstn_net_0 ),
        .xclk     ( xclk_net_0 ),
        .PRDATA   ( PRDATA_net_0 ),
        // Inouts
        .siod     ( siod_net_0 ) 
        );

//--------FCCC_C1
FCCC_C1 FCCC_C1_0(
        // Inputs
        .RCOSC_25_50MHZ ( OSC_C1_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC ),
        // Outputs
        .GL0            ( FCCC_C1_0_GL0 ),
        .LOCK           ( FCCC_C1_0_LOCK ) 
        );

//--------OSC_C1
OSC_C1 OSC_C1_0(
        // Outputs
        .RCOSC_25_50MHZ_CCC ( OSC_C1_0_RCOSC_25_50MHZ_CCC_OUT_RCOSC_25_50MHZ_CCC ) 
        );

//--------SYSRESET
SYSRESET SYSRESET_0(
        // Inputs
        .DEVRST_N         ( DEVRST_N ),
        // Outputs
        .POWER_ON_RESET_N ( SYSRESET_0_POWER_ON_RESET_N ) 
        );


endmodule
