//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Mon Feb  1 19:24:36 2021
// Version: v12.3 12.800.0.16
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// SCCB
module SCCB(
    // Inputs
    PCLK,
    PRESETN,
    // Outputs
    SIO_C,
    // Inouts
    SIO_D
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input  PCLK;
input  PRESETN;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output SIO_C;
//--------------------------------------------------------------------
// Inout
//--------------------------------------------------------------------
inout  SIO_D;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire   BIBUF_0_Y;
wire   config_sccb_0_SIO_DE;
wire   config_sccb_0_SIO_DO;
wire   PCLK;
wire   PRESETN;
wire   SIO_C_net_0;
wire   SIO_D;
wire   SIO_C_net_1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign SIO_C_net_1 = SIO_C_net_0;
assign SIO_C       = SIO_C_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------BIBUF
BIBUF BIBUF_0(
        // Inputs
        .D   ( config_sccb_0_SIO_DO ),
        .E   ( config_sccb_0_SIO_DE ),
        // Outputs
        .Y   ( BIBUF_0_Y ),
        // Inouts
        .PAD ( SIO_D ) 
        );

//--------config_sccb
config_sccb config_sccb_0(
        // Inputs
        .PCLK    ( PCLK ),
        .PRESETN ( PRESETN ),
        .SIO_DI  ( BIBUF_0_Y ),
        // Outputs
        .SIO_C   ( SIO_C_net_0 ),
        .SIO_DO  ( config_sccb_0_SIO_DO ),
        .SIO_DE  ( config_sccb_0_SIO_DE ) 
        );


endmodule
