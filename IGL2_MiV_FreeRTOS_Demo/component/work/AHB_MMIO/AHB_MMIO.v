//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Tue Oct 27 12:28:16 2020
// Version: v12.3 12.800.0.16
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// AHB_MMIO
module AHB_MMIO(
    // Inputs
    HADDR_M0,
    HBURST_M0,
    HCLK,
    HMASTLOCK_M0,
    HPROT_M0,
    HRDATA_S6,
    HRDATA_S7,
    HREADYOUT_S6,
    HREADYOUT_S7,
    HRESETN,
    HRESP_S6,
    HRESP_S7,
    HSIZE_M0,
    HTRANS_M0,
    HWDATA_M0,
    HWRITE_M0,
    REMAP_M0,
    // Outputs
    HADDR_S6,
    HADDR_S7,
    HBURST_S6,
    HBURST_S7,
    HMASTLOCK_S6,
    HMASTLOCK_S7,
    HPROT_S6,
    HPROT_S7,
    HRDATA_M0,
    HREADY_M0,
    HREADY_S6,
    HREADY_S7,
    HRESP_M0,
    HSEL_S6,
    HSEL_S7,
    HSIZE_S6,
    HSIZE_S7,
    HTRANS_S6,
    HTRANS_S7,
    HWDATA_S6,
    HWDATA_S7,
    HWRITE_S6,
    HWRITE_S7
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [31:0] HADDR_M0;
input  [2:0]  HBURST_M0;
input         HCLK;
input         HMASTLOCK_M0;
input  [3:0]  HPROT_M0;
input  [31:0] HRDATA_S6;
input  [31:0] HRDATA_S7;
input         HREADYOUT_S6;
input         HREADYOUT_S7;
input         HRESETN;
input  [1:0]  HRESP_S6;
input  [1:0]  HRESP_S7;
input  [2:0]  HSIZE_M0;
input  [1:0]  HTRANS_M0;
input  [31:0] HWDATA_M0;
input         HWRITE_M0;
input         REMAP_M0;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [31:0] HADDR_S6;
output [31:0] HADDR_S7;
output [2:0]  HBURST_S6;
output [2:0]  HBURST_S7;
output        HMASTLOCK_S6;
output        HMASTLOCK_S7;
output [3:0]  HPROT_S6;
output [3:0]  HPROT_S7;
output [31:0] HRDATA_M0;
output        HREADY_M0;
output        HREADY_S6;
output        HREADY_S7;
output [1:0]  HRESP_M0;
output        HSEL_S6;
output        HSEL_S7;
output [2:0]  HSIZE_S6;
output [2:0]  HSIZE_S7;
output [1:0]  HTRANS_S6;
output [1:0]  HTRANS_S7;
output [31:0] HWDATA_S6;
output [31:0] HWDATA_S7;
output        HWRITE_S6;
output        HWRITE_S7;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [31:0] HADDR_M0;
wire   [2:0]  HBURST_M0;
wire          HMASTLOCK_M0;
wire   [3:0]  HPROT_M0;
wire   [31:0] AHBmmaster0_HRDATA;
wire          AHBmmaster0_HREADY;
wire   [1:0]  AHBmmaster0_HRESP;
wire   [2:0]  HSIZE_M0;
wire   [1:0]  HTRANS_M0;
wire   [31:0] HWDATA_M0;
wire          HWRITE_M0;
wire   [31:0] AHBmslave6_4_HADDR;
wire   [2:0]  AHBmslave6_4_HBURST;
wire          AHBmslave6_4_HMASTLOCK;
wire   [3:0]  AHBmslave6_4_HPROT;
wire   [31:0] HRDATA_S6;
wire          AHBmslave6_4_HREADY;
wire          HREADYOUT_S6;
wire   [1:0]  HRESP_S6;
wire          AHBmslave6_4_HSELx;
wire   [2:0]  AHBmslave6_4_HSIZE;
wire   [1:0]  AHBmslave6_4_HTRANS;
wire   [31:0] AHBmslave6_4_HWDATA;
wire          AHBmslave6_4_HWRITE;
wire   [31:0] AHBmslave7_4_HADDR;
wire   [2:0]  AHBmslave7_4_HBURST;
wire          AHBmslave7_4_HMASTLOCK;
wire   [3:0]  AHBmslave7_4_HPROT;
wire   [31:0] HRDATA_S7;
wire          AHBmslave7_4_HREADY;
wire          HREADYOUT_S7;
wire   [1:0]  HRESP_S7;
wire          AHBmslave7_4_HSELx;
wire   [2:0]  AHBmslave7_4_HSIZE;
wire   [1:0]  AHBmslave7_4_HTRANS;
wire   [31:0] AHBmslave7_4_HWDATA;
wire          AHBmslave7_4_HWRITE;
wire          HCLK;
wire          HRESETN;
wire          REMAP_M0;
wire   [31:0] AHBmmaster0_HRDATA_net_0;
wire          AHBmmaster0_HREADY_net_0;
wire   [1:0]  AHBmmaster0_HRESP_net_0;
wire   [31:0] AHBmslave6_4_HADDR_net_0;
wire   [1:0]  AHBmslave6_4_HTRANS_net_0;
wire          AHBmslave6_4_HWRITE_net_0;
wire   [2:0]  AHBmslave6_4_HSIZE_net_0;
wire   [31:0] AHBmslave6_4_HWDATA_net_0;
wire          AHBmslave6_4_HSELx_net_0;
wire          AHBmslave6_4_HREADY_net_0;
wire          AHBmslave6_4_HMASTLOCK_net_0;
wire   [2:0]  AHBmslave6_4_HBURST_net_0;
wire   [3:0]  AHBmslave6_4_HPROT_net_0;
wire   [31:0] AHBmslave7_4_HADDR_net_0;
wire   [1:0]  AHBmslave7_4_HTRANS_net_0;
wire          AHBmslave7_4_HWRITE_net_0;
wire   [2:0]  AHBmslave7_4_HSIZE_net_0;
wire   [31:0] AHBmslave7_4_HWDATA_net_0;
wire          AHBmslave7_4_HSELx_net_0;
wire          AHBmslave7_4_HREADY_net_0;
wire          AHBmslave7_4_HMASTLOCK_net_0;
wire   [2:0]  AHBmslave7_4_HBURST_net_0;
wire   [3:0]  AHBmslave7_4_HPROT_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire   [31:0] HADDR_M1_const_net_0;
wire   [1:0]  HTRANS_M1_const_net_0;
wire          GND_net;
wire   [2:0]  HSIZE_M1_const_net_0;
wire   [2:0]  HBURST_M1_const_net_0;
wire   [3:0]  HPROT_M1_const_net_0;
wire   [31:0] HWDATA_M1_const_net_0;
wire   [31:0] HADDR_M2_const_net_0;
wire   [1:0]  HTRANS_M2_const_net_0;
wire   [2:0]  HSIZE_M2_const_net_0;
wire   [2:0]  HBURST_M2_const_net_0;
wire   [3:0]  HPROT_M2_const_net_0;
wire   [31:0] HWDATA_M2_const_net_0;
wire   [31:0] HADDR_M3_const_net_0;
wire   [1:0]  HTRANS_M3_const_net_0;
wire   [2:0]  HSIZE_M3_const_net_0;
wire   [2:0]  HBURST_M3_const_net_0;
wire   [3:0]  HPROT_M3_const_net_0;
wire   [31:0] HWDATA_M3_const_net_0;
wire   [31:0] HRDATA_S0_const_net_0;
wire          VCC_net;
wire   [1:0]  HRESP_S0_const_net_0;
wire   [31:0] HRDATA_S1_const_net_0;
wire   [1:0]  HRESP_S1_const_net_0;
wire   [31:0] HRDATA_S2_const_net_0;
wire   [1:0]  HRESP_S2_const_net_0;
wire   [31:0] HRDATA_S3_const_net_0;
wire   [1:0]  HRESP_S3_const_net_0;
wire   [31:0] HRDATA_S4_const_net_0;
wire   [1:0]  HRESP_S4_const_net_0;
wire   [31:0] HRDATA_S5_const_net_0;
wire   [1:0]  HRESP_S5_const_net_0;
wire   [31:0] HRDATA_S8_const_net_0;
wire   [1:0]  HRESP_S8_const_net_0;
wire   [31:0] HRDATA_S9_const_net_0;
wire   [1:0]  HRESP_S9_const_net_0;
wire   [31:0] HRDATA_S10_const_net_0;
wire   [1:0]  HRESP_S10_const_net_0;
wire   [31:0] HRDATA_S11_const_net_0;
wire   [1:0]  HRESP_S11_const_net_0;
wire   [31:0] HRDATA_S12_const_net_0;
wire   [1:0]  HRESP_S12_const_net_0;
wire   [31:0] HRDATA_S13_const_net_0;
wire   [1:0]  HRESP_S13_const_net_0;
wire   [31:0] HRDATA_S14_const_net_0;
wire   [1:0]  HRESP_S14_const_net_0;
wire   [31:0] HRDATA_S15_const_net_0;
wire   [1:0]  HRESP_S15_const_net_0;
wire   [31:0] HRDATA_S16_const_net_0;
wire   [1:0]  HRESP_S16_const_net_0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign HADDR_M1_const_net_0   = 32'h00000000;
assign HTRANS_M1_const_net_0  = 2'h0;
assign GND_net                = 1'b0;
assign HSIZE_M1_const_net_0   = 3'h0;
assign HBURST_M1_const_net_0  = 3'h0;
assign HPROT_M1_const_net_0   = 4'h0;
assign HWDATA_M1_const_net_0  = 32'h00000000;
assign HADDR_M2_const_net_0   = 32'h00000000;
assign HTRANS_M2_const_net_0  = 2'h0;
assign HSIZE_M2_const_net_0   = 3'h0;
assign HBURST_M2_const_net_0  = 3'h0;
assign HPROT_M2_const_net_0   = 4'h0;
assign HWDATA_M2_const_net_0  = 32'h00000000;
assign HADDR_M3_const_net_0   = 32'h00000000;
assign HTRANS_M3_const_net_0  = 2'h0;
assign HSIZE_M3_const_net_0   = 3'h0;
assign HBURST_M3_const_net_0  = 3'h0;
assign HPROT_M3_const_net_0   = 4'h0;
assign HWDATA_M3_const_net_0  = 32'h00000000;
assign HRDATA_S0_const_net_0  = 32'h00000000;
assign VCC_net                = 1'b1;
assign HRESP_S0_const_net_0   = 2'h0;
assign HRDATA_S1_const_net_0  = 32'h00000000;
assign HRESP_S1_const_net_0   = 2'h0;
assign HRDATA_S2_const_net_0  = 32'h00000000;
assign HRESP_S2_const_net_0   = 2'h0;
assign HRDATA_S3_const_net_0  = 32'h00000000;
assign HRESP_S3_const_net_0   = 2'h0;
assign HRDATA_S4_const_net_0  = 32'h00000000;
assign HRESP_S4_const_net_0   = 2'h0;
assign HRDATA_S5_const_net_0  = 32'h00000000;
assign HRESP_S5_const_net_0   = 2'h0;
assign HRDATA_S8_const_net_0  = 32'h00000000;
assign HRESP_S8_const_net_0   = 2'h0;
assign HRDATA_S9_const_net_0  = 32'h00000000;
assign HRESP_S9_const_net_0   = 2'h0;
assign HRDATA_S10_const_net_0 = 32'h00000000;
assign HRESP_S10_const_net_0  = 2'h0;
assign HRDATA_S11_const_net_0 = 32'h00000000;
assign HRESP_S11_const_net_0  = 2'h0;
assign HRDATA_S12_const_net_0 = 32'h00000000;
assign HRESP_S12_const_net_0  = 2'h0;
assign HRDATA_S13_const_net_0 = 32'h00000000;
assign HRESP_S13_const_net_0  = 2'h0;
assign HRDATA_S14_const_net_0 = 32'h00000000;
assign HRESP_S14_const_net_0  = 2'h0;
assign HRDATA_S15_const_net_0 = 32'h00000000;
assign HRESP_S15_const_net_0  = 2'h0;
assign HRDATA_S16_const_net_0 = 32'h00000000;
assign HRESP_S16_const_net_0  = 2'h0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign AHBmmaster0_HRDATA_net_0     = AHBmmaster0_HRDATA;
assign HRDATA_M0[31:0]              = AHBmmaster0_HRDATA_net_0;
assign AHBmmaster0_HREADY_net_0     = AHBmmaster0_HREADY;
assign HREADY_M0                    = AHBmmaster0_HREADY_net_0;
assign AHBmmaster0_HRESP_net_0      = AHBmmaster0_HRESP;
assign HRESP_M0[1:0]                = AHBmmaster0_HRESP_net_0;
assign AHBmslave6_4_HADDR_net_0     = AHBmslave6_4_HADDR;
assign HADDR_S6[31:0]               = AHBmslave6_4_HADDR_net_0;
assign AHBmslave6_4_HTRANS_net_0    = AHBmslave6_4_HTRANS;
assign HTRANS_S6[1:0]               = AHBmslave6_4_HTRANS_net_0;
assign AHBmslave6_4_HWRITE_net_0    = AHBmslave6_4_HWRITE;
assign HWRITE_S6                    = AHBmslave6_4_HWRITE_net_0;
assign AHBmslave6_4_HSIZE_net_0     = AHBmslave6_4_HSIZE;
assign HSIZE_S6[2:0]                = AHBmslave6_4_HSIZE_net_0;
assign AHBmslave6_4_HWDATA_net_0    = AHBmslave6_4_HWDATA;
assign HWDATA_S6[31:0]              = AHBmslave6_4_HWDATA_net_0;
assign AHBmslave6_4_HSELx_net_0     = AHBmslave6_4_HSELx;
assign HSEL_S6                      = AHBmslave6_4_HSELx_net_0;
assign AHBmslave6_4_HREADY_net_0    = AHBmslave6_4_HREADY;
assign HREADY_S6                    = AHBmslave6_4_HREADY_net_0;
assign AHBmslave6_4_HMASTLOCK_net_0 = AHBmslave6_4_HMASTLOCK;
assign HMASTLOCK_S6                 = AHBmslave6_4_HMASTLOCK_net_0;
assign AHBmslave6_4_HBURST_net_0    = AHBmslave6_4_HBURST;
assign HBURST_S6[2:0]               = AHBmslave6_4_HBURST_net_0;
assign AHBmslave6_4_HPROT_net_0     = AHBmslave6_4_HPROT;
assign HPROT_S6[3:0]                = AHBmslave6_4_HPROT_net_0;
assign AHBmslave7_4_HADDR_net_0     = AHBmslave7_4_HADDR;
assign HADDR_S7[31:0]               = AHBmslave7_4_HADDR_net_0;
assign AHBmslave7_4_HTRANS_net_0    = AHBmslave7_4_HTRANS;
assign HTRANS_S7[1:0]               = AHBmslave7_4_HTRANS_net_0;
assign AHBmslave7_4_HWRITE_net_0    = AHBmslave7_4_HWRITE;
assign HWRITE_S7                    = AHBmslave7_4_HWRITE_net_0;
assign AHBmslave7_4_HSIZE_net_0     = AHBmslave7_4_HSIZE;
assign HSIZE_S7[2:0]                = AHBmslave7_4_HSIZE_net_0;
assign AHBmslave7_4_HWDATA_net_0    = AHBmslave7_4_HWDATA;
assign HWDATA_S7[31:0]              = AHBmslave7_4_HWDATA_net_0;
assign AHBmslave7_4_HSELx_net_0     = AHBmslave7_4_HSELx;
assign HSEL_S7                      = AHBmslave7_4_HSELx_net_0;
assign AHBmslave7_4_HREADY_net_0    = AHBmslave7_4_HREADY;
assign HREADY_S7                    = AHBmslave7_4_HREADY_net_0;
assign AHBmslave7_4_HMASTLOCK_net_0 = AHBmslave7_4_HMASTLOCK;
assign HMASTLOCK_S7                 = AHBmslave7_4_HMASTLOCK_net_0;
assign AHBmslave7_4_HBURST_net_0    = AHBmslave7_4_HBURST;
assign HBURST_S7[2:0]               = AHBmslave7_4_HBURST_net_0;
assign AHBmslave7_4_HPROT_net_0     = AHBmslave7_4_HPROT;
assign HPROT_S7[3:0]                = AHBmslave7_4_HPROT_net_0;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------CoreAHBLite   -   Actel:DirectCore:CoreAHBLite:5.2.100
CoreAHBLite #( 
        .FAMILY             ( 24 ),
        .HADDR_SHG_CFG      ( 1 ),
        .M0_AHBSLOT0ENABLE  ( 0 ),
        .M0_AHBSLOT1ENABLE  ( 0 ),
        .M0_AHBSLOT2ENABLE  ( 0 ),
        .M0_AHBSLOT3ENABLE  ( 0 ),
        .M0_AHBSLOT4ENABLE  ( 0 ),
        .M0_AHBSLOT5ENABLE  ( 0 ),
        .M0_AHBSLOT6ENABLE  ( 1 ),
        .M0_AHBSLOT7ENABLE  ( 1 ),
        .M0_AHBSLOT8ENABLE  ( 0 ),
        .M0_AHBSLOT9ENABLE  ( 0 ),
        .M0_AHBSLOT10ENABLE ( 0 ),
        .M0_AHBSLOT11ENABLE ( 0 ),
        .M0_AHBSLOT12ENABLE ( 0 ),
        .M0_AHBSLOT13ENABLE ( 0 ),
        .M0_AHBSLOT14ENABLE ( 0 ),
        .M0_AHBSLOT15ENABLE ( 0 ),
        .M0_AHBSLOT16ENABLE ( 0 ),
        .M1_AHBSLOT0ENABLE  ( 0 ),
        .M1_AHBSLOT1ENABLE  ( 0 ),
        .M1_AHBSLOT2ENABLE  ( 0 ),
        .M1_AHBSLOT3ENABLE  ( 0 ),
        .M1_AHBSLOT4ENABLE  ( 0 ),
        .M1_AHBSLOT5ENABLE  ( 0 ),
        .M1_AHBSLOT6ENABLE  ( 0 ),
        .M1_AHBSLOT7ENABLE  ( 0 ),
        .M1_AHBSLOT8ENABLE  ( 0 ),
        .M1_AHBSLOT9ENABLE  ( 0 ),
        .M1_AHBSLOT10ENABLE ( 0 ),
        .M1_AHBSLOT11ENABLE ( 0 ),
        .M1_AHBSLOT12ENABLE ( 0 ),
        .M1_AHBSLOT13ENABLE ( 0 ),
        .M1_AHBSLOT14ENABLE ( 0 ),
        .M1_AHBSLOT15ENABLE ( 0 ),
        .M1_AHBSLOT16ENABLE ( 0 ),
        .M2_AHBSLOT0ENABLE  ( 0 ),
        .M2_AHBSLOT1ENABLE  ( 0 ),
        .M2_AHBSLOT2ENABLE  ( 0 ),
        .M2_AHBSLOT3ENABLE  ( 0 ),
        .M2_AHBSLOT4ENABLE  ( 0 ),
        .M2_AHBSLOT5ENABLE  ( 0 ),
        .M2_AHBSLOT6ENABLE  ( 0 ),
        .M2_AHBSLOT7ENABLE  ( 0 ),
        .M2_AHBSLOT8ENABLE  ( 0 ),
        .M2_AHBSLOT9ENABLE  ( 0 ),
        .M2_AHBSLOT10ENABLE ( 0 ),
        .M2_AHBSLOT11ENABLE ( 0 ),
        .M2_AHBSLOT12ENABLE ( 0 ),
        .M2_AHBSLOT13ENABLE ( 0 ),
        .M2_AHBSLOT14ENABLE ( 0 ),
        .M2_AHBSLOT15ENABLE ( 0 ),
        .M2_AHBSLOT16ENABLE ( 0 ),
        .M3_AHBSLOT0ENABLE  ( 0 ),
        .M3_AHBSLOT1ENABLE  ( 0 ),
        .M3_AHBSLOT2ENABLE  ( 0 ),
        .M3_AHBSLOT3ENABLE  ( 0 ),
        .M3_AHBSLOT4ENABLE  ( 0 ),
        .M3_AHBSLOT5ENABLE  ( 0 ),
        .M3_AHBSLOT6ENABLE  ( 0 ),
        .M3_AHBSLOT7ENABLE  ( 0 ),
        .M3_AHBSLOT8ENABLE  ( 0 ),
        .M3_AHBSLOT9ENABLE  ( 0 ),
        .M3_AHBSLOT10ENABLE ( 0 ),
        .M3_AHBSLOT11ENABLE ( 0 ),
        .M3_AHBSLOT12ENABLE ( 0 ),
        .M3_AHBSLOT13ENABLE ( 0 ),
        .M3_AHBSLOT14ENABLE ( 0 ),
        .M3_AHBSLOT15ENABLE ( 0 ),
        .M3_AHBSLOT16ENABLE ( 0 ),
        .MEMSPACE           ( 1 ),
        .SC_0               ( 0 ),
        .SC_1               ( 0 ),
        .SC_2               ( 0 ),
        .SC_3               ( 0 ),
        .SC_4               ( 0 ),
        .SC_5               ( 0 ),
        .SC_6               ( 0 ),
        .SC_7               ( 0 ),
        .SC_8               ( 0 ),
        .SC_9               ( 0 ),
        .SC_10              ( 0 ),
        .SC_11              ( 0 ),
        .SC_12              ( 0 ),
        .SC_13              ( 0 ),
        .SC_14              ( 0 ),
        .SC_15              ( 0 ) )
AHB_MMIO_0(
        // Inputs
        .HCLK          ( HCLK ),
        .HRESETN       ( HRESETN ),
        .REMAP_M0      ( REMAP_M0 ),
        .HMASTLOCK_M0  ( HMASTLOCK_M0 ),
        .HWRITE_M0     ( HWRITE_M0 ),
        .HMASTLOCK_M1  ( GND_net ), // tied to 1'b0 from definition
        .HWRITE_M1     ( GND_net ), // tied to 1'b0 from definition
        .HMASTLOCK_M2  ( GND_net ), // tied to 1'b0 from definition
        .HWRITE_M2     ( GND_net ), // tied to 1'b0 from definition
        .HMASTLOCK_M3  ( GND_net ), // tied to 1'b0 from definition
        .HWRITE_M3     ( GND_net ), // tied to 1'b0 from definition
        .HREADYOUT_S0  ( VCC_net ), // tied to 1'b1 from definition
        .HREADYOUT_S1  ( VCC_net ), // tied to 1'b1 from definition
        .HREADYOUT_S2  ( VCC_net ), // tied to 1'b1 from definition
        .HREADYOUT_S3  ( VCC_net ), // tied to 1'b1 from definition
        .HREADYOUT_S4  ( VCC_net ), // tied to 1'b1 from definition
        .HREADYOUT_S5  ( VCC_net ), // tied to 1'b1 from definition
        .HREADYOUT_S6  ( HREADYOUT_S6 ),
        .HREADYOUT_S7  ( HREADYOUT_S7 ),
        .HREADYOUT_S8  ( VCC_net ), // tied to 1'b1 from definition
        .HREADYOUT_S9  ( VCC_net ), // tied to 1'b1 from definition
        .HREADYOUT_S10 ( VCC_net ), // tied to 1'b1 from definition
        .HREADYOUT_S11 ( VCC_net ), // tied to 1'b1 from definition
        .HREADYOUT_S12 ( VCC_net ), // tied to 1'b1 from definition
        .HREADYOUT_S13 ( VCC_net ), // tied to 1'b1 from definition
        .HREADYOUT_S14 ( VCC_net ), // tied to 1'b1 from definition
        .HREADYOUT_S15 ( VCC_net ), // tied to 1'b1 from definition
        .HREADYOUT_S16 ( VCC_net ), // tied to 1'b1 from definition
        .HADDR_M0      ( HADDR_M0 ),
        .HSIZE_M0      ( HSIZE_M0 ),
        .HTRANS_M0     ( HTRANS_M0 ),
        .HWDATA_M0     ( HWDATA_M0 ),
        .HBURST_M0     ( HBURST_M0 ),
        .HPROT_M0      ( HPROT_M0 ),
        .HADDR_M1      ( HADDR_M1_const_net_0 ), // tied to 32'h00000000 from definition
        .HSIZE_M1      ( HSIZE_M1_const_net_0 ), // tied to 3'h0 from definition
        .HTRANS_M1     ( HTRANS_M1_const_net_0 ), // tied to 2'h0 from definition
        .HWDATA_M1     ( HWDATA_M1_const_net_0 ), // tied to 32'h00000000 from definition
        .HBURST_M1     ( HBURST_M1_const_net_0 ), // tied to 3'h0 from definition
        .HPROT_M1      ( HPROT_M1_const_net_0 ), // tied to 4'h0 from definition
        .HADDR_M2      ( HADDR_M2_const_net_0 ), // tied to 32'h00000000 from definition
        .HSIZE_M2      ( HSIZE_M2_const_net_0 ), // tied to 3'h0 from definition
        .HTRANS_M2     ( HTRANS_M2_const_net_0 ), // tied to 2'h0 from definition
        .HWDATA_M2     ( HWDATA_M2_const_net_0 ), // tied to 32'h00000000 from definition
        .HBURST_M2     ( HBURST_M2_const_net_0 ), // tied to 3'h0 from definition
        .HPROT_M2      ( HPROT_M2_const_net_0 ), // tied to 4'h0 from definition
        .HADDR_M3      ( HADDR_M3_const_net_0 ), // tied to 32'h00000000 from definition
        .HSIZE_M3      ( HSIZE_M3_const_net_0 ), // tied to 3'h0 from definition
        .HTRANS_M3     ( HTRANS_M3_const_net_0 ), // tied to 2'h0 from definition
        .HWDATA_M3     ( HWDATA_M3_const_net_0 ), // tied to 32'h00000000 from definition
        .HBURST_M3     ( HBURST_M3_const_net_0 ), // tied to 3'h0 from definition
        .HPROT_M3      ( HPROT_M3_const_net_0 ), // tied to 4'h0 from definition
        .HRDATA_S0     ( HRDATA_S0_const_net_0 ), // tied to 32'h00000000 from definition
        .HRESP_S0      ( HRESP_S0_const_net_0 ), // tied to 2'h0 from definition
        .HRDATA_S1     ( HRDATA_S1_const_net_0 ), // tied to 32'h00000000 from definition
        .HRESP_S1      ( HRESP_S1_const_net_0 ), // tied to 2'h0 from definition
        .HRDATA_S2     ( HRDATA_S2_const_net_0 ), // tied to 32'h00000000 from definition
        .HRESP_S2      ( HRESP_S2_const_net_0 ), // tied to 2'h0 from definition
        .HRDATA_S3     ( HRDATA_S3_const_net_0 ), // tied to 32'h00000000 from definition
        .HRESP_S3      ( HRESP_S3_const_net_0 ), // tied to 2'h0 from definition
        .HRDATA_S4     ( HRDATA_S4_const_net_0 ), // tied to 32'h00000000 from definition
        .HRESP_S4      ( HRESP_S4_const_net_0 ), // tied to 2'h0 from definition
        .HRDATA_S5     ( HRDATA_S5_const_net_0 ), // tied to 32'h00000000 from definition
        .HRESP_S5      ( HRESP_S5_const_net_0 ), // tied to 2'h0 from definition
        .HRDATA_S6     ( HRDATA_S6 ),
        .HRESP_S6      ( HRESP_S6 ),
        .HRDATA_S7     ( HRDATA_S7 ),
        .HRESP_S7      ( HRESP_S7 ),
        .HRDATA_S8     ( HRDATA_S8_const_net_0 ), // tied to 32'h00000000 from definition
        .HRESP_S8      ( HRESP_S8_const_net_0 ), // tied to 2'h0 from definition
        .HRDATA_S9     ( HRDATA_S9_const_net_0 ), // tied to 32'h00000000 from definition
        .HRESP_S9      ( HRESP_S9_const_net_0 ), // tied to 2'h0 from definition
        .HRDATA_S10    ( HRDATA_S10_const_net_0 ), // tied to 32'h00000000 from definition
        .HRESP_S10     ( HRESP_S10_const_net_0 ), // tied to 2'h0 from definition
        .HRDATA_S11    ( HRDATA_S11_const_net_0 ), // tied to 32'h00000000 from definition
        .HRESP_S11     ( HRESP_S11_const_net_0 ), // tied to 2'h0 from definition
        .HRDATA_S12    ( HRDATA_S12_const_net_0 ), // tied to 32'h00000000 from definition
        .HRESP_S12     ( HRESP_S12_const_net_0 ), // tied to 2'h0 from definition
        .HRDATA_S13    ( HRDATA_S13_const_net_0 ), // tied to 32'h00000000 from definition
        .HRESP_S13     ( HRESP_S13_const_net_0 ), // tied to 2'h0 from definition
        .HRDATA_S14    ( HRDATA_S14_const_net_0 ), // tied to 32'h00000000 from definition
        .HRESP_S14     ( HRESP_S14_const_net_0 ), // tied to 2'h0 from definition
        .HRDATA_S15    ( HRDATA_S15_const_net_0 ), // tied to 32'h00000000 from definition
        .HRESP_S15     ( HRESP_S15_const_net_0 ), // tied to 2'h0 from definition
        .HRDATA_S16    ( HRDATA_S16_const_net_0 ), // tied to 32'h00000000 from definition
        .HRESP_S16     ( HRESP_S16_const_net_0 ), // tied to 2'h0 from definition
        // Outputs
        .HREADY_M0     ( AHBmmaster0_HREADY ),
        .HREADY_M1     (  ),
        .HREADY_M2     (  ),
        .HREADY_M3     (  ),
        .HSEL_S0       (  ),
        .HWRITE_S0     (  ),
        .HREADY_S0     (  ),
        .HMASTLOCK_S0  (  ),
        .HSEL_S1       (  ),
        .HWRITE_S1     (  ),
        .HREADY_S1     (  ),
        .HMASTLOCK_S1  (  ),
        .HSEL_S2       (  ),
        .HWRITE_S2     (  ),
        .HREADY_S2     (  ),
        .HMASTLOCK_S2  (  ),
        .HSEL_S3       (  ),
        .HWRITE_S3     (  ),
        .HREADY_S3     (  ),
        .HMASTLOCK_S3  (  ),
        .HSEL_S4       (  ),
        .HWRITE_S4     (  ),
        .HREADY_S4     (  ),
        .HMASTLOCK_S4  (  ),
        .HSEL_S5       (  ),
        .HWRITE_S5     (  ),
        .HREADY_S5     (  ),
        .HMASTLOCK_S5  (  ),
        .HSEL_S6       ( AHBmslave6_4_HSELx ),
        .HWRITE_S6     ( AHBmslave6_4_HWRITE ),
        .HREADY_S6     ( AHBmslave6_4_HREADY ),
        .HMASTLOCK_S6  ( AHBmslave6_4_HMASTLOCK ),
        .HSEL_S7       ( AHBmslave7_4_HSELx ),
        .HWRITE_S7     ( AHBmslave7_4_HWRITE ),
        .HREADY_S7     ( AHBmslave7_4_HREADY ),
        .HMASTLOCK_S7  ( AHBmslave7_4_HMASTLOCK ),
        .HSEL_S8       (  ),
        .HWRITE_S8     (  ),
        .HREADY_S8     (  ),
        .HMASTLOCK_S8  (  ),
        .HSEL_S9       (  ),
        .HWRITE_S9     (  ),
        .HREADY_S9     (  ),
        .HMASTLOCK_S9  (  ),
        .HSEL_S10      (  ),
        .HWRITE_S10    (  ),
        .HREADY_S10    (  ),
        .HMASTLOCK_S10 (  ),
        .HSEL_S11      (  ),
        .HWRITE_S11    (  ),
        .HREADY_S11    (  ),
        .HMASTLOCK_S11 (  ),
        .HSEL_S12      (  ),
        .HWRITE_S12    (  ),
        .HREADY_S12    (  ),
        .HMASTLOCK_S12 (  ),
        .HSEL_S13      (  ),
        .HWRITE_S13    (  ),
        .HREADY_S13    (  ),
        .HMASTLOCK_S13 (  ),
        .HSEL_S14      (  ),
        .HWRITE_S14    (  ),
        .HREADY_S14    (  ),
        .HMASTLOCK_S14 (  ),
        .HSEL_S15      (  ),
        .HWRITE_S15    (  ),
        .HREADY_S15    (  ),
        .HMASTLOCK_S15 (  ),
        .HSEL_S16      (  ),
        .HWRITE_S16    (  ),
        .HREADY_S16    (  ),
        .HMASTLOCK_S16 (  ),
        .HRESP_M0      ( AHBmmaster0_HRESP ),
        .HRDATA_M0     ( AHBmmaster0_HRDATA ),
        .HRESP_M1      (  ),
        .HRDATA_M1     (  ),
        .HRESP_M2      (  ),
        .HRDATA_M2     (  ),
        .HRESP_M3      (  ),
        .HRDATA_M3     (  ),
        .HADDR_S0      (  ),
        .HSIZE_S0      (  ),
        .HTRANS_S0     (  ),
        .HWDATA_S0     (  ),
        .HBURST_S0     (  ),
        .HPROT_S0      (  ),
        .HADDR_S1      (  ),
        .HSIZE_S1      (  ),
        .HTRANS_S1     (  ),
        .HWDATA_S1     (  ),
        .HBURST_S1     (  ),
        .HPROT_S1      (  ),
        .HADDR_S2      (  ),
        .HSIZE_S2      (  ),
        .HTRANS_S2     (  ),
        .HWDATA_S2     (  ),
        .HBURST_S2     (  ),
        .HPROT_S2      (  ),
        .HADDR_S3      (  ),
        .HSIZE_S3      (  ),
        .HTRANS_S3     (  ),
        .HWDATA_S3     (  ),
        .HBURST_S3     (  ),
        .HPROT_S3      (  ),
        .HADDR_S4      (  ),
        .HSIZE_S4      (  ),
        .HTRANS_S4     (  ),
        .HWDATA_S4     (  ),
        .HBURST_S4     (  ),
        .HPROT_S4      (  ),
        .HADDR_S5      (  ),
        .HSIZE_S5      (  ),
        .HTRANS_S5     (  ),
        .HWDATA_S5     (  ),
        .HBURST_S5     (  ),
        .HPROT_S5      (  ),
        .HADDR_S6      ( AHBmslave6_4_HADDR ),
        .HSIZE_S6      ( AHBmslave6_4_HSIZE ),
        .HTRANS_S6     ( AHBmslave6_4_HTRANS ),
        .HWDATA_S6     ( AHBmslave6_4_HWDATA ),
        .HBURST_S6     ( AHBmslave6_4_HBURST ),
        .HPROT_S6      ( AHBmslave6_4_HPROT ),
        .HADDR_S7      ( AHBmslave7_4_HADDR ),
        .HSIZE_S7      ( AHBmslave7_4_HSIZE ),
        .HTRANS_S7     ( AHBmslave7_4_HTRANS ),
        .HWDATA_S7     ( AHBmslave7_4_HWDATA ),
        .HBURST_S7     ( AHBmslave7_4_HBURST ),
        .HPROT_S7      ( AHBmslave7_4_HPROT ),
        .HADDR_S8      (  ),
        .HSIZE_S8      (  ),
        .HTRANS_S8     (  ),
        .HWDATA_S8     (  ),
        .HBURST_S8     (  ),
        .HPROT_S8      (  ),
        .HADDR_S9      (  ),
        .HSIZE_S9      (  ),
        .HTRANS_S9     (  ),
        .HWDATA_S9     (  ),
        .HBURST_S9     (  ),
        .HPROT_S9      (  ),
        .HADDR_S10     (  ),
        .HSIZE_S10     (  ),
        .HTRANS_S10    (  ),
        .HWDATA_S10    (  ),
        .HBURST_S10    (  ),
        .HPROT_S10     (  ),
        .HADDR_S11     (  ),
        .HSIZE_S11     (  ),
        .HTRANS_S11    (  ),
        .HWDATA_S11    (  ),
        .HBURST_S11    (  ),
        .HPROT_S11     (  ),
        .HADDR_S12     (  ),
        .HSIZE_S12     (  ),
        .HTRANS_S12    (  ),
        .HWDATA_S12    (  ),
        .HBURST_S12    (  ),
        .HPROT_S12     (  ),
        .HADDR_S13     (  ),
        .HSIZE_S13     (  ),
        .HTRANS_S13    (  ),
        .HWDATA_S13    (  ),
        .HBURST_S13    (  ),
        .HPROT_S13     (  ),
        .HADDR_S14     (  ),
        .HSIZE_S14     (  ),
        .HTRANS_S14    (  ),
        .HWDATA_S14    (  ),
        .HBURST_S14    (  ),
        .HPROT_S14     (  ),
        .HADDR_S15     (  ),
        .HSIZE_S15     (  ),
        .HTRANS_S15    (  ),
        .HWDATA_S15    (  ),
        .HBURST_S15    (  ),
        .HPROT_S15     (  ),
        .HADDR_S16     (  ),
        .HSIZE_S16     (  ),
        .HTRANS_S16    (  ),
        .HWDATA_S16    (  ),
        .HBURST_S16    (  ),
        .HPROT_S16     (  ) 
        );


endmodule
