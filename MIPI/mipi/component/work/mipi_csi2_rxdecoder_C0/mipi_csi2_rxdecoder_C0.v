//////////////////////////////////////////////////////////////////////
// Created by SmartDesign Fri Jan 29 14:14:40 2021
// Version: v12.3 12.800.0.16
//////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

// mipi_csi2_rxdecoder_C0
module mipi_csi2_rxdecoder_C0(
    // Inputs
    CAM_CLOCK_I,
    ChannelA_i,
    ChannelB_i,
    ChannelC_i,
    ChannelD_i,
    Num_of_Lanes_i,
    READ_CLOCK_I,
    RESET_n_I,
    // Outputs
    data_out_o,
    frame_end_o,
    frame_number_o,
    frame_start_o,
    line_end_o,
    line_start_o,
    pixel_valid_o,
    word_count_o
);

//--------------------------------------------------------------------
// Input
//--------------------------------------------------------------------
input         CAM_CLOCK_I;
input  [7:0]  ChannelA_i;
input  [7:0]  ChannelB_i;
input  [7:0]  ChannelC_i;
input  [7:0]  ChannelD_i;
input  [2:0]  Num_of_Lanes_i;
input         READ_CLOCK_I;
input         RESET_n_I;
//--------------------------------------------------------------------
// Output
//--------------------------------------------------------------------
output [7:0]  data_out_o;
output        frame_end_o;
output [15:0] frame_number_o;
output        frame_start_o;
output        line_end_o;
output        line_start_o;
output        pixel_valid_o;
output [15:0] word_count_o;
//--------------------------------------------------------------------
// Nets
//--------------------------------------------------------------------
wire          CAM_CLOCK_I;
wire   [7:0]  ChannelA_i;
wire   [7:0]  ChannelB_i;
wire   [7:0]  ChannelC_i;
wire   [7:0]  ChannelD_i;
wire   [7:0]  data_out_o_net_0;
wire          frame_end_o_net_0;
wire   [15:0] frame_number_o_net_0;
wire          frame_start_o_net_0;
wire          line_end_o_net_0;
wire          line_start_o_net_0;
wire   [2:0]  Num_of_Lanes_i;
wire          pixel_valid_o_net_0;
wire          READ_CLOCK_I;
wire          RESET_n_I;
wire   [15:0] word_count_o_net_0;
wire   [7:0]  data_out_o_net_1;
wire   [15:0] word_count_o_net_1;
wire          pixel_valid_o_net_1;
wire          frame_start_o_net_1;
wire          frame_end_o_net_1;
wire          line_start_o_net_1;
wire          line_end_o_net_1;
wire   [15:0] frame_number_o_net_1;
//--------------------------------------------------------------------
// Top level output port assignments
//--------------------------------------------------------------------
assign data_out_o_net_1     = data_out_o_net_0;
assign data_out_o[7:0]      = data_out_o_net_1;
assign word_count_o_net_1   = word_count_o_net_0;
assign word_count_o[15:0]   = word_count_o_net_1;
assign pixel_valid_o_net_1  = pixel_valid_o_net_0;
assign pixel_valid_o        = pixel_valid_o_net_1;
assign frame_start_o_net_1  = frame_start_o_net_0;
assign frame_start_o        = frame_start_o_net_1;
assign frame_end_o_net_1    = frame_end_o_net_0;
assign frame_end_o          = frame_end_o_net_1;
assign line_start_o_net_1   = line_start_o_net_0;
assign line_start_o         = line_start_o_net_1;
assign line_end_o_net_1     = line_end_o_net_0;
assign line_end_o           = line_end_o_net_1;
assign frame_number_o_net_1 = frame_number_o_net_0;
assign frame_number_o[15:0] = frame_number_o_net_1;
//--------------------------------------------------------------------
// Component instances
//--------------------------------------------------------------------
//--------mipi_csi2_rxdecoder   -   Microsemi:SolutionCore:mipi_csi2_rxdecoder:2.0.0
mipi_csi2_rxdecoder #( 
        .g_BUFF_DEPTH        ( 1280 ),
        .g_DATAWIDTH         ( 8 ),
        .g_INPUT_DATA_INVERT ( 1 ) )
mipi_csi2_rxdecoder_C0_0(
        // Inputs
        .CAM_CLOCK_I    ( CAM_CLOCK_I ),
        .READ_CLOCK_I   ( READ_CLOCK_I ),
        .RESET_n_I      ( RESET_n_I ),
        .Num_of_Lanes_i ( Num_of_Lanes_i ),
        .ChannelA_i     ( ChannelA_i ),
        .ChannelB_i     ( ChannelB_i ),
        .ChannelC_i     ( ChannelC_i ),
        .ChannelD_i     ( ChannelD_i ),
        // Outputs
        .data_out_o     ( data_out_o_net_0 ),
        .word_count_o   ( word_count_o_net_0 ),
        .pixel_valid_o  ( pixel_valid_o_net_0 ),
        .frame_start_o  ( frame_start_o_net_0 ),
        .frame_end_o    ( frame_end_o_net_0 ),
        .line_start_o   ( line_start_o_net_0 ),
        .line_end_o     ( line_end_o_net_0 ),
        .frame_number_o ( frame_number_o_net_0 ) 
        );


endmodule
