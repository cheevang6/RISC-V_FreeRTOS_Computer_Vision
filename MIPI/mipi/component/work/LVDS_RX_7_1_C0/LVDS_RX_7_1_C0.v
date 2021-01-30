//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Fri Jan 29 14:26:22 2021
// Version: v12.3 12.800.0.16
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// LVDS_RX_7_1_C0
module LVDS_RX_7_1_C0(
    // Inputs
    CAM_CLKOUT_N,
    CAM_CLKOUT_P,
    CAM_D0_N,
    CAM_D0_P,
    CAM_D1_N,
    CAM_D1_P,
    CAM_D2_N,
    CAM_D2_P,
    CAM_D3_N,
    CAM_D3_P,
    Reset_n,
    Serial_Clk,
    parallel_Clk,
    training_pattern,
    // Outputs
    Align_serializer_a,
    Align_serializer_b,
    Align_serializer_c,
    Align_serializer_d,
    RDATA_A,
    RDATA_B,
    RDATA_C,
    RDATA_D,
    Rclk_o
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input        CAM_CLKOUT_N;
input        CAM_CLKOUT_P;
input        CAM_D0_N;
input        CAM_D0_P;
input        CAM_D1_N;
input        CAM_D1_P;
input        CAM_D2_N;
input        CAM_D2_P;
input        CAM_D3_N;
input        CAM_D3_P;
input        Reset_n;
input        Serial_Clk;
input        parallel_Clk;
input  [6:0] training_pattern;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output       Align_serializer_a;
output       Align_serializer_b;
output       Align_serializer_c;
output       Align_serializer_d;
output [6:0] RDATA_A;
output [6:0] RDATA_B;
output [6:0] RDATA_C;
output [6:0] RDATA_D;
output       Rclk_o;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire         Align_serializer_a_net_0;
wire         Align_serializer_b_net_0;
wire         Align_serializer_c_net_0;
wire         Align_serializer_d_net_0;
wire         CAM_CLKOUT_N;
wire         CAM_CLKOUT_P;
wire         CAM_D0_N;
wire         CAM_D0_P;
wire         CAM_D1_N;
wire         CAM_D1_P;
wire         CAM_D2_N;
wire         CAM_D2_P;
wire         CAM_D3_N;
wire         CAM_D3_P;
wire         parallel_Clk;
wire         Rclk_o_net_0;
wire   [6:0] RDATA_A_net_0;
wire   [6:0] RDATA_B_net_0;
wire   [6:0] RDATA_C_net_0;
wire   [6:0] RDATA_D_net_0;
wire         Reset_n;
wire         Serial_Clk;
wire   [6:0] training_pattern;
wire         Align_serializer_a_net_1;
wire         Align_serializer_b_net_1;
wire         Align_serializer_c_net_1;
wire         Align_serializer_d_net_1;
wire   [6:0] RDATA_A_net_1;
wire   [6:0] RDATA_B_net_1;
wire   [6:0] RDATA_C_net_1;
wire   [6:0] RDATA_D_net_1;
wire         Rclk_o_net_1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign Align_serializer_a_net_1 = Align_serializer_a_net_0;
assign Align_serializer_a       = Align_serializer_a_net_1;
assign Align_serializer_b_net_1 = Align_serializer_b_net_0;
assign Align_serializer_b       = Align_serializer_b_net_1;
assign Align_serializer_c_net_1 = Align_serializer_c_net_0;
assign Align_serializer_c       = Align_serializer_c_net_1;
assign Align_serializer_d_net_1 = Align_serializer_d_net_0;
assign Align_serializer_d       = Align_serializer_d_net_1;
assign RDATA_A_net_1            = RDATA_A_net_0;
assign RDATA_A[6:0]             = RDATA_A_net_1;
assign RDATA_B_net_1            = RDATA_B_net_0;
assign RDATA_B[6:0]             = RDATA_B_net_1;
assign RDATA_C_net_1            = RDATA_C_net_0;
assign RDATA_C[6:0]             = RDATA_C_net_1;
assign RDATA_D_net_1            = RDATA_D_net_0;
assign RDATA_D[6:0]             = RDATA_D_net_1;
assign Rclk_o_net_1             = Rclk_o_net_0;
assign Rclk_o                   = Rclk_o_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------LVDS_RX_7_1   -   Microsemi:SolutionCore:LVDS_RX_7_1:1.0.1
LVDS_RX_7_1 LVDS_RX_7_1_C0_0(
        // Inputs
        .CAM_CLKOUT_N       ( CAM_CLKOUT_N ),
        .CAM_CLKOUT_P       ( CAM_CLKOUT_P ),
        .CAM_D0_N           ( CAM_D0_N ),
        .CAM_D0_P           ( CAM_D0_P ),
        .CAM_D1_N           ( CAM_D1_N ),
        .CAM_D1_P           ( CAM_D1_P ),
        .CAM_D2_N           ( CAM_D2_N ),
        .CAM_D2_P           ( CAM_D2_P ),
        .CAM_D3_N           ( CAM_D3_N ),
        .CAM_D3_P           ( CAM_D3_P ),
        .Reset_n            ( Reset_n ),
        .Serial_Clk         ( Serial_Clk ),
        .parallel_Clk       ( parallel_Clk ),
        .training_pattern   ( training_pattern ),
        // Outputs
        .Align_serializer_a ( Align_serializer_a_net_0 ),
        .Align_serializer_b ( Align_serializer_b_net_0 ),
        .Align_serializer_c ( Align_serializer_c_net_0 ),
        .Align_serializer_d ( Align_serializer_d_net_0 ),
        .RDATA_A            ( RDATA_A_net_0 ),
        .RDATA_B            ( RDATA_B_net_0 ),
        .RDATA_C            ( RDATA_C_net_0 ),
        .RDATA_D            ( RDATA_D_net_0 ),
        .Rclk_o             ( Rclk_o_net_0 ) 
        );


endmodule
