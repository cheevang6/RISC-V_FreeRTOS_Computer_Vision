/*****************************************************************************************************************************
--
--    File Name    : RX_SYNC.v

--    Description  : This Module implements Reciever data synch module after deserialization. 
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
module RX_SYNC(input wire WCLK,
               input wire RESET,
               input wire[13 : 0] WDATA,
               input wire RCLOCK,
               output reg[6 : 0] DATA_OUT,
               input wire align_serializer_i,
               output reg align_serializer_o,
               input wire enable);
  reg[13 : 0] RDATA;
  reg[13 : 0] i1;
  reg[13 : 0] Oo;
  reg[2 : 0] Io;
  reg[6 : 0] lo;
  wire[7 : 0] oo;
  reg io;
  reg Oi;
  wire Ii;
  always
    @(posedge WCLK or
      negedge RESET)
    begin
      if (RESET == 1'b0)
        begin
          lo <= 7'h0;
          Oi <= 1'b0;
        end
      else
        begin
          if (Io == 3'b001)
            begin
              lo <= RDATA[13 : 7];
              Oi <= 1'b1;
            end
          else
            if (Io == 3'b100)
              begin
                lo <= RDATA[6 : 0];
                Oi <= 1'b1;
              end
            else
              begin
                lo <= lo;
                Oi <= 1'b0;
              end
        end
    end
  always
    @(posedge RCLOCK or
      negedge RESET)
    begin
      if (RESET == 1'b0)
        begin
          DATA_OUT <= 7'h0;
          align_serializer_o <= 1'b0;
        end
      else
        begin
          if (!Ii)
            begin
              DATA_OUT <= oo[6 : 0];
              align_serializer_o <= oo[7];
            end
          else
            begin
              DATA_OUT <= 7'h0;
              align_serializer_o <= 1'b0;
            end
        end
    end
  cdcfifo #(.li(5), .oi(8)) ii(.k_lim(5'h1F),
                               .wrrstn(RESET),
                               .wrsrst(1'b0),
                               .wrclk(WCLK),
                               .wrreq(Oi),
                               .wrdata({ align_serializer_i, lo }),
                               .wrfull(),
                               .wrusedw(),
                               .rdrstn(RESET),
                               .rdclk(RCLOCK),
                               .rdsrst(1'b0),
                               .rdreq(~Ii),
                               .rddata(oo),
                               .rdempty(Ii),
                               .rdusedw());
  always
    @(posedge WCLK or
      negedge RESET)
    if (RESET == 1'b0)
      begin
        Io <= 3'b000;
      end
    else
      begin
        if (io)
          Io <= 3'b001;
        else
          if (Io >= 3'b001 && Io < 3'b110)
            Io <= Io + 1;
          else
            begin
              Io <= 3'b000;
            end
      end
  always
    @(posedge WCLK or
      negedge RESET)
    begin
      if (RESET == 1'b0)
        begin
          i1 <= 14'h0000;
          io <= 1'b0;
        end
      else
        begin
          i1 <= WDATA;
          io <= enable;
        end
    end
  always
    @(posedge WCLK or
      negedge RESET)
    begin
      if (RESET == 1'b0)
        begin
          Oo <= 14'b0;
        end
      else
        begin
          case (io)
            1'b1:
              Oo <= i1;
            default:
              Oo <= Oo;
          endcase
        end
    end
  always
    @(posedge WCLK or
      negedge RESET)
    begin
      if (RESET == 1'b0)
        begin
          RDATA <= 14'b0;
        end
      else
        begin
          if ((io == 1'b1))
            RDATA <= Oo;
          else
            RDATA <= RDATA;
        end
    end
endmodule
