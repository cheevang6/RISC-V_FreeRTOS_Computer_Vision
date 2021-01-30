 /*****************************************************************************************************************************
--
--    File Name    : RX_TOP.v 

--    Description  : This module implements LVDS7_1 Reciever Top block

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
module RX_TOP(input wire resetn,
              input wire serial_clk,
              input wire parallel_clk,
              input wire input_rising_c,
              input wire input_falling_c,
              input wire input_rising_d,
              input wire input_falling_d,
              input wire input_rising_b,
              input wire input_falling_b,
              input wire input_rising_a,
              input wire input_falling_a,
              input wire[6 : 0] training_pattern,
              output wire[6 : 0] RDATA_A,
              output wire[6 : 0] RDATA_B,
              output wire[6 : 0] RDATA_C,
              output wire[6 : 0] RDATA_D,
              output wire Align_serializer_a,
              output wire Align_serializer_b,
              output wire Align_serializer_c,
              output wire Align_serializer_d);
  wire[13 : 0] OOI;
  wire[13 : 0] IOI;
  wire[13 : 0] lOI;
  wire[13 : 0] oOI;
  wire iOI;
  wire OII;
  wire III;
  wire lII;
  wire oII;
  wire iII;
  wire OlI;
  wire IlI;
  Deserializer llI(.CLK(serial_clk),
                   .RESET(resetn),
                   .input_rising(input_rising_d),
                   .input_falling(input_falling_d),
                   .training_pattern(training_pattern),
                   .Align_serializer(IlI),
                   .enable(lII),
                   .Data_out(OOI));
  RX_SYNC olI(.WCLK(serial_clk),
              .RESET(resetn),
              .WDATA(OOI),
              .RCLOCK(parallel_clk),
              .enable(lII),
              .align_serializer_i(IlI),
              .align_serializer_o(Align_serializer_d),
              .DATA_OUT(RDATA_D));
  Deserializer ilI(.CLK(serial_clk),
                   .RESET(resetn),
                   .input_rising(input_rising_c),
                   .input_falling(input_falling_c),
                   .training_pattern(training_pattern),
                   .Align_serializer(OlI),
                   .enable(III),
                   .Data_out(lOI));
  RX_SYNC O0I(.WCLK(serial_clk),
              .RESET(resetn),
              .WDATA(lOI),
              .RCLOCK(parallel_clk),
              .enable(III),
              .align_serializer_i(OlI),
              .align_serializer_o(Align_serializer_c),
              .DATA_OUT(RDATA_C));
  Deserializer I0I(.CLK(serial_clk),
                   .RESET(resetn),
                   .input_rising(input_rising_b),
                   .input_falling(input_falling_b),
                   .training_pattern(training_pattern),
                   .Align_serializer(iII),
                   .enable(OII),
                   .Data_out(IOI));
  RX_SYNC l0I(.WCLK(serial_clk),
              .RESET(resetn),
              .WDATA(IOI),
              .RCLOCK(parallel_clk),
              .enable(OII),
              .align_serializer_i(iII),
              .align_serializer_o(Align_serializer_b),
              .DATA_OUT(RDATA_B));
  Deserializer o0I(.CLK(serial_clk),
                   .RESET(resetn),
                   .input_rising(input_rising_a),
                   .input_falling(input_falling_a),
                   .training_pattern(training_pattern),
                   .Align_serializer(oII),
                   .enable(iOI),
                   .Data_out(oOI));
  RX_SYNC i0I(.WCLK(serial_clk),
              .RESET(resetn),
              .WDATA(oOI),
              .RCLOCK(parallel_clk),
              .enable(iOI),
              .align_serializer_i(oII),
              .align_serializer_o(Align_serializer_a),
              .DATA_OUT(RDATA_A));
endmodule
