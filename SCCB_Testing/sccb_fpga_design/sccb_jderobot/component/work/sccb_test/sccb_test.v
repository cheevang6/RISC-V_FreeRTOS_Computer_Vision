//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Tue Feb  9 16:20:24 2021
// Version: v12.3 12.800.0.16
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// sccb_test
module sccb_test(
    // Inputs
    clk,
    rst,
    // Outputs
    cam_rstn,
    led,
    pwdn,
    sioc,
    siod,
    xclk
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  clk;
input  rst;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output cam_rstn;
output led;
output pwdn;
output sioc;
output siod;
output xclk;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   cam_rstn_net_0;
wire   clk;
wire   led_net_0;
wire   pwdn_net_0;
wire   rst;
wire   sioc_net_0;
wire   siod_net_0;
wire   xclk_net_0;
wire   sioc_net_1;
wire   siod_net_1;
wire   cam_rstn_net_1;
wire   pwdn_net_1;
wire   led_net_1;
wire   xclk_net_1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign sioc_net_1     = sioc_net_0;
assign sioc           = sioc_net_1;
assign siod_net_1     = siod_net_0;
assign siod           = siod_net_1;
assign cam_rstn_net_1 = cam_rstn_net_0;
assign cam_rstn       = cam_rstn_net_1;
assign pwdn_net_1     = pwdn_net_0;
assign pwdn           = pwdn_net_1;
assign led_net_1      = led_net_0;
assign led            = led_net_1;
assign xclk_net_1     = xclk_net_0;
assign xclk           = xclk_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------top_ov7670
top_ov7670 top_ov7670_0(
        // Inputs
        .rst          ( rst ),
        .clk          ( clk ),
        // Outputs
        .ov7670_sioc  ( sioc_net_0 ),
        .ov7670_siod  ( siod_net_0 ),
        .ov7670_rst_n ( cam_rstn_net_0 ),
        .ov7670_pwdn  ( pwdn_net_0 ),
        .ov7670_xclk  ( xclk_net_0 ),
        .done         ( led_net_0 ) 
        );


endmodule
