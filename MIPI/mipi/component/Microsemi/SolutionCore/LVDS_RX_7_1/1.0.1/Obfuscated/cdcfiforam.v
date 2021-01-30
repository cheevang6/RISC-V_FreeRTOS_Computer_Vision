/*****************************************************************************************************************************
--
--    File Name    : cdcfiforam.v

--    Description  : This block implements the RAM used for Clock domain Crossing fifo.
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
module cdcfiforam(data,
                  wren,
                  wraddress,
                  rdaddress,
                  wrclock,
                  rdclock,
                  q);
  parameter li = 4;
  parameter oi = 32;
  input[(oi - 1) : 0] data;
  input wren;
  input[(li - 1) : 0] wraddress;
  input[(li - 1) : 0] rdaddress;
  input wrclock;
  input rdclock;
  output[(oi - 1) : 0] q;
  wire[(oi - 1) : 0] q;
  reg[oi - 1 : 0] i1l[0 : 2 ** li - 1];/* synthesis syn_ramstyle = lram */
  reg[li - 1 : 0] oiI;
  reg[li - 1 : 0] lOl;
  reg Ool;
  reg[oi - 1 : 0] Iol;
  always
    @(posedge wrclock)
    begin
      Ool <= wren;
      lOl <= wraddress;
      Iol <= data;
      if (Ool == 1'b1)
        begin
          i1l[lOl] <= Iol;
        end
    end
  always
    @(posedge rdclock)
    begin
      oiI <= rdaddress;
    end
  assign q = i1l[oiI];
endmodule
