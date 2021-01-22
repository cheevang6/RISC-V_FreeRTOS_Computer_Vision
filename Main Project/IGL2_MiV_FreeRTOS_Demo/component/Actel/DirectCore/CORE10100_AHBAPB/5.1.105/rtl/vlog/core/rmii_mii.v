`timescale 1 ns / 100 ps
// ********************************************************************/ 
// Actel Corporation Proprietary and Confidential
// Copyright 2013 Microsemi Corporation.  All rights reserved.
//
// ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
// ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED 
// IN ADVANCE IN WRITING.  
//  
// Description: RMII to MII interface
//                     
//
// Revision Information:
// Date     Description
// 18Oct07  Initial Release 
//
//
// Resolved SARs
// SAR      Date     Who   Description
// 77068    05/25/2008 PS   Added the fix for the dribble error & suspected crc error from Hari;
//                          Also replaced CLK_TX_RX clocked circuit with CLK_TX_RX_ENB ("sync RX RMII signals to MII interface");
// 77068    06/03/2008 PS   Added the 2nd fix for the dribble error & suspected crc error from Hari;
//                          This has been verified by WIPRO.
// Notes: 
//        
// *********************************************************************/
module RMII_MII (RMII_CLK, RESETN, SPEED, CRS_DV, RX_ER, 
				RXD, TXD, TX_EN, 
	            CLK_TX_RX,
				MII_TX_EN,
	            MII_TXD, RX_DV, MII_RX_ER, MII_RXD, 
	            CRS, COL );

 // Ports declaration
   input RMII_CLK; // REF. 50 Mhz clock
   input RESETN; // active low reset for RMII clock domain
   input CRS_DV; // Carrier Sense/receive data valid
   input SPEED; // when 0, 10 Mb/s is selected; when 1, 100 Mb/s is selected
   input RX_ER; // PHY detected error from PHY
   input [1:0] RXD; // receive data from PHY
   output [1:0] TXD; // transmit data to PHY
   output TX_EN; // Transmit enable to PHY
   output CLK_TX_RX; // Transmit Clock and Receive Clock
   input MII_TX_EN; // Transmit enable to MAC
   input [3:0] MII_TXD; // transmit data to MAC
   output RX_DV; // Receive data valid signal
   output MII_RX_ER; // PHY detected error to MAC
   output [3:0] MII_RXD; // receive data to MAC
   output CRS;  // Carrier Sense
   output COL; // Collision detected

// State machine parameters 
   localparam[2:0] state0 = 0; 
   localparam[2:0] state1 = 1; 
   localparam[2:0] state2 = 2; 
   localparam[2:0] state3 = 3; 
   localparam[2:0] state4 = 4; 
   localparam[2:0] state5 = 5; 
   localparam[2:0] state6 = 6; 
   localparam[2:0] state7 = 7;

  wire COL;
  wire clktr;
  reg RMII_RX_DV; // Receive data valid signal
  reg RMII_RX_DV_reg; // Receive data valid signal
  reg RMII_RX_DV_0; // Receive data valid signal
  reg RMII_RX_DV_1; // Receive data valid signal
  reg RMII_RX_DV_2; // Receive data valid signal
  reg RMII_RX_DV_3; // Receive data valid signal
  reg RMII_CRS;  // Carrier Sense
  reg RMII_CRS_0; // Receive data valid signal
  reg RMII_CRS_1; // Receive data valid signal
  reg RMII_CRS_2; // Receive data valid signal
  reg RMII_CRS_3; // Receive data valid signal
  reg RMII_CRS_reg;  // Carrier Sense
  reg RX_ER_reg0; // PHY detected error from PHY
  reg RX_ER_reg1; // PHY detected error from PHY
  reg MII_RX_ER_reg0; // PHY detected error from PHY
  reg MII_RX_ER; // PHY detected error from PHY
  reg RX_ER_flag; // PHY detected error from PHY flag
  reg clk_2pt5;
  reg clk_25;
  reg clk_25_next;
  reg clk_2pt5_next;
  reg CLK_TX_RX /* synthesis syn_maxfan=1000 syn_keep=1 */; // Transmit Clock and Receive Clock
  reg CRS_DV_reg;
  reg[3:0] rate_cnt;
  reg[3:0] count;
  reg[3:0] count_next;
  reg[2:0] fifo_present_state; 
  reg[2:0] fifo_next_state;    
  reg [1:0] TXD; // transmit data to MAC
  reg [3:0] TXD_sync0; // transmit data to MAC
  reg [3:0] TXD_sync1; // transmit data to MAC
  reg TX_EN_sync0; // transmit data to MAC Enable RMII interface register
  reg TX_EN_sync1; // transmit data to MAC Enable RMII interface register
  reg TX_EN; // transmit data to MAC Enable
  reg tx_data_en; // rmii tx enable to ping pong data
  reg rx_data_en; // rmii rx enable to ping pong data
  reg[1:0] RXD_reg0; 
  reg[1:0] RXD_reg1; 
  reg[1:0] RXD_reg2; 
  reg[1:0] RXD_reg3; 
  reg[3:0] MII_RXD; 
  reg[3:0] RMII_RXD; 
  reg[3:0] RMII_RXD_reg; 
  reg[3:0] RMII_RXD_reg0; 
  reg[3:0] RMII_RXD_reg1; 
  reg[3:0] RMII_RXD_reg2; 
  reg[3:0] RMII_RXD_reg3; 
  wire RX_DV_EN;
  reg phase_en;
  reg phase_en_int;
  reg phase_en_reg;
  reg RX_DV;
  reg RX_DV_reg;
  reg CRS;
  reg CRS_reg;
  reg [4:0] rx_dv_count;
  reg [3:0] tx_count;
  reg MII_RX_ER0;
  reg RMRESETN;
  
  reg [31:0] preamble_count_next;
  reg [31:0] preamble_count;
  reg  preamble_en;
  reg pream_ok;
  reg pream_ok_reg;
  reg SPEED_SYNC;
  reg SPEED_META;
/************************************************************************/
assign clktr = SPEED_SYNC ? clk_25 : clk_2pt5; // generation of CLKT and CLKR
assign COL = MII_TX_EN & CRS; // generation of COL

// Counters to generate sampling for 25 MHz and 2.5 MHz frequencies
// Generation of 2.5MHz and 25MHz clocks	
always @(rate_cnt or SPEED_SYNC or clk_25 or clk_2pt5)
  begin
      clk_25_next = clk_25 ; 
      clk_2pt5_next = clk_2pt5 ; 
      case (SPEED_SYNC)
        1'b0:
             if (rate_cnt == 4'd9) 
              begin
                clk_2pt5_next = ~clk_2pt5 ; // selects the 10 Mbits/sec rate for 2.5 MHz frequency
              end
        1'b1:
              begin
                clk_25_next = ~clk_25 ; // selects the 100 Mbits/sec rate for 25 MHz frequency
              end
      endcase
  end

// counter
 always @(posedge RMII_CLK or negedge RMRESETN)
   begin
      if (RMRESETN == 1'b0)
       begin
         rate_cnt <= 4'd0 ; 
	 clk_2pt5 <= 1'b0;
	 clk_25 <= 1'b0;
	 SPEED_SYNC <= 1'b0; 
	 SPEED_META <= 1'b0; 
       end
      else 
       begin
	 SPEED_META <= SPEED; 
	 SPEED_SYNC <= SPEED_META; 
	 clk_25 <= clk_25_next;
	 clk_2pt5 <= clk_2pt5_next;
         rate_cnt <= rate_cnt + 1 ; 
         case (SPEED_SYNC)
           1'b0:
           begin
	        if (rate_cnt == 4'd9) 
                 begin
                    rate_cnt <= 4'd0 ; //  10 Mbits/sec rate for 50 MHZ frequency
                     end
           end
           1'b1:
           begin
            if (rate_cnt == 4'd1) 
                 begin
                   rate_cnt <= 4'd0  ; //  100 Mbits/sec rate for 50 MHz frequency 
                   end
     
           end
	 endcase
       end
   end

// Synchronization of 2.5MHz and 25MHz clocks
 always @(negedge RMII_CLK or negedge RMRESETN)
   begin
      if (RMRESETN == 1'b0)
       begin
	 CLK_TX_RX <= 1'b0;
       end
      else
       begin
	 CLK_TX_RX <= clktr; // synchronization of CLKT and CLKR
       end
   end

// Synchronization of RESET
 always @(negedge RMII_CLK )
   begin
     RMRESETN <= RESETN; // synchronization of RESETN to RMRESETN
   end


      //**********************************************************************
   //State machine to generate RMII_CRS and RMII_RX_DV - async portion
   always @(fifo_present_state or CRS_DV_reg or count or SPEED_SYNC or RXD_reg0 or RXD_reg1 or preamble_count or pream_ok_reg or RX_DV or rx_dv_count)
    begin
      RMII_CRS_reg = 1'b0; 
      RMII_RX_DV_reg = 1'b0;
      count_next = 4'b0; 
      preamble_count_next = 4'b0; 
      pream_ok = 1'b0;
      fifo_next_state = fifo_present_state; 
      case (fifo_present_state)
         state0 :
                  begin
                     RMII_RX_DV_reg = 1'b0; 
                     RMII_CRS_reg = 1'b0;
		     preamble_en = 1'b0 ; 
		     pream_ok = 1'b0;
                  // Preamble detection logic 
                     if ((CRS_DV_reg == 1'b1) && (RXD_reg0 == 2'b01))
                     begin
		       pream_ok = 1'b0;
		       count_next = count + 1;	
                       preamble_count_next = preamble_count + 1 ; 
                       preamble_en = 1'b0 ; 
                       RMII_RX_DV_reg = 1'b1; 
                       fifo_next_state = state5 ; 
		       if (SPEED_SYNC == 1'b0)
                        begin
			  count_next = 4'b0;
                        end
                       else
                        begin
			  count_next = 4'b0;
                        end
                     end
                     else
                     begin
                       fifo_next_state = state0 ; 
                       count_next = 4'b0; 
                     end 
                  // CRS detection logic 
                     if (CRS_DV_reg == 1'b1) 
                      begin
                       RMII_CRS_reg = 1'b1;
                     end
                  end
         state1 :
                  begin
                    RMII_RX_DV_reg = 1'b1; 
                    RMII_CRS_reg = 1'b1; 
		    count_next = count + 1;
		    pream_ok = 1'b0; 
		    if (pream_ok_reg == 1'b1)
		     begin 
                       pream_ok = 1'b1; 
                     end
	            	    
		    if (CRS_DV_reg == 1'b0)
                     begin
                       fifo_next_state = state2 ;
                       RMII_CRS_reg = 1'b0; 
		       if (SPEED_SYNC == 1'b0)
                        begin
			  count_next = 4'b0;
                        end
                       else
                        begin
			  count_next = 4'b0;
                        end
                     end
                    else
                     begin
                       fifo_next_state = state1 ;
		       if (SPEED_SYNC == 1'b0)
                        begin
			  if (count == 9)
			   begin
			     count_next = 4'b0;
                           end 
                        end 
		       else
                        begin
			  count_next = 4'b0;
                        end 

                     end 
                  end
         state2 :
                  begin
                     RMII_RX_DV_reg = 1'b1; 
                     preamble_en = 1'b1 ;
		     pream_ok = 1'b0; 
		     if (pream_ok_reg == 1'b1)
		      begin 
                        pream_ok = 1'b1; 
                      end  
		     if (SPEED_SYNC == 1'b1)
                      begin
                        if (CRS_DV_reg == 1'b1)
                         begin
                           RMII_CRS_reg = 1'b0; 
                           fifo_next_state = state3 ;
			   count_next = 4'b0;
                         end
                        else
                         begin
                           fifo_next_state = state7 ; 
                           RMII_CRS_reg = 1'b0; 
			   RMII_RX_DV_reg = 1'b0; 
			   count_next = 4'b0;
                         end 
                      end 
		     else
                      begin
		        count_next = count + 1;	
			if (count == 9)
			 begin
                           if (CRS_DV_reg == 1'b1)
                            begin
                              RMII_CRS_reg = 1'b0; 
                              fifo_next_state = state3 ;
			      count_next = 4'b0;
                            end
			   else
                            begin
                              fifo_next_state = state7 ; 
                              RMII_CRS_reg = 1'b0; 
                              RMII_RX_DV_reg = 1'b0; 
			      count_next = 4'b0;
                            end 
                         end 
                      end
                  end
         state3 :
                  begin
                    RMII_RX_DV_reg = 1'b1; 
                    preamble_en = 1'b1 ;
		    pream_ok = 1'b0; 
		    if (pream_ok_reg == 1'b1)
		     begin 
                       pream_ok = 1'b1; 
                     end 
		     if (SPEED_SYNC == 1'b1)
                      begin
                        if (CRS_DV_reg == 1'b0) 
			 begin  
                           RMII_CRS_reg = 1'b0; 
                           RMII_RX_DV_reg = 1'b1; 
                           fifo_next_state   = state2 ;
			 end
			else
			 begin  
                           RMII_CRS_reg = 1'b0;
                           RMII_RX_DV_reg = 1'b0; 
                           fifo_next_state   = state0 ; 
			 end 
                      end 
		     else
                      begin
		        count_next = count + 1;	
			if (count == 9)
			 begin
                           if (CRS_DV_reg == 1'b0)
                            begin
                              RMII_CRS_reg = 1'b0; 
                              fifo_next_state = state2 ;
                              RMII_RX_DV_reg = 1'b1; 
			      count_next = 4'b0;
                            end
			   else
                            begin
                              fifo_next_state = state0 ; 
                              RMII_CRS_reg = 1'b0; 
                              RMII_RX_DV_reg = 1'b0; 
			      count_next = 4'b0;
                            end 
                         end 
                      end
                  end
/*
       state4 :
                begin
                  preamble_en = 1'b1 ;
		  pream_ok = 1'b0; 
		  if (pream_ok_reg == 1'b1)
		   begin 
                     pream_ok = 1'b1; 
                   end 
	           if (SPEED_SYNC == 1'b1)
                    begin
		     //In state4 if CRS_DV is set, the next state will be state1.
		     //Else the next state will be state2.
		     //The same thing is repeated for SPEED=0 below.
                     if (CRS_DV_reg == 1'b1) 
		      begin  
		        fifo_next_state = state1 ; 
                        RMII_CRS_reg = 1'b1; 
                        RMII_RX_DV_reg = 1'b1; 
                      end
		     else 
		      begin  
                        fifo_next_state = state2 ; 
                        RMII_CRS_reg = 1'b0; 
                        RMII_RX_DV_reg = 1'b0; 
                      end
                    end
		   else
                    begin
		      count_next = count + 1;	
		      if (count == 9)
		       begin
                         if (CRS_DV_reg == 1'b0)
                          begin
                            RMII_CRS_reg = 1'b0; 
                            fifo_next_state = state2 ;
                            RMII_RX_DV_reg = 1'b0; 
			    count_next = 4'b0;
                          end
			 else
                          begin
                            fifo_next_state = state1 ; 
                            RMII_CRS_reg = 1'b0; 
                            RMII_RX_DV_reg = 1'b0; 
			    count_next = 4'b0;
                          end 
                       end 
                    end
                end
*/
         state5 :
                  begin
		   //10mbps modification
		    pream_ok = 1'b0; 
                    RMII_RX_DV_reg = 1'b1; 
                    RMII_CRS_reg = 1'b1;
		    if (pream_ok_reg == 1'b1)
		     begin 
                       pream_ok = 1'b1; 
                     end
		    if (CRS_DV_reg == 1'b1)
		     begin 
		       if(SPEED_SYNC == 1'b1) 
		        begin
                          RMII_CRS_reg = 1'b1; 
                          preamble_count_next = preamble_count + 1 ; 
		          count_next = 4'b0;
                         // SFD detection logic 
                          if ((RXD_reg0 == 2'b11) && (RXD_reg1 == 2'b01))
                           begin
                             preamble_en = 1'b1 ; 
                             RMII_RX_DV_reg = 1'b1; 
                             fifo_next_state = state1 ; 
                             RMII_CRS_reg = 1'b1;
                             preamble_count_next = 0 ; 
                             if (preamble_count[0] == 1'b0) 
                              begin
                                fifo_next_state = state1 ; 
                                pream_ok = 1'b1; 
                              end
                             else
                              begin
                                fifo_next_state = state6 ; 
                                pream_ok = 1'b0; 
                              end
                           end
  		          else
                           begin
                             fifo_next_state = state5 ; 
                             count_next = 4'b0; 
                           end 
		        end
		       else 
		        begin
		          count_next = count + 1;	
		          if (count == 9)
		           begin
                             RMII_RX_DV_reg = 1'b1; 
                             RMII_CRS_reg = 1'b1; 
                             preamble_count_next = preamble_count + 1 ; 
		             count_next = 4'b0;
                             if((RXD_reg0 == 2'b11) && (RXD_reg1 == 2'b01))
                              begin
                                preamble_en = 1'b1 ; 
                                RMII_RX_DV_reg = 1'b1; 
                                fifo_next_state = state1 ; 
                                RMII_CRS_reg = 1'b1;
                                preamble_count_next = 0 ; 
                                if(rx_dv_count == 5'd19) 
                                 begin
                                   fifo_next_state = state1 ; 
                                   pream_ok = 1'b1; 
                                 end
                                else
                                 begin
                                   fifo_next_state = state6 ; 
                                   pream_ok = 1'b0; 
                                 end
                              end
	                     else
                              begin
                                fifo_next_state = state5 ; 
                                count_next = 4'b0; 
                              end 
		           end
                        end 
		     end //(CRS_DV_reg == 1'b1)
		 else 
                  begin
                    fifo_next_state = state0 ; 
                    RMII_RX_DV_reg = 1'b0; 
                    RMII_CRS_reg = 1'b0; 
		    count_next = 4'b0;
                    preamble_en = 1'b0 ; 
		    pream_ok = 1'b0;
		  end 
	         end 
         state6 :
                  begin
                     RMII_RX_DV_reg = 1'b1; 
		     pream_ok = 1'b0;
                     if (pream_ok_reg == 1'b1)
		      begin 
                        pream_ok = 1'b1; 
                      end
		     if(SPEED_SYNC == 1'b1)
		      begin
                        preamble_en = 1'b1 ; 
                        RMII_RX_DV_reg = 1'b1; 
                        RMII_CRS_reg = 1'b1; 
                        count_next = 4'b0; 
                        fifo_next_state = state1 ; 
		      end
		     //else for 10mbps
		     else 
		      begin
		        count_next = count + 1;	
		        if(count == 9) begin
                         preamble_en = 1'b1 ; 
                         RMII_RX_DV_reg = 1'b1; 
                         RMII_CRS_reg = 1'b1; 
                         count_next = 4'b0; 
                         fifo_next_state = state1 ; 
		       end
		      end
                  end
         state7 :
                  begin
		     pream_ok = 1'b0;
                     if (pream_ok_reg == 1'b1)
		      begin 
                        pream_ok = 1'b1; 
                      end
		     if(SPEED_SYNC == 1'b1) 
		       begin
                         preamble_en = 1'b1 ; 
                         RMII_RX_DV_reg = 1'b0; 
                         RMII_CRS_reg = 1'b0; 
                         count_next = 4'b0;
		         if ((RX_DV == 1'b1) && (pream_ok_reg == 1'b1))
		          begin 
                            fifo_next_state = state7 ; 
                            pream_ok = 1'b1; 
                          end
		         else
		          begin 
                            fifo_next_state = state0 ; 
                            pream_ok = 1'b0; 
                          end
		       end
		     //else for 10mbps
		     else
		      begin
		        count_next = count + 1;	
		        if(count == 4'd9)
		        begin
                          preamble_en = 1'b1 ; 
                          RMII_RX_DV_reg = 1'b0; 
                          RMII_CRS_reg = 1'b0; 
                          count_next = 4'b0;
		          if ((RX_DV == 1'b1) && (pream_ok_reg == 1'b1))
		           begin 
                             fifo_next_state = state7 ; 
                             pream_ok = 1'b1; 
                           end
		          else
		           begin 
                             fifo_next_state = state0 ; 
                             pream_ok = 1'b0; 
                           end
		        end
		      end
                  end
         default :
                  begin
                     fifo_next_state = state0 ; 
                     RMII_RX_DV_reg = 1'b0; 
                     RMII_CRS_reg = 1'b0; 
		     count_next = 4'b0;
                     preamble_en = 1'b0 ; 
		     pream_ok = 1'b0;
                  end
      endcase 
    end 

   // sync portion of RMII_CRS_DV state machine			
   always @(posedge RMII_CLK or negedge RMRESETN)
    begin
      if (RMRESETN == 1'b0)
       begin
        fifo_present_state <= state0 ; 
        RMII_RX_DV_0 <= 1'b0; 
        RMII_CRS_0 <= 1'b0; 
        RX_ER_reg0 <= 1'b0 ; 
        RX_ER_reg1 <= 1'b0 ; 
        RX_ER_flag <= 1'b0 ; 
        count <= 4'b0 ; 
        preamble_count <= 32'b0 ;
	pream_ok_reg <= 1'b0;
       end
      else 
       begin
	 pream_ok_reg <= pream_ok;
         preamble_count <= preamble_count_next; 
         fifo_present_state <= fifo_next_state ;
         RMII_RX_DV_0 <= RMII_RX_DV_reg; 
         RMII_CRS_0 <= RMII_CRS_reg; 
         count <= count_next; 
         RX_ER_reg0 <= MII_RX_ER; 
         RX_ER_reg1 <= RX_ER_reg0; 
	 if (RX_ER == 1'b1)
	  begin
            RX_ER_flag <= 1'b1 ; 
          end 
	 else if (RX_ER_reg1 == 1'b1)
	  begin
            RX_ER_flag <= 1'b0 ; 
          end 
       end 
    end 

// sync RX RMII signals to MII interface
   always @(posedge CLK_TX_RX or negedge RMRESETN)
    begin
      if (RMRESETN == 1'b0)
       begin
            RX_DV <= 1'b0;
            CRS <= 1'b0;
            CRS_reg <= 1'b0;
            MII_RX_ER_reg0 <= 1'b0;
            MII_RX_ER <= 1'b0;
            MII_RX_ER0 <= 1'b0;
            MII_RXD <= 4'b0;
            RX_DV_reg <= 1'b0;
       end
      else
       begin
          RX_DV_reg <= RMII_RX_DV;
	      if (SPEED_SYNC == 1'b0) 
	        begin
                MII_RX_ER_reg0 <= RX_ER_flag;
	        MII_RX_ER0 <= MII_RX_ER_reg0;
                MII_RX_ER <= MII_RX_ER0;
                //Modified for multiple CRS_DV toggle 
	            //RX_DV <=  RX_DV_reg;
                RX_DV <=  RMII_RX_DV;
	        end
	      else
	        begin
                MII_RX_ER_reg0 <= RX_ER_flag;
                MII_RX_ER <= MII_RX_ER_reg0;
	        RX_DV  <= RX_DV_reg;
            end
          CRS_reg <= RMII_CRS;
          CRS <= CRS_reg;
	  if (pream_ok == 1'b1)
          MII_RXD <=  RMII_RXD_reg;
	  else
          MII_RXD <=  RMII_RXD;
       end // else 
     end // always

// sync TX RMII signals to MII interface
// TX data transfer from MAC to PHY
   always @(posedge RMII_CLK or negedge RMRESETN)
    begin
      if (RMRESETN == 1'b0)
       begin
        TX_EN <= 1'b0;
        TX_EN_sync0 <= 1'b0;
        TX_EN_sync1 <= 1'b0;
        TXD <= 2'b0;
        TXD_sync0 <= 4'b0;
        TXD_sync1 <= 4'b0;
        tx_data_en <= 1'b0; // Generate rmii ping pong enable
	tx_count <= 4'd0;
       end
      else
       begin
         TXD_sync0 <= MII_TXD;
         TXD_sync1 <= TXD_sync0;
         TX_EN_sync0 <= MII_TX_EN; // sync enable to RMII domain
         TX_EN_sync1 <= TX_EN_sync0; // sync enable to RMII domain
         TX_EN <= 1'b0;
         TXD <= 2'b0;
	 tx_count <= 4'd0;
         tx_data_en <= 1'b0; // Generate rmii ping pong enable
	 if (TX_EN_sync1 == 1'b1)
          begin
	    if (tx_data_en == 1'b0)
             begin
	       if (SPEED_SYNC == 1'b0)
                begin
                  if (tx_count == 4'd9)
                   begin
                     tx_data_en <= 1'b1; // Generate rmii ping pong enable
	             tx_count <= 4'd0;
                     TX_EN <= TX_EN; // sync enable to RMII domain
                     TXD <= TXD;  // data to RMII domain
                   end
                  else
                   begin
                     TXD <= TXD_sync1[1:0];  // data to RMII domain
		     tx_count <= tx_count + 1;
                     tx_data_en <= 1'b0; // Generate rmii ping pong enable
                     TX_EN <= TX_EN_sync1; // sync enable to RMII domain
                   end
                end
               else
                begin
                  TXD <= TXD_sync1[1:0];  // data to RMII domain
                  tx_data_en <= 1'b1; // Generate rmii ping pong enable
                  TX_EN <= TX_EN_sync1; // sync enable to RMII domain
                end
             end
            else
             begin
	       if (SPEED_SYNC == 1'b0)
                begin
                  if (tx_count == 4'd9)
                   begin
                     tx_data_en <= 1'b0; // Generate rmii ping pong enable
	             tx_count <= 4'd0;
                     TX_EN <= TX_EN; // sync enable to RMII domain
                     TXD <= TXD;  // data to RMII domain
                   end
                  else
                   begin
                     TXD <= TXD_sync1[3:2];  // data to RMII domain
		     tx_count <= tx_count + 1;
                     tx_data_en <= 1'b1; // Generate rmii ping pong enable
                     TX_EN <= TX_EN_sync1; // sync enable to RMII domain
                   end
                end
               else
                begin
                  TXD <= TXD_sync1[3:2];  // data to RMII domain
                  tx_data_en <= 1'b0; // Generate rmii ping pong enable
                  TX_EN <= TX_EN_sync1; // sync enable to RMII domain
                end
             end
          end
       end
    end


// RX data transfer from PHY to MAC
   always @(posedge RMII_CLK or negedge RMRESETN)
    begin
      if (RMRESETN == 1'b0)
       begin
        RXD_reg0 <= 2'b0;
        RXD_reg1 <= 2'b0;
        RXD_reg2 <= 2'b0;
        RXD_reg3 <= 2'b0;
        CRS_DV_reg <= 1'b0;
        rx_data_en <= 1'b0;
	RMII_RXD <= 4'b0;
	RMII_RXD_reg <= 4'b0;
	RMII_RXD_reg0 <= 4'b0;
	RMII_RXD_reg1 <= 4'b0;
	RMII_RXD_reg2 <= 4'b0;
	RMII_RXD_reg3 <= 4'b0;
	RMII_RX_DV <= 1'b0;
	RMII_RX_DV_1 <= 1'b0;
	RMII_RX_DV_2 <= 1'b0;
	RMII_RX_DV_3 <= 1'b0;
	RMII_CRS <= 1'b0;
	RMII_CRS_1 <= 1'b0;
	RMII_CRS_2 <= 1'b0;
	RMII_CRS_3 <= 1'b0;
	rx_dv_count <= 5'd0;
	phase_en_reg <= 1'b0;
       end
      else
       begin
	 RMII_RXD_reg <= RMII_RXD;
         phase_en_reg <= phase_en;
	 rx_dv_count <= 5'd0;
         RXD_reg0 <= RXD;
         //RXD_reg1 <= pream_ok ? RXD_reg3 : RXD_reg0;
         RXD_reg1 <= RXD_reg0;
         RXD_reg2 <= RXD_reg0;
         RXD_reg3 <= RXD_reg2;
         CRS_DV_reg <= CRS_DV;
         rx_data_en <= 1'b0;
	 if (SPEED_SYNC == 1'b1)
	  begin
	   RMII_RXD_reg1 <= RMII_RXD_reg0;
	   if(pream_ok == 1'b1)
	    begin
  	     if(rx_data_en == 1'b0) 
	      begin
	       RMII_RXD_reg2 <= RMII_RXD_reg1;
	     end
	   end
	   else 
	    begin
              RMII_RXD_reg2 <= RMII_RXD_reg1;
	    end
	  end
	 else
	  RMII_RXD_reg2 <= RMII_RXD_reg1;
	  RMII_RXD_reg3 <= RMII_RXD_reg2;
         //Modified for multiple CRS_DV toggle 
	 // RMII_RX_DV_1 <= RMII_RX_DV_0;
	 if (SPEED_SYNC == 1'b1) begin
	   //if ((fifo_next_state != 1'b0) || (pream_ok == 1'b1))
	   if ((fifo_next_state != state7) || (pream_ok == 1'b1))
	     RMII_RX_DV_1 <= RMII_RX_DV_0;
	   else  
	     RMII_RX_DV_1 <= 1'b0;
	 end    
	 else if ((pream_ok == 1'b1) && rx_dv_count == 5'd9) begin
	     RMII_RX_DV_1 <= RMII_RX_DV_0;
	   RMII_RXD_reg1 <= RMII_RXD_reg0;
	   end
	 else if ((pream_ok == 1'b0) && rx_dv_count == 5'd19) begin
	     RMII_RX_DV_1 <= RMII_RX_DV_0;
	   RMII_RXD_reg1 <= RMII_RXD_reg0;
	   end
	 RMII_RX_DV_2 <= RMII_RX_DV_1;
	 RMII_RX_DV_3 <= RMII_RX_DV_2;
	 RMII_CRS_1 <= RMII_CRS_0;
	 RMII_CRS_2 <= RMII_CRS_1;
	 RMII_CRS_3 <= RMII_CRS_2;
         //Modified for multiple CRS_DV toggle 
	 if (RMII_RX_DV_0 == 1'b1 || RMII_RX_DV_1 == 1'b1)
          begin
	    if (rx_data_en == 1'b0)
             begin
	       if (SPEED_SYNC == 1'b0)
                begin
                  if (rx_dv_count == 5'd9)
                   begin
		     rx_dv_count <= rx_dv_count + 1;
                     rx_data_en <= 1'b1;
	             // RMII_RXD_reg0 <= RMII_RXD_reg0;
                   end
		  else
                   begin
		     rx_dv_count <= rx_dv_count + 1;
		   if(pream_ok == 1'b1)
		    begin
	             RMII_RXD_reg0 <= {RXD_reg1, RMII_RXD_reg0[1:0]};
		    end 
		   else 
		    begin
	              RMII_RXD_reg0 <= {RMII_RXD_reg0[3:2], RXD_reg1};
		   end

                     rx_data_en <= 1'b0;
                   end
                end
	       else
                begin
                  rx_data_en <= 1'b1;
		  if(pream_ok == 1'b1)
		   begin
	             RMII_RXD_reg0 <= {RXD_reg1, RMII_RXD_reg0[1:0]};
		   end
		  else 
		   begin
	             RMII_RXD_reg0 <= {RMII_RXD_reg0[3:2], RXD_reg1};
		  end
                end
             end
            else
             begin
	       if (SPEED_SYNC == 1'b0)
                begin
                  if (rx_dv_count == 5'd19)
                   begin
		     rx_dv_count <= 5'd0;
                     rx_data_en <= 1'b0;
	             // RMII_RXD_reg0 <= RMII_RXD_reg0;
		     // RMII_RXD_reg1 <= RMII_RXD_reg0;
                     //Modified for multiple CRS_DV toggle 
		     // RMII_RX_DV_1 <= RMII_RX_DV_0;
                   end
		  else
                   begin
		     rx_dv_count <= rx_dv_count + 1;
                     rx_data_en <= 1'b1;
		     if(pream_ok == 1'b1)
		      begin
	                RMII_RXD_reg0 <= {RMII_RXD_reg0[3:2], RXD_reg1};
		      end
		     else 
		      begin
	                RMII_RXD_reg0 <= {RXD_reg1, RMII_RXD_reg0[1:0]};
		     end
                   end
                end
	       else
                begin
                  rx_data_en <= 1'b0;
		  if(pream_ok == 1'b1)
		   begin
	             RMII_RXD_reg0 <= {RMII_RXD_reg0[3:2], RXD_reg1};
		   end
		  else 
		   begin
	             RMII_RXD_reg0 <= {RXD_reg1, RMII_RXD_reg0[1:0]};
		  end
                end
             end
          end
	// Align the phase
	if (SPEED_SYNC == 1'b1)
	  if ((phase_en == 1'b1) || ((phase_en_reg == 1'b1) && (pream_ok == 1'b1)))
           begin
           RMII_RX_DV <= RMII_RX_DV_2;
           RMII_CRS <= RMII_CRS_2;
	   RMII_RXD <= RMII_RXD_reg2;    // Changed from stage1 to stage2
           end
          else
           begin
           RMII_RX_DV <= RMII_RX_DV_3;
	   RMII_CRS <= RMII_CRS_3;
	   RMII_RXD <=  RMII_RXD_reg3;      //Changed from stage2 to stage3
           end
	else
	 begin
          RMII_RX_DV <= RMII_RX_DV_3;
          RMII_CRS <= RMII_CRS_3;
	  RMII_RXD <= RMII_RXD_reg3;    // Changed from stage1 to stage2
	 end
       end
    end

// Generate phase enable logic
   always @(posedge RMII_CLK or negedge RMRESETN)
    begin
      if (RMRESETN == 1'b0)
       begin
        phase_en <= 1'b0;
	phase_en_int <= 1'b0;
       end
      else
       begin
         phase_en <= phase_en_int ;
	 if ((RX_DV_EN == 1'b1) && (CLK_TX_RX == 1'b0))
          begin
            phase_en_int <= 1'b1; // sync enable to RMII domain
          end
	 else if (RMII_RX_DV_1 == 1'b0)
          begin
            phase_en_int <= 1'b0; // sync enable to RMII domain
          end
       end
    end

// generate RX_DV Enable
assign RX_DV_EN = (RMII_RX_DV_0 & (!RMII_RX_DV_1) );

endmodule



