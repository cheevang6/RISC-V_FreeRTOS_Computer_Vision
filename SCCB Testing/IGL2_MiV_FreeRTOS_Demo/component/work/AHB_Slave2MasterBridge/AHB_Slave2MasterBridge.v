//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Tue Mar 19 11:34:35 2019
// Version: v12.0 12.500.0.22
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// AHB_Slave2MasterBridge
module AHB_Slave2MasterBridge(
    // Inputs
    HADDR_SLAVE,
    HBURST_SLAVE,
    HMASTLOCK_SLAVE,
    HPROT_SLAVE,
    HRDATA_MASTER,
    HREADY_MASTER,
    HREADY_SLAVE,
    HRESP_MASTER,
    HSEL_SLAVE,
    HSIZE_SLAVE,
    HTRANS_SLAVE,
    HWDATA_SLAVE,
    HWRITE_SLAVE,
    clock,
    resetn,
    // Outputs
    HADDR_MASTER,
    HBURST_MASTER,
    HMASTLOCK_MASTER,
    HPROT_MASTER,
    HRDATA_SLAVE,
    HREADYOUT_SLAVE,
    HRESP_SLAVE,
    HSIZE_MASTER,
    HTRANS_MASTER,
    HWDATA_MASTER,
    HWRITE_MASTER
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [31:0] HADDR_SLAVE;
input  [2:0]  HBURST_SLAVE;
input         HMASTLOCK_SLAVE;
input  [3:0]  HPROT_SLAVE;
input  [31:0] HRDATA_MASTER;
input         HREADY_MASTER;
input         HREADY_SLAVE;
input  [1:0]  HRESP_MASTER;
input         HSEL_SLAVE;
input  [2:0]  HSIZE_SLAVE;
input  [1:0]  HTRANS_SLAVE;
input  [31:0] HWDATA_SLAVE;
input         HWRITE_SLAVE;
input         clock;
input         resetn;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [31:0] HADDR_MASTER;
output [2:0]  HBURST_MASTER;
output        HMASTLOCK_MASTER;
output [3:0]  HPROT_MASTER;
output [31:0] HRDATA_SLAVE;
output        HREADYOUT_SLAVE;
output [1:0]  HRESP_SLAVE;
output [2:0]  HSIZE_MASTER;
output [1:0]  HTRANS_MASTER;
output [31:0] HWDATA_MASTER;
output        HWRITE_MASTER;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          clock;
wire   [31:0] MASTER_HADDR;
wire   [2:0]  MASTER_HBURST;
wire          MASTER_HLOCK;
wire   [3:0]  MASTER_HPROT;
wire   [31:0] HRDATA_MASTER;
wire          HREADY_MASTER;
wire   [1:0]  HRESP_MASTER;
wire   [2:0]  MASTER_HSIZE;
wire   [1:0]  MASTER_HTRANS;
wire   [31:0] MASTER_HWDATA;
wire          MASTER_HWRITE;
wire          resetn;
wire   [31:0] HADDR_SLAVE;
wire   [2:0]  HBURST_SLAVE;
wire          HMASTLOCK_SLAVE;
wire   [3:0]  HPROT_SLAVE;
wire   [31:0] SLAVE_HRDATA;
wire          HREADY_SLAVE;
wire          SLAVE_HREADYOUT;
wire   [1:0]  SLAVE_HRESP;
wire          HSEL_SLAVE;
wire   [2:0]  HSIZE_SLAVE;
wire   [1:0]  HTRANS_SLAVE;
wire   [31:0] HWDATA_SLAVE;
wire          HWRITE_SLAVE;
wire   [31:0] MASTER_HADDR_net_0;
wire   [1:0]  MASTER_HTRANS_net_0;
wire          MASTER_HWRITE_net_0;
wire   [2:0]  MASTER_HSIZE_net_0;
wire   [2:0]  MASTER_HBURST_net_0;
wire   [3:0]  MASTER_HPROT_net_0;
wire   [31:0] MASTER_HWDATA_net_0;
wire          MASTER_HLOCK_net_0;
wire   [31:0] SLAVE_HRDATA_net_0;
wire          SLAVE_HREADYOUT_net_0;
wire   [1:0]  SLAVE_HRESP_net_0;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign MASTER_HADDR_net_0    = MASTER_HADDR;
assign HADDR_MASTER[31:0]    = MASTER_HADDR_net_0;
assign MASTER_HTRANS_net_0   = MASTER_HTRANS;
assign HTRANS_MASTER[1:0]    = MASTER_HTRANS_net_0;
assign MASTER_HWRITE_net_0   = MASTER_HWRITE;
assign HWRITE_MASTER         = MASTER_HWRITE_net_0;
assign MASTER_HSIZE_net_0    = MASTER_HSIZE;
assign HSIZE_MASTER[2:0]     = MASTER_HSIZE_net_0;
assign MASTER_HBURST_net_0   = MASTER_HBURST;
assign HBURST_MASTER[2:0]    = MASTER_HBURST_net_0;
assign MASTER_HPROT_net_0    = MASTER_HPROT;
assign HPROT_MASTER[3:0]     = MASTER_HPROT_net_0;
assign MASTER_HWDATA_net_0   = MASTER_HWDATA;
assign HWDATA_MASTER[31:0]   = MASTER_HWDATA_net_0;
assign MASTER_HLOCK_net_0    = MASTER_HLOCK;
assign HMASTLOCK_MASTER      = MASTER_HLOCK_net_0;
assign SLAVE_HRDATA_net_0    = SLAVE_HRDATA;
assign HRDATA_SLAVE[31:0]    = SLAVE_HRDATA_net_0;
assign SLAVE_HREADYOUT_net_0 = SLAVE_HREADYOUT;
assign HREADYOUT_SLAVE       = SLAVE_HREADYOUT_net_0;
assign SLAVE_HRESP_net_0     = SLAVE_HRESP;
assign HRESP_SLAVE[1:0]      = SLAVE_HRESP_net_0;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------MIRSLV2MIRMSTRBRIDGE_AHB   -   USER:UserCore:MIRSLV2MIRMSTRBRIDGE_AHB:1.0.3
MIRSLV2MIRMSTRBRIDGE_AHB #( 
        .MSTR_DRI_UPR_4_ADDR_BITS ( 1 ),
        .UPR_4_ADDR_BITS          ( 0 ) )
AHB_Slave2MasterBridge_0(
        // Inputs
        .HADDR_SLAVE      ( HADDR_SLAVE ),
        .HTRANS_SLAVE     ( HTRANS_SLAVE ),
        .HSIZE_SLAVE      ( HSIZE_SLAVE ),
        .HWDATA_SLAVE     ( HWDATA_SLAVE ),
        .HBURST_SLAVE     ( HBURST_SLAVE ),
        .HPROT_SLAVE      ( HPROT_SLAVE ),
        .HWRITE_SLAVE     ( HWRITE_SLAVE ),
        .HMASTLOCK_SLAVE  ( HMASTLOCK_SLAVE ),
        .HREADY_SLAVE     ( HREADY_SLAVE ),
        .HSEL_SLAVE       ( HSEL_SLAVE ),
        .HREADY_MASTER    ( HREADY_MASTER ),
        .HRDATA_MASTER    ( HRDATA_MASTER ),
        .HRESP_MASTER     ( HRESP_MASTER ),
        .clock            ( clock ),
        .resetn           ( resetn ),
        // Outputs
        .HREADYOUT_SLAVE  ( SLAVE_HREADYOUT ),
        .HRDATA_SLAVE     ( SLAVE_HRDATA ),
        .HRESP_SLAVE      ( SLAVE_HRESP ),
        .HADDR_MASTER     ( MASTER_HADDR ),
        .HTRANS_MASTER    ( MASTER_HTRANS ),
        .HSIZE_MASTER     ( MASTER_HSIZE ),
        .HWDATA_MASTER    ( MASTER_HWDATA ),
        .HBURST_MASTER    ( MASTER_HBURST ),
        .HPROT_MASTER     ( MASTER_HPROT ),
        .HWRITE_MASTER    ( MASTER_HWRITE ),
        .HMASTLOCK_MASTER ( MASTER_HLOCK ) 
        );


endmodule
