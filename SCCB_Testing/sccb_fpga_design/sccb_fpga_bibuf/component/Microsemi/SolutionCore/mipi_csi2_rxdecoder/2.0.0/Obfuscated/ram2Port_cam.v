/*****************************************************************************************************************************
--
--    File Name    : ram2port_cam.v

--    Description  : This module is the two port ram for internal fifo
--                   

-- Targeted device                     : Microsemi-SoC
-- Author                              : India Solutions Team

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

module ram2port_cam #(parameter g_BUFF_AWIDTH = 10,
                      parameter g_DWIDTH = 64,
                      parameter BUFF_DEPTH = 1920)
                    (input wclock,
                     input rclock,
                     input we,
                     input[g_BUFF_AWIDTH - 1 : 0] rd_addr,
                     input[g_BUFF_AWIDTH - 1 : 0] wr_addr,
                     input[g_DWIDTH - 1 : 0] wr_data_i,
                     output wire[g_DWIDTH - 1 : 0] rd_data_o);
  reg[g_BUFF_AWIDTH - 1 : 0] l1l;
  reg[g_DWIDTH - 1 : 0] o1l[0 : BUFF_DEPTH - 1]/* synthesis syn_ramstyle="uram" */;
  always
    @(posedge wclock)
    begin
      if (we)
        begin
          o1l[wr_addr] <= wr_data_i;
        end
    end
  always
    @(posedge rclock)
    begin
      l1l <= rd_addr;
    end
  assign rd_data_o = o1l[l1l];
endmodule
