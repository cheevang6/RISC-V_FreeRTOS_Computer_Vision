//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Tue Jan 19 14:18:33 2021
// Version: v12.3 12.800.0.16
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// COREI2C_C0
module COREI2C_C0(
    // Inputs
    PADDR,
    PCLK,
    PENABLE,
    PRESETN,
    PSEL,
    PWDATA,
    PWRITE,
    SCLI,
    SDAI,
    // Outputs
    INT,
    PRDATA,
    SCLO,
    SDAO
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [8:0] PADDR;
input        PCLK;
input        PENABLE;
input        PRESETN;
input        PSEL;
input  [7:0] PWDATA;
input        PWRITE;
input  [0:0] SCLI;
input  [0:0] SDAI;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [0:0] INT;
output [7:0] PRDATA;
output [0:0] SCLO;
output [0:0] SDAO;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [8:0] PADDR;
wire         PENABLE;
wire   [7:0] APBslave_PRDATA;
wire         PSEL;
wire   [7:0] PWDATA;
wire         PWRITE;
wire   [0:0] INT_0;
wire         PCLK;
wire         PRESETN;
wire   [0:0] SCLI;
wire   [0:0] SCLO_0;
wire   [0:0] SDAI;
wire   [0:0] SDAO_0;
wire   [7:0] APBslave_PRDATA_net_0;
wire   [0:0] INT_0_net_0;
wire   [0:0] SCLO_0_net_0;
wire   [0:0] SDAO_0_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire         GND_net;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net    = 1'b0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign APBslave_PRDATA_net_0 = APBslave_PRDATA;
assign PRDATA[7:0]           = APBslave_PRDATA_net_0;
assign INT_0_net_0[0]        = INT_0[0];
assign INT[0:0]              = INT_0_net_0[0];
assign SCLO_0_net_0[0]       = SCLO_0[0];
assign SCLO[0:0]             = SCLO_0_net_0[0];
assign SDAO_0_net_0[0]       = SDAO_0[0];
assign SDAO[0:0]             = SDAO_0_net_0[0];
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------COREI2C_C0_COREI2C_C0_0_COREI2C   -   Actel:DirectCore:COREI2C:7.2.101
COREI2C_C0_COREI2C_C0_0_COREI2C #( 
        .ADD_SLAVE1_ADDRESS_EN   ( 0 ),
        .BAUD_RATE_FIXED         ( 0 ),
        .BAUD_RATE_VALUE         ( 0 ),
        .BCLK_ENABLED            ( 0 ),
        .FIXED_SLAVE0_ADDR_EN    ( 0 ),
        .FIXED_SLAVE0_ADDR_VALUE ( 'h0 ),
        .FIXED_SLAVE1_ADDR_EN    ( 0 ),
        .FIXED_SLAVE1_ADDR_VALUE ( 'h0 ),
        .FREQUENCY               ( 30 ),
        .GLITCHREG_NUM           ( 3 ),
        .I2C_NUM                 ( 1 ),
        .IPMI_EN                 ( 0 ),
        .OPERATING_MODE          ( 0 ),
        .SMB_EN                  ( 0 ) )
COREI2C_C0_0(
        // Inputs
        .BCLK        ( GND_net ), // tied to 1'b0 from definition
        .PCLK        ( PCLK ),
        .PENABLE     ( PENABLE ),
        .PRESETN     ( PRESETN ),
        .PSEL        ( PSEL ),
        .PWRITE      ( PWRITE ),
        .PADDR       ( PADDR ),
        .PWDATA      ( PWDATA ),
        .SCLI        ( SCLI ),
        .SDAI        ( SDAI ),
        .SMBALERT_NI ( GND_net ), // tied to 1'b0 from definition
        .SMBSUS_NI   ( GND_net ), // tied to 1'b0 from definition
        // Outputs
        .INT         ( INT_0 ),
        .PRDATA      ( APBslave_PRDATA ),
        .SCLO        ( SCLO_0 ),
        .SDAO        ( SDAO_0 ),
        .SMBALERT_NO (  ),
        .SMBA_INT    (  ),
        .SMBSUS_NO   (  ),
        .SMBS_INT    (  ) 
        );


endmodule
