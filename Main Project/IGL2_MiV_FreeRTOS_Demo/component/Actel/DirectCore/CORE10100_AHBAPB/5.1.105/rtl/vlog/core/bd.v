//
`timescale 1 ns / 100 ps
// *********************************************************************/ 
// Copyright 2013 Microsemi Corporation.  All rights reserved.
// IP Solutions Group
//
// ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
// ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED 
// IN ADVANCE IN WRITING.  
//  
// File:  bd.v
//     
// Description: Core10100
//              Core - Transmit for half duplex  
//
// Notes: 
//		  
//
// *********************************************************************/ 
//
// *******************************************************************--
// Copyright 2013 Microsemi Corporation.  All rights reserved.
// *******************************************************************--
// Please review the terms of the license agreement before using     --
// this file. If you are not an authorized user, please destroy this --
// source code file and notify Actel Corp. immediately that you     --
// inadvertently received an unauthorized copy.                      --
// *******************************************************************--
//---------------------------------------------------------------------
// Project name         : MAC
// Project description  : Ethernet Media Access Controller
//
// File name            : bd.v
// File contents        : Entity BD
//                        Architecture RTL of BD
// Purpose              : Transmit procedures for half duplex operation
//
// Destination library  : work
// Dependencies         : work.UTILITY
//                        IEEE.STD_LOGIC_1164
//                        IEEE.STD_LOGIC_UNSIGNED
//
// Design Engineer      : T.K.
// Quality Engineer     : M.B.
// Version              : 2.00.E08
// Last modification    : 2004-06-07
//---------------------------------------------------------------------
// *******************************************************************--
// Modifications with respect to Version 2.00.E00:
// 2.00.E01   :
// 2003.03.21 : T.K. - MIIWIDTH generic removed
// 2003.03.21 : T.K. - support for frame bursting removed
// 2.00.E02   :
// 2003.04.15 : T.K  - synchronous processes merged
// 2.00.E06   : 
// 2004.01.20 : T.K  - transmition status bug fixed (F200.05.tx_status) :
//                      * crs_reg_proc process modified
//
// 2004.01.20 : B.W. - RTL code changes due to VN Check
//                     and code coverage (I200.06.vn):
//                      * bkrel_proc process modified
// 2.00.E07   :
// 2004.03.22 : L.C. - fixed backoff algorithm (F200.06.backoff)
//                      * crc port width modified
//                      * rand signal width modified
//                      * rand_reg_proc process changed
//                      * slcnt_reg_proc process changed
// 2004.03.22 : T.K. - Fixed collision functionality (F200.06.retry).
//                      * ilc signal added
//                      * bkcnt_reg_proc process changed
//                      * ibkoff_reg_proc process changed
//                      * col_reg_proc process changed
//                      * lc_drv assignment added
// 2.00.E08   :
// 2004.06.07 : T.K. - modified backoff algorithm (F200.08.backoff)
//                      * crc port removed
//                      * tprogf_c and tprog_r signals removed
//                      * tprog_reg_proc process removed
//                      * tprogf_drv assignment removed
//                      * rand_reg_proc process changed
// *******************************************************************--
// *****************************************************************--
module BD (clk, rst, col, crs, fdp, tprog, preamble, tpend, winp, tiack, coll, carrier, bkoff, lc, lo, nc, ec, cc);

    `include "utility.v"

    input clk; 
    input rst; 
    input col; 
    input crs; 
    input fdp; 
    input tprog; 
    input preamble; 
    input tpend; 
    output winp; 
    wire winp;
    input tiack; 
    output coll; 
    wire coll;
    output carrier; 
    wire carrier;
    output bkoff; 
    wire bkoff;
    output lc; 
    wire lc;
    output lo; 
    reg lo;
    output nc; 
    wire nc;
    output ec; 
    reg ec;
    output[3:0] cc; 
    wire[3:0] cc;

    //-------------------------- deferring ------------------------------
    // mii carrier sense registered
    reg crs_r; 
    // internal no carrier registered
    reg inc; 
    //---------------------------- backoff ------------------------------
    // internal backoff in progress registered
    reg ibkoff; 
    // internal backoff in progress double registered
    reg ibkoff_r; 
    // collision indication registered
    reg icoll; 
    // late collision
    reg ilc; 
    // collision counter registered
    reg[3:0] ccnt; 
    // backoff counter registered
    reg[9:0] bkcnt; 
    // slot counter registered
    reg[8:0] slcnt; 
    // backoff counter reload value combinatorial
    reg[9:0] bkrel_c; 
    // pseudo-random number generator registered
    reg[30:0] rand; 
    // collision window passed registered
    reg iwinp; 

    //===================================================================--
    //                            deferring                              --
    //===================================================================--
    //-------------------------------------------------------------------
    // carrier sense registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : crs_reg_proc
        if (rst == 1'b0)
        begin
            crs_r <= 1'b0 ; 
            lo <= 1'b0 ; 
            inc <= 1'b0 ; 
        end
        else
        begin
            // carrier sense
            if (fdp == 1'b1)
            begin
                crs_r <= 1'b0 ; 
            end
            else
            begin
                crs_r <= crs ; 
            end 
            // loss of carrier
            if (tprog == 1'b1 & inc == 1'b0 & crs_r == 1'b0)
            begin
                lo <= 1'b1 ; 
            end
            else if (tpend == 1'b0 & tprog == 1'b0)
            begin
                lo <= 1'b0 ; 
            end 
            // no carrier
            if (tprog == 1'b1 & crs_r == 1'b1)
            begin
                inc <= 1'b0 ; 
            end
            else if (tpend == 1'b0 & tprog == 1'b0)
            begin
                inc <= 1'b1 ; 
            end 
        end 
    end // crs_reg_proc
    //-------------------------------------------------------------------
    // no carrier
    // registered output
    //-------------------------------------------------------------------
    assign nc = inc ;

    //===================================================================--
    //                               BACKOFF                             --
    //===================================================================--
    //-------------------------------------------------------------------
    // backoff preset value combinatorial
    //-------------------------------------------------------------------
    always @(ccnt or rand)
    begin : bkrel_proc
        bkrel_c <= rand[9:0] ; 
        case (ccnt)
            4'b0000 :
                        begin
                            bkrel_c <= {9'b000000000, rand[0]} ; 
                        end
            4'b0001 :
                        begin
                            bkrel_c <= {8'b00000000, rand[1:0]} ; 
                        end
            4'b0010 :
                        begin
                            bkrel_c <= {7'b0000000, rand[2:0]} ; 
                        end
            4'b0011 :
                        begin
                            bkrel_c <= {6'b000000, rand[3:0]} ; 
                        end
            4'b0100 :
                        begin
                            bkrel_c <= {5'b00000, rand[4:0]} ; 
                        end
            4'b0101 :
                        begin
                            bkrel_c <= {4'b0000, rand[5:0]} ; 
                        end
            4'b0110 :
                        begin
                            bkrel_c <= {3'b000, rand[6:0]} ; 
                        end
            4'b0111 :
                        begin
                            bkrel_c <= {2'b00, rand[7:0]} ; 
                        end
            4'b1000 :
                        begin
                            bkrel_c <= {1'b0, rand[8:0]} ; 
                        end
            default :
                        begin
                        end
        endcase 
    end // bkrel_proc

    //-------------------------------------------------------------------
    // slot counter registered
    //-------------------------------------------------------------------  
    always @(posedge clk or negedge rst)
    begin : slcnt_reg_proc
        if (rst == 1'b0)
        begin
            slcnt <= {9{1'b1}} ; 
        end
        else
        begin
            if (tprog == 1'b1 & preamble == 1'b0 & icoll == 1'b0)
            begin
                if (slcnt != 9'b000000000)
                begin
                    slcnt <= slcnt - 1 ; 
                end 
            end
            else if (ibkoff == 1'b1)
            begin
                if (slcnt == 9'b000000000 | icoll == 1'b1)
                begin
                    slcnt <= SLOT_TIME ; 
                end
                else
                begin
                    slcnt <= slcnt - 1 ; 
                end 
            end
            else
            begin
                slcnt <= SLOT_TIME ; 
            end 
        end 
    end // slcnt_reg_proc

    //-------------------------------------------------------------------
    // backoff counter registered
    //-------------------------------------------------------------------  
    always @(posedge clk or negedge rst)
    begin : bkcnt_reg_proc
        if (rst == 1'b0)
        begin
            bkcnt <= {10{1'b1}} ; 
        end
        else
        begin
            if (icoll == 1'b1 & ibkoff == 1'b0)
            begin
                bkcnt <= bkrel_c ; 
            end
            else if (slcnt == 9'b000000000)
            begin
                bkcnt <= bkcnt - 1 ; 
            end 
        end 
    end // bkcnt_reg_proc

    //-------------------------------------------------------------------
    // random number generator registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : rand_reg_proc
        integer i; // loop index
        if (rst == 1'b0)
        begin
            rand <= {31{1'b1}} ; 
        end
        else
        begin
            begin : xhdl_10
                integer i;
                for(i = 30; i >= 1; i = i - 1)
                begin
                    rand[i] <= rand[i - 1] ; 
                end
            end 
            rand[0] <= rand[30] ^ rand[28] ; 
        end 
    end // rand_reg_proc

    //-------------------------------------------------------------------
    // internal backoff indicator registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : ibkoff_reg_proc
        if (rst == 1'b0)
        begin
            ibkoff <= 1'b0 ; 
            ibkoff_r <= 1'b0 ; 
        end
        else
        begin
            ibkoff_r <= ibkoff ; 
            if (icoll == 1'b1 & ccnt != 4'b1111 & iwinp == 1'b0 & ilc == 1'b0)
            begin
                ibkoff <= 1'b1 ; 
            end
            else if (bkcnt == 10'b0000000000)
            begin
                ibkoff <= 1'b0 ; 
            end 
        end 
    end // ibkoff_reg_proc

    //-------------------------------------------------------------------
    // collision detected registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : coll_reg_proc
        if (rst == 1'b0)
        begin
            icoll <= 1'b0 ; 
            ilc <= 1'b0 ; 
            ec <= 1'b0 ; 
            iwinp <= 1'b1 ; 
            ccnt <= {4{1'b0}} ; 
        end
        else
        begin
            // collision detected
            if ((preamble == 1'b1 | tprog == 1'b1) & col == 1'b1 & fdp == 1'b0)
            begin
                icoll <= 1'b1 ; 
            end
            else if (tprog == 1'b0 & preamble == 1'b0)
            begin
                icoll <= 1'b0 ; 
            end 
            // late collision
            if (tiack == 1'b1)
            begin
                ilc <= 1'b0 ; 
            end
            else if (tprog == 1'b1 & icoll == 1'b1 & iwinp == 1'b1)
            begin
                ilc <= 1'b1 ; 
            end 
            // excessive collisions
            if (tiack == 1'b1)
            begin
                ec <= 1'b0 ; 
            end
            else if (icoll == 1'b1 & ccnt == 4'b1111 & tprog == 1'b1)
            begin
                ec <= 1'b1 ; 
            end 
            // collision window passed
            if (slcnt == 9'b000000000 | tprog == 1'b0)
            begin
                iwinp <= 1'b1 ; 
            end
            else
            begin
                iwinp <= 1'b0 ; 
            end 
            // collision counter
            if (tpend == 1'b0 & tprog == 1'b0)
            begin
                ccnt <= 4'b0000 ; 
            end
            else if (ibkoff == 1'b1 & ibkoff_r == 1'b0)
            begin
                ccnt <= ccnt + 1 ; 
            end 
        end 
    end // coll_reg_proc
    //-------------------------------------------------------------------
    // late collision
    // registered output
    //-------------------------------------------------------------------
    assign lc = ilc ;
    //-------------------------------------------------------------------
    // collision window passed
    // registered output
    //-------------------------------------------------------------------
    assign winp = iwinp ;
    //-------------------------------------------------------------------
    // carrier sense
    // registered output
    //-------------------------------------------------------------------
    assign carrier = crs_r ;
    //-------------------------------------------------------------------
    // collision detected
    // registered output
    //-------------------------------------------------------------------
    assign coll = icoll ;
    //-------------------------------------------------------------------
    // backoff in progress
    // registered output
    //-------------------------------------------------------------------
    assign bkoff = ibkoff ;
    //-------------------------------------------------------------------
    // collision count
    // registered output
    //-------------------------------------------------------------------
    assign cc = ccnt ;
endmodule
