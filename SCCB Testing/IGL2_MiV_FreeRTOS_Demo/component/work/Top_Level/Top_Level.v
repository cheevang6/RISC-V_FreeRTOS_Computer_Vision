//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Wed Apr 24 09:08:07 2019
// Version: v12.1 12.600.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// Top_Level
module Top_Level(
    // Inputs
    DEVRST_N,
    FTDI_UART0_TXD,
    MDDR_DQS_TMATCH_0_IN,
    TCK,
    TDI,
    TMS,
    TRSTB,
    USER_BUTTON1,
    USER_BUTTON2,
    // Outputs
    FTDI_UART0_RXD,
    LED1_GREEN,
    LED1_RED,
    LED2_GREEN,
    LED2_RED,
    MDDR_ADDR,
    MDDR_BA,
    MDDR_CAS_N,
    MDDR_CKE,
    MDDR_CLK,
    MDDR_CLK_N,
    MDDR_CS_N,
    MDDR_DQS_TMATCH_0_OUT,
    MDDR_ODT,
    MDDR_RAS_N,
    MDDR_RESET_N,
    MDDR_WE_N,
    TDO,
    // Inouts
    MDDR_DM_RDQS,
    MDDR_DQ,
    MDDR_DQS,
    MDDR_DQS_N
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input         DEVRST_N;
input         FTDI_UART0_TXD;
input         MDDR_DQS_TMATCH_0_IN;
input         TCK;
input         TDI;
input         TMS;
input         TRSTB;
input         USER_BUTTON1;
input         USER_BUTTON2;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output        FTDI_UART0_RXD;
output        LED1_GREEN;
output        LED1_RED;
output        LED2_GREEN;
output        LED2_RED;
output [15:0] MDDR_ADDR;
output [2:0]  MDDR_BA;
output        MDDR_CAS_N;
output        MDDR_CKE;
output        MDDR_CLK;
output        MDDR_CLK_N;
output        MDDR_CS_N;
output        MDDR_DQS_TMATCH_0_OUT;
output        MDDR_ODT;
output        MDDR_RAS_N;
output        MDDR_RESET_N;
output        MDDR_WE_N;
output        TDO;
//--------------------------------------------------------------------
// Inout
//--------------------------------------------------------------------
inout  [1:0]  MDDR_DM_RDQS;
inout  [15:0] MDDR_DQ;
inout  [1:0]  MDDR_DQS;
inout  [1:0]  MDDR_DQS_N;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [31:0] AHB_MEM_0_AHBmslave16_HADDR;
wire   [2:0]  AHB_MEM_0_AHBmslave16_HBURST;
wire          AHB_MEM_0_AHBmslave16_HMASTLOCK;
wire   [3:0]  AHB_MEM_0_AHBmslave16_HPROT;
wire   [31:0] AHB_MEM_0_AHBmslave16_HRDATA;
wire          AHB_MEM_0_AHBmslave16_HREADY;
wire          AHB_MEM_0_AHBmslave16_HREADYOUT;
wire          AHB_MEM_0_AHBmslave16_HSELx;
wire   [1:0]  AHB_MEM_0_AHBmslave16_HTRANS;
wire   [31:0] AHB_MEM_0_AHBmslave16_HWDATA;
wire          AHB_MEM_0_AHBmslave16_HWRITE;
wire   [31:0] AHB_MMIO_0_AHBmslave6_HADDR;
wire   [2:0]  AHB_MMIO_0_AHBmslave6_HBURST;
wire          AHB_MMIO_0_AHBmslave6_HMASTLOCK;
wire   [3:0]  AHB_MMIO_0_AHBmslave6_HPROT;
wire   [31:0] AHB_MMIO_0_AHBmslave6_HRDATA;
wire          AHB_MMIO_0_AHBmslave6_HREADY;
wire          AHB_MMIO_0_AHBmslave6_HREADYOUT;
wire   [1:0]  AHB_MMIO_0_AHBmslave6_HRESP;
wire          AHB_MMIO_0_AHBmslave6_HSELx;
wire   [2:0]  AHB_MMIO_0_AHBmslave6_HSIZE;
wire   [1:0]  AHB_MMIO_0_AHBmslave6_HTRANS;
wire   [31:0] AHB_MMIO_0_AHBmslave6_HWDATA;
wire          AHB_MMIO_0_AHBmslave6_HWRITE;
wire   [31:0] AHB_MMIO_0_AHBmslave7_HADDR;
wire   [2:0]  AHB_MMIO_0_AHBmslave7_HBURST;
wire          AHB_MMIO_0_AHBmslave7_HMASTLOCK;
wire   [3:0]  AHB_MMIO_0_AHBmslave7_HPROT;
wire   [31:0] AHB_MMIO_0_AHBmslave7_HRDATA;
wire          AHB_MMIO_0_AHBmslave7_HREADY;
wire          AHB_MMIO_0_AHBmslave7_HREADYOUT;
wire   [1:0]  AHB_MMIO_0_AHBmslave7_HRESP;
wire          AHB_MMIO_0_AHBmslave7_HSELx;
wire   [2:0]  AHB_MMIO_0_AHBmslave7_HSIZE;
wire   [1:0]  AHB_MMIO_0_AHBmslave7_HTRANS;
wire   [31:0] AHB_MMIO_0_AHBmslave7_HWDATA;
wire          AHB_MMIO_0_AHBmslave7_HWRITE;
wire   [31:0] AHB_Slave2MasterBridge_0_MASTER_HADDR;
wire   [2:0]  AHB_Slave2MasterBridge_0_MASTER_HBURST;
wire          AHB_Slave2MasterBridge_0_MASTER_HLOCK;
wire   [3:0]  AHB_Slave2MasterBridge_0_MASTER_HPROT;
wire   [31:0] AHB_Slave2MasterBridge_0_MASTER_HRDATA;
wire          AHB_Slave2MasterBridge_0_MASTER_HREADY;
wire   [1:0]  AHB_Slave2MasterBridge_0_MASTER_HRESP;
wire   [2:0]  AHB_Slave2MasterBridge_0_MASTER_HSIZE;
wire   [1:0]  AHB_Slave2MasterBridge_0_MASTER_HTRANS;
wire   [31:0] AHB_Slave2MasterBridge_0_MASTER_HWDATA;
wire          AHB_Slave2MasterBridge_0_MASTER_HWRITE;
wire   [31:0] AHBtoAPB3_0_APBmaster_PADDR;
wire          AHBtoAPB3_0_APBmaster_PENABLE;
wire   [31:0] AHBtoAPB3_0_APBmaster_PRDATA;
wire          AHBtoAPB3_0_APBmaster_PREADY;
wire          AHBtoAPB3_0_APBmaster_PSELx;
wire          AHBtoAPB3_0_APBmaster_PSLVERR;
wire   [31:0] AHBtoAPB3_0_APBmaster_PWDATA;
wire          AHBtoAPB3_0_APBmaster_PWRITE;
wire          APB3_Bus_0_APBmslave0_0_PENABLE;
wire   [31:0] APB3_Bus_0_APBmslave0_0_PRDATA;
wire          APB3_Bus_0_APBmslave0_0_PREADY;
wire          APB3_Bus_0_APBmslave0_0_PSELx;
wire          APB3_Bus_0_APBmslave0_0_PSLVERR;
wire   [31:0] APB3_Bus_0_APBmslave0_0_PWDATA;
wire          APB3_Bus_0_APBmslave0_0_PWRITE;
wire   [31:0] APB3_Bus_0_APBmslave1_PRDATA;
wire          APB3_Bus_0_APBmslave1_PSELx;
wire          BasicIO_Interface_0_USER_PB1_IRQ;
wire          BasicIO_Interface_0_USER_PB2_IRQ;
wire          DEVRST_N;
wire          FTDI_UART0_RXD_net_0;
wire          FTDI_UART0_TXD;
wire          JTAG_0_TGT_TCK_0;
wire          JTAG_0_TGT_TDI_0;
wire          JTAG_0_TGT_TMS_0;
wire          JTAG_0_TGT_TRSTB_0;
wire          LED1_GREEN_net_0;
wire          LED1_RED_net_0;
wire          LED2_GREEN_net_0;
wire          LED2_RED_0;
wire   [15:0] MDDR_ADDR_net_0;
wire   [2:0]  MDDR_BA_net_0;
wire          MDDR_CAS_N_net_0;
wire          MDDR_CKE_net_0;
wire          MDDR_CLK_net_0;
wire          MDDR_CLK_N_net_0;
wire          MDDR_CS_N_net_0;
wire   [1:0]  MDDR_DM_RDQS;
wire   [15:0] MDDR_DQ;
wire   [1:0]  MDDR_DQS;
wire   [1:0]  MDDR_DQS_N;
wire          MDDR_DQS_TMATCH_0_IN;
wire          MDDR_DQS_TMATCH_0_OUT_net_0;
wire          MDDR_ODT_net_0;
wire          MDDR_RAS_N_net_0;
wire          MDDR_RESET_N_net_0;
wire          MDDR_WE_N_net_0;
wire   [31:0] MiV_Core32_0_AHB_MST_MEM_HADDR;
wire   [2:0]  MiV_Core32_0_AHB_MST_MEM_HBURST;
wire          MiV_Core32_0_AHB_MST_MEM_HLOCK;
wire   [3:0]  MiV_Core32_0_AHB_MST_MEM_HPROT;
wire   [31:0] MiV_Core32_0_AHB_MST_MEM_HRDATA;
wire          MiV_Core32_0_AHB_MST_MEM_HREADY;
wire   [2:0]  MiV_Core32_0_AHB_MST_MEM_HSIZE;
wire   [1:0]  MiV_Core32_0_AHB_MST_MEM_HTRANS;
wire   [31:0] MiV_Core32_0_AHB_MST_MEM_HWDATA;
wire          MiV_Core32_0_AHB_MST_MEM_HWRITE;
wire   [2:0]  MiV_Core32_0_AHB_MST_MMIO_HBURST;
wire          MiV_Core32_0_AHB_MST_MMIO_HLOCK;
wire   [3:0]  MiV_Core32_0_AHB_MST_MMIO_HPROT;
wire   [31:0] MiV_Core32_0_AHB_MST_MMIO_HRDATA;
wire          MiV_Core32_0_AHB_MST_MMIO_HREADY;
wire   [2:0]  MiV_Core32_0_AHB_MST_MMIO_HSIZE;
wire   [1:0]  MiV_Core32_0_AHB_MST_MMIO_HTRANS;
wire   [31:0] MiV_Core32_0_AHB_MST_MMIO_HWDATA;
wire          MiV_Core32_0_AHB_MST_MMIO_HWRITE;
wire          MiV_Core32_0_TDO;
wire          MSS_SubSystem_sb_0_FIC_0_CLK;
wire          MSS_SubSystem_sb_0_INIT_DONE_0;
wire          TCK;
wire          TDI;
wire          TDO_net_0;
wire          Timer_0_TIMINT_0;
wire          TMS;
wire          TRSTB;
wire          USER_BUTTON1;
wire          USER_BUTTON2;
wire          MDDR_DQS_TMATCH_0_OUT_net_1;
wire          MDDR_CAS_N_net_1;
wire          MDDR_CLK_net_1;
wire          MDDR_CLK_N_net_1;
wire          MDDR_CKE_net_1;
wire          MDDR_CS_N_net_1;
wire          MDDR_ODT_net_1;
wire          MDDR_RAS_N_net_1;
wire          MDDR_RESET_N_net_1;
wire          MDDR_WE_N_net_1;
wire          TDO_net_1;
wire   [15:0] MDDR_ADDR_net_1;
wire   [2:0]  MDDR_BA_net_1;
wire          FTDI_UART0_RXD_net_1;
wire          LED1_GREEN_net_1;
wire          LED1_RED_net_1;
wire          LED2_GREEN_net_1;
wire          LED2_RED_0_net_0;
wire   [30:0] IRQ_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          GND_net;
wire   [27:0] IRQ_const_net_0;
wire          VCC_net;
//--------------------------------------------------------------------
// Bus Interface Nets Declarations - Unequal Pin Widths
//--------------------------------------------------------------------
wire   [1:1]  AHB_MEM_0_AHBmslave16_HRESP_0_1to1;
wire   [0:0]  AHB_MEM_0_AHBmslave16_HRESP_0_0to0;
wire   [1:0]  AHB_MEM_0_AHBmslave16_HRESP_0;
wire          AHB_MEM_0_AHBmslave16_HRESP;
wire   [1:0]  AHB_MEM_0_AHBmslave16_HSIZE_0_1to0;
wire   [1:0]  AHB_MEM_0_AHBmslave16_HSIZE_0;
wire   [2:0]  AHB_MEM_0_AHBmslave16_HSIZE;
wire   [31:0] APB3_Bus_0_APBmslave0_0_PADDR;
wire   [4:2]  APB3_Bus_0_APBmslave0_0_PADDR_0_4to2;
wire   [4:2]  APB3_Bus_0_APBmslave0_0_PADDR_0;
wire   [1:0]  MiV_Core32_0_AHB_MST_MEM_HRESP;
wire   [0:0]  MiV_Core32_0_AHB_MST_MEM_HRESP_0_0to0;
wire          MiV_Core32_0_AHB_MST_MEM_HRESP_0;
wire   [30:0] MiV_Core32_0_AHB_MST_MMIO_HADDR;
wire   [31:31]MiV_Core32_0_AHB_MST_MMIO_HADDR_0_31to31;
wire   [30:0] MiV_Core32_0_AHB_MST_MMIO_HADDR_0_30to0;
wire   [31:0] MiV_Core32_0_AHB_MST_MMIO_HADDR_0;
wire   [0:0]  MiV_Core32_0_AHB_MST_MMIO_HRESP_0_0to0;
wire          MiV_Core32_0_AHB_MST_MMIO_HRESP_0;
wire   [1:0]  MiV_Core32_0_AHB_MST_MMIO_HRESP;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net         = 1'b0;
assign IRQ_const_net_0 = 28'h0000000;
assign VCC_net         = 1'b1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign MDDR_DQS_TMATCH_0_OUT_net_1 = MDDR_DQS_TMATCH_0_OUT_net_0;
assign MDDR_DQS_TMATCH_0_OUT       = MDDR_DQS_TMATCH_0_OUT_net_1;
assign MDDR_CAS_N_net_1            = MDDR_CAS_N_net_0;
assign MDDR_CAS_N                  = MDDR_CAS_N_net_1;
assign MDDR_CLK_net_1              = MDDR_CLK_net_0;
assign MDDR_CLK                    = MDDR_CLK_net_1;
assign MDDR_CLK_N_net_1            = MDDR_CLK_N_net_0;
assign MDDR_CLK_N                  = MDDR_CLK_N_net_1;
assign MDDR_CKE_net_1              = MDDR_CKE_net_0;
assign MDDR_CKE                    = MDDR_CKE_net_1;
assign MDDR_CS_N_net_1             = MDDR_CS_N_net_0;
assign MDDR_CS_N                   = MDDR_CS_N_net_1;
assign MDDR_ODT_net_1              = MDDR_ODT_net_0;
assign MDDR_ODT                    = MDDR_ODT_net_1;
assign MDDR_RAS_N_net_1            = MDDR_RAS_N_net_0;
assign MDDR_RAS_N                  = MDDR_RAS_N_net_1;
assign MDDR_RESET_N_net_1          = MDDR_RESET_N_net_0;
assign MDDR_RESET_N                = MDDR_RESET_N_net_1;
assign MDDR_WE_N_net_1             = MDDR_WE_N_net_0;
assign MDDR_WE_N                   = MDDR_WE_N_net_1;
assign TDO_net_1                   = TDO_net_0;
assign TDO                         = TDO_net_1;
assign MDDR_ADDR_net_1             = MDDR_ADDR_net_0;
assign MDDR_ADDR[15:0]             = MDDR_ADDR_net_1;
assign MDDR_BA_net_1               = MDDR_BA_net_0;
assign MDDR_BA[2:0]                = MDDR_BA_net_1;
assign FTDI_UART0_RXD_net_1        = FTDI_UART0_RXD_net_0;
assign FTDI_UART0_RXD              = FTDI_UART0_RXD_net_1;
assign LED1_GREEN_net_1            = LED1_GREEN_net_0;
assign LED1_GREEN                  = LED1_GREEN_net_1;
assign LED1_RED_net_1              = LED1_RED_net_0;
assign LED1_RED                    = LED1_RED_net_1;
assign LED2_GREEN_net_1            = LED2_GREEN_net_0;
assign LED2_GREEN                  = LED2_GREEN_net_1;
assign LED2_RED_0_net_0            = LED2_RED_0;
assign LED2_RED                    = LED2_RED_0_net_0;
//--------------------------------------------------------------------
// Concatenation assignments
//--------------------------------------------------------------------
assign IRQ_net_0 = { BasicIO_Interface_0_USER_PB1_IRQ , BasicIO_Interface_0_USER_PB2_IRQ , Timer_0_TIMINT_0 , 28'h0000000 };
//--------------------------------------------------------------------
// Bus Interface Nets Assignments - Unequal Pin Widths
//--------------------------------------------------------------------
assign AHB_MEM_0_AHBmslave16_HRESP_0_1to1 = 1'b0;
assign AHB_MEM_0_AHBmslave16_HRESP_0_0to0 = AHB_MEM_0_AHBmslave16_HRESP;
assign AHB_MEM_0_AHBmslave16_HRESP_0 = { AHB_MEM_0_AHBmslave16_HRESP_0_1to1, AHB_MEM_0_AHBmslave16_HRESP_0_0to0 };

assign AHB_MEM_0_AHBmslave16_HSIZE_0_1to0 = AHB_MEM_0_AHBmslave16_HSIZE[1:0];
assign AHB_MEM_0_AHBmslave16_HSIZE_0 = { AHB_MEM_0_AHBmslave16_HSIZE_0_1to0 };

assign APB3_Bus_0_APBmslave0_0_PADDR_0_4to2 = APB3_Bus_0_APBmslave0_0_PADDR[4:2];
assign APB3_Bus_0_APBmslave0_0_PADDR_0 = { APB3_Bus_0_APBmslave0_0_PADDR_0_4to2 };

assign MiV_Core32_0_AHB_MST_MEM_HRESP_0_0to0 = MiV_Core32_0_AHB_MST_MEM_HRESP[0:0];
assign MiV_Core32_0_AHB_MST_MEM_HRESP_0 = { MiV_Core32_0_AHB_MST_MEM_HRESP_0_0to0 };

assign MiV_Core32_0_AHB_MST_MMIO_HADDR_0_31to31 = 1'b0;
assign MiV_Core32_0_AHB_MST_MMIO_HADDR_0_30to0 = MiV_Core32_0_AHB_MST_MMIO_HADDR[30:0];
assign MiV_Core32_0_AHB_MST_MMIO_HADDR_0 = { MiV_Core32_0_AHB_MST_MMIO_HADDR_0_31to31, MiV_Core32_0_AHB_MST_MMIO_HADDR_0_30to0 };

assign MiV_Core32_0_AHB_MST_MMIO_HRESP_0_0to0 = MiV_Core32_0_AHB_MST_MMIO_HRESP[0:0];
assign MiV_Core32_0_AHB_MST_MMIO_HRESP_0 = { MiV_Core32_0_AHB_MST_MMIO_HRESP_0_0to0 };

//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------AHB_MEM
AHB_MEM AHB_MEM_0(
        // Inputs
        .HCLK          ( MSS_SubSystem_sb_0_FIC_0_CLK ),
        .HRESETN       ( MSS_SubSystem_sb_0_INIT_DONE_0 ),
        .REMAP_M0      ( GND_net ),
        .HWRITE_M0     ( MiV_Core32_0_AHB_MST_MEM_HWRITE ),
        .HMASTLOCK_M0  ( MiV_Core32_0_AHB_MST_MEM_HLOCK ),
        .HREADYOUT_S16 ( AHB_MEM_0_AHBmslave16_HREADYOUT ),
        .HADDR_M0      ( MiV_Core32_0_AHB_MST_MEM_HADDR ),
        .HTRANS_M0     ( MiV_Core32_0_AHB_MST_MEM_HTRANS ),
        .HSIZE_M0      ( MiV_Core32_0_AHB_MST_MEM_HSIZE ),
        .HBURST_M0     ( MiV_Core32_0_AHB_MST_MEM_HBURST ),
        .HPROT_M0      ( MiV_Core32_0_AHB_MST_MEM_HPROT ),
        .HWDATA_M0     ( MiV_Core32_0_AHB_MST_MEM_HWDATA ),
        .HRDATA_S16    ( AHB_MEM_0_AHBmslave16_HRDATA ),
        .HRESP_S16     ( AHB_MEM_0_AHBmslave16_HRESP_0 ),
        // Outputs
        .HREADY_M0     ( MiV_Core32_0_AHB_MST_MEM_HREADY ),
        .HWRITE_S16    ( AHB_MEM_0_AHBmslave16_HWRITE ),
        .HSEL_S16      ( AHB_MEM_0_AHBmslave16_HSELx ),
        .HREADY_S16    ( AHB_MEM_0_AHBmslave16_HREADY ),
        .HMASTLOCK_S16 ( AHB_MEM_0_AHBmslave16_HMASTLOCK ),
        .HRDATA_M0     ( MiV_Core32_0_AHB_MST_MEM_HRDATA ),
        .HRESP_M0      ( MiV_Core32_0_AHB_MST_MEM_HRESP ),
        .HADDR_S16     ( AHB_MEM_0_AHBmslave16_HADDR ),
        .HTRANS_S16    ( AHB_MEM_0_AHBmslave16_HTRANS ),
        .HSIZE_S16     ( AHB_MEM_0_AHBmslave16_HSIZE ),
        .HWDATA_S16    ( AHB_MEM_0_AHBmslave16_HWDATA ),
        .HBURST_S16    ( AHB_MEM_0_AHBmslave16_HBURST ),
        .HPROT_S16     ( AHB_MEM_0_AHBmslave16_HPROT ) 
        );

//--------AHB_MMIO
AHB_MMIO AHB_MMIO_0(
        // Inputs
        .HCLK         ( MSS_SubSystem_sb_0_FIC_0_CLK ),
        .HRESETN      ( MSS_SubSystem_sb_0_INIT_DONE_0 ),
        .REMAP_M0     ( GND_net ),
        .HWRITE_M0    ( MiV_Core32_0_AHB_MST_MMIO_HWRITE ),
        .HMASTLOCK_M0 ( MiV_Core32_0_AHB_MST_MMIO_HLOCK ),
        .HREADYOUT_S6 ( AHB_MMIO_0_AHBmslave6_HREADYOUT ),
        .HREADYOUT_S7 ( AHB_MMIO_0_AHBmslave7_HREADYOUT ),
        .HADDR_M0     ( MiV_Core32_0_AHB_MST_MMIO_HADDR_0 ),
        .HTRANS_M0    ( MiV_Core32_0_AHB_MST_MMIO_HTRANS ),
        .HSIZE_M0     ( MiV_Core32_0_AHB_MST_MMIO_HSIZE ),
        .HBURST_M0    ( MiV_Core32_0_AHB_MST_MMIO_HBURST ),
        .HPROT_M0     ( MiV_Core32_0_AHB_MST_MMIO_HPROT ),
        .HWDATA_M0    ( MiV_Core32_0_AHB_MST_MMIO_HWDATA ),
        .HRDATA_S6    ( AHB_MMIO_0_AHBmslave6_HRDATA ),
        .HRESP_S6     ( AHB_MMIO_0_AHBmslave6_HRESP ),
        .HRDATA_S7    ( AHB_MMIO_0_AHBmslave7_HRDATA ),
        .HRESP_S7     ( AHB_MMIO_0_AHBmslave7_HRESP ),
        // Outputs
        .HREADY_M0    ( MiV_Core32_0_AHB_MST_MMIO_HREADY ),
        .HWRITE_S6    ( AHB_MMIO_0_AHBmslave6_HWRITE ),
        .HSEL_S6      ( AHB_MMIO_0_AHBmslave6_HSELx ),
        .HREADY_S6    ( AHB_MMIO_0_AHBmslave6_HREADY ),
        .HMASTLOCK_S6 ( AHB_MMIO_0_AHBmslave6_HMASTLOCK ),
        .HWRITE_S7    ( AHB_MMIO_0_AHBmslave7_HWRITE ),
        .HSEL_S7      ( AHB_MMIO_0_AHBmslave7_HSELx ),
        .HREADY_S7    ( AHB_MMIO_0_AHBmslave7_HREADY ),
        .HMASTLOCK_S7 ( AHB_MMIO_0_AHBmslave7_HMASTLOCK ),
        .HRDATA_M0    ( MiV_Core32_0_AHB_MST_MMIO_HRDATA ),
        .HRESP_M0     ( MiV_Core32_0_AHB_MST_MMIO_HRESP ),
        .HADDR_S6     ( AHB_MMIO_0_AHBmslave6_HADDR ),
        .HTRANS_S6    ( AHB_MMIO_0_AHBmslave6_HTRANS ),
        .HSIZE_S6     ( AHB_MMIO_0_AHBmslave6_HSIZE ),
        .HWDATA_S6    ( AHB_MMIO_0_AHBmslave6_HWDATA ),
        .HBURST_S6    ( AHB_MMIO_0_AHBmslave6_HBURST ),
        .HPROT_S6     ( AHB_MMIO_0_AHBmslave6_HPROT ),
        .HADDR_S7     ( AHB_MMIO_0_AHBmslave7_HADDR ),
        .HTRANS_S7    ( AHB_MMIO_0_AHBmslave7_HTRANS ),
        .HSIZE_S7     ( AHB_MMIO_0_AHBmslave7_HSIZE ),
        .HWDATA_S7    ( AHB_MMIO_0_AHBmslave7_HWDATA ),
        .HBURST_S7    ( AHB_MMIO_0_AHBmslave7_HBURST ),
        .HPROT_S7     ( AHB_MMIO_0_AHBmslave7_HPROT ) 
        );

//--------AHB_Slave2MasterBridge
AHB_Slave2MasterBridge AHB_Slave2MasterBridge_0(
        // Inputs
        .clock            ( MSS_SubSystem_sb_0_FIC_0_CLK ),
        .resetn           ( MSS_SubSystem_sb_0_INIT_DONE_0 ),
        .HREADY_MASTER    ( AHB_Slave2MasterBridge_0_MASTER_HREADY ),
        .HWRITE_SLAVE     ( AHB_MMIO_0_AHBmslave6_HWRITE ),
        .HSEL_SLAVE       ( AHB_MMIO_0_AHBmslave6_HSELx ),
        .HMASTLOCK_SLAVE  ( AHB_MMIO_0_AHBmslave6_HMASTLOCK ),
        .HREADY_SLAVE     ( AHB_MMIO_0_AHBmslave6_HREADY ),
        .HRDATA_MASTER    ( AHB_Slave2MasterBridge_0_MASTER_HRDATA ),
        .HRESP_MASTER     ( AHB_Slave2MasterBridge_0_MASTER_HRESP ),
        .HADDR_SLAVE      ( AHB_MMIO_0_AHBmslave6_HADDR ),
        .HTRANS_SLAVE     ( AHB_MMIO_0_AHBmslave6_HTRANS ),
        .HSIZE_SLAVE      ( AHB_MMIO_0_AHBmslave6_HSIZE ),
        .HBURST_SLAVE     ( AHB_MMIO_0_AHBmslave6_HBURST ),
        .HPROT_SLAVE      ( AHB_MMIO_0_AHBmslave6_HPROT ),
        .HWDATA_SLAVE     ( AHB_MMIO_0_AHBmslave6_HWDATA ),
        // Outputs
        .HWRITE_MASTER    ( AHB_Slave2MasterBridge_0_MASTER_HWRITE ),
        .HMASTLOCK_MASTER ( AHB_Slave2MasterBridge_0_MASTER_HLOCK ),
        .HREADYOUT_SLAVE  ( AHB_MMIO_0_AHBmslave6_HREADYOUT ),
        .HADDR_MASTER     ( AHB_Slave2MasterBridge_0_MASTER_HADDR ),
        .HTRANS_MASTER    ( AHB_Slave2MasterBridge_0_MASTER_HTRANS ),
        .HSIZE_MASTER     ( AHB_Slave2MasterBridge_0_MASTER_HSIZE ),
        .HBURST_MASTER    ( AHB_Slave2MasterBridge_0_MASTER_HBURST ),
        .HPROT_MASTER     ( AHB_Slave2MasterBridge_0_MASTER_HPROT ),
        .HWDATA_MASTER    ( AHB_Slave2MasterBridge_0_MASTER_HWDATA ),
        .HRDATA_SLAVE     ( AHB_MMIO_0_AHBmslave6_HRDATA ),
        .HRESP_SLAVE      ( AHB_MMIO_0_AHBmslave6_HRESP ) 
        );

//--------AHBtoAPB3
AHBtoAPB3 AHBtoAPB3_0(
        // Inputs
        .HCLK      ( MSS_SubSystem_sb_0_FIC_0_CLK ),
        .HRESETN   ( MSS_SubSystem_sb_0_INIT_DONE_0 ),
        .HWRITE    ( AHB_MMIO_0_AHBmslave7_HWRITE ),
        .HSEL      ( AHB_MMIO_0_AHBmslave7_HSELx ),
        .HREADY    ( AHB_MMIO_0_AHBmslave7_HREADY ),
        .PREADY    ( AHBtoAPB3_0_APBmaster_PREADY ),
        .PSLVERR   ( AHBtoAPB3_0_APBmaster_PSLVERR ),
        .HADDR     ( AHB_MMIO_0_AHBmslave7_HADDR ),
        .HTRANS    ( AHB_MMIO_0_AHBmslave7_HTRANS ),
        .HWDATA    ( AHB_MMIO_0_AHBmslave7_HWDATA ),
        .PRDATA    ( AHBtoAPB3_0_APBmaster_PRDATA ),
        // Outputs
        .HREADYOUT ( AHB_MMIO_0_AHBmslave7_HREADYOUT ),
        .PSEL      ( AHBtoAPB3_0_APBmaster_PSELx ),
        .PENABLE   ( AHBtoAPB3_0_APBmaster_PENABLE ),
        .PWRITE    ( AHBtoAPB3_0_APBmaster_PWRITE ),
        .HRDATA    ( AHB_MMIO_0_AHBmslave7_HRDATA ),
        .HRESP     ( AHB_MMIO_0_AHBmslave7_HRESP ),
        .PADDR     ( AHBtoAPB3_0_APBmaster_PADDR ),
        .PWDATA    ( AHBtoAPB3_0_APBmaster_PWDATA ) 
        );

//--------APB3_Bus
APB3_Bus APB3_Bus_0(
        // Inputs
        .PADDR     ( AHBtoAPB3_0_APBmaster_PADDR ),
        .PSEL      ( AHBtoAPB3_0_APBmaster_PSELx ),
        .PENABLE   ( AHBtoAPB3_0_APBmaster_PENABLE ),
        .PWRITE    ( AHBtoAPB3_0_APBmaster_PWRITE ),
        .PWDATA    ( AHBtoAPB3_0_APBmaster_PWDATA ),
        .PRDATAS0  ( APB3_Bus_0_APBmslave0_0_PRDATA ),
        .PREADYS0  ( APB3_Bus_0_APBmslave0_0_PREADY ),
        .PSLVERRS0 ( APB3_Bus_0_APBmslave0_0_PSLVERR ),
        .PRDATAS1  ( APB3_Bus_0_APBmslave1_PRDATA ),
        .PREADYS1  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS1 ( GND_net ), // tied to 1'b0 from definition
        // Outputs
        .PRDATA    ( AHBtoAPB3_0_APBmaster_PRDATA ),
        .PREADY    ( AHBtoAPB3_0_APBmaster_PREADY ),
        .PSLVERR   ( AHBtoAPB3_0_APBmaster_PSLVERR ),
        .PADDRS    ( APB3_Bus_0_APBmslave0_0_PADDR ),
        .PSELS0    ( APB3_Bus_0_APBmslave0_0_PSELx ),
        .PENABLES  ( APB3_Bus_0_APBmslave0_0_PENABLE ),
        .PWRITES   ( APB3_Bus_0_APBmslave0_0_PWRITE ),
        .PWDATAS   ( APB3_Bus_0_APBmslave0_0_PWDATA ),
        .PSELS1    ( APB3_Bus_0_APBmslave1_PSELx ) 
        );

//--------BasicIO_Interface
BasicIO_Interface BasicIO_Interface_0(
        // Inputs
        .FTDI_UART0_TXD ( FTDI_UART0_TXD ),
        .PADDR_in       ( APB3_Bus_0_APBmslave0_0_PADDR ),
        .PCLK           ( MSS_SubSystem_sb_0_FIC_0_CLK ),
        .PENABLE_in     ( APB3_Bus_0_APBmslave0_0_PENABLE ),
        .PRESETN        ( MSS_SubSystem_sb_0_INIT_DONE_0 ),
        .PSEL_in        ( APB3_Bus_0_APBmslave0_0_PSELx ),
        .PWDATA_in      ( APB3_Bus_0_APBmslave0_0_PWDATA ),
        .PWRITE_in      ( APB3_Bus_0_APBmslave0_0_PWRITE ),
        .USER_BUTTON1   ( USER_BUTTON1 ),
        .USER_BUTTON2   ( USER_BUTTON2 ),
        // Outputs
        .FTDI_UART0_RXD ( FTDI_UART0_RXD_net_0 ),
        .LED1_GREEN     ( LED1_GREEN_net_0 ),
        .LED1_RED       ( LED1_RED_net_0 ),
        .LED2_GREEN     ( LED2_GREEN_net_0 ),
        .LED2_RED       ( LED2_RED_0 ),
        .PRDATA_in      ( APB3_Bus_0_APBmslave0_0_PRDATA ),
        .PREADY_in      ( APB3_Bus_0_APBmslave0_0_PREADY ),
        .PSLVERR_in     ( APB3_Bus_0_APBmslave0_0_PSLVERR ),
        .USER_PB1_IRQ   ( BasicIO_Interface_0_USER_PB1_IRQ ),
        .USER_PB2_IRQ   ( BasicIO_Interface_0_USER_PB2_IRQ ) 
        );

//--------JTAG
JTAG JTAG_0(
        // Inputs
        .TRSTB       ( TRSTB ),
        .TCK         ( TCK ),
        .TMS         ( TMS ),
        .TDI         ( TDI ),
        .TGT_TDO_0   ( MiV_Core32_0_TDO ),
        // Outputs
        .TDO         ( TDO_net_0 ),
        .TGT_TRSTB_0 ( JTAG_0_TGT_TRSTB_0 ),
        .TGT_TCK_0   ( JTAG_0_TGT_TCK_0 ),
        .TGT_TMS_0   ( JTAG_0_TGT_TMS_0 ),
        .TGT_TDI_0   ( JTAG_0_TGT_TDI_0 ) 
        );

//--------MiV_Core32
MiV_Core32 MiV_Core32_0(
        // Inputs
        .CLK                 ( MSS_SubSystem_sb_0_FIC_0_CLK ),
        .RESETN              ( MSS_SubSystem_sb_0_INIT_DONE_0 ),
        .TDI                 ( JTAG_0_TGT_TDI_0 ),
        .TCK                 ( JTAG_0_TGT_TCK_0 ),
        .TMS                 ( JTAG_0_TGT_TMS_0 ),
        .TRST                ( JTAG_0_TGT_TRSTB_0 ),
        .AHB_MST_MEM_HREADY  ( MiV_Core32_0_AHB_MST_MEM_HREADY ),
        .AHB_MST_MEM_HRESP   ( MiV_Core32_0_AHB_MST_MEM_HRESP_0 ),
        .AHB_MST_MMIO_HREADY ( MiV_Core32_0_AHB_MST_MMIO_HREADY ),
        .AHB_MST_MMIO_HRESP  ( MiV_Core32_0_AHB_MST_MMIO_HRESP_0 ),
        .IRQ                 ( IRQ_net_0 ),
        .AHB_MST_MEM_HRDATA  ( MiV_Core32_0_AHB_MST_MEM_HRDATA ),
        .AHB_MST_MMIO_HRDATA ( MiV_Core32_0_AHB_MST_MMIO_HRDATA ),
        // Outputs
        .AHB_MST_MEM_HSEL    (  ),
        .AHB_MST_MMIO_HSEL   (  ),
        .TDO                 ( MiV_Core32_0_TDO ),
        .EXT_RESETN          (  ),
        .DRV_TDO             (  ),
        .AHB_MST_MEM_HWRITE  ( MiV_Core32_0_AHB_MST_MEM_HWRITE ),
        .AHB_MST_MEM_HLOCK   ( MiV_Core32_0_AHB_MST_MEM_HLOCK ),
        .AHB_MST_MMIO_HWRITE ( MiV_Core32_0_AHB_MST_MMIO_HWRITE ),
        .AHB_MST_MMIO_HLOCK  ( MiV_Core32_0_AHB_MST_MMIO_HLOCK ),
        .AHB_MST_MEM_HADDR   ( MiV_Core32_0_AHB_MST_MEM_HADDR ),
        .AHB_MST_MEM_HTRANS  ( MiV_Core32_0_AHB_MST_MEM_HTRANS ),
        .AHB_MST_MEM_HSIZE   ( MiV_Core32_0_AHB_MST_MEM_HSIZE ),
        .AHB_MST_MEM_HBURST  ( MiV_Core32_0_AHB_MST_MEM_HBURST ),
        .AHB_MST_MEM_HPROT   ( MiV_Core32_0_AHB_MST_MEM_HPROT ),
        .AHB_MST_MEM_HWDATA  ( MiV_Core32_0_AHB_MST_MEM_HWDATA ),
        .AHB_MST_MMIO_HADDR  ( MiV_Core32_0_AHB_MST_MMIO_HADDR ),
        .AHB_MST_MMIO_HTRANS ( MiV_Core32_0_AHB_MST_MMIO_HTRANS ),
        .AHB_MST_MMIO_HSIZE  ( MiV_Core32_0_AHB_MST_MMIO_HSIZE ),
        .AHB_MST_MMIO_HBURST ( MiV_Core32_0_AHB_MST_MMIO_HBURST ),
        .AHB_MST_MMIO_HPROT  ( MiV_Core32_0_AHB_MST_MMIO_HPROT ),
        .AHB_MST_MMIO_HWDATA ( MiV_Core32_0_AHB_MST_MMIO_HWDATA ) 
        );

//--------MSS_SubSystem_sb
MSS_SubSystem_sb MSS_SubSystem_sb_0(
        // Inputs
        .MDDR_DQS_TMATCH_0_IN        ( MDDR_DQS_TMATCH_0_IN ),
        .FAB_RESET_N                 ( VCC_net ),
        .HWRITE_M0                   ( AHB_Slave2MasterBridge_0_MASTER_HWRITE ),
        .HMASTLOCK_M0                ( AHB_Slave2MasterBridge_0_MASTER_HLOCK ),
        .DEVRST_N                    ( DEVRST_N ),
        .MDDR_DDR_AHB0_S_HWRITE      ( AHB_MEM_0_AHBmslave16_HWRITE ),
        .MDDR_DDR_AHB0_S_HSEL        ( AHB_MEM_0_AHBmslave16_HSELx ),
        .MDDR_DDR_AHB0_S_HMASTLOCK   ( AHB_MEM_0_AHBmslave16_HMASTLOCK ),
        .MDDR_DDR_AHB0_S_HREADY      ( AHB_MEM_0_AHBmslave16_HREADY ),
        .HADDR_M0                    ( AHB_Slave2MasterBridge_0_MASTER_HADDR ),
        .HTRANS_M0                   ( AHB_Slave2MasterBridge_0_MASTER_HTRANS ),
        .HSIZE_M0                    ( AHB_Slave2MasterBridge_0_MASTER_HSIZE ),
        .HBURST_M0                   ( AHB_Slave2MasterBridge_0_MASTER_HBURST ),
        .HPROT_M0                    ( AHB_Slave2MasterBridge_0_MASTER_HPROT ),
        .HWDATA_M0                   ( AHB_Slave2MasterBridge_0_MASTER_HWDATA ),
        .MDDR_DDR_AHB0_S_HADDR       ( AHB_MEM_0_AHBmslave16_HADDR ),
        .MDDR_DDR_AHB0_S_HTRANS      ( AHB_MEM_0_AHBmslave16_HTRANS ),
        .MDDR_DDR_AHB0_S_HSIZE       ( AHB_MEM_0_AHBmslave16_HSIZE_0 ),
        .MDDR_DDR_AHB0_S_HBURST      ( AHB_MEM_0_AHBmslave16_HBURST ),
        .MDDR_DDR_AHB0_S_HWDATA      ( AHB_MEM_0_AHBmslave16_HWDATA ),
        // Outputs
        .MDDR_DQS_TMATCH_0_OUT       ( MDDR_DQS_TMATCH_0_OUT_net_0 ),
        .MDDR_CAS_N                  ( MDDR_CAS_N_net_0 ),
        .MDDR_CLK                    ( MDDR_CLK_net_0 ),
        .MDDR_CLK_N                  ( MDDR_CLK_N_net_0 ),
        .MDDR_CKE                    ( MDDR_CKE_net_0 ),
        .MDDR_CS_N                   ( MDDR_CS_N_net_0 ),
        .MDDR_ODT                    ( MDDR_ODT_net_0 ),
        .MDDR_RAS_N                  ( MDDR_RAS_N_net_0 ),
        .MDDR_RESET_N                ( MDDR_RESET_N_net_0 ),
        .MDDR_WE_N                   ( MDDR_WE_N_net_0 ),
        .POWER_ON_RESET_N            (  ),
        .INIT_DONE                   ( MSS_SubSystem_sb_0_INIT_DONE_0 ),
        .HPMS_DDR_FIC_SUBSYSTEM_CLK  (  ),
        .HPMS_DDR_FIC_SUBSYSTEM_LOCK (  ),
        .HREADY_M0                   ( AHB_Slave2MasterBridge_0_MASTER_HREADY ),
        .FIC_0_CLK                   ( MSS_SubSystem_sb_0_FIC_0_CLK ),
        .FIC_0_LOCK                  (  ),
        .DDR_READY                   (  ),
        .HPMS_READY                  (  ),
        .MDDR_DDR_AHB0_S_HREADYOUT   ( AHB_MEM_0_AHBmslave16_HREADYOUT ),
        .MDDR_DDR_AHB0_S_HRESP       ( AHB_MEM_0_AHBmslave16_HRESP ),
        .COMM_BLK_INT                (  ),
        .MDDR_ADDR                   ( MDDR_ADDR_net_0 ),
        .MDDR_BA                     ( MDDR_BA_net_0 ),
        .HRDATA_M0                   ( AHB_Slave2MasterBridge_0_MASTER_HRDATA ),
        .HRESP_M0                    ( AHB_Slave2MasterBridge_0_MASTER_HRESP ),
        .MDDR_DDR_AHB0_S_HRDATA      ( AHB_MEM_0_AHBmslave16_HRDATA ),
        .HPMS_INT_M2F                (  ),
        // Inouts
        .MDDR_DM_RDQS                ( MDDR_DM_RDQS ),
        .MDDR_DQ                     ( MDDR_DQ ),
        .MDDR_DQS                    ( MDDR_DQS ),
        .MDDR_DQS_N                  ( MDDR_DQS_N ) 
        );

//--------Timer
Timer Timer_0(
        // Inputs
        .PCLK    ( MSS_SubSystem_sb_0_FIC_0_CLK ),
        .PRESETn ( MSS_SubSystem_sb_0_INIT_DONE_0 ),
        .PSEL    ( APB3_Bus_0_APBmslave1_PSELx ),
        .PENABLE ( APB3_Bus_0_APBmslave0_0_PENABLE ),
        .PWRITE  ( APB3_Bus_0_APBmslave0_0_PWRITE ),
        .PADDR   ( APB3_Bus_0_APBmslave0_0_PADDR_0 ),
        .PWDATA  ( APB3_Bus_0_APBmslave0_0_PWDATA ),
        // Outputs
        .TIMINT  ( Timer_0_TIMINT_0 ),
        .PRDATA  ( APB3_Bus_0_APBmslave1_PRDATA ) 
        );


endmodule
