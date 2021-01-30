/*****************************************************************************************************************************
--
--    File Name    : Deserializer.v 

--    Description  : This module implements deserializer which converts serial data in to parallel

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
module Deserializer(input wire CLK,
                    input wire RESET,
                    input wire input_rising,
                    input wire input_falling,
                    input wire[6 : 0] training_pattern,
                    output reg[13 : 0] Data_out,
                    output wire enable,
                    output wire Align_serializer);
  parameter O = 0,
            I = 1,
            l = 2,
            o = 3,
            i = 4,
            OI = 5,
            II = 6,
            lI = 7;
  parameter oI = 0,
            iI = 1,
            Ol = 2,
            Il = 3,
            ll = 4,
            ol = 5,
            il = 6;
  reg[3 : 0] O0;
  reg[3 : 0] I0;
  reg[13 : 0] l0;
  reg o0;
  reg i0;
  reg[1 : 0] O1;
  reg[13 : 0] I1;
  assign Align_serializer = O1[1];
  always
    @(posedge CLK or
      negedge RESET)
    begin
      if (RESET == 1'b0)
        begin
          I1 <= 14'd0;
          i0 <= 1'b0;
        end
      else
        begin
          i0 <= input_rising;
          I1 <= { I1[11 : 0], i0, input_falling };
        end
    end
  always
    @(posedge (CLK) or
      negedge (RESET))
    if (!RESET)
      begin
        O0 <= O;
        O1 <= 2'b00;
      end
    else
      begin
        case (O0)
          O:
            begin
              if (I1[1 : 0] == training_pattern[6 : 5])
                begin
                  O0 <= I;
                end
              else
                begin
                  O0 <= O;
                end
            end
          I:
            begin
              if (I1[3 : 0] == training_pattern[6 : 3])
                begin
                  O0 <= l;
                end
              else
                begin
                  O0 <= O;
                end
            end
          l:
            begin
              if (I1[5 : 0] == training_pattern[6 : 1])
                begin
                  O0 <= o;
                end
              else
                begin
                  O0 <= O;
                end
            end
          o:
            begin
              if (I1[7 : 0] == { training_pattern[6 : 0], training_pattern[6] })
                begin
                  O0 <= i;
                end
              else
                begin
                  O0 <= O;
                end
            end
          i:
            begin
              if (I1[9 : 0] == { training_pattern[6 : 0], training_pattern[6 : 4] })
                begin
                  O0 <= OI;
                end
              else
                begin
                  O0 <= O;
                end
            end
          OI:
            begin
              if (I1[11 : 0] == { training_pattern[6 : 0], training_pattern[6 : 2] })
                begin
                  O0 <= II;
                end
              else
                begin
                  O0 <= O;
                end
            end
          II:
            begin
              if (I1[13 : 0] == { training_pattern[6 : 0], training_pattern[6 : 0] })
                begin
                  O0 <= lI;
                end
              else
                begin
                  O0 <= O;
                end
            end
          lI:
            begin
              O0 <= lI;
              O1 <= 2'b10;
            end
          default:
            O0 <= O;
        endcase
      end
  always
    @(posedge CLK or
      negedge RESET)
    begin
      if (RESET == 1'b0)
        begin
          I0 <= 4'h0;
          l0 <= 14'h0;
          o0 <= 1'b0;
        end
      else
        begin
          if (O1 == 2'b10)
            begin
              l0 <= I1[13 : 0];
              case (I0)
                oI:
                  begin
                    I0 <= 4'h1;
                    o0 <= 1'b0;
                  end
                iI:
                  begin
                    I0 <= 4'h2;
                    o0 <= 1'b0;
                  end
                Ol:
                  begin
                    I0 <= 4'h3;
                    o0 <= 1'b0;
                  end
                Il:
                  begin
                    I0 <= 4'h4;
                    o0 <= 1'b0;
                  end
                ll:
                  begin
                    I0 <= 4'h5;
                    o0 <= 1'b0;
                  end
                ol:
                  begin
                    I0 <= 4'h6;
                    o0 <= 1'b1;
                  end
                il:
                  begin
                    I0 <= 4'h0;
                    o0 <= 1'b0;
                  end
                default:
                  begin
                    I0 <= 4'h0;
                    o0 <= 1'b0;
                  end
              endcase
            end
        end
    end
  assign enable = o0;
  always
    @(posedge CLK or
      negedge RESET)
    begin
      if (RESET == 1'b0)
        begin
          Data_out <= 14'h0;
        end
      else
        begin
          if (o0)
            Data_out <= l0;
          else
            Data_out <= Data_out;
        end
    end
endmodule
