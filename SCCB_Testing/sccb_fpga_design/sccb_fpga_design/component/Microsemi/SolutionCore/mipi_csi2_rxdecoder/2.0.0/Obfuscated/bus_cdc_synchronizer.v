/*****************************************************************************************************************************
--
--    File Name    : bus_cdc_synchronizer.v

--    Description  : This module implements CDC synchronizer for buses
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

`timescale 1ns/1ps
module bus_cdc_synchronizer     #(parameter g_BUS_WIDTH = 32)
                                (input wire DEST_CLOCK_I,
                                 input wire[(g_BUS_WIDTH - 1) : 0] input_bus_i,
                                 output reg[(g_BUS_WIDTH - 1) : 0] output_bus_o);
  wire[(g_BUS_WIDTH - 1) : 0] O;
  reg[(g_BUS_WIDTH - 1) : 0] I,
                             l;
  integer o;
  assign O = (input_bus_i >> 1) ^ input_bus_i;
  always
    @(posedge DEST_CLOCK_I)
    begin
      I <= O;
      l <= I;
    end
  always
    @(l)
    begin
      for (o = 0; o < g_BUS_WIDTH; o = o + 1)
        begin
          output_bus_o[o] = ^(l >> o);
        end
    end
endmodule
