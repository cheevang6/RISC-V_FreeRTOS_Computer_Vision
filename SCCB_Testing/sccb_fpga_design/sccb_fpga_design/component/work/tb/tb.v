//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Mon Feb  1 22:33:51 2021
// Version: v12.3 12.800.0.16
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// tb
module tb(
    // Inputs
    reset,
    // Outputs
    led1,
    led2,
    sioc,
    xclk,
    // Inouts
    sio_d
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  reset;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output led1;
output led2;
output sioc;
output xclk;
//--------------------------------------------------------------------
// Inout
//--------------------------------------------------------------------
inout  sio_d;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   led1_net_0;
wire   led2_net_0;
wire   reset;
wire   sio_d;
wire   sioc_net_0;
wire   xclk_net_0;
wire   sioc_net_1;
wire   led1_net_1;
wire   led2_net_1;
wire   xclk_net_1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign sioc_net_1 = sioc_net_0;
assign sioc       = sioc_net_1;
assign led1_net_1 = led1_net_0;
assign led1       = led1_net_1;
assign led2_net_1 = led2_net_0;
assign led2       = led2_net_1;
assign xclk_net_1 = xclk_net_0;
assign xclk       = xclk_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------sccb_design
sccb_design sccb_design_0(
        // Inputs
        .DEVRST_N ( reset ),
        // Outputs
        .sio_c    ( sioc_net_0 ),
        .led1     ( led1_net_0 ),
        .xclk     ( xclk_net_0 ),
        .led2     ( led2_net_0 ),
        // Inouts
        .sio_d    ( sio_d ) 
        );


endmodule
