/*****************************************************************************************************************************
--
--    File Name    : cdc_fifo_logic.v

--    Description  : This module passes the valid input data and control signals from write clock domian to read clock domain.
--                   

-- Targeted device : Microsemi-SoC
-- Author          : India Solutions Team

-- SVN Revision Information:
-- SVN $Revision: TBD
-- SVN $Date: TBD
--
--
--
-- COPYRIGHT 2017 BY MICROSEMI 
-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS 
-- FROM MICROSEMI CORP.  IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM 
-- MICROSEMI FOR USE OF THIS FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND 
-- NO BACK-UP OF THE FILE SHOULD BE MADE. 
-- 

--******************************************************************************************************************************/

`timescale 1ns/1ps
module cdc_fifo_logic #(parameter g_DATAWIDTH = 8,
                        parameter g_BUFF_DEPTH = 1280)
                      (input wire CAM_CLOCK_I,
                       input wire READ_CLOCK_I,
                       input wire RESET_n_I,
                       input wire[(g_DATAWIDTH - 1) : 0] pixel_in_i,
                       input wire pixel_in_vld_i,
                       input wire frame_done_i,
                       input wire frame_start_i,
                       input wire[15 : 0] word_count_i,
                       input wire line_start_i,
                       output reg[(g_DATAWIDTH - 1) : 0] pixel_out_o,
                       output reg pixel_vld_o,
                       output wire line_start_o,
                       output wire frame_start_o,
                       output reg line_done_o,
                       output wire frame_done_o);
  reg OI,
      II;
  reg[(g_DATAWIDTH - 1) : 0] lI;
  reg[15 : 0] oI;
  reg[15 : 0] iI;
  reg[15 : 0] Ol;
  wire[15 : 0] Il;
  reg ll;
  reg ol;
  wire[(g_DATAWIDTH - 1) : 0] il;
  reg O0;
  reg I0;
  reg l0,
      o0,
      i0;
  wire O1;
  reg I1,
      l1,
      o1;
  wire i1;
  reg Oo,
      Io,
      lo;
  wire oo;
  wire[15 : 0] io;
  assign O1 = line_start_i ? ~I1 : I1;
  always
    @(posedge (CAM_CLOCK_I) or
      negedge (RESET_n_I))
    begin
      if (!RESET_n_I)
        begin
          I1 <= 1'd0;
        end
      else
        begin
          I1 <= O1;
        end
    end
  always
    @(posedge (READ_CLOCK_I) or
      negedge (RESET_n_I))
    begin
      if (!RESET_n_I)
        begin
          l1 <= 1'd0;
        end
      else
        begin
          l1 <= I1;
        end
    end
  always
    @(posedge (READ_CLOCK_I) or
      negedge (RESET_n_I))
    begin
      if (!RESET_n_I)
        begin
          o1 <= 1'd0;
        end
      else
        begin
          o1 <= l1;
        end
    end
  assign line_start_o = o1 ^ l1;
  assign i1 = frame_done_i ? ~Oo : Oo;
  always
    @(posedge (CAM_CLOCK_I) or
      negedge (RESET_n_I))
    begin
      if (!RESET_n_I)
        begin
          Oo <= 1'd0;
        end
      else
        begin
          Oo <= i1;
        end
    end
  always
    @(posedge (READ_CLOCK_I) or
      negedge (RESET_n_I))
    begin
      if (!RESET_n_I)
        begin
          Io <= 1'd0;
        end
      else
        begin
          Io <= Oo;
        end
    end
  always
    @(posedge (READ_CLOCK_I) or
      negedge (RESET_n_I))
    begin
      if (!RESET_n_I)
        begin
          lo <= 1'd0;
        end
      else
        begin
          lo <= Io;
        end
    end
  assign frame_done_o = lo ^ Io;
  assign oo = frame_start_i ? ~l0 : l0;
  always
    @(posedge (CAM_CLOCK_I) or
      negedge (RESET_n_I))
    begin
      if (!RESET_n_I)
        begin
          l0 <= 1'd0;
        end
      else
        begin
          l0 <= oo;
        end
    end
  always
    @(posedge (READ_CLOCK_I) or
      negedge (RESET_n_I))
    begin
      if (!RESET_n_I)
        begin
          o0 <= 1'd0;
        end
      else
        begin
          o0 <= l0;
        end
    end
  always
    @(posedge (READ_CLOCK_I) or
      negedge (RESET_n_I))
    begin
      if (!RESET_n_I)
        begin
          i0 <= 1'd0;
        end
      else
        begin
          i0 <= o0;
        end
    end
  assign frame_start_o = i0 ^ o0;
  always
    @(posedge (CAM_CLOCK_I) or
      negedge (RESET_n_I))
    begin
      if (!RESET_n_I)
        begin
          O0 <= 1'b0;
          I0 <= 1'b0;
        end
      else
        begin
          O0 <= frame_start_i;
          I0 <= line_start_i;
        end
    end
  always
    @(posedge (CAM_CLOCK_I) or
      negedge (RESET_n_I))
    begin
      if (!RESET_n_I)
        begin
          lI <= 8'd0;
        end
      else
        begin
          if (I0 == 1'b1 || O0 == 1'b1)
            begin
              lI <= 8'd0;
            end
          else
            begin
              if (pixel_in_vld_i == 1'b1)
                begin
                  lI <= pixel_in_i;
                end
            end
        end
    end
  always
    @(posedge (CAM_CLOCK_I) or
      negedge (RESET_n_I))
    begin
      if (!RESET_n_I)
        begin
          oI <= 16'hFFFF;
        end
      else
        begin
          if (I0 == 1'b1 || O0 == 1'b1)
            begin
              oI <= 16'd0;
            end
          else
            if (oI < (io) && pixel_in_vld_i == 1'b1)
              begin
                oI <= oI + 1'b1;
              end
        end
    end
  always
    @(posedge (CAM_CLOCK_I) or
      negedge (RESET_n_I))
    begin
      if (!RESET_n_I)
        begin
          ll <= 1'b0;
        end
      else
        begin
          if (oI < (io) && pixel_in_vld_i == 1'b1)
            begin
              ll <= 1'b1;
            end
          else
            begin
              ll <= 1'b0;
            end
        end
    end
  always
    @(posedge (CAM_CLOCK_I) or
      negedge (RESET_n_I))
    begin
      if (!RESET_n_I)
        begin
          iI <= 16'hFFFF;
        end
      else
        begin
          iI <= oI;
        end
    end
  always
    @(posedge (READ_CLOCK_I) or
      negedge (RESET_n_I))
    begin
      if (!RESET_n_I)
        begin
          ol <= 1'b0;
        end
      else
        begin
          if (Ol <= ((io) - 1))
            begin
              ol <= 1'b1;
            end
          else
            begin
              ol <= 1'b0;
            end
        end
    end
  always
    @(posedge (READ_CLOCK_I) or
      negedge (RESET_n_I))
    begin
      if (!RESET_n_I)
        begin
          OI <= 1'b0;
        end
      else
        begin
          if (Ol == (io - 1))
            begin
              OI <= 1'b1;
            end
          else
            begin
              OI <= 1'b0;
            end
        end
    end
  always
    @(posedge (READ_CLOCK_I) or
      negedge (RESET_n_I))
    begin
      if (!RESET_n_I)
        begin
          II <= 1'd0;
          line_done_o <= 1'b0;
        end
      else
        begin
          line_done_o <= II;
          II <= OI;
        end
    end
  always
    @(posedge (READ_CLOCK_I) or
      negedge (RESET_n_I))
    begin
      if (!RESET_n_I)
        begin
          Ol <= 16'hFFFF;
        end
      else
        begin
          if (Ol <= (io - 1))
            begin
              Ol <= Ol + 1'd1;
            end
          else
            begin
              if (Il == (io - 16'd100))
                begin
                  Ol <= 16'd0;
                end
            end
        end
    end
  ram2port_cam #(.g_BUFF_AWIDTH(16), .g_DWIDTH(g_DATAWIDTH), .BUFF_DEPTH(g_BUFF_DEPTH)) Oi(.wr_data_i(lI),
                                                                                           .rd_addr(Ol),
                                                                                           .wr_addr(iI),
                                                                                           .we(ll),
                                                                                           .wclock(CAM_CLOCK_I),
                                                                                           .rclock(READ_CLOCK_I),
                                                                                           .rd_data_o(il));
  bus_cdc_synchronizer #(.g_BUS_WIDTH(16)) Ii(.input_bus_i(iI),
                                                  .output_bus_o(Il),
                                                  .DEST_CLOCK_I(READ_CLOCK_I));
  bus_cdc_synchronizer #(.g_BUS_WIDTH(16)) li(.input_bus_i(word_count_i),
                                                  .output_bus_o(io),
                                                  .DEST_CLOCK_I(READ_CLOCK_I));
  always
    @(posedge READ_CLOCK_I or
      negedge RESET_n_I)
    begin
      if (!RESET_n_I)
        begin
          pixel_out_o <= { g_DATAWIDTH { 1'b0 } };
          pixel_vld_o <= 1'b0;
        end
      else
        begin
          pixel_out_o <= il;
          pixel_vld_o <= ol;
        end
    end
endmodule
