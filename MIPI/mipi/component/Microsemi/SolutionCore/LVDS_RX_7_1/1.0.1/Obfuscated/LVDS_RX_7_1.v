/*****************************************************************************************************************************
--
--    File Name    : LVDS_RX_7_1.v

--    Description  : This module implements LVDS 7:1 Receiver module  
--                                   

-- Targeted device : Microsemi-SoC                     
-- Author          : India Solutions Team

-- SVN Revision Information:
-- SVN $Revision: TBD
-- SVN $Date: TBD
--
--
--
-- COPYRIGHT 2016 BY MICROSEMI 
-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS 
-- FROM MICROSEMI CORP.  IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM 
-- MICROSEMI FOR USE OF THIS FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND 
-- NO BACK-UP OF THE FILE SHOULD BE MADE. 
-- 

--******************************************************************************************************************************/
`timescale 1ns/100ps

module LVDS_RX_7_1(
/******************************************************************************************************************************/
/***********************************************Module IO**********************************************************************/
/******************************************************************************************************************************/
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
                
                   Align_serializer_a,
                   Align_serializer_b,
                   Align_serializer_c,
                   Align_serializer_d,
                   RDATA_A,
                   RDATA_B,
                   RDATA_C,
                   RDATA_D,                  
                   Rclk_o);

  // Input
  input CAM_CLKOUT_N;
  input CAM_CLKOUT_P;
  input CAM_D0_N;
  input CAM_D0_P;
  input CAM_D1_N;
  input CAM_D1_P;
  input CAM_D2_N;
  input CAM_D2_P;
  input CAM_D3_N;
  input CAM_D3_P;
  input Reset_n;
  input Serial_Clk;
  input parallel_Clk;
  input [6:0] training_pattern;

  // Output
  output Align_serializer_a;
  output Align_serializer_b;
  output Align_serializer_c;
  output Align_serializer_d;
  output[6 : 0] RDATA_B;
  output[6 : 0] RDATA_C;
  output[6 : 0] RDATA_D;
  output[6 : 0] RDATA_A;
  output Rclk_o;

  // Nets
  wire Align_serializer_a_net_0;
  wire Align_serializer_b_net_0;
  wire Align_serializer_c_net_0;
  wire Align_serializer_d_net_0;
  wire Serial_Clk;
  wire parallel_Clk;
  wire CAM_CLKOUT_N;
  wire CAM_CLKOUT_P;
  wire CAM_D0_N;
  wire CAM_D0_P;
  wire CAM_D1_N;
  wire CAM_D1_P;
  wire CAM_D2_N;
  wire CAM_D2_P;
  wire CAM_D3_N;
  wire CAM_D3_P;
  wire DDR_IN_0_QF_0;
  wire DDR_IN_0_QR;
  wire DDR_IN_1_QF;
  wire DDR_IN_1_QR;
  wire DDR_IN_2_QF;
  wire DDR_IN_2_QR;
  wire DDR_IN_3_QF;
  wire DDR_IN_3_QR;
  wire INBUF_DIFF_0_Y;
  wire INBUF_DIFF_1_Y;
  wire INBUF_DIFF_2_Y;
  wire INBUF_DIFF_3_Y;
  wire Reset_n;
  wire[6 : 0] RDATA_B_0_0;
  wire[6 : 0] RDATA_C_0_0;
  wire[6 : 0] RDATA_D_0_0;
  wire[6 : 0] RDATA_A_0_0;
  wire Y_net_0;
  wire Align_serializer_d_net_1;
  wire Align_serializer_a_net_1;
  wire Align_serializer_c_net_1;
  wire Align_serializer_b_net_1;
  wire Y_net_1;
  wire[6 : 0] RDATA_A_0_0_net_0;
  wire[6 : 0] RDATA_D_0_0_net_0;
  wire[6 : 0] RDATA_B_0_0_net_0;
  wire[6 : 0] RDATA_C_0_0_net_0;

  // TiedOff Nets
  wire VCC_net;

  
  
/******************************************************************************************************************************/
/**********************************************Constant assignments************************************************************/
/******************************************************************************************************************************/

  assign VCC_net = 1'b1;

/******************************************************************************************************************************/
/*********************************Top level output port assignments************************************************************/
/******************************************************************************************************************************/
  assign Align_serializer_d_net_1 = Align_serializer_d_net_0;
  assign Align_serializer_d = Align_serializer_d_net_1;
  assign Align_serializer_a_net_1 = Align_serializer_a_net_0;
  assign Align_serializer_a = Align_serializer_a_net_1;
  assign Align_serializer_c_net_1 = Align_serializer_c_net_0;
  assign Align_serializer_c = Align_serializer_c_net_1;
  assign Align_serializer_b_net_1 = Align_serializer_b_net_0;
  assign Align_serializer_b = Align_serializer_b_net_1;
  assign Y_net_1 = Y_net_0;
  assign Rclk_o = Y_net_1;
  assign RDATA_A_0_0_net_0 = RDATA_A_0_0;
  assign RDATA_A[6 : 0] = RDATA_A_0_0_net_0;
  assign RDATA_D_0_0_net_0 = RDATA_D_0_0;
  assign RDATA_D[6 : 0] = RDATA_D_0_0_net_0;
  assign RDATA_B_0_0_net_0 = RDATA_B_0_0;
  assign RDATA_B[6 : 0] = RDATA_B_0_0_net_0;
  assign RDATA_C_0_0_net_0 = RDATA_C_0_0;
  assign RDATA_C[6 : 0] = RDATA_C_0_0_net_0;

  //DDR_IN
  DDR_IN DDR_IN_0(
                  // Inputs
                  .D(INBUF_DIFF_3_Y),
                  .CLK(Serial_Clk),
                  .EN(VCC_net),
                  .ALn(VCC_net),
                  .ADn(VCC_net),
                  .SLn(VCC_net),
                  .SD(VCC_net),
                  // Outputs
                  .QR(DDR_IN_0_QR),
                  .QF(DDR_IN_0_QF_0));
  //DDR_IN
  DDR_IN DDR_IN_1(
                  // Inputs
                  .D(INBUF_DIFF_0_Y),
                  .CLK(Serial_Clk),
                  .EN(VCC_net),
                  .ALn(VCC_net),
                  .ADn(VCC_net),
                  .SLn(VCC_net),
                  .SD(VCC_net),
                  // Outputs
                  .QR(DDR_IN_1_QR),
                  .QF(DDR_IN_1_QF));
  //DDR_IN
  DDR_IN DDR_IN_2(
                  // Inputs
                  .D(INBUF_DIFF_1_Y),
                  .CLK(Serial_Clk),
                  .EN(VCC_net),
                  .ALn(VCC_net),
                  .ADn(VCC_net),
                  .SLn(VCC_net),
                  .SD(VCC_net),
                  // Outputs
                  .QR(DDR_IN_2_QR),
                  .QF(DDR_IN_2_QF));
  //DDR_IN
  DDR_IN DDR_IN_3(
                  // Inputs
                  .D(INBUF_DIFF_2_Y),
                  .CLK(Serial_Clk),
                  .EN(VCC_net),
                  .ALn(VCC_net),
                  .ADn(VCC_net),
                  .SLn(VCC_net),
                  .SD(VCC_net),
                  // Outputs
                  .QR(DDR_IN_3_QR),
                  .QF(DDR_IN_3_QF));
  //INBUF_DIFF
  INBUF_DIFF INBUF_DIFF_0(
                          // Inputs
                          .PADP(CAM_D1_P),
                          .PADN(CAM_D1_N),
                          // Outputs
                          .Y(INBUF_DIFF_0_Y));
  //INBUF_DIFF
  INBUF_DIFF INBUF_DIFF_1(
                          // Inputs
                          .PADP(CAM_D2_P),
                          .PADN(CAM_D2_N),
                          // Outputs
                          .Y(INBUF_DIFF_1_Y));
  //INBUF_DIFF
  INBUF_DIFF INBUF_DIFF_2(
                          // Inputs
                          .PADP(CAM_D3_P),
                          .PADN(CAM_D3_N),
                          // Outputs
                          .Y(INBUF_DIFF_2_Y));
  //INBUF_DIFF
  INBUF_DIFF INBUF_DIFF_3(
                          // Inputs
                          .PADP(CAM_D0_P),
                          .PADN(CAM_D0_N),
                          // Outputs
                          .Y(INBUF_DIFF_3_Y));
  //INBUF_DIFF
  INBUF_DIFF INBUF_DIFF_4(
                          // Inputs
                          .PADP(CAM_CLKOUT_P),
                          .PADN(CAM_CLKOUT_N),
                          // Outputs
                          .Y(Y_net_0));
  //RX_TOP
  RX_TOP RX_TOP_0(
                  // Inputs
                  .resetn(Reset_n),
                  .serial_clk(Serial_Clk),
                  .parallel_clk(parallel_Clk),
                  .input_rising_c(DDR_IN_2_QR),
                  .input_falling_c(DDR_IN_2_QF),
                  .input_rising_d(DDR_IN_3_QR),
                  .input_falling_d(DDR_IN_3_QF),
                  .input_rising_b(DDR_IN_1_QR),
                  .input_falling_b(DDR_IN_1_QF),
                  .input_rising_a(DDR_IN_0_QR),
                  .input_falling_a(DDR_IN_0_QF_0),
                  .training_pattern(training_pattern),
                  // Outputs
                  .Align_serializer_a(Align_serializer_a_net_0),
                  .Align_serializer_b(Align_serializer_b_net_0),
                  .Align_serializer_c(Align_serializer_c_net_0),
                  .Align_serializer_d(Align_serializer_d_net_0),
                  .RDATA_A(RDATA_A_0_0),
                  .RDATA_B(RDATA_B_0_0),
                  .RDATA_C(RDATA_C_0_0),
                  .RDATA_D(RDATA_D_0_0));
endmodule
