//
// Copyright 2006 Actel Corporation.  All rights reserved.
// IP Solutions Group
//
// ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
// ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED 
// IN ADVANCE IN WRITING.  
//  
// File:  testram.v
//     
// Description: Core10100
//              Dual port RAM   
//
// Rev: 3.0  01Sep06  IPB  : v3.0 CoreConsole Release  
//
// Notes:  RAM for test uses - note auto zeros at simulation start
//		  
//
// *********************************************************************/ 
//

`timescale 1 ns / 100 ps

module TESTRAM (CLKW, CLKR, WE, WADDR, RADDR, WDATA, RDATA);

    parameter AWIDTH  = 10;
    parameter DWIDTH  = 8;
    input CLKW; 
    input CLKR; 
    input WE; 
    input[AWIDTH - 1:0] WADDR; 
    input[AWIDTH - 1:0] RADDR; 
    input[DWIDTH - 1:0] WDATA; 
    output[DWIDTH - 1:0] RDATA; 
    reg[DWIDTH - 1:0] RDATA;

    wire READEN; 
    wire WRITEEN; 
    reg[DWIDTH - 1:0] RAM[0:(2 ** AWIDTH) - 1]; 	 /* */

    reg init;

    initial 
      begin
      	init <= 1;
		@(posedge CLKW);
        init <= 0;
      end
      	

    always @(posedge CLKW)
    begin : xhdl_3
        integer addr; 
        if (init==1 )
          for (addr=0; addr<(2 ** AWIDTH); addr = addr+1) RAM[addr] = 0;	 /* */
        if (WE == 1'b1)
        begin
            addr = WADDR; 
            RAM[addr] <= WDATA ; 
        end  
    end 

    always @(posedge CLKR)
    begin : xhdl_6
        integer addr; 
        addr = RADDR; 
        RDATA <= RAM[addr] ;  
    end 
endmodule
