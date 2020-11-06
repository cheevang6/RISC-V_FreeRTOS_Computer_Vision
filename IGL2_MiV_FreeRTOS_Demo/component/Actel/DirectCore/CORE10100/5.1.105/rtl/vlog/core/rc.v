`timescale 1 ns / 100 ps
// ********************************************************************/ 
// Copyright 2013 Microsemi Corporation.  All rights reserved.
// IP Solutions Group
//
// ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
// ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED 
// IN ADVANCE IN WRITING.  
//  
// File:  rc.v
//     
// Description: Core10100
//              See below  
//
//
//
// Notes:  Includes SAR73505
//		  
//
// *********************************************************************/ 
//
// *******************************************************************--
 // Copyright 2013 Microsemi Corporation.  All rights reserved.
// *******************************************************************--
// Please review the terms of the license agreement before using     --
// this file. If you are not an authorized user, please destroy this --
// source code file and notify Actel immediately that you     --
// inadvertently received an unauthorized copy.                      --
// *******************************************************************--
//---------------------------------------------------------------------
// Project name         : MAC
// Project description  : Ethernet Media Access Controller
//
// File name            : rc.vhd
// File contents        : Entity RC
//                        Architecture RTL of RC
// Purpose              : Receive Controller for MAC
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
// 2003.03.21 : T.K. - watchdog functionality removed
// 2003.03.21 : T.K. - missed frames counter moved to the rlsm.vhd
// 2003.03.21 : T.K. - frame cache not full is now registered
// 2003.03.21 : T.K. - "hash_reg_proc" simplified
// 2003.03.21 : T.K. - external address matching interface modified
// 2003.03.21 : T.K. - rcpoll port added
// 2.00.E02   :
// 2003.04.15 : T.K  - synchronous processes merged
// 2.00.E05_ACTEL : H.C. - fix the dribbling error
// 2004.01.20 : B.W. - fixed mfc counter (F200.05.mfc) &
//                     statistical counters module integration
//                     support (I200.05.sc) :
//						* mfc counter related ports added
//                      * cachenf_2r and eorfff signals added
//                      * fcgbcnt and fcgbcnt_r signals added
//                      * mfcnt and mfcl_r signals added
//                      * fifofull_reg_proc process changed
//                      * rsm_proc process changed
//                      * bncnt_reg_proc process modified
//                      * winp_reg_proc process modified
//                      * length_reg_proc process changed
//                      * fcfbcnt_reg_proc process added
//                      * eorfff_reg_proc process added
//                      * stat_reg_proc process changed
//                      * fsm_proc process modified
//                      * focnt_reg_proc process changed
//                      * mfcnt_reg_proc process moved from RLSM component
//                      * mfcnt_reg_proc process modified
//
// 2004.01.20 : B.W. - fixed frame filtering in hash mode (F200.05.hash)
//                      * fa_reg_proc process modified
//
// 2004.01.20 : B.W. - RTL code changes due to VN Check
//                     and code coverage (I200.06.vn):
//                      * crc_proc process changed
//                      * perfm_proc process changed
//
// 
// 2.00.E06a  :
// 2004.02.20 : T.K. - cs collision seen functionality fixed (F200.06.cs) :
//                      * col port added
//                      * col_r signal added
//                      * mii_reg_proc process changed
//                      * stat_reg_proc process changed
//
// 2004.02.20 : T.K. - fixed receive DATA RAM read/write address pointers
//                     when receiving a frame with dribbling bit
//                      * we_reg_proc process changed
// 2.00.E09   :
// 2004.06.23 : T.K. - dribbling bit in 32bit mode fixed (F200.09.db) :
//                      * we_reg_proc process changed
// 2004.06.23 : B.W. - fifo control fixed (F200.09.cachenf) :
//                      * fifofull_reg_proc process changed
// *******************************************************************--
// *****************************************************************--
module RC (clk, rst, rxdv, rxer, col, rxd, ramwe, ramaddr, ramdata, fdata, faddr, cachenf, radg, wadg, rprog, rcpoll, riack, ren, ra, pm, pr, pb, rif, ho, hp, rireq, ff, rf, mf, db, re, ce, tl, ftp, ov, cs, length, match, matchval, matchen, matchdata, mfcl, focl, foclack, oco, mfclack, mfo, focg, mfcg, stopi, stopo, rcsack, rcsreq);

    parameter FIFODEPTH  = 9;
    parameter DATAWIDTH  = 32;
    `include "utility.v"

    input clk; 
    input rst; 
    input rxdv; 
    input rxer; 
    input col; 
    input[3:0] rxd; 
    output ramwe; 
    wire ramwe;
    output[FIFODEPTH - 1:0] ramaddr; 
    wire[FIFODEPTH - 1:0] ramaddr;
    output[DATAWIDTH - 1:0] ramdata; 
    wire[DATAWIDTH - 1:0] ramdata;
    input[ADDRWIDTH - 1:0] fdata; 
    output[ADDRDEPTH - 1:0] faddr; 
    wire[ADDRDEPTH - 1:0] faddr;
    input cachenf; 
    input[FIFODEPTH - 1:0] radg; 
    output[FIFODEPTH - 1:0] wadg; 
    wire[FIFODEPTH - 1:0] wadg;
    output rprog; 
    reg rprog;
    output rcpoll; 
    wire rcpoll;
    input riack; 
    input ren; 
    input ra; 
    input pm; 
    input pr; 
    input pb; 
    input rif; 
    input ho; 
    input hp; 
    output rireq; 
    reg rireq;
    output ff; 
    reg ff;
    output rf; 
    reg rf;
    output mf; 
    reg mf;
    output db; 
    reg db;
    output re; 
    reg re;
    output ce; 
    reg ce;
    output tl; 
    reg tl;
    output ftp; 
    reg ftp;
    output ov; 
    reg ov;
    output cs; 
    reg cs;
    output[13:0] length; 
    reg[13:0] length;
    input match; 
    input matchval; 
    output matchen; 
    reg matchen;
    output[47:0] matchdata; 
    wire[47:0] matchdata;
    input mfcl; 
    input focl; 
    output foclack; 
    wire foclack;
    output oco; 
    reg oco;
    output mfclack; 
    wire mfclack;
    output mfo; 
    reg mfo;
    output[10:0] focg; 
    reg[10:0] focg;
    output[15:0] mfcg; 
    reg[15:0] mfcg;
    input stopi; 
    output stopo; 
    reg stopo;
    input rcsack; 
    output rcsreq; 
    reg rcsreq;

    //---------------------------- fifo ---------------------------------
    // frame cache not full registered
    reg cachenf_2r; 
    // bytes counter when frame cache full
    reg fcfbcnt; 
    // bytes counter when frame cache full registered
    reg fcfbcnt_r; 
    // end of receiving frame when frame cache full
    reg eorfff; 
    // fifo write enable registered
    reg we; 
    // fifo full registered
    reg full; 
    // fifo write address registered
    reg[FIFODEPTH - 1:0] wad; 
    // fifo write address incremented registered
    reg[FIFODEPTH - 1:0] wadi; 
    // fifo write address grey coded registered
    reg[FIFODEPTH - 1:0] iwadg; 
    // fifo write address incremented grey coded registered
    reg[FIFODEPTH - 1:0] wadig; 
    // collision detected
    reg col_r; 
    // fifo read address grey coded registered
    reg[FIFODEPTH - 1:0] radg_r; 
    // start of frame address registered
    reg[FIFODEPTH - 1:0] isofad; 
    // frame cache not full
    reg cachenf_r; 
    //------------------------------ mii --------------------------------
    // mii data valid registered
    reg rxdv_r; 
    // mii error registered
    reg rxer_r; 
    // mii receive data registered
    reg[3:0] rxd_r; 
    // mii receive data 4 bit registered
    wire[3:0] rxd_r4; 
    //--------------------------- framing -------------------------------
    // frame sequencer state machine combinatorial
    reg[3:0] rsm_c; 
    // frame sequencer state machine registered
    reg[3:0] rsm; 
    // nibble counter
    reg[3:0] ncnt; 
    // 2 least significant bits of nibble counter
    wire[1:0] ncnt10; 
    // 3 least significant bits of nibble counter
    wire[2:0] ncnt20; 
    // data register combinatorial
    reg[DATAWIDTH - 1:0] data_c; 
    // data register registered
    reg[DATAWIDTH - 1:0] data; 
    // crc remainder combinatorial
    reg[31:0] crc_c; 
    // crc remainder registered
    reg[31:0] crc; 
    // byte counter
    reg[6:0] bcnt; 
    // 3 least significant bits of byte counter
    wire[2:0] bcnt20; 
    // byte counter = 0
    reg bz; 
    // collision window passed registered
    reg winp; 
    // interrupt request combinatorial
    wire iri_c; 
    // interrupt request registered
    reg iri; 
    // interrupt acknowledge registered
    reg riack_r; 
    // frame length counter
    reg[13:0] lcnt; 
    // LENGTH/TYPE field
    reg[15:0] lfield; 
    // receive enable registered
    reg ren_r; 
    // receive in progress
    reg irprog; 
    //---------------------- address filtering --------------------------
    // filtering state machine combinatorial
    reg[2:0] fsm_c; 
    // filtering state machine registered
    reg[2:0] fsm; 
    // perfect address match combinatorial
    reg perfm_c; 
    // perfect address match registered
    reg perfm; 
    // inverse match registered
    reg invm; 
    // crc value for hash table registered
    reg[8:0] crchash; 
    // hash table match registered
    reg hash; 
    // DA frame field
    reg[47:0] dest; 
    // counter for 16-bit words in 48-bit ethernet address
    reg[2:0] flcnt; 
    // filtering ram address
    reg[ADDRDEPTH - 1:0] fa; 
    // filtering ram data registered
    reg[15:0] fdata_r; 
    //---------------------------- timers -------------------------------
    // cycle size request
    reg rcs; 
    // cycle size acknowledge registered
    reg rcsack_r; 
    // cycle size counter
    reg[7:0] rcscnt; 
    //-------------------- statistical counters -------------------------
    // fifo overflow counter
    reg[10:0] focnt; 
    // fifo overflow counter clear registered
    reg focl_r; 
    // missed frames counter
    reg[15:0] mfcnt; 
    // missed counter clear registered
    reg mfcl_r; 
    //------------------------ power management -------------------------
    // stop receive process registered
    reg stop_r; 
    //---------------------------- others -------------------------------
    // all zeros vector for fifo (predefined value)
    wire[FIFODEPTH - 1:0] fzero; 

    //===================================================================--
    //                                 mii                               --
    //===================================================================--
    //-------------------------------------------------------------------
    // mii interface registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : mii_reg_proc
        if (rst == 1'b0)
        begin
            rxdv_r <= 1'b0 ; 
            rxer_r <= 1'b0 ; 
            col_r <= 1'b0 ; 
            rxd_r <= {4{1'b0}} ; 
            data <= {DATAWIDTH - 1-(0)+1{1'b1}} ; 
        end
        else
        begin
            rxdv_r <= rxdv ; 
            rxer_r <= rxer ; 
            col_r <= col ; 
            rxd_r <= rxd ; 
            data <= data_c ; 
        end 
    end // mii_reg_proc
    //-------------------------------------------------------------------
    // mii receive data 4 bit
    //-------------------------------------------------------------------
    assign rxd_r4 = rxd_r ;
    //-------------------------------------------------------------------
    // 2 least significant bits of nibble counter
    //-------------------------------------------------------------------
    assign ncnt10 = ncnt[1:0] ;
    //-------------------------------------------------------------------
    // 3 least significant bits of nibble counter
    //-------------------------------------------------------------------
    assign ncnt20 = ncnt[2:0] ;

    //-------------------------------------------------------------------
    // receive data combinatorial
    //-------------------------------------------------------------------
    // Changes made to this process in v3.0 due to vector width misalignments SAR56860
    always @(ncnt or ncnt10 or ncnt20 or rxd_r or data)
    begin : data_proc
        reg[31:0] data16; // only uses 15:0, other bits for alignment
        reg[31:0] data32; 
        data_c <= {DATAWIDTH - 1-(0)+1{1'b0}} ; 
        case (DATAWIDTH)
            //---------------------------------------
            8 :
                        begin
                            //---------------------------------------
                            data_c <= data ; 
                            if ((ncnt[0]) == 1'b0)
                            begin
                                data_c[3:0] <= rxd_r ; 
                            end
                            else
                            begin
                                data_c[7:4] <= rxd_r ; 
                            end 
                        end
            16 :
                        begin
                            //---------------------------------------
                            data16 = {32{1'b0}}; 
                            data16[15:0] = data[15:0]; 
                            case (ncnt10)
                                //---------------------------------------
                                2'b00 :
                                            begin
                                                data16[3:0] = rxd_r; 
                                            end
                                2'b01 :
                                            begin
                                                data16[7:4] = rxd_r; 
                                            end
                                2'b10 :
                                            begin
                                                data16[11:8] = rxd_r; 
                                            end
                                default :
                                            begin
                                                data16[15:12] = rxd_r; 
                                            end
                            endcase 
                            data_c[DATAWIDTH - 1:0] <= data16[DATAWIDTH - 1:0] ; 
                        end
            default :
                        begin
                            // 32
                            //---------------------------------------
                            data32 = data; 
                            case (ncnt20)
                                //---------------------------------------
                                3'b000 :
                                            begin
                                                data32[3:0] = rxd_r; 
                                            end
                                3'b001 :
                                            begin
                                                data32[7:4] = rxd_r; 
                                            end
                                3'b010 :
                                            begin
                                                data32[11:8] = rxd_r; 
                                            end
                                3'b011 :
                                            begin
                                                data32[15:12] = rxd_r; 
                                            end
                                3'b100 :
                                            begin
                                                data32[19:16] = rxd_r; 
                                            end
                                3'b101 :
                                            begin
                                                data32[23:20] = rxd_r; 
                                            end
                                3'b110 :
                                            begin
                                                data32[27:24] = rxd_r; 
                                            end
                                default :
                                            begin
                                                data32[31:28] = rxd_r; 
                                            end
                            endcase 
                            data_c[DATAWIDTH - 1:0] <= data32[DATAWIDTH - 1:0] ; 
                        end
        endcase 
    end // data_proc

    //===================================================================--
    //                               rfifo                               --
    //===================================================================--
    //-------------------------------------------------------------------
    // fifo full logic registered
    //-------------------------------------------------------------------  
    always @(posedge clk or negedge rst)
    begin : fifofull_reg_proc
        if (rst == 1'b0)
        begin
            cachenf_2r <= 1'b1 ; 
            cachenf_r <= 1'b1 ; 
            full <= 1'b0 ; 
        end
        else
        begin
            // frame chache not full
            cachenf_r <= cachenf ; 
            // frame chache not full registered
            if (cachenf_2r == 1'b1 | ((rxdv_r == 1'b0 & cachenf_r == 1'b1) | (rxdv_r == 1'b1 & cachenf_r == 1'b1 & (rsm == RSM_IDLE | rsm == RSM_SFD))))
            begin
                cachenf_2r <= cachenf_r ; 
            end 
            // fifo full
            if (wadig == radg_r | (iwadg == radg_r & full == 1'b1))
            begin
                full <= 1'b1 ; 
            end
            else
            begin
                full <= 1'b0 ; 
            end 
        end 
    end // fifofull_reg_proc

    //-------------------------------------------------------------------
    // fifo address registered
    //-------------------------------------------------------------------  
    always @(posedge clk or negedge rst)
    begin : addr_reg_proc
        if (rst == 1'b0)
        begin
            wad <= {FIFODEPTH - 1-(0)+1{1'b0}} ; 
            wadi <= {fzero[FIFODEPTH - 1:1], 1'b1} ; 
            iwadg <= {FIFODEPTH - 1-(0)+1{1'b0}} ; 
            isofad <= {FIFODEPTH - 1-(0)+1{1'b0}} ; 
            wadig <= {fzero[FIFODEPTH - 1:1], 1'b1} ; 
            radg_r <= {FIFODEPTH - 1-(0)+1{1'b0}} ; 
        end
        else
        begin
            // fifo write address
            if (rsm == RSM_BAD)
            begin
                wad <= isofad ; 
            end
            else if (we == 1'b1)
            begin
                wad <= wad + 1 ; 
            end 
            // fifo write address incremented
            if (rsm == RSM_BAD)
            begin
                wadi <= isofad + 1 ; 
            end
            else if (we == 1'b1)
            begin
                wadi <= wadi + 1 ; 
            end 
            // fifo write address grey coded
            iwadg[FIFODEPTH - 1] <= wad[FIFODEPTH - 1] ; 
            begin : xhdl_10
                integer i;
                for(i = FIFODEPTH - 2; i >= 0; i = i - 1)
                begin
                    iwadg[i] <= wad[i + 1] ^ wad[i] ; 
                end
            end 
            // fifo write address incremented grey coded
            wadig[FIFODEPTH - 1] <= wadi[FIFODEPTH - 1] ; 
            begin : xhdl_11
                integer i;
                for(i = FIFODEPTH - 2; i >= 0; i = i - 1)
                begin
                    wadig[i] <= wadi[i + 1] ^ wadi[i] ; 
                end
            end 
            // fifo start of frame address
            if (rsm == RSM_IDLE)
            begin
                isofad <= wad ; 
            end 
            // fifo read address grey coded
            radg_r <= radg ; 
        end 
    end // addr_reg_proc

    //-------------------------------------------------------------------
    // fifo write enable registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : we_reg_proc
        if (rst == 1'b0)
        begin
            we <= 1'b0 ; 
        end
        else
        begin
            if ((rsm == RSM_INFO | rsm == RSM_DEST | rsm == RSM_LENGTH | rsm == RSM_SOURCE) & 
                  ((rxdv_r == 1'b1 & ((DATAWIDTH == 8 & (ncnt[0]) == 1'b1) 
                                    | (DATAWIDTH == 16 & ncnt[1:0] == 2'b11) 
                                    | (DATAWIDTH == 32 & ncnt[2:0] == 3'b111)
                                    )) 
                   | (rxdv_r == 1'b0 & we == 1'b0 & (DATAWIDTH == 16 & ncnt[2:1] != 2'b00)) //IPB SAR73505
                   | (rxdv_r == 1'b0 & we == 1'b0 & (DATAWIDTH == 32 & ncnt[2:1] != 2'b00)) 
                   | (full == 1'b1 & we == 1'b0)))
            begin
                we <= 1'b1 ; 
            end
            else
            begin
                we <= 1'b0 ; 
            end 
        end 
    end // we_reg_proc
    //-------------------------------------------------------------------
    // ram data
    // registered output from data
    //-------------------------------------------------------------------
    assign ramdata = data ;
    //-------------------------------------------------------------------
    // ram write enable
    // registered output from we
    //-------------------------------------------------------------------
    assign ramwe = we ;
    //-------------------------------------------------------------------
    // ram address
    // registered output from wadddr
    //-------------------------------------------------------------------
    assign ramaddr = wad ;
    //-------------------------------------------------------------------
    // fifo write address
    // registered output from iwadg
    //-------------------------------------------------------------------
    assign wadg = iwadg ;

    //===================================================================--
    //                                frame                              --
    //===================================================================--
    //-------------------------------------------------------------------
    // receive sequencer state machine combinatorial
    //-------------------------------------------------------------------
    always @(rsm or rxdv_r or rxd_r or rxd_r4 or stop_r or bz or fsm or ra or 
             pm or pb or dest or riack_r or full or ren_r or winp or irprog or 
             cachenf_r)
    begin : rsm_proc
        case (rsm)
            //-----------------------------------------
            RSM_IDLE_RCSMT :
                        begin
                            if (rxdv_r == 1'b1 & stop_r == 1'b0 & ren_r == 1'b1)
                            begin
                                //-----------------------------------------
                                if (rxd_r == 4'b0101)
                                begin
                                    rsm_c <= RSM_SFD ; 
                                end
                                else
                                begin
                                    rsm_c <= RSM_IDLE_RCSMT ; 
                                end 
                            end
                            else
                            begin
                                rsm_c <= RSM_IDLE_RCSMT ; 
                            end 
                        end
            RSM_SFD :
                        begin
                            //-----------------------------------------
                            if (rxdv_r == 1'b1 & full == 1'b0 & cachenf_r == 1'b1)
                            begin
                                case (rxd_r4)
                                    //-----------------------------------------
                                    4'b1101 :
                                                begin
                                                    rsm_c <= RSM_DEST ; 
                                                end
                                    4'b0101 :
                                                begin
                                                    rsm_c <= RSM_SFD ; 
                                                end
                                    default :
                                                begin
                                                    rsm_c <= RSM_IDLE_RCSMT ; 
                                                end
                                endcase 
                            end
                            else if (full == 1'b1 | cachenf_r == 1'b0)
                            begin
                                rsm_c <= RSM_BAD ; 
                            end
                            else
                            begin
                                rsm_c <= RSM_IDLE_RCSMT ; 
                            end 
                        end
            //-----------------------------------------
            RSM_DEST :
                        begin
                            //-----------------------------------------
                            if (rxdv_r == 1'b0 | full == 1'b1 | cachenf_r == 1'b0)
                            begin
                                rsm_c <= RSM_BAD ; 
                            end
                            else if (bz == 1'b1)
                            begin
                                rsm_c <= RSM_SOURCE ; 
                            end
                            else
                            begin
                                rsm_c <= RSM_DEST ; 
                            end 
                        end
            //-----------------------------------------
            RSM_SOURCE :
                        begin
                            if (rxdv_r == 1'b0)
                            begin
                                //-----------------------------------------
                                if ((pb == 1'b1) & (fsm == FSM_MATCH | ra == 1'b1 | (pm == 1'b1 & (dest[0]) == 1'b1)))
                                begin
                                    rsm_c <= RSM_SUCC ; 
                                end
                                else
                                begin
                                    rsm_c <= RSM_BAD ; 
                                end 
                            end
                            else if (full == 1'b1 | cachenf_r == 1'b0)
                            begin
                                rsm_c <= RSM_BAD ; 
                            end
                            else if (bz == 1'b1)
                            begin
                                rsm_c <= RSM_LENGTH ; 
                            end
                            else
                            begin
                                rsm_c <= RSM_SOURCE ; 
                            end 
                        end
            //-----------------------------------------
            RSM_LENGTH :
                        begin
                            if (rxdv_r == 1'b0)
                            begin
                                //-----------------------------------------
                                if ((pb == 1'b1) & (fsm == FSM_MATCH | ra == 1'b1 | (pm == 1'b1 & (dest[0]) == 1'b1)))
                                begin
                                    rsm_c <= RSM_SUCC ; 
                                end
                                else
                                begin
                                    rsm_c <= RSM_BAD ; 
                                end 
                            end
                            else if (full == 1'b1 | cachenf_r == 1'b0)
                            begin
                                rsm_c <= RSM_BAD ; 
                            end
                            else if (bz == 1'b1)
                            begin
                                rsm_c <= RSM_INFO ; 
                            end
                            else
                            begin
                                rsm_c <= RSM_LENGTH ; 
                            end 
                        end
            //-----------------------------------------
            RSM_INFO :
                        begin
                            if (rxdv_r == 1'b0)
                            begin
                                //-----------------------------------------
                                if ((winp == 1'b1 | pb == 1'b1) & (fsm == FSM_MATCH | ra == 1'b1 | (pm == 1'b1 & (dest[0]) == 1'b1)))
                                begin
                                    rsm_c <= RSM_SUCC ; 
                                end
                                else
                                begin
                                    rsm_c <= RSM_BAD ; 
                                end 
                            end
                            else if (full == 1'b1 | cachenf_r == 1'b0)
                            begin
                                if (winp == 1'b1)
                                begin
                                    rsm_c <= RSM_SUCC ; 
                                end
                                else
                                begin
                                    rsm_c <= RSM_BAD ; 
                                end 
                            end
                            else if (fsm == FSM_FAIL & ra == 1'b0 & ~(pm == 1'b1 & (dest[0]) == 1'b1))
                            begin
                                rsm_c <= RSM_BAD ; 
                            end
                            else
                            begin
                                rsm_c <= RSM_INFO ; 
                            end 
                        end
            //-----------------------------------------
            RSM_SUCC :
                        begin
                            //-----------------------------------------
                            rsm_c <= RSM_INT ; 
                        end
            //-----------------------------------------
            RSM_INT :
                        begin
                            //-----------------------------------------
                            if (riack_r == 1'b1)
                            begin
                                rsm_c <= RSM_INT1 ; 
                            end
                            else
                            begin
                                rsm_c <= RSM_INT ; 
                            end 
                        end
            //-----------------------------------------
            RSM_INT1 :
                        begin
                            //-----------------------------------------
                            if (rxdv_r == 1'b0 & riack_r == 1'b0)
                            begin
                                rsm_c <= RSM_IDLE_RCSMT ; 
                            end
                            else
                            begin
                                rsm_c <= RSM_INT1 ; 
                            end 
                        end
            //-----------------------------------------
            default :
                        begin
                            // RSM_BAD
                            //-----------------------------------------
                            if (rxdv_r == 1'b0 & riack_r == 1'b0 & irprog == 1'b0)
                            begin
                                rsm_c <= RSM_IDLE_RCSMT ; 
                            end
                            else
                            begin
                                rsm_c <= RSM_BAD ; 
                            end 
                        end
        endcase 
    end // rsm_proc

    //-------------------------------------------------------------------
    // receive sequencer state machine registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : rsm_reg_proc
        if (rst == 1'b0)
        begin
            rsm <= RSM_IDLE_RCSMT ; 
        end
        else
        begin
            rsm <= rsm_c ; 
        end 
    end // rsm_reg_proc

    //-------------------------------------------------------------------
    // receive in progress registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : rprog_reg_proc
        if (rst == 1'b0)
        begin
            irprog <= 1'b0 ; 
            rprog <= 1'b0 ; 
        end
        else
        begin
            // internal receive in progress
            if (rsm == RSM_IDLE | rsm == RSM_BAD | rsm == RSM_INT | rsm == RSM_INT1)
            begin
                irprog <= 1'b0 ; 
            end
            else
            begin
                irprog <= 1'b1 ; 
            end 
            // receive in progress
            if (winp == 1'b1 & irprog == 1'b1)
            begin
                rprog <= 1'b1 ; 
            end
            else
            begin
                rprog <= 1'b0 ; 
            end 
        end 
    end // rprog_reg_proc
    //-------------------------------------------------------------------
    // rc poll
    //-------------------------------------------------------------------
    assign rcpoll = irprog ;

    //-------------------------------------------------------------------
    // byte & nibble counter registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : bncnt_reg_proc
        if (rst == 1'b0)
        begin
            bcnt <= {7{1'b0}} ; 
            bz <= 1'b0 ; 
            ncnt <= 4'b0000 ; 
        end
        else
        begin
            if (cachenf_r == 1'b1)
            begin
                if (bz == 1'b1 | rsm == RSM_IDLE)
                begin
                    case (rsm)
                        //-----------------------------------
                        RSM_IDLE_RCSMT :
                                    begin
                                        //-----------------------------------
                                        bcnt <= 7'b0000101 ; // 6B
                                    end
                        //-----------------------------------
                        RSM_DEST :
                                    begin
                                        //-----------------------------------
                                        bcnt <= 7'b0000101 ; // 6B
                                    end
                        //-----------------------------------
                        RSM_SOURCE :
                                    begin
                                        //-----------------------------------
                                        bcnt <= 7'b0000001 ; // 2B
                                    end
                        //-----------------------------------
                        default :
                                    begin
                                        // RSM_LENGTH
                                        //-----------------------------------
                                        bcnt <= 7'b0110001 ; // 50B
                                    end
                    endcase 
                end
                else
                begin
                    // byte counter
                    if ((ncnt[0]) == 1'b1)
                    begin
                        bcnt <= bcnt - 1 ; 
                    end 
                end 
            end
            else
            begin
                if (fcfbcnt_r == 1'b0)
                begin
                    bcnt <= 7'b0111111 ; // 50+6+6+2
                end
                else
                begin
                    if ((ncnt[0]) == 1'b0)
                    begin
                        bcnt <= bcnt - 1 ; 
                    end 
                end 
            end 
            // byte counter = 0
            if ((bcnt == 7'b0000000 & (ncnt[0]) == 1'b0 & cachenf_2r == 1'b1) | (bcnt == 7'b0000000 & (ncnt[0]) == 1'b1 & cachenf_2r == 1'b0))
            begin
                bz <= 1'b1 ; 
            end
            else
            begin
                bz <= 1'b0 ; 
            end 
            // nibble counter
            if (rsm == RSM_SFD | rsm == RSM_IDLE)
            begin
                ncnt <= 4'b0000 ; 
            end
            else
            begin
                ncnt <= ncnt + 1 ; 
            end 
        end 
    end // bcnt_reg_proc

    //-------------------------------------------------------------------
    // 512-bit window passed registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : winp_reg_proc
        if (rst == 1'b0)
        begin
            winp <= 1'b0 ; 
        end
        else
        begin
            if (rsm == RSM_IDLE)
            begin
                winp <= 1'b0 ; 
            end
            else
            begin
                if ((rsm == RSM_INFO & cachenf_2r == 1'b1 & bz == 1'b1) | (rsm == RSM_BAD & cachenf_2r == 1'b0 & bz == 1'b1))
                begin
                    winp <= 1'b1 ; 
                end 
            end 
        end 
    end // winp_reg_proc

    //-------------------------------------------------------------------
    // crc combinatorial
    //-------------------------------------------------------------------
    always @(crc or rsm or rxd_r)
    begin : crc_proc
        crc_c <= crc ; 
        case (rsm)
            //-----------------------------------------
            RSM_IDLE_RCSMT :
                        begin
                            //-----------------------------------------
                            crc_c <= {32{1'b1}} ; 
                        end
            //-----------------------------------------
            RSM_DEST, RSM_SOURCE, RSM_LENGTH, RSM_INFO :
                        begin
                            //-----------------------------------------
                            crc_c[0] <= crc[28] ^ rxd_r[3] ; 
                            crc_c[1] <= crc[28] ^ crc[29] ^ rxd_r[2] ^ rxd_r[3] ; 
                            crc_c[2] <= crc[28] ^ crc[29] ^ crc[30] ^ rxd_r[1] ^ rxd_r[2] ^ rxd_r[3] ; 
                            crc_c[3] <= crc[29] ^ crc[30] ^ crc[31] ^ rxd_r[0] ^ rxd_r[1] ^ rxd_r[2] ; 
                            crc_c[4] <= crc[0] ^ crc[28] ^ crc[30] ^ crc[31] ^ rxd_r[0] ^ rxd_r[1] ^ rxd_r[3] ; 
                            crc_c[5] <= crc[1] ^ crc[28] ^ crc[29] ^ crc[31] ^ rxd_r[0] ^ rxd_r[2] ^ rxd_r[3] ; 
                            crc_c[6] <= crc[2] ^ crc[29] ^ crc[30] ^ rxd_r[1] ^ rxd_r[2] ; 
                            crc_c[7] <= crc[3] ^ crc[28] ^ crc[30] ^ crc[31] ^ rxd_r[0] ^ rxd_r[1] ^ rxd_r[3] ; 
                            crc_c[8] <= crc[4] ^ crc[28] ^ crc[29] ^ crc[31] ^ rxd_r[0] ^ rxd_r[2] ^ rxd_r[3] ; 
                            crc_c[9] <= crc[5] ^ crc[29] ^ crc[30] ^ rxd_r[1] ^ rxd_r[2] ; 
                            crc_c[10] <= crc[6] ^ crc[28] ^ crc[30] ^ crc[31] ^ rxd_r[0] ^ rxd_r[1] ^ rxd_r[3] ; 
                            crc_c[11] <= crc[7] ^ crc[28] ^ crc[29] ^ crc[31] ^ rxd_r[0] ^ rxd_r[2] ^ rxd_r[3] ; 
                            crc_c[12] <= crc[8] ^ crc[28] ^ crc[29] ^ crc[30] ^ rxd_r[1] ^ rxd_r[2] ^ rxd_r[3] ; 
                            crc_c[13] <= crc[9] ^ crc[29] ^ crc[30] ^ crc[31] ^ rxd_r[0] ^ rxd_r[1] ^ rxd_r[2] ; 
                            crc_c[14] <= crc[10] ^ crc[30] ^ crc[31] ^ rxd_r[0] ^ rxd_r[1] ; 
                            crc_c[15] <= crc[11] ^ crc[31] ^ rxd_r[0] ; 
                            crc_c[16] <= crc[12] ^ crc[28] ^ rxd_r[3] ; 
                            crc_c[17] <= crc[13] ^ crc[29] ^ rxd_r[2] ; 
                            crc_c[18] <= crc[14] ^ crc[30] ^ rxd_r[1] ; 
                            crc_c[19] <= crc[15] ^ crc[31] ^ rxd_r[0] ; 
                            crc_c[20] <= crc[16] ; 
                            crc_c[21] <= crc[17] ; 
                            crc_c[22] <= crc[18] ^ crc[28] ^ rxd_r[3] ; 
                            crc_c[23] <= crc[19] ^ crc[28] ^ crc[29] ^ rxd_r[2] ^ rxd_r[3] ; 
                            crc_c[24] <= crc[20] ^ crc[29] ^ crc[30] ^ rxd_r[1] ^ rxd_r[2] ; 
                            crc_c[25] <= crc[21] ^ crc[30] ^ crc[31] ^ rxd_r[0] ^ rxd_r[1] ; 
                            crc_c[26] <= crc[22] ^ crc[28] ^ crc[31] ^ rxd_r[0] ^ rxd_r[3] ; 
                            crc_c[27] <= crc[23] ^ crc[29] ^ rxd_r[2] ; 
                            crc_c[28] <= crc[24] ^ crc[30] ^ rxd_r[1] ; 
                            crc_c[29] <= crc[25] ^ crc[31] ^ rxd_r[0] ; 
                            crc_c[30] <= crc[26] ; 
                            crc_c[31] <= crc[27] ; 
                        end
            //-----------------------------------------
            default :
                        begin
                            // RSM_CRC | RSM_SFD
                            //-----------------------------------------
                        end
        endcase 
    end // crc_proc

    //-------------------------------------------------------------------
    // crc registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : crc_reg_proc
        if (rst == 1'b0)
        begin
            crc <= {32{1'b1}} ; 
        end
        else
        begin
            crc <= crc_c ; 
        end 
    end // crc_reg_proc
    //-------------------------------------------------------------------
    // receive interrupts combinatorial
    //-------------------------------------------------------------------
    assign iri_c = (rsm == RSM_INT) ? 1'b1 : 1'b0 ;

    //-------------------------------------------------------------------
    // receive interrupt control registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : rint_reg_proc
        if (rst == 1'b0)
        begin
            iri <= 1'b0 ; 
            riack_r <= 1'b0 ; 
            rireq <= 1'b0 ; 
        end
        else
        begin
            iri <= iri_c ; 
            riack_r <= riack ; 
            rireq <= iri ; 
        end 
    end // rint_reg_proc

    //-------------------------------------------------------------------
    // receive length counter registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : length_reg_proc
        if (rst == 1'b0)
        begin
            lcnt <= {14{1'b0}} ; 
            length <= {14{1'b0}} ; 
        end
        else
        begin
            if ((rsm == RSM_IDLE & cachenf_2r == 1'b1) | (fcfbcnt == 1'b0 & cachenf_2r == 1'b0) | rsm == RSM_INT1)
            begin
                lcnt <= {14{1'b0}} ; 
            end
            else if (((rsm == RSM_INFO | rsm == RSM_LENGTH | rsm == RSM_DEST | rsm == RSM_SOURCE) & rxdv_r == 1'b1) | (fcfbcnt == 1'b1 & cachenf_2r == 1'b0))
            begin
                // frame length counter
                if ((ncnt[0]) == 1'b1)
                begin
                    lcnt <= lcnt + 1 ; 
                end 
            end 
            // frame length grey coded
            length[13] <= lcnt[13] ; 
            begin : xhdl_36
                integer i;
                for(i = 12; i >= 0; i = i - 1)
                begin
                    length[i] <= lcnt[i + 1] ^ lcnt[i] ; 
                end
            end 
        end 
    end // length_reg_proc

    //-------------------------------------------------------------------
    // bytes counter when frame cache full
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : fcfbcnt_reg_proc
        if (rst == 1'b0)
        begin
            fcfbcnt <= 1'b0 ; 
            fcfbcnt_r <= 1'b0 ; 
        end
        else
        begin
            if (cachenf_2r == 1'b0)
            begin
                if (rxdv_r == 1'b1 & rxd_r4 == 4'b1101)
                begin
                    fcfbcnt <= 1'b1 ; 
                end
                else if (rxdv_r == 1'b0)
                begin
                    fcfbcnt <= 1'b0 ; 
                end 
            end
            else
            begin
                fcfbcnt <= 1'b0 ; 
            end 
            fcfbcnt_r <= fcfbcnt ; 
        end 
    end // fcfbcnt_reg_proc

    //-------------------------------------------------------------------
    // end of receiving frame when frame cache full
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : eorfff_reg_proc
        if (rst == 1'b0)
        begin
            eorfff <= 1'b0 ; 
        end
        else
        begin
            if (rsm_c == RSM_IDLE & rsm == RSM_BAD & cachenf_2r == 1'b0)
            begin
                eorfff <= 1'b1 ; 
            end
            else
            begin
                eorfff <= 1'b0 ; 
            end 
        end 
    end // eorfff_reg_proc

    //-------------------------------------------------------------------
    // statistic informations registered
    //-------------------------------------------------------------------  
    always @(posedge clk or negedge rst)
    begin : stat_reg_proc
        if (rst == 1'b0)
        begin
            lfield <= {16{1'b0}} ; 
            ftp <= 1'b0 ; 
            tl <= 1'b0 ; 
            ff <= 1'b0 ; 
            mf <= 1'b0 ; 
            re <= 1'b0 ; 
            ce <= 1'b0 ; 
            db <= 1'b0 ; 
            rf <= 1'b0 ; 
            ov <= 1'b0 ; 
            cs <= 1'b0 ; 
        end
        else
        begin
            if (rsm == RSM_LENGTH)
            begin
                if (bcnt[1:0] == 2'b00)
                begin
                    // frame LENGTH/TYPE field
                    if ((ncnt[0]) == 1'b0)
                    begin
                        lfield[3:0] <= rxd_r ; 
                    end
                    else
                    begin
                        lfield[7:4] <= rxd_r ; 
                    end 
                end
                else
                begin
                    if ((ncnt[0]) == 1'b0)
                    begin
                        lfield[11:8] <= rxd_r ; 
                    end
                    else
                    begin
                        lfield[15:12] <= rxd_r ; 
                    end 
                end 
            end 
            // frame type
            if (lfield > MAX_SIZE)
            begin
                ftp <= 1'b1 ; 
            end
            else
            begin
                ftp <= 1'b0 ; 
            end 
            // frame too long
            if (lcnt == MAX_FRAME & iri_c == 1'b0)
            begin
                tl <= 1'b1 ; 
            end
            else if (rsm == RSM_IDLE)
            begin
                tl <= 1'b0 ; 
            end 
            if (iri_c == 1'b0)
            begin
                // filtering fail
                if (fsm == FSM_MATCH)
                begin
                    ff <= 1'b0 ; 
                end
                else
                begin
                    ff <= 1'b1 ; 
                end 
            end 
            // multicast frame
            if (iri_c == 1'b0)
            begin
                mf <= dest[0] ; 
            end 
            // mii error
            if (rxer_r == 1'b1 & iri_c == 1'b0)
            begin
                re <= 1'b1 ; 
            end
            else if (rsm == RSM_IDLE)
            begin
                re <= 1'b0 ; 
            end 
            // collision seen
            if (col_r == 1'b1 & iri_c == 1'b0)
            begin
                cs <= 1'b1 ; 
            end
            else if (rsm == RSM_IDLE)
            begin
                cs <= 1'b0 ; 
            end 
            if (rsm == RSM_INFO & (ncnt[0]) == 1'b0)
            begin
                // crc error
                if (crc == CRCVAL)
                begin
                    ce <= 1'b0 ; 
                end
                else
                begin
                    ce <= 1'b1 ; 
                end 
            end 
            if (rsm == RSM_INFO)
            begin
                // dribbling bit
                if (rxdv_r == 1'b0 & (ncnt[0]) == 1'b1)
                begin
                    db <= 1'b1 ; 
                end
                else
                begin
                    db <= 1'b0 ; 
                end 
            end 
            // runt frame
            if (winp == 1'b0 & iri_c == 1'b1)
            begin
                rf <= 1'b1 ; 
            end
            else if (rsm == RSM_IDLE)
            begin
                rf <= 1'b0 ; 
            end 
            // fifo overflow
            if (rsm == RSM_IDLE)
            begin
                ov <= 1'b0 ; 
            end
            else if (full == 1'b1 | cachenf_r == 1'b0)
            begin
                ov <= 1'b1 ; 
            end 
        end 
    end // stat_reg_proc

    //-------------------------------------------------------------------
    // receive enable registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : ren_reg_proc
        if (rst == 1'b0)
        begin
            ren_r <= 1'b0 ; 
        end
        else
        begin
            if (rsm == RSM_IDLE)
            begin
                ren_r <= ren ; 
            end 
        end 
    end // ren_reg_proc

    //===================================================================--
    //                         address filtering                         --
    //===================================================================--
    //-------------------------------------------------------------------
    // address filtering state machine
    //-------------------------------------------------------------------
    always @(fsm or rsm or ho or hp or dest or lcnt or ncnt or flcnt or perfm or 
             hash or pr or fa or invm or rif or matchval or match)
    begin : fsm_proc
        case (fsm)
            //-----------------------------------------
            FSM_IDLE :
                        begin
                            if (lcnt[2:0] == 3'b101 & (ncnt[0]) == 1'b1)
                            begin
                                //-----------------------------------------
                                if (pr == 1'b1)
                                begin
                                    fsm_c <= FSM_MATCH ; 
                                end
                                else if (ho == 1'b1 | (hp == 1'b1 & (dest[0]) == 1'b1))
                                begin
                                    fsm_c <= FSM_HASH ; 
                                end
                                else if (hp == 1'b0)
                                begin
                                    fsm_c <= FSM_PERF16 ; 
                                end
                                else
                                begin
                                    fsm_c <= FSM_PERF1 ; 
                                end 
                            end
                            else
                            begin
                                fsm_c <= FSM_IDLE ; 
                            end 
                        end
            //-----------------------------------------
            FSM_PERF1 :
                        begin
                            if (fa == 6'b101100)
                            begin
                                //-----------------------------------------
                                if (perfm == 1'b1 | (matchval == 1'b1 & match == 1'b1))
                                begin
                                    fsm_c <= FSM_MATCH ; 
                                end
                                else
                                begin
                                    fsm_c <= FSM_FAIL ; 
                                end 
                            end
                            else
                            begin
                                fsm_c <= FSM_PERF1 ; 
                            end 
                        end
            //-----------------------------------------
            FSM_PERF16 :
                        begin
                            //-----------------------------------------
                            if ((flcnt == 3'b010 & perfm == 1'b1 & rif == 1'b0) | (fa == 6'b110010 & rif == 1'b1 & invm == 1'b1) | (matchval == 1'b1 & match == 1'b1))
                            begin
                                fsm_c <= FSM_MATCH ; 
                            end
                            else if (fa == 6'b110010)
                            begin
                                fsm_c <= FSM_FAIL ; 
                            end
                            else
                            begin
                                fsm_c <= FSM_PERF16 ; 
                            end 
                        end
            //-----------------------------------------
            FSM_HASH :
                        begin
                            if (matchval == 1'b1 & match == 1'b1)
                            begin
                                fsm_c <= FSM_MATCH ; 
                            end
                            else if (flcnt == 3'b101)
                            begin
                                //-----------------------------------------
                                if (hash == 1'b1)
                                begin
                                    fsm_c <= FSM_MATCH ; 
                                end
                                else
                                begin
                                    fsm_c <= FSM_FAIL ; 
                                end 
                            end
                            else
                            begin
                                fsm_c <= FSM_HASH ; 
                            end 
                        end
            //-----------------------------------------
            FSM_MATCH :
                        begin
                            //-----------------------------------------
                            if (rsm == RSM_IDLE)
                            begin
                                fsm_c <= FSM_IDLE ; 
                            end
                            else
                            begin
                                fsm_c <= FSM_MATCH ; 
                            end 
                        end
            //-----------------------------------------
            default :
                        begin
                            // FSM_FAIL
                            //-----------------------------------------
                            if (rsm == RSM_IDLE)
                            begin
                                fsm_c <= FSM_IDLE ; 
                            end
                            else
                            begin
                                fsm_c <= FSM_FAIL ; 
                            end 
                        end
        endcase 
    end // fsm_proc

    //-------------------------------------------------------------------
    // address filtering state machine registered
    //-------------------------------------------------------------------  
    always @(posedge clk or negedge rst)
    begin : fsm_reg_proc
        if (rst == 1'b0)
        begin
            fsm <= FSM_IDLE ; 
        end
        else
        begin
            fsm <= fsm_c ; 
        end 
    end // fsm_reg_proc
    //-------------------------------------------------------------------
    // 3 least significant bits of byte counter
    //-------------------------------------------------------------------
    assign bcnt20 = bcnt[2:0] ;

    //-------------------------------------------------------------------
    // destination address registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : dest_reg_proc
        if (rst == 1'b0)
        begin
            dest <= {48{1'b0}} ; 
        end
        else
        begin
            if (rsm == RSM_DEST)
            begin
                if ((ncnt[0]) == 1'b0)
                begin
                    case (bcnt20)
                        3'b101 :
                                    begin
                                        dest[3:0] <= rxd_r ; 
                                    end
                        3'b100 :
                                    begin
                                        dest[11:8] <= rxd_r ; 
                                    end
                        3'b011 :
                                    begin
                                        dest[19:16] <= rxd_r ; 
                                    end
                        3'b010 :
                                    begin
                                        dest[27:24] <= rxd_r ; 
                                    end
                        3'b001 :
                                    begin
                                        dest[35:32] <= rxd_r ; 
                                    end
                        default :
                                    begin
                                        dest[43:40] <= rxd_r ; 
                                    end
                    endcase 
                end
                else
                begin
                    case (bcnt20)
                        3'b101 :
                                    begin
                                        dest[7:4] <= rxd_r ; 
                                    end
                        3'b100 :
                                    begin
                                        dest[15:12] <= rxd_r ; 
                                    end
                        3'b011 :
                                    begin
                                        dest[23:20] <= rxd_r ; 
                                    end
                        3'b010 :
                                    begin
                                        dest[31:28] <= rxd_r ; 
                                    end
                        3'b001 :
                                    begin
                                        dest[39:36] <= rxd_r ; 
                                    end
                        default :
                                    begin
                                        dest[47:44] <= rxd_r ; 
                                    end
                    endcase 
                end 
            end 
        end 
    end // dest_reg_proc;

    //-------------------------------------------------------------------
    // hash filtering registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : hash_reg_proc
        if (rst == 1'b0)
        begin
            crchash <= {9{1'b0}} ; 
            hash <= 1'b0 ; 
            fdata_r <= {16{1'b0}} ; 
        end
        else
        begin
            // crc value for addressing hash table
            if (fsm == FSM_HASH & flcnt == 3'b000)
            begin
                crchash <= {crc[23], crc[24], crc[25], crc[26], crc[27], crc[28], crc[29], crc[30], crc[31]} ; 
            end 
            // hash value
            hash <= fdata_r[crchash[3:0]] ; 
            // filtering RAM data
            fdata_r <= fdata ; 
        end 
    end // crchash_reg_proc

    // perfect filtering match combinatorial
    //-------------------------------------------------------------------
    always @(perfm or flcnt or fsm or fdata_r or dest)
    begin : perfm_proc
        perfm_c <= perfm ; 
        if ((flcnt == 3'b001 & fdata_r != dest[47:32]) | (flcnt == 3'b000 & fdata_r != dest[31:16]) | (flcnt == 3'b010 & fdata_r != dest[15:0]) | fsm == FSM_IDLE)
        begin
            perfm_c <= 1'b0 ; 
        end
        else if (flcnt == 3'b010 & fdata_r == dest[15:0])
        begin
            perfm_c <= 1'b1 ; 
        end 
    end // perfm_proc

    //-------------------------------------------------------------------
    // perfect match registered
    //-------------------------------------------------------------------  
    always @(posedge clk or negedge rst)
    begin : perfm_reg_proc
        if (rst == 1'b0)
        begin
            perfm <= 1'b0 ; 
            invm <= 1'b0 ; 
        end
        else
        begin
            // perfect match
            perfm <= perfm_c ; 
            // inverse perfect match
            if (fsm == FSM_IDLE)
            begin
                invm <= 1'b1 ; 
            end
            else if (flcnt == 3'b001 & perfm_c == 1'b1)
            begin
                invm <= 1'b0 ; 
            end 
        end 
    end // perfm_reg_proc

    //-------------------------------------------------------------------
    // filtering ram address registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : fa_reg_proc
        if (rst == 1'b0)
        begin
            flcnt <= {3{1'b0}} ; 
            fa <= {ADDRDEPTH - 1-(0)+1{1'b0}} ; 
        end
        else
        begin
            // filtering ram address
            case (fsm)
                //-------------------------------------
                FSM_PERF1, FSM_PERF16 :
                            begin
                                //-------------------------------------
                                fa <= fa + 1 ; 
                            end
                //-------------------------------------
                FSM_HASH :
                            begin
                                //-------------------------------------
                                fa[5:0] <= {1'b0, crchash[8:4]} ; 
                            end
                //-------------------------------------
                default :
                            begin
                                //-------------------------------------
                                if (hp == 1'b1 & (dest[0]) == 1'b0)
                                begin
                                    fa <= PERF1_ADDR ; 
                                end
                                else
                                begin
                                    fa <= {ADDRDEPTH - 1-(0)+1{1'b0}} ; 
                                end 
                            end
            endcase 
            // filtering ram 16-bit word counter
            if (fsm_c == FSM_IDLE | (flcnt == 3'b010 & fsm_c == FSM_PERF16) | (flcnt == 3'b010 & fsm_c == FSM_PERF1))
            begin
                flcnt <= {3{1'b0}} ; 
            end
            else if (fsm == FSM_PERF1 | fsm == FSM_PERF16 | fsm == FSM_HASH)
            begin
                flcnt <= flcnt + 1 ; 
            end 
        end 
    end // fa_reg_proc
    //-------------------------------------------------------------------
    // Filter address
    // registered output
    //-------------------------------------------------------------------
    assign faddr = fa ;
    //===================================================================--
    //                      external address filtering                   --
    //===================================================================--
    //-------------------------------------------------------------------
    // match data
    // registered output
    //-------------------------------------------------------------------
    assign matchdata = dest ;

    //-------------------------------------------------------------------
    // match enable
    // registered output
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : matchen_reg_proc
        if (rst == 1'b0)
        begin
            matchen <= 1'b0 ; 
        end
        else
        begin
            if (fsm == FSM_PERF1 | fsm == FSM_HASH | fsm == FSM_PERF16)
            begin
                matchen <= 1'b1 ; 
            end
            else
            begin
                matchen <= 1'b0 ; 
            end 
        end 
    end // matchen_reg_proc

    //===================================================================--
    //                           power management                        --
    //===================================================================--
    //-------------------------------------------------------------------
    // stop registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : stop_reg_proc
        if (rst == 1'b0)
        begin
            stop_r <= 1'b0 ; 
            stopo <= 1'b0 ; 
        end
        else
        begin
            // stop input
            stop_r <= stopi ; 
            // stop output
            if (stop_r == 1'b1 & rsm == RSM_IDLE)
            begin
                stopo <= 1'b1 ; 
            end
            else
            begin
                stopo <= 1'b0 ; 
            end 
        end 
    end // stop_reg_proc

    //===================================================================--
    //                              timers                               --
    //===================================================================--
    //-------------------------------------------------------------------
    // receive cycle size counter registered
    //-------------------------------------------------------------------  
    always @(posedge clk or negedge rst)
    begin : rcscnt_reg_proc
        if (rst == 1'b0)
        begin
            rcscnt <= {8{1'b0}} ; 
            rcs <= 1'b0 ; 
            rcsreq <= 1'b0 ; 
            rcsack_r <= 1'b0 ; 
        end
        else
        begin
            // receive cycle size counter registered
            if (rcscnt == 8'b00000000)
            begin
                rcscnt <= 8'b10000000 ; 
            end
            else
            begin
                rcscnt <= rcscnt - 1 ; 
            end 
            // cycle size indicator
            if (rcscnt == 8'b00000000)
            begin
                rcs <= 1'b1 ; 
            end
            else if (rcsack_r == 1'b1)
            begin
                rcs <= 1'b0 ; 
            end 
            // cycle size request
            if (rcs == 1'b1 & rcsack_r == 1'b0)
            begin
                rcsreq <= 1'b1 ; 
            end
            else if (rcsack_r == 1'b1)
            begin
                rcsreq <= 1'b0 ; 
            end 
            // cycle size acknowledge
            rcsack_r <= rcsack ; 
        end 
    end // rcscnt_reg_proc

    //===================================================================--
    //                         statistical counters                      --
    //===================================================================--
    //-------------------------------------------------------------------
    // fifo overflow counter
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : focnt_reg_proc
        if (rst == 1'b0)
        begin
            focnt <= {11{1'b0}} ; 
            oco <= 1'b0 ; 
            focl_r <= 1'b0 ; 
            focg <= {11{1'b0}} ; 
        end
        else
        begin
            // fifo overflow counter
            if (focl_r == 1'b1)
            begin
                focnt <= {11{1'b0}} ; 
            end
            else if ((rsm == RSM_DEST | rsm == RSM_SOURCE | rsm == RSM_LENGTH | rsm == RSM_INFO | rsm == RSM_SFD) & full == 1'b1)
            begin
                // and   cachenf_2r='1'
                focnt <= focnt + 1 ; 
            end 
            //vnavigatoroff
            // fifo overflow counter overflow
            if (focl_r == 1'b1)
            begin
                oco <= 1'b0 ; 
            end
            else if ((rsm == RSM_DEST | rsm == RSM_SOURCE | rsm == RSM_LENGTH | rsm == RSM_INFO) & (full == 1'b1 | cachenf_r == 1'b0) & focnt == 11'b11111111111)
            begin
                oco <= 1'b1 ; 
            end 
            //vnavigatoron
            // fifo overflow counter clear
            focl_r <= focl ; 
            // fifo overflow counter grey coded
            focg[10] <= focnt[10] ; 
            begin : xhdl_68
                integer i;
                for(i = 9; i >= 0; i = i - 1)
                begin
                    focg[i] <= focnt[i] ^ focnt[i + 1] ; 
                end
            end 
        end 
    end // focnt_reg_proc

    //-------------------------------------------------------------------
    // missed frames counter
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : mfcnt_reg_proc
        if (rst == 1'b0)
        begin
            mfcnt <= {16{1'b0}} ; 
            mfo <= 1'b0 ; 
            mfcl_r <= 1'b0 ; 
            mfcg <= {16{1'b0}} ; 
        end
        else
        begin
            // missed frames counter
            if (mfcl_r == 1'b1)
            begin
                mfcnt <= {16{1'b0}} ; 
            end
            else if (eorfff == 1'b1 & (pb == 1'b1 | winp == 1'b1) & (fsm == FSM_MATCH | ra == 1'b1 | (pm == 1'b1 & (dest[0]) == 1'b1)))
            begin
                mfcnt <= mfcnt + 1 ; 
            end 
            //vnavigatoroff
            // missed frames counter overflow
            if (mfcl_r == 1'b1)
            begin
                mfo <= 1'b0 ; 
            end
            else if (mfcnt == 16'b1111111111111111 & pb == 1'b1 & (fsm == FSM_MATCH | ra == 1'b1 | (pm == 1'b1 & (dest[0]) == 1'b1)))
            begin
                mfo <= 1'b1 ; 
            end 
            //vnavigatoron
            // missed frames counter clear
            mfcl_r <= mfcl ; 
            // missed frames counter grey coded
            mfcg[15] <= mfcnt[15] ; 
            begin : xhdl_71
                integer i;
                for(i = 14; i >= 0; i = i - 1)
                begin
                    mfcg[i] <= mfcnt[i] ^ mfcnt[i + 1] ; 
                end
            end 
        end 
    end // mfcnt_reg_proc
    //-------------------------------------------------------------------
    // missed frames counter clear acknowledge
    //-------------------------------------------------------------------
    assign mfclack = mfcl_r ;
    //-------------------------------------------------------------------
    // fifo overflow counter clear acknowledge
    //-------------------------------------------------------------------
    assign foclack = focl_r ;
    //===================================================================--
    //                               others                              --
    //===================================================================--
    //-------------------------------------------------------------------
    // all zeros vector for fifo
    //-------------------------------------------------------------------
    assign fzero = {FIFODEPTH - 1-(0)+1{1'b0}} ;
endmodule
