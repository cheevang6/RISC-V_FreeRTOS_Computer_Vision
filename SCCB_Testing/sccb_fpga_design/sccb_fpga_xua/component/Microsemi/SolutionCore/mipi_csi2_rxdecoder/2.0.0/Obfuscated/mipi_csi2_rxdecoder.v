/*****************************************************************************************************************************
--
--    File Name    : mipi_csi2_rxdecoder.v 

--    Description  : This module implements High Speed Data decoding of MIPI CSI-2 interface.


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
`timescale 1ns/1ps
module mipi_csi2_rxdecoder #(
							 //Width of input/output data : currently supports 8-bit only
							 parameter g_DATAWIDTH = 8,
							 //Choose to invert the incoming input data
                             parameter g_INPUT_DATA_INVERT = 1,// 1 : implies invert the incoming data
															   // 0: do not invert the incoming data
                             //Buffer Depth of FIFO
							 parameter g_BUFF_DEPTH = 1280)
                           (input CAM_CLOCK_I,
                            input READ_CLOCK_I,
                            input RESET_n_I,
                            input[2 : 0] Num_of_Lanes_i,
                            input wire[g_DATAWIDTH - 1 : 0] ChannelA_i,
                            input wire[g_DATAWIDTH - 1 : 0] ChannelB_i,
                            input wire[g_DATAWIDTH - 1 : 0] ChannelC_i,
                            input wire[g_DATAWIDTH - 1 : 0] ChannelD_i,
                            output wire[g_DATAWIDTH - 1 : 0] data_out_o,
                            output reg[15 : 0] word_count_o,
                            output wire pixel_valid_o,
                            output reg frame_start_o,
                            output reg frame_end_o,
                            output reg line_start_o,
                            output reg line_end_o,
                            output reg[15 : 0] frame_number_o);
  parameter oi = 16;
  parameter ii = 16'hb800;
  parameter OOI = 16'hb801;
  parameter IOI = 16'hb82a;
  parameter lOI = 8'hb8;
  parameter oOI = 0,
            iOI = 1,
            OII = 2,
            III = 3,
            lII = 4,
            oII = 5,
            iII = 6,
            OlI = 7,
            IlI = 8,
            llI = 9,
            olI = 10,
            ilI = 11,
            O0I = 12,
            I0I = 13,
            l0I = 14,
            o0I = 15;
  parameter i0I = 0,
            O1I = 1,
            I1I = 2,
            l1I = 3,
            o1I = 4;
  parameter i1I = 0,
            OoI = 1,
            IoI = 2;
  reg[7 : 0] loI,
             ooI;
  reg ioI;
  reg OiI;
  reg IiI;
  reg liI;
  reg[7 : 0] oiI;
  reg[7 : 0] iiI,
             OOl,
             IOl,
             lOl;
  reg[15 : 0] oOl;
  reg[7 : 0] iOl;
  reg[7 : 0] OIl;
  reg[g_DATAWIDTH - 1 : 0] IIl;
  reg[3 : 0] lIl;
  reg[oi - 1 : 0] oIl;
  reg[7 : 0] iIl,
             Oll,
             Ill;
  reg[1 : 0] lll;
  reg[2 : 0] oll;
  reg[1 : 0] ill;
  reg O0l;
  reg I0l;
  wire l0l;
  wire o0l;
  wire i0l;
  wire O1l;
  always
    @(posedge CAM_CLOCK_I or
      negedge RESET_n_I)
    begin
      if (!RESET_n_I)
        begin
          ill <= 2'b0;
        end
      else
        begin
          case (Num_of_Lanes_i)
            3'd1:
              begin
                if (ill == 2'd3)
                  ill <= 0;
                else
                  ill <= ill + 1;
              end
            3'd2:
              begin
                if (ill == 2'd1)
                  ill <= 0;
                else
                  ill <= ill + 1;
              end
            default:
              ill <= 2'd0;
          endcase
        end
    end
  always
    @(posedge CAM_CLOCK_I or
      negedge RESET_n_I)
    begin
      if (!RESET_n_I)
        begin
          I0l <= 1'b0;
        end
      else
        begin
          if (ill == 2'd2 || ill == 2'd3 || ill == 2'd1)
            I0l <= 1'd1;
          else
            I0l <= 1'd0;
        end
    end
  always
    @(posedge CAM_CLOCK_I or
      negedge RESET_n_I)
    begin
      if (!RESET_n_I)
        begin
          O0l <= 1'b0;
        end
      else
        begin
          case (Num_of_Lanes_i)
            3'd1:
              begin
                O0l <= I0l;
              end
            3'd2:
              begin
                if (ill == 2'd1)
                  O0l <= 1'd1;
                else
                  O0l <= 1'd0;
              end
            3'd4:
              begin
                O0l <= 1'd0;
              end
            default:
              O0l <= 1'd0;
          endcase
        end
    end
  always
    @(posedge CAM_CLOCK_I or
      negedge RESET_n_I)
    begin
      if (!RESET_n_I)
        begin
          iiI <= 8'd0;
        end
      else
        if (!O0l)
          begin
            if (g_INPUT_DATA_INVERT)
              iiI <= { ChannelA_i[0], ChannelA_i[1], ChannelA_i[2], ChannelA_i[3], ChannelA_i[4], ChannelA_i[5], ChannelA_i[6], ChannelA_i[7] };
            else
              iiI <= ChannelA_i;
          end
    end
  always
    @(posedge CAM_CLOCK_I or
      negedge RESET_n_I)
    begin
      if (!RESET_n_I)
        OOl <= 8'd0;
      else
        if (!O0l)
          begin
            if (g_INPUT_DATA_INVERT)
              OOl <= { ChannelB_i[0], ChannelB_i[1], ChannelB_i[2], ChannelB_i[3], ChannelB_i[4], ChannelB_i[5], ChannelB_i[6], ChannelB_i[7] };
            else
              OOl <= ChannelB_i;
          end
    end
  always
    @(posedge CAM_CLOCK_I or
      negedge RESET_n_I)
    begin
      if (!RESET_n_I)
        begin
          IOl <= 8'd0;
        end
      else
        if (!O0l)
          begin
            if (g_INPUT_DATA_INVERT)
              IOl <= { ChannelC_i[0], ChannelC_i[1], ChannelC_i[2], ChannelC_i[3], ChannelC_i[4], ChannelC_i[5], ChannelC_i[6], ChannelC_i[7] };
            else
              IOl <= ChannelC_i;
          end
    end
  always
    @(posedge CAM_CLOCK_I or
      negedge RESET_n_I)
    begin
      if (!RESET_n_I)
        lOl <= 8'd0;
      else
        if (!O0l)
          begin
            if (g_INPUT_DATA_INVERT)
              lOl <= { ChannelD_i[0], ChannelD_i[1], ChannelD_i[2], ChannelD_i[3], ChannelD_i[4], ChannelD_i[5], ChannelD_i[6], ChannelD_i[7] };
            else
              lOl <= ChannelD_i;
          end
    end
  always
    @(posedge CAM_CLOCK_I or
      negedge RESET_n_I)
    begin
      if (!RESET_n_I)
        begin
          Ill <= 8'b0;
        end
      else
        if (!O0l)
          begin
            if (Num_of_Lanes_i == 1)
              begin
                Ill <= iiI;
              end
            else
              Ill <= 8'b0;
          end
    end
  always
    @(posedge CAM_CLOCK_I or
      negedge RESET_n_I)
    begin
      if (!RESET_n_I)
        begin
          lll <= 2'b0;
          Oll <= 8'b0;
        end
      else
        if (!O0l)
          begin
            case (lll)
              i1I:
                begin
                  if (Num_of_Lanes_i == 2 && iiI == lOI && OOl == lOI)
                    begin
                      Oll <= iiI;
                      lll <= IoI;
                    end
                  else
                    begin
                      Oll <= 0;
                      lll <= i1I;
                    end
                end
              OoI:
                begin
                  Oll <= iiI;
                  lll <= IoI;
                end
              IoI:
                begin
                  Oll <= OOl;
                  lll <= OoI;
                end
              default:
                lll <= 2'b0;
            endcase
          end
    end
  always
    @(posedge CAM_CLOCK_I or
      negedge RESET_n_I)
    begin
      if (!RESET_n_I)
        begin
          oll <= 3'b0;
          iIl <= 8'b0;
        end
      else
        if (!O0l)
          begin
            case (oll)
              i0I:
                begin
                  if (iiI == lOI && OOl == lOI && IOl == lOI && lOl == lOI && Num_of_Lanes_i == 4)
                    begin
                      iIl <= iiI;
                      oll <= I1I;
                    end
                  else
                    begin
                      iIl <= 0;
                      oll <= i0I;
                    end
                end
              O1I:
                begin
                  iIl <= iiI;
                  oll <= I1I;
                end
              I1I:
                begin
                  iIl <= OOl;
                  oll <= l1I;
                end
              l1I:
                begin
                  iIl <= IOl;
                  oll <= o1I;
                end
              o1I:
                begin
                  iIl <= lOl;
                  oll <= O1I;
                end
              default:
                oll <= 3'b0;
            endcase
          end
    end
  always
    @(posedge CAM_CLOCK_I or
      negedge RESET_n_I)
    begin
      if (!RESET_n_I)
        begin
          IIl <= 8'b0;
        end
      else
        if (!O0l)
          begin
            case (Num_of_Lanes_i)
              3'd1:
                IIl <= Ill;
              3'd2:
                IIl <= Oll;
              3'd4:
                IIl <= iIl;
              default:
                IIl <= Ill;
            endcase
          end
    end
  always
    @(posedge CAM_CLOCK_I or
      negedge RESET_n_I)
    begin
      if (!RESET_n_I)
        begin
          oIl <= 16'b0;
        end
      else
        if (!O0l)
          begin
            oIl <= { oIl[oi - 9 : 0], IIl[7 : 0] };
          end
    end
  always
    @(posedge CAM_CLOCK_I or
      negedge RESET_n_I)
    begin
      if (!RESET_n_I)
        begin
          lIl <= 4'b0;
          ioI <= 1'b0;
          OiI <= 1'b0;
          IiI <= 1'b0;
          liI <= 1'b0;
          oOl <= 16'b0;
          ooI <= 8'd0;
          loI <= 8'd0;
          frame_number_o <= 16'd0;
          iOl <= 8'd0;
          OIl <= 8'd0;
          word_count_o <= 16'hFFFF;
          oiI <= 8'd0;
        end
      else
        if (!O0l)
          begin
            case (lIl)
              oOI:
                begin
                  if (oIl == ii)
                    begin
                      ioI <= 1;
                      lIl <= iOI;
                    end
                  else
                    lIl <= oOI;
                end
              iOI:
                begin
                  lIl <= OII;
                  ioI <= 0;
                  loI <= oIl[7 : 0];
                end
              OII:
                begin
                  lIl <= III;
                  ioI <= 0;
                  ooI <= oIl[7 : 0];
                end
              III:
                begin
                  lIl <= lII;
                  ioI <= 0;
                  frame_number_o <= { ooI, loI };
                end
              lII:
                begin
                  if (oIl == OOI)
                    begin
                      OiI <= 1;
                      lIl <= O0I;
                      IiI <= 0;
                      ioI <= 0;
                    end
                  else
                    if (oIl == IOI)
                      begin
                        liI <= 0;
                        lIl <= oII;
                        IiI <= 1'b1;
                      end
                    else
                      begin
                        liI <= 0;
                        lIl <= lII;
                        IiI <= 0;
                      end
                end
              oII:
                begin
                  IiI <= 0;
                  iOl <= oIl[7 : 0];
                  lIl <= iII;
                end
              iII:
                begin
                  IiI <= 0;
                  OIl <= oIl[7 : 0];
                  lIl <= OlI;
                end
              OlI:
                begin
                  word_count_o <= { OIl, iOl };
                  lIl <= IlI;
                end
              IlI:
                begin
                  if (oOl < word_count_o)
                    begin
                      oOl <= oOl + 1;
                      liI <= 1;
                      oiI <= oIl[7 : 0];
                      lIl <= IlI;
                    end
                  else
                    begin
                      oOl <= 0;
                      liI <= 0;
                      oiI <= 0;
                      lIl <= llI;
                    end
                end
              llI:
                begin
                  lIl <= olI;
                end
              olI:
                begin
                  lIl <= ilI;
                end
              ilI:
                begin
                  lIl <= lII;
                end
              O0I:
                begin
                  OiI <= 0;
                  lIl <= I0I;
                  ioI <= 1'b0;
                end
              I0I:
                begin
                  lIl <= l0I;
                end
              l0I:
                begin
                  lIl <= o0I;
                end
              o0I:
                begin
                  lIl <= oOI;
                end
              default:
                lIl <= oOI;
            endcase
          end
        else
          begin
            liI <= 0;
            OiI <= 0;
            ioI <= 0;
            IiI <= 0;
          end
    end
  always
    @(posedge (READ_CLOCK_I) or
      negedge (RESET_n_I))
    begin
      if (!RESET_n_I)
        begin
          frame_start_o <= 1'd0;
        end
      else
        begin
          frame_start_o <= O1l;
        end
    end
  always
    @(posedge (READ_CLOCK_I) or
      negedge (RESET_n_I))
    begin
      if (!RESET_n_I)
        begin
          line_end_o <= 1'd0;
        end
      else
        begin
          line_end_o <= l0l;
        end
    end
  always
    @(posedge (READ_CLOCK_I) or
      negedge (RESET_n_I))
    begin
      if (!RESET_n_I)
        begin
          frame_end_o <= 1'd0;
        end
      else
        begin
          frame_end_o <= i0l;
        end
    end
  always
    @(posedge (READ_CLOCK_I) or
      negedge (RESET_n_I))
    begin
      if (!RESET_n_I)
        begin
          line_start_o <= 1'd0;
        end
      else
        begin
          line_start_o <= o0l;
        end
    end
  cdc_fifo_logic #(.g_DATAWIDTH(g_DATAWIDTH), .g_BUFF_DEPTH(g_BUFF_DEPTH)) I1l(.CAM_CLOCK_I(CAM_CLOCK_I),
                                                                               .READ_CLOCK_I(READ_CLOCK_I),
                                                                               .RESET_n_I(RESET_n_I),
                                                                               .pixel_in_i(oiI),
                                                                               .pixel_in_vld_i(liI),
                                                                               .frame_done_i(OiI),
                                                                               .frame_start_i(ioI),
                                                                               .word_count_i(word_count_o),
                                                                               .line_start_i(IiI),
                                                                               .pixel_out_o(data_out_o),
                                                                               .pixel_vld_o(pixel_valid_o),
                                                                               .line_start_o(o0l),
                                                                               .frame_start_o(O1l),
                                                                               .line_done_o(l0l),
                                                                               .frame_done_o(i0l));
endmodule
