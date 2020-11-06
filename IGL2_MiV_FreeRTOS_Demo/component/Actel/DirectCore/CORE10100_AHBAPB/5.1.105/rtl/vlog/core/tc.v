//
`timescale 1 ns / 100 ps
// ********************************************************************/ 
// Copyright 2013 Microsemi Corporation.  All rights reserved.
// IP Solutions Group
//
// ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
// ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED 
// IN ADVANCE IN WRITING.  
//  
// File:  tc.v
//     
// Description: Core10100
//              See below  
//
// 
// SVN Revision Information:
// SVN $Revision: 6743 $
// SVN $Date: 2009-02-20 23:45:26 +0530 (Fri, 20 Feb 2009) $    
//
// Notes: 
//		  
//
// *********************************************************************/ 
//
// *******************************************************************--
// Copyright (c) 2001-2003  Actel Corp.                             --
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
// File name            : tc.vhd
// File contents        : Entity TC
//                        Architecture RTL of TC
// Purpose              : Transmit Controller for MAC
//
// Destination library  : work
// Dependencies         : work.UTILITY
//                        IEEE.STD_LOGIC_1164
//                        IEEE.STD_LOGIC_UNSIGNED
//
// Design Engineer      : T.K.
// Quality Engineer     : M.B.
// Version              : 2.00.E07a
// Last modification    : 2004-03-26
//---------------------------------------------------------------------
// *******************************************************************--
// Modifications with respect to Version 2.00.E00:
// 2.00.E01   :
// 2003.03.21 : T.K. - MIIWIDTH generic removed
// 2003.03.21 : T.K. - references to 64-bit wide data bus removed
// 2003.03.21 : T.K. - references to flow control removed
// 2003.03.21 : T.K. - txer is now stuck at '0'
// 2.00.E02   :
// 2003.04.15 : T.K. - synchronous processes merged
// 2.00.E03   :
// 2003.05.12 : T.K. - stop_r signal added
// 2003.05.12 : T.K. - tsm_proc: condition for TSM_IDLE changed
// 2.00.E05   :
// 2003.08.10 : H.C. - eofreq_r2 redundant signal removed
// 2.00.E06   :  
// 2004.01.20 : B.W. - fixed transmit frame descriptor status
//                     assignment(F200.05.tx_status)
//                      * de_reg_proc process changed
//
// 2004.01.20 : B.W. - fixed retransmission error (F200.05.rettx)
//                      * tstate_reg_proc process changed
//
// 2004.01.20 : B.W. - RTL code chandes due to VN Check
//                     and code coverage (I200.06.vn) :
//                      * empty_proc process changed
//                      * re_proc process changed
//                      * bset_reg_proc process changed
//                      * nset_proc process changed
//                      * crc_proc process changed
//                      * datamux_proc process changed
// 2.00.E07   :
// 2004.03.22 : L.C. - fixed backoff algorithm (F200.06.backoff)
//                      * crco port width changed
//                      * crco_drv assignment changed
// 2004.03.22 : T.K. - fixed collision during SFD (F200.06.col)
//                      * bcnt_reg_proc process changed
// 2004.03.22 : T.K. - fixed collision functionality (F200.06.retry)
//                      * tstate_reg_proc process changed
// 2.00.E08   :
// 2004.06.07 : T.K. - modified backoff algorithm (F200.08.backoff)
//                      * crco port removed
//                      * crco_drv assignment removed
// *******************************************************************--
// *****************************************************************--
module TC (clk, rst, txen, txer, txd, ramdata, ramaddr, wadg, radg, dpd, ac, sofreq, eofreq, tiack, lastbe, eofadg, tireq, ur, de, coll, carrier, bkoff, tpend, tprog, preamble, stopi, stopo, tcsack, tcsreq);

    parameter FIFODEPTH  = 9;
    parameter DATAWIDTH  = 32;
    `include "utility.v"

    input clk; 
    input rst; 
    output txen; 
    reg txen;
    output txer; 
    wire txer;
    output[3:0] txd; 
    reg[3:0] txd;
    input[DATAWIDTH - 1:0] ramdata; 
    output[FIFODEPTH - 1:0] ramaddr; 
    wire[FIFODEPTH - 1:0] ramaddr;
    input[FIFODEPTH - 1:0] wadg; 
    output[FIFODEPTH - 1:0] radg; 
    wire[FIFODEPTH - 1:0] radg;
    input dpd; 
    input ac; 
    input sofreq; 
    input eofreq; 
    input tiack; 
    input[DATAWIDTH / 8 - 1:0] lastbe; 
    input[FIFODEPTH - 1:0] eofadg; 
    output tireq; 
    reg tireq;
    output ur; 
    wire ur;
    output de; 
    reg de;
    input coll; 
    input carrier; 
    input bkoff; 
    output tpend; 
    wire tpend;
    output tprog; 
    reg tprog;
    output preamble; 
    reg preamble;
    input stopi; 
    output stopo; 
    reg stopo;
    input tcsack; 
    output tcsreq; 
    reg tcsreq;

    //---------------------------- fifo ---------------------------------
    // fifo read enable combinatorial
    reg re_c; 
    // fifo read enable registered
    reg re; 
    // fifo empty combinatorial
    reg empty_c; 
    // fifo empty registered
    reg empty; 
    // fifo read address registered
    reg[FIFODEPTH - 1:0] rad_r; 
    // fifo read address double registered
    reg[FIFODEPTH - 1:0] rad; 
    // fifo read address grey coded registered
    reg[FIFODEPTH - 1:0] iradg; 
    // fifo write address grey coded registered
    reg[FIFODEPTH - 1:0] iwadg; 
    // fifo write address combinatorial
    reg[FIFODEPTH - 1:0] iwad_c; 
    // fifo write address registered
    reg[FIFODEPTH - 1:0] iwad; 
    // fifo start of frame address registered
    reg[FIFODEPTH - 1:0] sofad; 
    // fifo end of frame address grey coded registered
    reg[FIFODEPTH - 1:0] eofadg_r; 
    // start of frame request registered
    reg sofreq_r; 
    // end of frame request registered
    reg eofreq_r; 
    reg eofreq_r1; 
    // end of frame request double registered
    // whole frame in fifo registered
    reg whole; 
    // end of frame registered
    reg eof; 
    // ram data registered
    reg[DATAWIDTH - 1:0] ramdata_r; 
    //----------------------------- mii ---------------------------------
    // mii transmit data phase 0 registered
    reg[3:0] itxd0; 
    // predefined frame fields multiplexor registered
    reg[DATAWIDTH - 1:0] pmux; 
    // transmit data multiplexor
    reg[DATAWIDTH - 1:0] datamux_c; 
    // transmit data multiplexor max
    wire[DATAWIDTH_MAX:0] datamux_c_max; 
    // transmit enable 1 registered
    reg txen1; 
    //---------------------------- frame --------------------------------
    // frame sequencer state machine combinatorial
    reg[3:0] tsm_c; 
    // frame sequencer state machine registered
    reg[3:0] tsm; 
    // nibble counter set registered
    reg nset; 
    // nibble counter
    reg[3:0] ncnt; 
    // nibble counter 1 downto 0
    wire[1:0] ncnt10; 
    // nibble counter 2 downto 0
    wire[2:0] ncnt20; 
    // byte counter reload value registered
    reg[6:0] brel; 
    // byte counter set registered
    reg bset; 
    // byte counter registered
    reg[6:0] bcnt; 
    // byte counter = 0 combinatorial
    reg bz; 
    // no padding registered
    reg nopad; 
    // crc generating registered
    reg crcgen; 
    // crc transmission registered
    reg crcsend; 
    // crc remainder combinatorial
    reg[31:0] crc_c; 
    // crc remainder registered
    reg[31:0] crc; 
    // crc remainder inverted combinatorial
    reg[31:0] crcneg_c; 
    // transmit in progress registered
    reg itprog; 
    // transmit pending registered
    reg itpend; 
    // fifo underrun registered
    reg iur; 
    // interrupt request registered
    reg iti; 
    // interrupt acknowledge registered
    reg tiack_r; 
    // interframe space counter registered
    reg[3:0] ifscnt; 
    //--------------------------- timers --------------------------------
    // cycle size acknowledge registered
    reg tcsack_r; 
    // cycle size counter
    reg[7:0] tcscnt; 
    // cycle size request
    reg tcs; 
    //----------------------- interframe spacing ------------------------
    // interframe space period 1 in progress
    reg ifs1p; 
    // interframe space period 2 in progress
    reg ifs2p; 
    // deferring in progress
    wire defer; 
    //--------------------------- backoff -------------------------------
    // backoff registered
    reg bkoff_r; 
    //---------------------------- others -------------------------------
    // stop input registered
    reg stop_r; 
    // highest nibble (predefined value)
    wire[3:0] hnibble; 
    // zero vactor max
    wire[DATAWIDTH_MAX:0] dzero_max; 

     //Collision registered
    reg coll_r;

    //===================================================================--
    //                                fifo                               --
    //===================================================================--
    //-------------------------------------------------------------------
    // fifo address registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : faddr_reg_proc
        if (rst == 1'b0)
        begin
            rad <= {FIFODEPTH - 1-(0)+1{1'b0}} ; 
            rad_r <= {FIFODEPTH - 1-(0)+1{1'b0}} ; 
            iradg <= {FIFODEPTH - 1-(0)+1{1'b0}} ; 
            sofad <= {FIFODEPTH - 1-(0)+1{1'b0}} ; 
            eofadg_r <= {FIFODEPTH - 1-(0)+1{1'b0}} ; 
            iwad <= {FIFODEPTH - 1-(0)+1{1'b0}} ; 
            iwadg <= {FIFODEPTH - 1-(0)+1{1'b0}} ; 
        end
        else
        begin
            // fifo read address
            if (bkoff_r == 1'b1)
            begin
                rad <= sofad ; 
            end
            else if (re_c == 1'b1)
            begin
                rad <= rad + 1 ; 
            end
            else if (eof == 1'b1 & tsm == TSM_FLUSH)
            begin
                rad <= iwad ; 
            end 
            // fifo read address double registered
            rad_r <= rad ; 
            // fifo read address grey coded
            iradg <= rad ^ {1'b0, rad[FIFODEPTH - 1:1]} ; 
            // start of frame address
            if (tsm == TSM_IDLE)
            begin
                sofad <= rad_r ; 
            end 
            // end of frame address grey coded
            if (eofreq_r == 1'b1)
            begin
                eofadg_r <= eofadg ; 
            end 
            // fifo write addresses binary
            iwad <= iwad_c ; 
            // fifo write address grey coded
            if (eofreq_r1 == 1'b1)
            begin
                iwadg <= eofadg_r ; 
            end
            else
            begin
                iwadg <= wadg ; 
            end 
        end 
    end // faddr_reg_proc

    //-------------------------------------------------------------------
    // fifo write address binary combinatorial
    //-------------------------------------------------------------------
    always @(iwadg)
    begin : iwad_proc
        reg[FIFODEPTH - 1:0] wad_v; 
        wad_v[FIFODEPTH - 1] = iwadg[FIFODEPTH - 1]; 
        begin : xhdl_3
            integer i;
            for(i = FIFODEPTH - 2; i >= 0; i = i - 1)
            begin
                wad_v[i] = wad_v[i + 1] ^ iwadg[i]; 
            end
        end 
        iwad_c <= wad_v ; 
    end // iwad_proc

    //-------------------------------------------------------------------
    // fifo empty combinatorial
    //-------------------------------------------------------------------
    always @(rad or iwad)
    begin : empty_proc
        empty_c <= 1'b0 ; 
        if (rad == iwad)
        begin
            empty_c <= 1'b1 ; 
        end 
    end // empty_proc

    //-------------------------------------------------------------------
    // fifo empty registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : empty_reg_proc
        if (rst == 1'b0)
        begin
            empty <= 1'b1 ; 
        end
        else
        begin
            empty <= empty_c ; 
        end 
    end // empty_reg_proc

    //-------------------------------------------------------------------
    //  fifo read enable combinatorial
    //-------------------------------------------------------------------
    always @(tsm or empty_c or ncnt)
    begin : re_proc
        re_c <= 1'b0 ; 
        if ((tsm == TSM_INFO | tsm == TSM_SFD | tsm == TSM_FLUSH) & empty_c == 1'b0 & ((DATAWIDTH == 8 & (ncnt[0]) == 1'b0) | (DATAWIDTH == 16 & ncnt[1:0] == 2'b10) | (DATAWIDTH == 32 & ncnt[2:0] == 3'b110)))
        begin
            re_c <= 1'b1 ; 
        end 
    end // re_reg_proc

    //-------------------------------------------------------------------
    //  fifo read enable registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : re_reg_proc
        if (rst == 1'b0)
        begin
            re <= 1'b0 ; 
        end
        else
        begin
            re <= re_c ; 
        end 
    end // re_reg_proc
    //-------------------------------------------------------------------
    // ram address
    // registered output
    //-------------------------------------------------------------------
    assign ramaddr = rad ;
    //-------------------------------------------------------------------
    // fifo read address
    // registered output
    //-------------------------------------------------------------------
    assign radg = iradg ;

    //===================================================================--
    //                          transmit control                         --
    //===================================================================--
    //-------------------------------------------------------------------
    // end of frame registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : whole_reg_proc
        if (rst == 1'b0)
        begin
            whole <= 1'b0 ; 
        end
        else
        begin
            if (iti == 1'b1)
            begin
                whole <= 1'b0 ; 
            end
            else if (eofreq_r == 1'b1)
            begin
                whole <= 1'b1 ; 
            end 
        end 
    end // whole_reg_proc

    //-------------------------------------------------------------------
    // start/end of frame registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : se_reg_proc
        if (rst == 1'b0)
        begin
            sofreq_r <= 1'b0 ; 
            eofreq_r <= 1'b0 ; 
	    eofreq_r1 <= 1'b0 ;
        end
        else
        begin
            sofreq_r <= sofreq ; 
            eofreq_r <= eofreq ; 
	    eofreq_r1 <= eofreq_r ;
        end 
    end // se_reg_proc

    //This always block registers the collision signal
    always @(posedge clk or negedge rst)
    begin  
        if (rst == 1'b0)
          coll_r <= 1'b0 ; 
        else
	  coll_r <= coll;
    end 	
    //===================================================================--
    //                                frame                              --
    //===================================================================--
    //-------------------------------------------------------------------
    // sequencer state machine combinatorial
    //-------------------------------------------------------------------
    //Added check for ncnt[0] = 1 to ensure that the state machine should toggle
    //only on byte boundaries. This will make sure that the collision is also
    //captured at the byte boundaries. Also added check for collision registered
    //to ensure that the collision for odd/even nibbles is captured. 
    always @(tsm or itpend or bkoff_r or defer or bz or ncnt or dpd or iur or 
             hnibble or ac or empty or whole or tiack_r or nopad or coll or eof or coll_r)
    begin : tsm_proc
        case (tsm)
            //-----------------------------------------
            TSM_IDLE :
                        begin
                            //-----------------------------------------
                            if (itpend == 1'b1 & bkoff_r == 1'b0 & defer == 1'b0)
                            begin
                                tsm_c <= TSM_PREA ; 
                            end
                            else
                            begin
                                tsm_c <= TSM_IDLE ; 
                            end 
                        end
            //-----------------------------------------
            TSM_PREA :
                        begin
                            //-----------------------------------------
                            if (bz == 1'b1 & (ncnt[0]) == 1'b1)
                            begin
                                tsm_c <= TSM_SFD ; 
                            end
                            else
                            begin
                                tsm_c <= TSM_PREA ; 
                            end 
                        end
            //-----------------------------------------
            TSM_SFD :
                        begin
                            //-----------------------------------------
                            if (bz == 1'b1 & coll == 1'b0 & (ncnt[0]) == 1'b1) //coll == 1'b0 added   
                            begin
                                tsm_c <= TSM_INFO ;
                            end
			    //Extra "else if" to fix the delay of JAM pattern transmission
			    //for collision during Preamble & SFD.
                            else if (bz == 1'b1 & coll == 1'b1 & (ncnt[0]) == 1'b1)
                            begin
                                tsm_c <= TSM_JAM ;
                            end
                            else
                            begin
                                tsm_c <= TSM_SFD ;
                            end
                        end
            //-----------------------------------------
            TSM_INFO :
                        begin
                            if ((coll == 1'b1 | coll_r == 1'b1) & (ncnt[0]) == 1'b1)
                            begin
                                tsm_c <= TSM_JAM ; 
                            end
                            else if (empty == 1'b1)
                            begin
                                if (whole == 1'b0 & ncnt == hnibble)
                                begin
                                    tsm_c <= TSM_JAM ; 
                                end
                                else if (eof == 1'b1 & (nopad == 1'b1 | dpd == 1'b1))
                                begin
                                    //-----------------------------------------
                                    if (ac == 1'b1)
                                    begin
                                        tsm_c <= TSM_INT ; 
                                    end
                                    else
                                    begin
                                        tsm_c <= TSM_CRC ; 
                                    end 
                                end
                                else if (eof == 1'b1)
                                begin
                                    tsm_c <= TSM_PAD ; 
                                end
                                else
                                begin
                                    tsm_c <= TSM_INFO ; 
                                end 
                            end
                            else
                            begin
                                tsm_c <= TSM_INFO ; 
                            end 
                        end
            //-----------------------------------------
            TSM_PAD :
                        begin
                            //-----------------------------------------
                            if ((coll == 1'b1 | coll_r == 1'b1) & (ncnt[0]) == 1'b1)
                            begin
                                tsm_c <= TSM_JAM ; 
                            end
                            else if (nopad == 1'b1 & (ncnt[0]) == 1'b1)
                            begin
                                tsm_c <= TSM_CRC ; 
                            end
                            else
                            begin
                                tsm_c <= TSM_PAD ; 
                            end 
                        end
            //-----------------------------------------
            TSM_CRC :
                        begin
                            //-----------------------------------------
                            if ((coll == 1'b1 | coll_r == 1'b1) & (ncnt[0]) == 1'b1)
                            begin
                                tsm_c <= TSM_JAM ; 
                            end
                            else if (bz == 1'b1 & (ncnt[0]) == 1'b1)
                            begin
                                tsm_c <= TSM_INT ; 
                            end
                            else
                            begin
                                tsm_c <= TSM_CRC ; 
                            end 
                        end
            //-----------------------------------------
            TSM_JAM :
                        begin
                            if (bz == 1'b1 & (ncnt[0]) == 1'b1)
                            begin
                                //-----------------------------------------
                                if (bkoff_r == 1'b0 | iur == 1'b1)
                                begin
                                    tsm_c <= TSM_FLUSH ; 
                                end
                                else
                                begin
                                    tsm_c <= TSM_IDLE ; 
                                end 
                            end
                            else
                            begin
                                tsm_c <= TSM_JAM ; 
                            end 
                        end
            //-----------------------------------------
            TSM_FLUSH :
                        begin
                            //-----------------------------------------
                            if (whole == 1'b1 & empty == 1'b1)
                            begin
                                tsm_c <= TSM_INT ; 
                            end
                            else
                            begin
                                tsm_c <= TSM_FLUSH ; 
                            end 
                        end
            //-----------------------------------------
            default :
                        begin
                            // TSM_INT
                            //-----------------------------------------
                            if (tiack_r == 1'b1)
                            begin
                                tsm_c <= TSM_IDLE ; 
                            end
                            else
                            begin
                                tsm_c <= TSM_INT ; 
                            end 
                        end
        endcase 
    end // tsm_proc

    //-------------------------------------------------------------------
    // transmit sequencer state machine registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : tsm_reg_proc
        if (rst == 1'b0)
        begin
            tsm <= TSM_IDLE ; 
        end
        else
        begin
            tsm <= tsm_c ; 
        end 
    end // tcnt_reg_proc
    //-------------------------------------------------------------------
    // deferring in progress
    //-------------------------------------------------------------------
    assign defer = ifs1p | ifs2p ;

    //-------------------------------------------------------------------
    // interframe space
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : ifs_reg_proc
        if (rst == 1'b0)
        begin
            ifs1p <= 1'b0 ; 
            ifs2p <= 1'b0 ; 
            ifscnt <= IFS1_TIME ; 
        end
        else
        begin
            // interframe space period 1 in progress
            if (itprog == 1'b0 & ifs1p == 1'b0 & ifs2p == 1'b0 & ifscnt != 4'b0000)
            begin
                ifs1p <= 1'b1 ; 
            end
            else if (ifscnt == 4'b0000 | ifs2p == 1'b1)
            begin
                ifs1p <= 1'b0 ; 
            end 
            // interframe space period 2 in progress
            if (ifs1p == 1'b1 & ifscnt == 4'b0000)
            begin
                ifs2p <= 1'b1 ; 
            end
            else if (ifs2p == 1'b1 & ifscnt == 4'b0000)
            begin
                ifs2p <= 1'b0 ; 
            end 
            // interframe space counter
            if (itprog == 1'b1 | (carrier == 1'b1 & ifs1p == 1'b1) | (carrier == 1'b1 & ifscnt == 4'b0000 & itpend == 1'b0))
            begin
                ifscnt <= IFS1_TIME ; 
            end
            else if (ifs1p == 1'b1 & ifscnt == 4'b0000)
            begin
                ifscnt <= IFS2_TIME ; 
            end
            else if (ifscnt != 4'b0000)
            begin
                ifscnt <= ifscnt - 1 ; 
            end 
        end 
    end // ifs_reg_proc

    //-------------------------------------------------------------------
    // deferred
    // registered output
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : de_reg_proc
        if (rst == 1'b0)
        begin
            de <= 1'b0 ; 
        end
        else
        begin
            if (ifs1p == 1'b1 & itpend == 1'b1 & carrier == 1'b1 & tsm == TSM_IDLE)
            begin
                de <= 1'b1 ; 
            end
            else if (tiack_r == 1'b1)
            begin
                de <= 1'b0 ; 
            end 
        end 
    end // de_reg_proc

    //-------------------------------------------------------------------
    // end of frame registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : eof_reg_proc
        if (rst == 1'b0)
        begin
            eof <= 1'b0 ; 
        end
        else
        begin
            case (DATAWIDTH)
                //-------------------------------------
                8 :
                            begin
                                //-------------------------------------
                                if (whole == 1'b1 & (ncnt[0]) == 1'b0)
                                begin
                                    eof <= 1'b1 ; 
                                end
                                else
                                begin
                                    eof <= 1'b0 ; 
                                end 
                            end
                //-------------------------------------
                16 :
                            begin
                                //-------------------------------------
                                if (whole == 1'b1 & ((lastbe == 2'b11 & ncnt[1:0] == 2'b10) | (lastbe == 2'b01 & ncnt[1:0] == 2'b00)))
                                begin
                                    eof <= 1'b1 ; 
                                end
                                else
                                begin
                                    eof <= 1'b0 ; 
                                end 
                            end
                //-------------------------------------
                default :
                            begin
                                // 32
                                //-------------------------------------
                                if (whole == 1'b1 & ((lastbe == 4'b1111 & ncnt[2:0] == 3'b110) | (lastbe == 4'b0111 & ncnt[2:0] == 3'b100) | (lastbe == 4'b0011 & ncnt[2:0] == 3'b010) | (lastbe == 4'b0001 & ncnt[2:0] == 3'b000)))
                                begin
                                    eof <= 1'b1 ; 
                                end
                                else
                                begin
                                    eof <= 1'b0 ; 
                                end 
                            end
            endcase 
        end 
    end // eof_reg_proc

    //-------------------------------------------------------------------
    // byte count set combinatorial
    //-------------------------------------------------------------------
    always @(coll or tsm or ncnt or bz or empty or eof or nopad)
    begin : bset_reg_proc
        bset <= 1'b0 ; 
        if ((coll == 1'b1 & (tsm == TSM_INFO | tsm == TSM_PAD | tsm == TSM_CRC)) | (tsm == TSM_PAD & nopad == 1'b1 & (ncnt[0]) == 1'b0) | (tsm == TSM_PREA & bz == 1'b1 & (ncnt[0]) == 1'b0) | (tsm == TSM_SFD & (ncnt[0]) == 1'b1) | (tsm == TSM_INFO & empty == 1'b1 & eof == 1'b1 & nopad == 1'b1) | (tsm == TSM_IDLE))
        begin
            bset <= 1'b1 ; 
        end 
    end // bset_reg_proc

    //-------------------------------------------------------------------
    // byte counter registered
    //-------------------------------------------------------------------  
    always @(posedge clk or negedge rst)
    begin : bcnt_reg_proc
        if (rst == 1'b0)
        begin
            bcnt <= {7{1'b1}} ; 
            brel <= 7'b0000110 ; 
            bz <= 1'b0 ; 
        end
        else
        begin
            if (bset == 1'b1)
            begin
                if (coll == 1'b1 & tsm == TSM_INFO)
                begin
                    bcnt <= 7'b0000011 ; 
                end
                else
                begin
                    bcnt <= brel ; 
                end 
            end
            else if ((ncnt[0]) == 1'b1 & bz == 1'b0)
            begin
                bcnt <= bcnt - 1 ; 
            end 
            // byte count reload value
            case (tsm)
                TSM_IDLE :
                            begin
                                brel <= 7'b0000110 ; 
                            end
                TSM_PREA :
                            begin
                                brel <= 7'b0000000 ; 
                            end
                TSM_SFD :
                            begin
                                if (coll == 1'b1)
                                begin
                                    brel <= 7'b0000011 ; 
                                end
                                else
                                begin
                                    brel <= MIN_FRAME - 1 ; 
                                end 
                            end
                default :
                            begin
                                brel <= 7'b0000011 ; 
                            end
            endcase 
            // byte count = 0
            if (bset == 1'b1 & brel != 7'b0000000)
            begin
                bz <= 1'b0 ; 
            end
            else if (bcnt == 7'b0000001 & (ncnt[0]) == 1'b1 & bz == 1'b0)
            begin
                bz <= 1'b1 ; 
            end 
        end 
    end // bcnt_reg_proc

    //-------------------------------------------------------------------
    // no padding registered
    //-------------------------------------------------------------------  
    always @(posedge clk or negedge rst)
    begin : nopad_reg_proc
        if (rst == 1'b0)
        begin
            nopad <= 1'b0 ; 
        end
        else
        begin
            if ((tsm == TSM_INFO & bcnt == 7'b0000100 & ac == 1'b0) | (tsm == TSM_INFO & bcnt == 7'b0000001 & ac == 1'b1) | (tsm == TSM_PAD & bcnt == 7'b0000100) | (dpd == 1'b1 & ac == 1'b0))
            begin
                nopad <= 1'b1 ; 
            end
            else if (tsm == TSM_IDLE)
            begin
                nopad <= 1'b0 ; 
            end 
        end 
    end // nopad_reg_proc

    //-------------------------------------------------------------------
    // nibble set combinatorial
    //-------------------------------------------------------------------
    always @(tsm or itpend or bkoff_r or defer or ncnt or eof or empty or nopad)
    begin : nset_proc
        nset <= 1'b0 ; 
        if ((tsm == TSM_IDLE & ~(itpend == 1'b1 & bkoff_r == 1'b0 & defer == 1'b0)) | (tsm == TSM_INFO & empty == 1'b1 & eof == 1'b1) | (tsm == TSM_PAD & nopad == 1'b1 & (ncnt[0]) == 1'b1))
        begin
            nset <= 1'b1 ; 
        end 
    end // nset_proc

    //-------------------------------------------------------------------
    // nibble counter registered
    //-------------------------------------------------------------------  
    always @(posedge clk or negedge rst)
    begin : ncnt_reg_proc
        if (rst == 1'b0)
        begin
            ncnt <= {4{1'b0}} ; 
        end
        else
        begin
            if (nset == 1'b1)
            begin
                ncnt <= {4{1'b0}} ; 
            end
            else if (tsm != TSM_IDLE)
            begin
                ncnt <= ncnt + 1 ; 
            end 
        end 
    end // ncnt_reg_proc

    //-------------------------------------------------------------------
    // transmit crc combinatorial
    //-------------------------------------------------------------------
    always @(tsm or crc or itxd0 or crcgen)
    begin : crc_proc
        crc_c <= crc ; 
        if (tsm == TSM_PREA)
        begin
            crc_c <= {32{1'b1}} ; 
        end
        else if (crcgen == 1'b1)
        begin
            crc_c[0] <= crc[28] ^ itxd0[3] ; 
            crc_c[1] <= crc[28] ^ crc[29] ^ itxd0[2] ^ itxd0[3] ; 
            crc_c[2] <= crc[28] ^ crc[29] ^ crc[30] ^ itxd0[1] ^ itxd0[2] ^ itxd0[3] ; 
            crc_c[3] <= crc[29] ^ crc[30] ^ crc[31] ^ itxd0[0] ^ itxd0[1] ^ itxd0[2] ; 
            crc_c[4] <= crc[0] ^ crc[28] ^ crc[30] ^ crc[31] ^ itxd0[0] ^ itxd0[1] ^ itxd0[3] ; 
            crc_c[5] <= crc[1] ^ crc[28] ^ crc[29] ^ crc[31] ^ itxd0[0] ^ itxd0[2] ^ itxd0[3] ; 
            crc_c[6] <= crc[2] ^ crc[29] ^ crc[30] ^ itxd0[1] ^ itxd0[2] ; 
            crc_c[7] <= crc[3] ^ crc[28] ^ crc[30] ^ crc[31] ^ itxd0[0] ^ itxd0[1] ^ itxd0[3] ; 
            crc_c[8] <= crc[4] ^ crc[28] ^ crc[29] ^ crc[31] ^ itxd0[0] ^ itxd0[2] ^ itxd0[3] ; 
            crc_c[9] <= crc[5] ^ crc[29] ^ crc[30] ^ itxd0[1] ^ itxd0[2] ; 
            crc_c[10] <= crc[6] ^ crc[28] ^ crc[30] ^ crc[31] ^ itxd0[0] ^ itxd0[1] ^ itxd0[3] ; 
            crc_c[11] <= crc[7] ^ crc[28] ^ crc[29] ^ crc[31] ^ itxd0[0] ^ itxd0[2] ^ itxd0[3] ; 
            crc_c[12] <= crc[8] ^ crc[28] ^ crc[29] ^ crc[30] ^ itxd0[1] ^ itxd0[2] ^ itxd0[3] ; 
            crc_c[13] <= crc[9] ^ crc[29] ^ crc[30] ^ crc[31] ^ itxd0[0] ^ itxd0[1] ^ itxd0[2] ; 
            crc_c[14] <= crc[10] ^ crc[30] ^ crc[31] ^ itxd0[0] ^ itxd0[1] ; 
            crc_c[15] <= crc[11] ^ crc[31] ^ itxd0[0] ; 
            crc_c[16] <= crc[12] ^ crc[28] ^ itxd0[3] ; 
            crc_c[17] <= crc[13] ^ crc[29] ^ itxd0[2] ; 
            crc_c[18] <= crc[14] ^ crc[30] ^ itxd0[1] ; 
            crc_c[19] <= crc[15] ^ crc[31] ^ itxd0[0] ; 
            crc_c[20] <= crc[16] ; 
            crc_c[21] <= crc[17] ; 
            crc_c[22] <= crc[18] ^ crc[28] ^ itxd0[3] ; 
            crc_c[23] <= crc[19] ^ crc[28] ^ crc[29] ^ itxd0[2] ^ itxd0[3] ; 
            crc_c[24] <= crc[20] ^ crc[29] ^ crc[30] ^ itxd0[1] ^ itxd0[2] ; 
            crc_c[25] <= crc[21] ^ crc[30] ^ crc[31] ^ itxd0[0] ^ itxd0[1] ; 
            crc_c[26] <= crc[22] ^ crc[28] ^ crc[31] ^ itxd0[0] ^ itxd0[3] ; 
            crc_c[27] <= crc[23] ^ crc[29] ^ itxd0[2] ; 
            crc_c[28] <= crc[24] ^ crc[30] ^ itxd0[1] ; 
            crc_c[29] <= crc[25] ^ crc[31] ^ itxd0[0] ; 
            crc_c[30] <= crc[26] ; 
            crc_c[31] <= crc[27] ; 
        end 
    end // crc_proc

    //-------------------------------------------------------------------
    // crc registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : crc_reg_proc
        if (rst == 1'b0)
        begin
            crcgen <= 1'b0 ; 
            crcsend <= 1'b0 ; 
            crc <= {32{1'b1}} ; 
        end
        else
        begin
            // crc registered
            crc <= crc_c ; 
            // crc generate
            if (tsm == TSM_INFO | tsm == TSM_PAD)
            begin
                crcgen <= 1'b1 ; 
            end
            else
            begin
                crcgen <= 1'b0 ; 
            end 
            // crc send
            if (tsm == TSM_CRC)
            begin
                crcsend <= 1'b1 ; 
            end
            else
            begin
                crcsend <= 1'b0 ; 
            end 
        end 
    end // crc_reg_proc

    //-------------------------------------------------------------------
    // transmit state registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : tstate_reg_proc
        if (rst == 1'b0)
        begin
            itprog <= 1'b0 ; 
            itpend <= 1'b0 ; 
            tprog <= 1'b0 ; 
            preamble <= 1'b0 ; 
        end
        else
        begin
            // internal transmit in progress
            if (tsm == TSM_INFO | tsm == TSM_PAD | tsm == TSM_CRC | tsm == TSM_JAM)
            begin
                itprog <= 1'b1 ; 
            end
            else
            begin
                itprog <= 1'b0 ; 
            end 
            // transmit pending
            if (sofreq_r == 1'b1)
            begin
                itpend <= 1'b1 ; 
            end
            else
            begin
                //elsif iti='1' then
                itpend <= 1'b0 ; 
            end 
            // transmit in progress
            if (tsm == TSM_PREA | tsm == TSM_SFD | tsm == TSM_INFO | tsm == TSM_PAD | tsm == TSM_CRC | tsm == TSM_JAM)
            begin
                tprog <= 1'b1 ; 
            end
            else
            begin
                tprog <= 1'b0 ; 
            end 
            // preamble transmission in progress
            if (tsm == TSM_PREA | tsm == TSM_SFD)
            begin
                preamble <= 1'b1 ; 
            end
            else
            begin
                preamble <= 1'b0 ; 
            end 
        end 
    end // tstate_reg_proc
    //-------------------------------------------------------------------
    // transmit pending
    // registered output
    //-------------------------------------------------------------------
    assign tpend = itpend ;

    //-------------------------------------------------------------------
    // transmit interrupt registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : iti_reg_proc
        if (rst == 1'b0)
        begin
            iti <= 1'b0 ; 
            tireq <= 1'b0 ; 
            tiack_r <= 1'b0 ; 
        end
        else
        begin
            // internal transmit interrupt
            if (tsm == TSM_INT)
            begin
                iti <= 1'b1 ; 
            end
            else if (tiack == 1'b1)
            begin
                iti <= 1'b0 ; 
            end 
            // transmit interrupt
            tireq <= iti ; 
            tiack_r <= tiack ; 
        end 
    end // iti_reg_proc

    //-------------------------------------------------------------------
    // fifo underrun registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : iur_reg_proc
        if (rst == 1'b0)
        begin
            iur <= 1'b0 ; 
        end
        else
        begin
            if (itprog == 1'b1 & empty == 1'b1 & whole == 1'b0)
            begin
                iur <= 1'b1 ; 
            end
            else if (tiack_r == 1'b1)
            begin
                iur <= 1'b0 ; 
            end 
        end 
    end // iur_reg_proc
    //-------------------------------------------------------------------
    // fifo underrun
    // registered output
    //-------------------------------------------------------------------
    assign ur = iur ;

    //===================================================================--
    //                                  mii                              --
    //===================================================================--
    //-------------------------------------------------------------------
    // transmit data mux
    //-------------------------------------------------------------------
    always @(tsm or ramdata_r or pmux)
    begin : datamux_proc
        datamux_c <= pmux ; 
        if (tsm == TSM_INFO)
        begin
            datamux_c <= ramdata_r ; 
        end 
    end // datamux_proc
    //-------------------------------------------------------------------
    // ncnt 1 downto 0
    //-------------------------------------------------------------------
    assign ncnt10 = ncnt[1:0] ;
    //-------------------------------------------------------------------
    // ncnt 2 downto 0
    //-------------------------------------------------------------------
    assign ncnt20 = ncnt[2:0] ;
    //-------------------------------------------------------------------
    // Data mux extended to maximum length
    //-------------------------------------------------------------------
    assign datamux_c_max = {dzero_max[DATAWIDTH_MAX:DATAWIDTH], datamux_c} ;

    //-------------------------------------------------------------------
    // crc remainder inverted combinatorial
    //-------------------------------------------------------------------
    always @(crc)
    begin : crcneg_proc
        begin : xhdl_50
            integer i;
            for(i = 31; i >= 0; i = i - 1)
            begin
                crcneg_c[i] <= ~crc[31 - i] ; 
            end
        end 
    end // crcneg_proc

    //-------------------------------------------------------------------
    // mii transmit data
    // registered output
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : txd_proc
        if (rst == 1'b0)
        begin
            txd <= {4{1'b1}} ; 
            pmux <= {DATAWIDTH - 1-(0)+1{1'b1}} ; 
            itxd0 <= {4{1'b1}} ; 
            ramdata_r <= {DATAWIDTH - 1-(0)+1{1'b0}} ; 
        end
        else
        begin
            // predefined frame field data mux
            case (tsm_c)
                TSM_PAD :
                            begin
                                pmux <= PAD_PATTERN[63:64 - DATAWIDTH] ; 
                            end
                TSM_JAM :
                            begin
                                pmux <= JAM_PATTERN[63:64 - DATAWIDTH] ; 
                            end
                TSM_PREA :
                            begin
                                pmux <= PRE_PATTERN[63:64 - DATAWIDTH] ; 
                            end
                TSM_SFD :
                            begin
                                pmux <= SFD_PATTERN[63:64 - DATAWIDTH] ; 
                            end
                default :
                            begin
                                pmux <= {DATAWIDTH - 1-(0)+1{1'b1}} ; 
                            end
            endcase 
            // mii data mux
            case (DATAWIDTH)
                32 :
                            begin
                                //-----------------------------------------
                                case (ncnt20)
                                    //-----------------------------------------
                                    3'b000 :
                                                begin
                                                    itxd0 <= datamux_c_max[3:0] ; 
                                                end
                                    3'b001 :
                                                begin
                                                    itxd0 <= datamux_c_max[7:4] ; 
                                                end
                                    3'b010 :
                                                begin
                                                    itxd0 <= datamux_c_max[11:8] ; 
                                                end
                                    3'b011 :
                                                begin
                                                    itxd0 <= datamux_c_max[15:12] ; 
                                                end
                                    3'b100 :
                                                begin
                                                    itxd0 <= datamux_c_max[19:16] ; 
                                                end
                                    3'b101 :
                                                begin
                                                    itxd0 <= datamux_c_max[23:20] ; 
                                                end
                                    3'b110 :
                                                begin
                                                    itxd0 <= datamux_c_max[27:24] ; 
                                                end
                                    default :
                                                begin
                                                    itxd0 <= datamux_c_max[31:28] ; 
                                                end
                                endcase 
                            end
                16 :
                            begin
                                //-----------------------------------------
                                case (ncnt10)
                                    //-----------------------------------------
                                    2'b00 :
                                                begin
                                                    itxd0 <= datamux_c_max[3:0] ; 
                                                end
                                    2'b01 :
                                                begin
                                                    itxd0 <= datamux_c_max[7:4] ; 
                                                end
                                    2'b10 :
                                                begin
                                                    itxd0 <= datamux_c_max[11:8] ; 
                                                end
                                    default :
                                                begin
                                                    itxd0 <= datamux_c_max[15:12] ; 
                                                end
                                endcase 
                            end
                //-----------------------------------------
                default :
                            begin
                                // 8
                                //-----------------------------------------
                                if ((ncnt[0]) == 1'b0)
                                begin
                                    itxd0 <= datamux_c_max[3:0] ; 
                                end
                                else
                                begin
                                    itxd0 <= datamux_c_max[7:4] ; 
                                end 
                            end
            endcase 
            // ram data
            if (re == 1'b1)
            begin
                ramdata_r <= ramdata ; 
            end 
            // mii transmit data
            if (crcsend == 1'b1)
            begin
                case (ncnt)
                    4'b0001 :
                                begin
                                    txd <= crcneg_c[3:0] ; 
                                end
                    4'b0010 :
                                begin
                                    txd <= crcneg_c[7:4] ; 
                                end
                    4'b0011 :
                                begin
                                    txd <= crcneg_c[11:8] ; 
                                end
                    4'b0100 :
                                begin
                                    txd <= crcneg_c[15:12] ; 
                                end
                    4'b0101 :
                                begin
                                    txd <= crcneg_c[19:16] ; 
                                end
                    4'b0110 :
                                begin
                                    txd <= crcneg_c[23:20] ; 
                                end
                    4'b0111 :
                                begin
                                    txd <= crcneg_c[27:24] ; 
                                end
                    default :
                                begin
                                    txd <= crcneg_c[31:28] ; 
                                end
                endcase 
            end
            else
            begin
                txd <= itxd0 ; 
            end 
        end 
    end // txd_proc

    //-------------------------------------------------------------------
    // mii transmit enable registered
    // registered output
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : txen_reg_proc
        if (rst == 1'b0)
        begin
            txen1 <= 1'b0 ; 
            txen <= 1'b0 ; 
        end
        else
        begin
            txen <= txen1 ; 
            if (tsm == TSM_IDLE | tsm == TSM_INT | tsm == TSM_FLUSH)
            begin
                txen1 <= 1'b0 ; 
            end
            else
            begin
                txen1 <= 1'b1 ; 
            end 
        end 
    end // txen_reg_proc
    //-------------------------------------------------------------------
    // transmit error
    // stuck at '0'
    //-------------------------------------------------------------------
    assign txer = 1'b0 ;

    //===================================================================--
    //                             backoff                               --
    //===================================================================--
    //-------------------------------------------------------------------
    // backoff in progress registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : bkoff_reg_proc
        if (rst == 1'b0)
        begin
            bkoff_r <= 1'b0 ; 
        end
        else
        begin
            if (bkoff == 1'b1)
            begin
                bkoff_r <= 1'b1 ; 
            end
            else if (tsm != TSM_JAM)
            begin
                bkoff_r <= 1'b0 ; 
            end 
        end 
    end // bkoff_reg_proc

    //===================================================================--
    //                           power management                        --
    //===================================================================--
    //-------------------------------------------------------------------
    // stop output
    // registered output
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : stopo_reg_proc
        if (rst == 1'b0)
        begin
            stop_r <= 1'b0 ; 
            stopo <= 1'b0 ; 
        end
        else
        begin
            // stop transmit input
            stop_r <= stopi ; 
            // stop transmit output
            if (stop_r == 1'b1 & tsm == TSM_IDLE & itpend == 1'b0)
            begin
                stopo <= 1'b1 ; 
            end
            else
            begin
                stopo <= 1'b0 ; 
            end 
        end 
    end // stopo_reg_proc

    //===================================================================--
    //                               timers                              --
    //===================================================================--
    //-------------------------------------------------------------------
    // cycle size counter registered
    //-------------------------------------------------------------------  
    always @(posedge clk or negedge rst)
    begin : cscnt_reg_proc
        if (rst == 1'b0)
        begin
            tcscnt <= {8{1'b0}} ; 
            tcs <= 1'b0 ; 
            tcsreq <= 1'b0 ; 
            tcsack_r <= 1'b0 ; 
        end
        else
        begin
            // cycle size counter registered
            if (tcscnt == 8'b00000000)
            begin
                tcscnt <= 8'b10000000 ; 
            end
            else
            begin
                tcscnt <= tcscnt - 1 ; 
            end 
            // cycle size indicator
            if (tcscnt == 8'b00000000)
            begin
                tcs <= 1'b1 ; 
            end
            else if (tcsack_r == 1'b1)
            begin
                tcs <= 1'b0 ; 
            end 
            // cycle size request
            if (tcs == 1'b1 & tcsack_r == 1'b0)
            begin
                tcsreq <= 1'b1 ; 
            end
            else if (tcsack_r == 1'b1)
            begin
                tcsreq <= 1'b0 ; 
            end 
            // cycle size acknowledge
            tcsack_r <= tcsack ; 
        end 
    end // cscnt_reg_proc
    //===================================================================--
    //                              others                               --
    //===================================================================--
    //-------------------------------------------------------------------
    // Highest nibble
    // Predefined value
    //-------------------------------------------------------------------
    assign hnibble = (DATAWIDTH == 32) ? 4'b0111 : (DATAWIDTH == 16) ? 4'b0011 : 4'b0001 ;
    //-------------------------------------------------------------------
    // zero vactor max
    //-------------------------------------------------------------------
    assign dzero_max = {2{1'b0}} ;
endmodule
