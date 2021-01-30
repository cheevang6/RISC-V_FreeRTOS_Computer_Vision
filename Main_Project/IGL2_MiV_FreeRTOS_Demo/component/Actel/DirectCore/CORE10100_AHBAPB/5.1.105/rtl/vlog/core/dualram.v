//
`timescale 1 ns / 100 ps
// Copyright 2013 Microsemi Corporation.  All rights reserved.
// IP Solutions Group
//
// ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
// ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED 
// IN ADVANCE IN WRITING.  
//  
// File:  dualram.v
//     
// Description: Core10100
//              Dual port RAM   
//
// Notes:  Either infers RAM or instantiates based on FAMILY
//		  
//
// *********************************************************************/ 
//
module DUALRAM (CLKW, CLKR, WE, WADDR, RADDR, WDATA, RDATA);

    parameter FAMILY   = 0;
    parameter AWIDTH   = 32;
    parameter DWIDTH   = 32;


    input CLKW; 
    input CLKR; 
    input WE; 
    input[AWIDTH - 1:0] WADDR; 
    input[AWIDTH - 1:0] RADDR; 
    input[DWIDTH - 1:0] WDATA; 
    output[DWIDTH - 1:0] RDATA; 

    // declare all RAM blocks in RAMBLOCKs_XXX.vhd
    wire READEN; 
    wire WRITEEN; 
    reg[DWIDTH - 1:0] RAM[0:2 ** AWIDTH];    /* */
   
    wire[DWIDTH - 1:0] RDATA;
    reg[DWIDTH - 1:0] RDATAX;

    wire[31:0] WADDR32;
    wire[31:0] RADDR32;
    wire[31:0] WDATA32;
    wire[31:0] RDATA32;


    assign WADDR32[AWIDTH-1:0] = WADDR  [AWIDTH-1:0];
    assign WDATA32[DWIDTH-1:0] = WDATA  [DWIDTH-1:0];
    assign RADDR32[AWIDTH-1:0] = RADDR  [AWIDTH-1:0];
	assign RDATA  [DWIDTH-1:0] = RDATA32[DWIDTH-1:0];


    generate
        if (FAMILY == 0)
        begin : URTL


            reg init;

            initial 
              begin
              	init <= 1;
           		@(posedge CLKW);
                init <= 0;
              end

            always @(posedge CLKW)
            begin : Xhdl_2
                integer addr; 
                if (init==1 )
                  for (addr=0; addr<(2 ** AWIDTH); addr = addr+1) RAM[addr] <= 0;	 /* */
                if (WE == 1'b1)
                begin
                    RAM[WADDR] <= WDATA ; 
                end  
            end 

            always @(posedge CLKR)
            begin : Xhdl_5
                reg[15:0] addr; 
                RDATAX <= RAM[RADDR] ;  
            end 
            	
            assign RDATA32[DWIDTH-1:0] = RDATAX;
        end
    endgenerate 

    //------------------------------------------------------------------------------------
    // Sort out the RAM RE/WE polarities

    assign WRITEEN = WE ;
    assign READEN  =  1'b1 ;

    generate
        if (FAMILY > 0 & DWIDTH == 8 & AWIDTH == 6)
        begin : U_RAMBLOCK64X8
            RAMBLOCK64X8 UU_RAMBLOCK64X8 (
                .Q(RDATA32[7:0]), 
                .DATA(WDATA32[7:0]), 
                .WADDRESS(WADDR32[5:0]), 
                .RADDRESS(RADDR32[5:0]), 
                .WE(WRITEEN), 
                .RE(READEN), 
                .WCLOCK(CLKW), 
                .RCLOCK(CLKR)
            ); 
        end
    endgenerate 

    generate
        if (FAMILY > 0 & DWIDTH == 8 & AWIDTH == 7)
        begin : U_RAMBLOCK128X8
            RAMBLOCK128X8 UU_RAMBLOCK128X8 (
                .Q(RDATA32[7:0]), 
                .DATA(WDATA32[7:0]), 
                .WADDRESS(WADDR32[6:0]), 
                .RADDRESS(RADDR32[6:0]), 
                .WE(WRITEEN), 
                .RE(READEN), 
                .WCLOCK(CLKW), 
                .RCLOCK(CLKR)
            ); 
        end
    endgenerate 

    generate
        if (FAMILY > 0 & DWIDTH == 8 & AWIDTH == 8)
        begin : U_RAMBLOCK256X8
            RAMBLOCK256X8 UU_RAMBLOCK256X8 (
                .Q(RDATA32[7:0]), 
                .DATA(WDATA32[7:0]), 
                .WADDRESS(WADDR32[7:0]), 
                .RADDRESS(RADDR32[7:0]), 
                .WE(WRITEEN), 
                .RE(READEN), 
                .WCLOCK(CLKW), 
                .RCLOCK(CLKR)
            ); 
        end
    endgenerate 

    generate
        if (FAMILY > 0 & DWIDTH == 8 & AWIDTH == 9)
        begin : U_RAMBLOCK512X8
            RAMBLOCK512X8 UU_RAMBLOCK512X8 (
                .Q(RDATA32[7:0]), 
                .DATA(WDATA32[7:0]), 
                .WADDRESS(WADDR32[8:0]), 
                .RADDRESS(RADDR32[8:0]), 
                .WE(WRITEEN), 
                .RE(READEN), 
                .WCLOCK(CLKW), 
                .RCLOCK(CLKR)
            ); 
        end
    endgenerate 

    generate
        if (FAMILY > 0 & DWIDTH == 8 & AWIDTH == 10)
        begin : U_RAMBLOCK1024X8
            RAMBLOCK1024X8 UU_RAMBLOCK1024X8 (
                .Q(RDATA32[7:0]), 
                .DATA(WDATA32[7:0]), 
                .WADDRESS(WADDR32[9:0]), 
                .RADDRESS(RADDR32[9:0]), 
                .WE(WRITEEN), 
                .RE(READEN), 
                .WCLOCK(CLKW), 
                .RCLOCK(CLKR)
            ); 
        end
    endgenerate 

    generate
        if (FAMILY > 0 & DWIDTH == 8 & AWIDTH == 11)
        begin : U_RAMBLOCK2048X8
            RAMBLOCK2048X8 UU_RAMBLOCK2048X8 (
                .Q(RDATA32[7:0]), 
                .DATA(WDATA32[7:0]), 
                .WADDRESS(WADDR32[10:0]), 
                .RADDRESS(RADDR32[10:0]), 
                .WE(WRITEEN), 
                .RE(READEN), 
                .WCLOCK(CLKW), 
                .RCLOCK(CLKR)
            ); 
        end
    endgenerate 

    generate
        if (FAMILY > 0 & DWIDTH == 8 & AWIDTH == 12)
        begin : U_RAMBLOCK4096X8
            RAMBLOCK4096X8 UU_RAMBLOCK4096X8 (
                .Q(RDATA32[7:0]), 
                .DATA(WDATA32[7:0]), 
                .WADDRESS(WADDR32[11:0]), 
                .RADDRESS(RADDR32[11:0]), 
                .WE(WRITEEN), 
                .RE(READEN), 
                .WCLOCK(CLKW), 
                .RCLOCK(CLKR)
            ); 
        end
    endgenerate 

    generate
        if (FAMILY > 0 & DWIDTH == 16 & AWIDTH == 6)
        begin : U_RAMBLOCK64X16
            RAMBLOCK64X16 UU_RAMBLOCK64X16 (
                .Q(RDATA32[15:0]), 
                .DATA(WDATA32[15:0]), 
                .WADDRESS(WADDR32[5:0]), 
                .RADDRESS(RADDR32[5:0]), 
                .WE(WRITEEN), 
                .RE(READEN), 
                .WCLOCK(CLKW), 
                .RCLOCK(CLKR)
            ); 
        end
    endgenerate 

    generate
        if (FAMILY > 0 & DWIDTH == 16 & AWIDTH == 7)
        begin : U_RAMBLOCK128X16
            RAMBLOCK128X16 UU_RAMBLOCK128X16 (
                .Q(RDATA32[15:0]), 
                .DATA(WDATA32[15:0]), 
                .WADDRESS(WADDR32[6:0]), 
                .RADDRESS(RADDR32[6:0]), 
                .WE(WRITEEN), 
                .RE(READEN), 
                .WCLOCK(CLKW), 
                .RCLOCK(CLKR)
            ); 
        end
    endgenerate 

    generate
        if (FAMILY > 0 & DWIDTH == 16 & AWIDTH == 8)
        begin : U_RAMBLOCK256X16
            RAMBLOCK256X16 UU_RAMBLOCK256X16 (
                .Q(RDATA32[15:0]), 
                .DATA(WDATA32[15:0]), 
                .WADDRESS(WADDR32[7:0]), 
                .RADDRESS(RADDR32[7:0]), 
                .WE(WRITEEN), 
                .RE(READEN), 
                .WCLOCK(CLKW), 
                .RCLOCK(CLKR)
            ); 
        end
    endgenerate 

    generate
        if (FAMILY > 0 & DWIDTH == 16 & AWIDTH == 9)
        begin : U_RAMBLOCK512X16
            RAMBLOCK512X16 UU_RAMBLOCK512X16 (
                .Q(RDATA32[15:0]), 
                .DATA(WDATA32[15:0]), 
                .WADDRESS(WADDR32[8:0]), 
                .RADDRESS(RADDR32[8:0]), 
                .WE(WRITEEN), 
                .RE(READEN), 
                .WCLOCK(CLKW), 
                .RCLOCK(CLKR)
            ); 
        end
    endgenerate 

    generate
        if (FAMILY > 0 & DWIDTH == 16 & AWIDTH == 10)
        begin : U_RAMBLOCK1024X16
            RAMBLOCK1024X16 UU_RAMBLOCK1024X16 (
                .Q(RDATA32[15:0]), 
                .DATA(WDATA32[15:0]), 
                .WADDRESS(WADDR32[9:0]), 
                .RADDRESS(RADDR32[9:0]), 
                .WE(WRITEEN), 
                .RE(READEN), 
                .WCLOCK(CLKW), 
                .RCLOCK(CLKR)
            ); 
        end
    endgenerate 

    generate
        if (FAMILY > 0 & DWIDTH == 16 & AWIDTH == 11)
        begin : U_RAMBLOCK2048X16
            RAMBLOCK2048X16 UU_RAMBLOCK2048X16 (
                .Q(RDATA32[15:0]), 
                .DATA(WDATA32[15:0]), 
                .WADDRESS(WADDR32[10:0]), 
                .RADDRESS(RADDR32[10:0]), 
                .WE(WRITEEN), 
                .RE(READEN), 
                .WCLOCK(CLKW), 
                .RCLOCK(CLKR)
            ); 
        end
    endgenerate 

    generate
        if (FAMILY > 0 & DWIDTH == 16 & AWIDTH == 12)
        begin : U_RAMBLOCK4096X16
            RAMBLOCK4096X16 UU_RAMBLOCK4096X16 (
                .Q(RDATA32[15:0]), 
                .DATA(WDATA32[15:0]), 
                .WADDRESS(WADDR32[11:0]), 
                .RADDRESS(RADDR32[11:0]), 
                .WE(WRITEEN), 
                .RE(READEN), 
                .WCLOCK(CLKW), 
                .RCLOCK(CLKR)
            ); 
        end
    endgenerate 

    generate
        if (FAMILY > 0 & DWIDTH == 32 & AWIDTH == 6)
        begin : U_RAMBLOCK64X32
            RAMBLOCK64X32 UU_RAMBLOCK64X32 (
                .Q(RDATA32[31:0]), 
                .DATA(WDATA32[31:0]), 
                .WADDRESS(WADDR32[5:0]), 
                .RADDRESS(RADDR32[5:0]), 
                .WE(WRITEEN), 
                .RE(READEN), 
                .WCLOCK(CLKW), 
                .RCLOCK(CLKR)
            ); 
        end
    endgenerate 

    generate
        if (FAMILY > 0 & DWIDTH == 32 & AWIDTH == 7)
        begin : U_RAMBLOCK128X32
            RAMBLOCK128X32 UU_RAMBLOCK128X32 (
                .Q(RDATA32[31:0]), 
                .DATA(WDATA32[31:0]), 
                .WADDRESS(WADDR32[6:0]), 
                .RADDRESS(RADDR32[6:0]), 
                .WE(WRITEEN), 
                .RE(READEN), 
                .WCLOCK(CLKW), 
                .RCLOCK(CLKR)
            ); 
        end
    endgenerate 

    generate
        if (FAMILY > 0 & DWIDTH == 32 & AWIDTH == 8)
        begin : U_RAMBLOCK256X32
            RAMBLOCK256X32 UU_RAMBLOCK256X32 (
                .Q(RDATA32[31:0]), 
                .DATA(WDATA32[31:0]), 
                .WADDRESS(WADDR32[7:0]), 
                .RADDRESS(RADDR32[7:0]), 
                .WE(WRITEEN), 
                .RE(READEN), 
                .WCLOCK(CLKW), 
                .RCLOCK(CLKR)
            ); 
        end
    endgenerate 

    generate
        if (FAMILY > 0 & DWIDTH == 32 & AWIDTH == 9)
        begin : U_RAMBLOCK512X32
            RAMBLOCK512X32 UU_RAMBLOCK512X32 (
                .Q(RDATA32[31:0]), 
                .DATA(WDATA32[31:0]), 
                .WADDRESS(WADDR32[8:0]), 
                .RADDRESS(RADDR32[8:0]), 
                .WE(WRITEEN), 
                .RE(READEN), 
                .WCLOCK(CLKW), 
                .RCLOCK(CLKR)
            ); 
        end
    endgenerate 

    generate
        if (FAMILY > 0 & DWIDTH == 32 & AWIDTH == 10)
        begin : U_RAMBLOCK1024X32
            RAMBLOCK1024X32 UU_RAMBLOCK1024X32 (
                .Q(RDATA32[31:0]), 
                .DATA(WDATA32[31:0]), 
                .WADDRESS(WADDR32[9:0]), 
                .RADDRESS(RADDR32[9:0]), 
                .WE(WRITEEN), 
                .RE(READEN), 
                .WCLOCK(CLKW), 
                .RCLOCK(CLKR)
            ); 
        end
    endgenerate 

    generate
        if (FAMILY > 0 & DWIDTH == 32 & AWIDTH == 11)
        begin : U_RAMBLOCK2048X32
            RAMBLOCK2048X32 UU_RAMBLOCK2048X32 (
                .Q(RDATA32[31:0]), 
                .DATA(WDATA32[31:0]), 
                .WADDRESS(WADDR32[10:0]), 
                .RADDRESS(RADDR32[10:0]), 
                .WE(WRITEEN), 
                .RE(READEN), 
                .WCLOCK(CLKW), 
                .RCLOCK(CLKR)
            ); 
        end
    endgenerate 

    generate
        if (FAMILY > 0 & DWIDTH == 32 & AWIDTH == 12)
        begin : U_RAMBLOCK4096X32
            RAMBLOCK4096X32 UU_RAMBLOCK4096X32 (
                .Q(RDATA32[31:0]), 
                .DATA(WDATA32[31:0]), 
                .WADDRESS(WADDR32[11:0]), 
                .RADDRESS(RADDR32[11:0]), 
                .WE(WRITEEN), 
                .RE(READEN), 
                .WCLOCK(CLKW), 
                .RCLOCK(CLKR)
            ); 
        end
    endgenerate 
endmodule
