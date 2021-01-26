//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Wed Apr 24 09:05:19 2019
// Version: v12.1 12.600.0.14
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// APB3_Bus
module APB3_Bus(
    // Inputs
    PADDR,
    PENABLE,
    PRDATAS0,
    PRDATAS1,
    PREADYS0,
    PREADYS1,
    PSEL,
    PSLVERRS0,
    PSLVERRS1,
    PWDATA,
    PWRITE,
    // Outputs
    PADDRS,
    PENABLES,
    PRDATA,
    PREADY,
    PSELS0,
    PSELS1,
    PSLVERR,
    PWDATAS,
    PWRITES
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  [31:0] PADDR;
input         PENABLE;
input  [31:0] PRDATAS0;
input  [31:0] PRDATAS1;
input         PREADYS0;
input         PREADYS1;
input         PSEL;
input         PSLVERRS0;
input         PSLVERRS1;
input  [31:0] PWDATA;
input         PWRITE;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [31:0] PADDRS;
output        PENABLES;
output [31:0] PRDATA;
output        PREADY;
output        PSELS0;
output        PSELS1;
output        PSLVERR;
output [31:0] PWDATAS;
output        PWRITES;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   [31:0] PADDR;
wire          PENABLE;
wire   [31:0] APB3mmaster_PRDATA;
wire          APB3mmaster_PREADY;
wire          PSEL;
wire          APB3mmaster_PSLVERR;
wire   [31:0] PWDATA;
wire          PWRITE;
wire   [31:0] APBmslave0_2_PADDR;
wire          APBmslave0_2_PENABLE;
wire   [31:0] PRDATAS0;
wire          PREADYS0;
wire          APBmslave0_2_PSELx;
wire          PSLVERRS0;
wire   [31:0] APBmslave0_2_PWDATA;
wire          APBmslave0_2_PWRITE;
wire   [31:0] PRDATAS1;
wire          PREADYS1;
wire          APBmslave1_3_PSELx;
wire          PSLVERRS1;
wire   [31:0] APB3mmaster_PRDATA_net_0;
wire          APB3mmaster_PREADY_net_0;
wire          APB3mmaster_PSLVERR_net_0;
wire   [31:0] APBmslave0_2_PADDR_net_0;
wire          APBmslave0_2_PSELx_net_0;
wire          APBmslave0_2_PENABLE_net_0;
wire          APBmslave0_2_PWRITE_net_0;
wire   [31:0] APBmslave0_2_PWDATA_net_0;
wire          APBmslave1_3_PSELx_net_0;
//--------------------------------------------------------------------
// TiedOff Nets
//--------------------------------------------------------------------
wire          GND_net;
wire          VCC_net;
wire   [31:0] IADDR_const_net_0;
wire   [31:0] PRDATAS2_const_net_0;
wire   [31:0] PRDATAS3_const_net_0;
wire   [31:0] PRDATAS4_const_net_0;
wire   [31:0] PRDATAS5_const_net_0;
wire   [31:0] PRDATAS6_const_net_0;
wire   [31:0] PRDATAS7_const_net_0;
wire   [31:0] PRDATAS8_const_net_0;
wire   [31:0] PRDATAS9_const_net_0;
wire   [31:0] PRDATAS10_const_net_0;
wire   [31:0] PRDATAS11_const_net_0;
wire   [31:0] PRDATAS12_const_net_0;
wire   [31:0] PRDATAS13_const_net_0;
wire   [31:0] PRDATAS14_const_net_0;
wire   [31:0] PRDATAS15_const_net_0;
wire   [31:0] PRDATAS16_const_net_0;
//--------------------------------------------------------------------
// Constant assignments
//--------------------------------------------------------------------
assign GND_net               = 1'b0;
assign VCC_net               = 1'b1;
assign IADDR_const_net_0     = 32'h00000000;
assign PRDATAS2_const_net_0  = 32'h00000000;
assign PRDATAS3_const_net_0  = 32'h00000000;
assign PRDATAS4_const_net_0  = 32'h00000000;
assign PRDATAS5_const_net_0  = 32'h00000000;
assign PRDATAS6_const_net_0  = 32'h00000000;
assign PRDATAS7_const_net_0  = 32'h00000000;
assign PRDATAS8_const_net_0  = 32'h00000000;
assign PRDATAS9_const_net_0  = 32'h00000000;
assign PRDATAS10_const_net_0 = 32'h00000000;
assign PRDATAS11_const_net_0 = 32'h00000000;
assign PRDATAS12_const_net_0 = 32'h00000000;
assign PRDATAS13_const_net_0 = 32'h00000000;
assign PRDATAS14_const_net_0 = 32'h00000000;
assign PRDATAS15_const_net_0 = 32'h00000000;
assign PRDATAS16_const_net_0 = 32'h00000000;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign APB3mmaster_PRDATA_net_0   = APB3mmaster_PRDATA;
assign PRDATA[31:0]               = APB3mmaster_PRDATA_net_0;
assign APB3mmaster_PREADY_net_0   = APB3mmaster_PREADY;
assign PREADY                     = APB3mmaster_PREADY_net_0;
assign APB3mmaster_PSLVERR_net_0  = APB3mmaster_PSLVERR;
assign PSLVERR                    = APB3mmaster_PSLVERR_net_0;
assign APBmslave0_2_PADDR_net_0   = APBmslave0_2_PADDR;
assign PADDRS[31:0]               = APBmslave0_2_PADDR_net_0;
assign APBmslave0_2_PSELx_net_0   = APBmslave0_2_PSELx;
assign PSELS0                     = APBmslave0_2_PSELx_net_0;
assign APBmslave0_2_PENABLE_net_0 = APBmslave0_2_PENABLE;
assign PENABLES                   = APBmslave0_2_PENABLE_net_0;
assign APBmslave0_2_PWRITE_net_0  = APBmslave0_2_PWRITE;
assign PWRITES                    = APBmslave0_2_PWRITE_net_0;
assign APBmslave0_2_PWDATA_net_0  = APBmslave0_2_PWDATA;
assign PWDATAS[31:0]              = APBmslave0_2_PWDATA_net_0;
assign APBmslave1_3_PSELx_net_0   = APBmslave1_3_PSELx;
assign PSELS1                     = APBmslave1_3_PSELx_net_0;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------CoreAPB3   -   Actel:DirectCore:CoreAPB3:4.1.100
CoreAPB3 #( 
        .APB_DWIDTH      ( 32 ),
        .APBSLOT0ENABLE  ( 1 ),
        .APBSLOT1ENABLE  ( 1 ),
        .APBSLOT2ENABLE  ( 0 ),
        .APBSLOT3ENABLE  ( 0 ),
        .APBSLOT4ENABLE  ( 0 ),
        .APBSLOT5ENABLE  ( 0 ),
        .APBSLOT6ENABLE  ( 0 ),
        .APBSLOT7ENABLE  ( 0 ),
        .APBSLOT8ENABLE  ( 0 ),
        .APBSLOT9ENABLE  ( 0 ),
        .APBSLOT10ENABLE ( 0 ),
        .APBSLOT11ENABLE ( 0 ),
        .APBSLOT12ENABLE ( 0 ),
        .APBSLOT13ENABLE ( 0 ),
        .APBSLOT14ENABLE ( 0 ),
        .APBSLOT15ENABLE ( 0 ),
        .FAMILY          ( 24 ),
        .IADDR_OPTION    ( 0 ),
        .MADDR_BITS      ( 16 ),
        .SC_0            ( 0 ),
        .SC_1            ( 0 ),
        .SC_2            ( 0 ),
        .SC_3            ( 0 ),
        .SC_4            ( 0 ),
        .SC_5            ( 0 ),
        .SC_6            ( 0 ),
        .SC_7            ( 0 ),
        .SC_8            ( 0 ),
        .SC_9            ( 0 ),
        .SC_10           ( 0 ),
        .SC_11           ( 0 ),
        .SC_12           ( 0 ),
        .SC_13           ( 0 ),
        .SC_14           ( 0 ),
        .SC_15           ( 0 ),
        .UPR_NIBBLE_POSN ( 7 ) )
APB3_Bus_0(
        // Inputs
        .PRESETN    ( GND_net ), // tied to 1'b0 from definition
        .PCLK       ( GND_net ), // tied to 1'b0 from definition
        .PWRITE     ( PWRITE ),
        .PENABLE    ( PENABLE ),
        .PSEL       ( PSEL ),
        .PREADYS0   ( PREADYS0 ),
        .PSLVERRS0  ( PSLVERRS0 ),
        .PREADYS1   ( PREADYS1 ),
        .PSLVERRS1  ( PSLVERRS1 ),
        .PREADYS2   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS2  ( GND_net ), // tied to 1'b0 from definition
        .PREADYS3   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS3  ( GND_net ), // tied to 1'b0 from definition
        .PREADYS4   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS4  ( GND_net ), // tied to 1'b0 from definition
        .PREADYS5   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS5  ( GND_net ), // tied to 1'b0 from definition
        .PREADYS6   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS6  ( GND_net ), // tied to 1'b0 from definition
        .PREADYS7   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS7  ( GND_net ), // tied to 1'b0 from definition
        .PREADYS8   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS8  ( GND_net ), // tied to 1'b0 from definition
        .PREADYS9   ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS9  ( GND_net ), // tied to 1'b0 from definition
        .PREADYS10  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS10 ( GND_net ), // tied to 1'b0 from definition
        .PREADYS11  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS11 ( GND_net ), // tied to 1'b0 from definition
        .PREADYS12  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS12 ( GND_net ), // tied to 1'b0 from definition
        .PREADYS13  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS13 ( GND_net ), // tied to 1'b0 from definition
        .PREADYS14  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS14 ( GND_net ), // tied to 1'b0 from definition
        .PREADYS15  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS15 ( GND_net ), // tied to 1'b0 from definition
        .PREADYS16  ( VCC_net ), // tied to 1'b1 from definition
        .PSLVERRS16 ( GND_net ), // tied to 1'b0 from definition
        .PADDR      ( PADDR ),
        .PWDATA     ( PWDATA ),
        .PRDATAS0   ( PRDATAS0 ),
        .PRDATAS1   ( PRDATAS1 ),
        .PRDATAS2   ( PRDATAS2_const_net_0 ), // tied to 32'h00000000 from definition
        .PRDATAS3   ( PRDATAS3_const_net_0 ), // tied to 32'h00000000 from definition
        .PRDATAS4   ( PRDATAS4_const_net_0 ), // tied to 32'h00000000 from definition
        .PRDATAS5   ( PRDATAS5_const_net_0 ), // tied to 32'h00000000 from definition
        .PRDATAS6   ( PRDATAS6_const_net_0 ), // tied to 32'h00000000 from definition
        .PRDATAS7   ( PRDATAS7_const_net_0 ), // tied to 32'h00000000 from definition
        .PRDATAS8   ( PRDATAS8_const_net_0 ), // tied to 32'h00000000 from definition
        .PRDATAS9   ( PRDATAS9_const_net_0 ), // tied to 32'h00000000 from definition
        .PRDATAS10  ( PRDATAS10_const_net_0 ), // tied to 32'h00000000 from definition
        .PRDATAS11  ( PRDATAS11_const_net_0 ), // tied to 32'h00000000 from definition
        .PRDATAS12  ( PRDATAS12_const_net_0 ), // tied to 32'h00000000 from definition
        .PRDATAS13  ( PRDATAS13_const_net_0 ), // tied to 32'h00000000 from definition
        .PRDATAS14  ( PRDATAS14_const_net_0 ), // tied to 32'h00000000 from definition
        .PRDATAS15  ( PRDATAS15_const_net_0 ), // tied to 32'h00000000 from definition
        .PRDATAS16  ( PRDATAS16_const_net_0 ), // tied to 32'h00000000 from definition
        .IADDR      ( IADDR_const_net_0 ), // tied to 32'h00000000 from definition
        // Outputs
        .PREADY     ( APB3mmaster_PREADY ),
        .PSLVERR    ( APB3mmaster_PSLVERR ),
        .PWRITES    ( APBmslave0_2_PWRITE ),
        .PENABLES   ( APBmslave0_2_PENABLE ),
        .PSELS0     ( APBmslave0_2_PSELx ),
        .PSELS1     ( APBmslave1_3_PSELx ),
        .PSELS2     (  ),
        .PSELS3     (  ),
        .PSELS4     (  ),
        .PSELS5     (  ),
        .PSELS6     (  ),
        .PSELS7     (  ),
        .PSELS8     (  ),
        .PSELS9     (  ),
        .PSELS10    (  ),
        .PSELS11    (  ),
        .PSELS12    (  ),
        .PSELS13    (  ),
        .PSELS14    (  ),
        .PSELS15    (  ),
        .PSELS16    (  ),
        .PRDATA     ( APB3mmaster_PRDATA ),
        .PADDRS     ( APBmslave0_2_PADDR ),
        .PWDATAS    ( APBmslave0_2_PWDATA ) 
        );


endmodule
