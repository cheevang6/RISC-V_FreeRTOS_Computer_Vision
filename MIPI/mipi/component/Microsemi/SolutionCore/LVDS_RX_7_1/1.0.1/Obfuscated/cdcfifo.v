/*****************************************************************************************************************************
--
--    File Name    : cdcfifo.v

--    Description  : This module implements the clock domain crossing fifo.
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
module cdcfifo(k_lim,
               wrrstn,
               wrsrst,
               wrclk,
               wrreq,
               wrdata,
               wrfull,
               wrusedw,
               rdrstn,
               rdclk,
               rdsrst,
               rdreq,
               rddata,
               rdempty,
               rdusedw);
  parameter[3 : 0] li = 4;
  parameter[7 : 0] oi = 74;
  input[li - 1 : 0] k_lim;
  input wrrstn;
  input wrsrst;
  input wrclk;
  input wrreq;
  input[(oi - 1) : 0] wrdata;
  output reg wrfull;
  output[(li - 1) : 0] wrusedw;
  input rdrstn;
  input rdclk;
  input rdsrst;
  input rdreq;
  output[(oi - 1) : 0] rddata;
  output rdempty;
  output reg[(li - 1) : 0] rdusedw;
  parameter[31 : 0] ooI = 32'h00000001;
  parameter[31 : 0] ioI = 32'h00000003;
  wire OiI;
  wire IiI;
  wire liI;
  reg[(li - 1) : 0] oiI;
  reg[(li - 1) : 0] iiI;
  reg[(li - 1) : 0] OOl;
  reg[(li - 1) : 0] IOl;
  reg[(li - 1) : 0] lOl;
  reg[(li - 1) : 0] oOl;
  reg[(li - 1) : 0] iOl;
  reg[(li - 1) : 0] OIl;
  reg[(li - 1) : 0] IIl;
  reg[(li - 1) : 0] lIl;
  reg[(li - 1) : 0] oIl;
  reg[(li - 1) : 0] iIl;
  wire[(li - 2) : 0] Oll;
  assign Oll = { li - 1 { 1'b0 } };
  cdcfiforam #(.li(li), .oi(oi)) Ill(.data(wrdata),
                                     .wren(IiI),
                                     .wraddress(lOl),
                                     .rdaddress(iiI),
                                     .wrclock(wrclk),
                                     .rdclock(rdclk),
                                     .q(rddata));
  always
    @(iOl or
      Oll)
    begin: lll
      reg[(li - 1) : 0] oll;
      reg ill;
      integer O0l;
      integer I0l;
      oll[(li - 1)] = iOl[(li - 1)];
      oll[(li - 2) : 0] = Oll;
      ill = 1'b0;
      for (O0l = 0; O0l <= (li - 1); O0l = O0l + 1)
        begin
          for (I0l = O0l; I0l <= (li - 1); I0l = I0l + 1)
            oll[O0l] = oll[O0l] ^ iOl[I0l];
          IIl[O0l] <= iOl[O0l] ^ ((~ill) & (~oll[O0l]));
          ill = ill | (~oll[O0l]);
        end
    end
  always
    @(negedge wrrstn or
      posedge wrclk)
    begin: l0l
      reg[(li - 1) : 0] o0l;
      reg[(li - 1) : 0] i0l;
      integer O0l;
      if (wrrstn == 1'b0)
        begin
          lOl <= { li { 1'b0 } };
          oOl <= { li { 1'b0 } };
          OIl <= ooI[(li - 1) : 0];
          iOl <= ioI[(li - 1) : 0];
          OOl <= { li { 1'b0 } };
          IOl <= { li { 1'b0 } };
          iIl <= { li { 1'b0 } };
          wrfull <= 1'b0;
          i0l = { li { 1'b0 } };
          o0l = { li { 1'b0 } };
        end
      else
        begin
          if (wrsrst == 1'b1)
            begin
              lOl <= { li { 1'b0 } };
              oOl <= { li { 1'b0 } };
              OIl <= ooI[(li - 1) : 0];
              iOl <= ioI[(li - 1) : 0];
              OOl <= { li { 1'b0 } };
              IOl <= { li { 1'b0 } };
              iIl <= { li { 1'b0 } };
              wrfull <= 1'b0;
              i0l = { li { 1'b0 } };
              o0l = { li { 1'b0 } };
            end
          else
            begin
              if (IiI == 1'b1)
                begin
                  iOl <= IIl;
                  OIl <= iOl;
                  lOl <= OIl;
                end
              oOl <= lOl;
              OOl <= oiI;
              IOl <= OOl;
              o0l[(li - 1)] = oOl[(li - 1)];
              for (O0l = (li - 2); O0l >= 0; O0l = O0l - 1)
                o0l[O0l] = o0l[O0l + 1] ^ oOl[O0l];
              i0l[(li - 1)] = IOl[(li - 1)];
              for (O0l = (li - 2); O0l >= 0; O0l = O0l - 1)
                i0l[O0l] = i0l[O0l + 1] ^ IOl[O0l];
              if (iIl >= k_lim)
                wrfull <= 1'b1;
              else
                wrfull <= 1'b0;
              iIl <= o0l - i0l;
            end
        end
    end
  assign wrusedw = iIl;
  assign IiI = wrreq;
  always
    @(oiI or
      OiI or
      Oll)
    begin: O1l
      reg[(li - 1) : 0] oll;
      reg ill;
      integer O0l;
      integer I0l;
      oll[(li - 1)] = oiI[(li - 1)];
      oll[(li - 2) : 0] = Oll;
      ill = 1'b0;
      for (O0l = 0; O0l <= (li - 1); O0l = O0l + 1)
        begin
          for (I0l = O0l; I0l <= (li - 1); I0l = I0l + 1)
            oll[O0l] = oll[O0l] ^ oiI[I0l];
          iiI[O0l] <= oiI[O0l] ^ (OiI & (~ill) & (~oll[O0l]));
          ill = ill | (~oll[O0l]);
        end
    end
  always
    @(negedge rdrstn or
      posedge rdclk)
    begin: I1l
      reg[(li - 1) : 0] l1l;
      reg[(li - 1) : 0] o1l;
      integer O0l;
      if (rdrstn == 1'b0)
        begin
          oiI <= { li { 1'b0 } };
          lIl <= { li { 1'b0 } };
          oIl <= { li { 1'b0 } };
          rdusedw <= { li { 1'b0 } };
          l1l = { li { 1'b0 } };
          o1l = { li { 1'b0 } };
        end
      else
        begin
          if (rdsrst == 1'b1)
            begin
              oiI <= { li { 1'b0 } };
              lIl <= { li { 1'b0 } };
              oIl <= { li { 1'b0 } };
              rdusedw <= { li { 1'b0 } };
              l1l = { li { 1'b0 } };
              o1l = { li { 1'b0 } };
            end
          else
            begin
              oiI <= iiI;
              lIl <= oOl;
              oIl <= lIl;
              o1l[(li - 1)] = oIl[(li - 1)];
              for (O0l = (li - 2); O0l >= 0; O0l = O0l - 1)
                o1l[O0l] = o1l[O0l + 1] ^ oIl[O0l];
              l1l[(li - 1)] = oiI[(li - 1)];
              for (O0l = (li - 2); O0l >= 0; O0l = O0l - 1)
                l1l[O0l] = l1l[O0l + 1] ^ oiI[O0l];
              rdusedw <= o1l - l1l;
            end
        end
    end
  assign liI = (oIl == oiI) ? 1'b1 : 1'b0;
  assign rdempty = liI;
  assign OiI = rdreq & (~liI);
endmodule
