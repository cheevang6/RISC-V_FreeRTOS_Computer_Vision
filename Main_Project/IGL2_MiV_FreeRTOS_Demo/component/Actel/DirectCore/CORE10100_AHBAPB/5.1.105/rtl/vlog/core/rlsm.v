`timescale 1 ns / 100 ps
// ********************************************************************/ 
// Copyright 2013 Microsemi Corporation.  All rights reserved.
// IP Solutions Group
//
// ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
// ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED 
// IN ADVANCE IN WRITING.  
//  
// File:  rlsm.vhd
//     
// Description: Core10100
//              See below  
//
// Notes: 
//		  
//  v3.0 Includes SARS 57010 and 57013
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
// File name            : lsm.vhd
// File contents        : Entity lsm
//                        Architecture RTL of lsm
// Purpose              : Receive linked List Management for MAC
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
// 2003.03.21 : T.K. - references to 64-bit wide data bus removed
// 2003.03.21 : T.K. - watchdog functionality removed
// 2003.03.21 : T.K. - missed frames counter added from rc.vhd
// 2003.03.21 : T.K. - "own_proc" process changed
// 2.00.E02   :
// 2003.04.15 : T.K. - lsm proc changed for LSM_NXT state
// 2003.04.15 : T.K. - fifolev unused port removed
// 2003.04.15 : T.K. - synchronous processes merged
// 2.00.E03   :
// 2003.05.12 : T.K. - condition for entering stopped state changed
// 2003.05.12 : T.K. - lsm_proc: condition for LSM_IDLE changed
// 2003.05.12 : T.K. - stat_reg_proc: fbuf changed
// 2.00.E06   :  
// 2004.01.20 : T.K. - fixed mfc counter (F200.05.mfc) &
//              B.W.   statistical counters module integration
//                     support (I200.05.sc) :
//                      * cachenf input added 
//                      * mfc related ports removed
//                      * mfcnt_reg_proc process moved to RC component                    
//
// 2004.01.20 : T.K. - fixed receive fifo data overwriting (F200.05.rfifo)
//                      * fifo level changed to combinatorial
//
// 2004.01.20 : T.K. - fixed receive address changing in unstopped states 
//                     (F200.05.rxaddrchange):
//                      * lsm_proc: condition for LSM_BUF1 and LSM_BUF2 
//
// 2004.01.20 : B.W. - RTL code changes due to VN Check
//                     and code coverage (I200.06.vn)
//                      * dmaaddro_proc process changed
//                      * own_proc process changed
//                      * whole_proc process changed
// 
// 2.00.E06a  :
// 2004.02.20 : T.K. - cs collision seen functionality fixed (F200.06.cs)
//                      * cs port added
//                      * fstat_drv assignment changed
//
// 2004.02.20 : T.K. - receive error summary fixed (F200.06.es)
//                      * res_drv assignment changed
// 2.00.E07   :
// 2004.03.22 : T.K. - unused comments removed
// 2.00.E08   :
// 2004.06.07 : T.K. - fifolev_r signal registered (F200.08.fivolev)
//                      * fbcnt_c signal added
//                      * length_r signal added
//                      * fbcnt_reg_proc process changed
//                      * fifolev_reg_proc process changed
//                      * fbcnt_proc process added
//                      * fifolev_drv assignment removed
// *******************************************************************--
// *****************************************************************--
module RLSM (clk, rst, cachenf, fifodata, fifore, cachere, dmaack, dmaeob, dmadatai, dmaaddr, dmareq, dmawr, dmacnt, dmaaddro, dmadatao, rprog, rcpoll, fifocne, ff, rf, mf, db, re, ce, tl, ftp, ov, cs, length, pbl, dsl, rpoll, rdbadc, rdbad, rpollack, rcompack, bufack, des, fbuf, stat, ru, rcomp, bufcomp, stopi, stopo);

     // 8|16|32|64
    parameter DATAWIDTH = 32;
    parameter DATADEPTH  = 32;
    parameter FIFODEPTH  = 9;
    `include "utility.v"

    input clk; 
    input rst; 
    input cachenf; 
    input[DATAWIDTH - 1:0] fifodata; 
    output fifore; 
    wire fifore;
    output cachere; 
    wire cachere;
    input dmaack; 
    input dmaeob; 
    input[DATAWIDTH - 1:0] dmadatai; 
    input[DATADEPTH - 1:0] dmaaddr; 
    output dmareq; 
    wire dmareq;
    output dmawr; 
    wire dmawr;
    output[FIFODEPTH_MAX - 1:0] dmacnt; 
    reg[FIFODEPTH_MAX - 1:0] dmacnt;
    output[DATADEPTH - 1:0] dmaaddro; 
    reg[DATADEPTH - 1:0] dmaaddro;
    output[DATAWIDTH - 1:0] dmadatao; 
    reg[DATAWIDTH - 1:0] dmadatao;
    input rprog; 
    input rcpoll; 
    input fifocne; 
    input ff; 
    input rf; 
    input mf; 
    input db; 
    input re; 
    input ce; 
    input tl; 
    input ftp; 
    input ov; 
    input cs; 
    input[13:0] length; 
    input[5:0] pbl; 
    input[4:0] dsl; 
    input rpoll; 
    input rdbadc; 
    input[DATADEPTH - 1:0] rdbad; 
    output rpollack; 
    reg rpollack;
    input rcompack; 
    input bufack; 
    output des; 
    reg des;
    output fbuf; 
    reg fbuf;
    output stat; 
    reg stat;
    output ru; 
    reg ru;
    output rcomp; 
    reg rcomp;
    output bufcomp; 
    reg bufcomp;
    input stopi; 
    output stopo; 
    reg stopo;

    //---------------------------- lsm ----------------------------------
    // receive linked list state machine combinatorial
    reg[3:0] lsm_c; 
    // receive linked list state machine registered
    reg[3:0] lsm; 
    // receive linked list state machine double registered
    reg[3:0] lsm_r; 
    // ownership combinatorial
    reg own_c; 
    // ownership registered
    reg own; 
    // chained regsistered
    reg rch; 
    // end of ring registered
    reg rer; 
    // last segment registered
    reg rls; 
    // first segment registered
    reg rfs; 
    // receive descriptor error registered
    reg rde; 
    // receive error summary
    wire res_c; 
    // receive buffer 1 size registered
    reg[10:0] bs1; 
    // receive buffer 1 size registered
    reg[10:0] bs2; 
    //------------------------- lsm addresses ---------------------------
    // address write enabl
    reg adwrite; 
    // receive buffer address registered
    reg[DATADEPTH - 1:0] bad; 
    // receive descriptor address registered
    reg[DATADEPTH - 1:0] dad; 
    // receive buffer counter
    reg[10:0] bcnt; 
    // frame status
    reg[DATADEPTH - 1:0] statad; 
    // temporary status address
    reg[DATADEPTH - 1:0] tstatad; 
    // descriptor base address changed registered
    reg dbadc_r; 
    //------------------------------ dma --------------------------------
    // internal dma request combinatorial
    reg req_c; 
    // internal dma request registered
    reg req; 
    // 3 low significant bits of dma address
    wire[2:0] dmaaddr20; 
    // 2 least significant bits of dma address
    wire[1:0] addr10; 
    // dmadatai of maximum length
    wire[DATAWIDTH_MAX:0] dmadatai_max; 
    // data input extended to DATADEPTH_MAX registered
    reg[DATADEPTH_MAX - 1:0] dataimax_r; 
    // frame status
    wire[31:0] fstat; 
    //------------------------ receive control --------------------------
    // receive in progress registered
    reg rprog_r; 
    // receive in progress registered
    reg rcpoll_r; 
    // receive in progress double registered
    reg rcpoll_r2; 
    // whole frame transferred
    reg whole; 
    //----------------------------- fifo --------------------------------
    // fifo level registered
    reg[13:0] fifolev_r; 
    // fifo byte counter registered
    reg[13:0] fbcnt; 
    // fifo byte counter combinatorial
    reg[13:0] fbcnt_c; 
    // length of the frame registered
    reg[13:0] length_r; 
    // internal fifo read enable
    wire ififore; 
    // internal fifo read enable registered
    reg ififore_r; 
    // internal cache read enable
    reg icachere; 
    // buffer byte size extended to FIFODEPTH_MAX
    wire[FIFODEPTH_MAX - 1:0] bsmax; 
    // free space in fifo extended to FIFODEPTH_MAX
    wire[FIFODEPTH_MAX - 1:0] flmax; 
    // programmable burst length extended to FIFODEPTH_MAX
    wire[FIFODEPTH_MAX - 1:0] blmax; 
    // free space in fifo greater then 16
    reg fl_g_16; 
    // free space in fifo greater then buffer byte size
    reg fl_g_bs; 
    // free space in fifo greater then programmable burst length
    reg fl_g_bl; 
    // programmable burst length greater then buffer byte size
    reg bl_g_bs; 
    // programmable burst length=0 registered
    reg pblz; 
    //----------------------- power management --------------------------
    // stop receive process registered
    reg stop_r; 
    //---------------------------- others -------------------------------
    // zero vector of DATAWIDTH_MAX length
    wire[DATAWIDTH_MAX:0] dzero_max; 
    // zero vector of FIFODEPTH_MAX length
    wire[FIFODEPTH_MAX - 1:0] fzero_max; 

    //=================================================================--
    //                             dma                                 --
    //=================================================================--
    //-------------------------------------------------------------------
    // dma data input registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : dataimax_reg_proc
        if (rst == 1'b0)
        begin
            dataimax_r <= {DATADEPTH_MAX - 1-(0)+1{1'b1}} ; 
        end
        else
        begin
            case (DATAWIDTH)
                8 :
                            begin
                                //-------------------------------------
                                case (dmaaddr20)
                                    //-------------------------------------
                                    3'b000, 3'b100 :
                                                begin
                                                    dataimax_r[7:0] <= dmadatai ; 
                                                end
                                    3'b001, 3'b101 :
                                                begin
                                                    dataimax_r[15:8] <= dmadatai ; 
                                                end
                                    3'b010, 3'b110 :
                                                begin
                                                    dataimax_r[23:16] <= dmadatai ; 
                                                end
                                    default :
                                                begin
                                                    // "011"|"111"
                                                    dataimax_r[31:24] <= dmadatai ; 
                                                end
                                endcase 
                            end
                //-------------------------------------
                16 :
                            begin
                                //-------------------------------------
                                if ((dmaaddr[1]) == 1'b0)
                                begin
                                    dataimax_r[15:0] <= dmadatai ; 
                                end
                                else
                                begin
                                    dataimax_r[31:16] <= dmadatai ; 
                                end 
                            end
                //-------------------------------------
                default :
                            begin
                                // 32
                                //-------------------------------------
                                dataimax_r <= dmadatai ; 
                            end
            endcase 
        end 
    end // dataimax_r

    //-------------------------------------------------------------------
    // fifo level registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : fifolev_reg_proc
        if (rst == 1'b0)
        begin
            fl_g_bs <= 1'b0 ; 
            fl_g_16 <= 1'b0 ; 
            fl_g_bl <= 1'b0 ; 
            bl_g_bs <= 1'b0 ; 
            fifolev_r <= {14{1'b0}} ; 
            length_r <= {14{1'b0}} ; 
            pblz <= 1'b0 ; 
        end
        else
        begin
            // length of the frame registered
            length_r <= length ; 
            // fifo level
            fifolev_r <= length_r - fbcnt_c ; 
            // fifo level greater then buffer size
            if (flmax >= bsmax)
            begin
                fl_g_bs <= 1'b1 ; 
            end
            else
            begin
                fl_g_bs <= 1'b0 ; 
            end 
            // fifo level greater then 64 bytes
            case (DATAWIDTH)
                //-------------------------------------
                8 :
                            begin
                                //-------------------------------------
                                if (flmax > ({fzero_max[FIFODEPTH_MAX - 1:6], 6'b111111}))
                                begin
                                    fl_g_16 <= 1'b1 ; 
                                end
                                else
                                begin
                                    fl_g_16 <= 1'b0 ; 
                                end 
                            end
                //-------------------------------------
                16 :
                            begin
                                //-------------------------------------
                                if (flmax > ({fzero_max[FIFODEPTH_MAX - 1:5], 5'b11111}))
                                begin
                                    fl_g_16 <= 1'b1 ; 
                                end
                                else
                                begin
                                    fl_g_16 <= 1'b0 ; 
                                end 
                            end
                //-------------------------------------
                default :
                            begin
                                // 32
                                //-------------------------------------
                                if (flmax > ({fzero_max[FIFODEPTH_MAX - 1:4], 4'b1111}))
                                begin
                                    fl_g_16 <= 1'b1 ; 
                                end
                                else
                                begin
                                    fl_g_16 <= 1'b0 ; 
                                end 
                            end
            endcase 
            // fifo level greater then programmable burst length
            if (flmax >= blmax + 1)
            begin
                fl_g_bl <= 1'b1 ; 
            end
            else
            begin
                fl_g_bl <= 1'b0 ; 
            end 
            // programmable burst length greater then buffer size
            if (blmax >= bsmax)
            begin
                bl_g_bs <= 1'b1 ; 
            end
            else
            begin
                bl_g_bs <= 1'b0 ; 
            end 
            // programmable burst length=0
            if (pbl == 6'b000000)
            begin
                pblz <= 1'b1 ; 
            end
            else
            begin
                pblz <= 1'b0 ; 
            end 
        end 
    end // fifolev_reg_proc
    //-------------------------------------------------------------------
    // fifo level extended to FIFODEPTH_MAX
    //-------------------------------------------------------------------
    assign flmax = (DATAWIDTH == 8) ? {fzero_max[FIFODEPTH_MAX - 1:14], fifolev_r} : (DATAWIDTH == 16) ? {fzero_max[FIFODEPTH_MAX - 1:13], fifolev_r[13:1]} : {fzero_max[FIFODEPTH_MAX - 1:12], fifolev_r[13:2]} ;
    //-------------------------------------------------------------------
    // programmable burst length extended to FIFODEPTH_MAX
    //-------------------------------------------------------------------
    assign blmax = {fzero_max[FIFODEPTH_MAX - 1:6], pbl} ;
    //-------------------------------------------------------------------
    // buffer size extended to FIFODEPTH_MAX
    //-------------------------------------------------------------------
    assign bsmax = (DATAWIDTH == 8) ? {fzero_max[FIFODEPTH_MAX - 1:11], bcnt} : (DATAWIDTH == 16) ? {fzero_max[FIFODEPTH_MAX - 1:10], bcnt[10:1]} : {fzero_max[FIFODEPTH_MAX - 1:9], bcnt[10:2]} ;

    //-------------------------------------------------------------------
    // dma counter
    // combinatorial output
    //-------------------------------------------------------------------
    always @(lsm or fl_g_bs or fl_g_bl or bl_g_bs or pblz or blmax or bsmax or 
             flmax or fzero_max)
    begin : dmacnt_proc
        // descriptor fetch -------------------------
        if (lsm == LSM_DES0 | lsm == LSM_DES1 | lsm == LSM_DES2 | lsm == LSM_DES3 | lsm == LSM_STAT | lsm == LSM_FSTAT | lsm == LSM_DES0P)
        begin
            case (DATAWIDTH)
                //---------------------------------------
                8 :
                            begin
                                //---------------------------------------
                                dmacnt <= {fzero_max[FIFODEPTH_MAX - 1:3], 3'b100} ; 
                            end
                //---------------------------------------
                16 :
                            begin
                                //---------------------------------------
                                dmacnt <= {fzero_max[FIFODEPTH_MAX - 1:3], 3'b010} ; 
                            end
                //---------------------------------------
                default :
                            begin
                                // 32
                                //---------------------------------------
                                dmacnt <= {fzero_max[FIFODEPTH_MAX - 1:3], 3'b001} ; 
                            end
            endcase 
        end
        // buffer fetch -----------------------------
        else
        begin
            // unlimited burst
            if (pblz == 1'b1)
            begin
                // fifo level greater then buffer size
                if (fl_g_bs == 1'b1)
                begin
                    dmacnt <= bsmax ; 
                end
                // fifo level less then buffer size
                else
                begin
                    dmacnt <= flmax ; 
                end 
            end
            // programmable burst length
            else
            begin
                // fifo level greater then programmable burst length
                if (fl_g_bl == 1'b1)
                begin
                    // programmable burst length greater then buffer size
                    if (bl_g_bs == 1'b1)
                    begin
                        dmacnt <= bsmax ; 
                    end
                    // programmable burst length less then buffer size
                    else
                    begin
                        dmacnt <= blmax ; 
                    end 
                end
                // fifo level less then programmable burst length
                else
                begin
                    // fifo level greater then buffer size
                    if (fl_g_bs == 1'b1)
                    begin
                        dmacnt <= bsmax ; 
                    end
                    // fifo level less then buffer size
                    else
                    begin
                        dmacnt <= flmax ; 
                    end 
                end 
            end 
        end 
    end // dmacnt_proc

    //-------------------------------------------------------------------
    // internal dma request combinatorial
    //-------------------------------------------------------------------
    always @(req or lsm or fifocne or fl_g_bl or fl_g_16 or pblz or rprog_r or 
             dmaack or dmaeob or whole or flmax or fzero_max)
    begin : req_proc
        case (lsm)
            //-----------------------------------------
            LSM_BUF1, LSM_BUF2 :
                        begin
                            //-----------------------------------------
                            if (dmaack == 1'b1 & dmaeob == 1'b1)
                            begin
                                req_c <= 1'b0 ; 
                            end
                            else if (fifocne == 1'b1 | (rprog_r == 1'b1 & ((fl_g_bl == 1'b1 & pblz == 1'b0) | (fl_g_16 == 1'b1 & pblz == 1'b1))))
                            begin
                                req_c <= 1'b1 ; 
                            end
                            else
                            begin
                                req_c <= req ; 
                            end 
                        end
            //-----------------------------------------
            LSM_DES0, LSM_DES1, LSM_DES2, LSM_DES3, LSM_STAT, LSM_DES0P :
                        begin
                            //-----------------------------------------
                            if (dmaack == 1'b1)
                            begin
                                req_c <= 1'b0 ; 
                            end
                            else
                            begin
                                req_c <= 1'b1 ; 
                            end 
                        end
            //-----------------------------------------
            LSM_FSTAT :
                        begin
                            //-----------------------------------------
		  // SAR 57103
		  //  It is unclear why these two lines are needed. 
		  //  SAR57010 fixes the misaligned packet problem instead now
		  //
		  //or ( DATAWIDTH=8 and flmax(1 downto 0) /= fzero_max(1 downto 0) )
          //or (DATAWIDTH=16 and flmax(1) /= fzero_max(1) )
                            if ( dmaack == 1'b1 
                               | whole == 1'b0 
                              // | (DATAWIDTH == 8 & flmax[1:0] != fzero_max[1:0]) 
                              // | (DATAWIDTH == 16 & flmax[1] != fzero_max[1])
                               )
                            begin
                                req_c <= 1'b0 ; 
                            end
                            else
                            begin
                                req_c <= 1'b1 ; 
                            end 
                        end
            //-----------------------------------------
            default :
                        begin
                            // LSM_IDLE
                            //-----------------------------------------
                            req_c <= 1'b0 ; 
                        end
        endcase 
    end // req_proc

    //-------------------------------------------------------------------
    // dma request registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : req_reg_proc
        if (rst == 1'b0)
        begin
            req <= 1'b0 ; 
        end
        else
        begin
            req <= req_c ; 
        end 
    end // req_reg_proc

    //-------------------------------------------------------------------
    // dma address
    // combinatorial output
    //-------------------------------------------------------------------
    always @(lsm or bad or dad or statad)
    begin : dmaaddro_proc
        dmaaddro <= dad ; 
        case (lsm)
            //-----------------------------------------
            LSM_BUF1, LSM_BUF2 :
                        begin
                            //-----------------------------------------
                            dmaaddro <= bad ; 
                        end
            //-----------------------------------------
            LSM_STAT, LSM_FSTAT :
                        begin
                            //-----------------------------------------
                            dmaaddro <= statad ; 
                        end
            //-----------------------------------------
            default :
                        begin
                            // LSM_DES0|LSM_DES1|LSM_DES2|LSM_DES3|LSM_DES0P
                            //-----------------------------------------
                        end
        endcase 
    end // dmaaddro_proc
    //-------------------------------------------------------------------
    // frame status
    //-------------------------------------------------------------------
    assign fstat = {1'b0, ff, length, res_c, rde, RDES0_RV[13:12], rf, mf, rfs, rls, tl, cs, ftp, RDES0_RV[4], re, db, ce, ov} ;
    //-------------------------------------------------------------------
    // dma write selection
    // combinatorial output
    //-------------------------------------------------------------------
    assign dmawr = (lsm == LSM_STAT | lsm == LSM_FSTAT | lsm == LSM_BUF1 | lsm == LSM_BUF2) ? 1'b1 : 1'b0 ;

    //-------------------------------------------------------------------
    // dma data output
    // combinatorial output
    //-------------------------------------------------------------------
    always @(fifodata or lsm or addr10 or fstat)
    begin : dmadatao_proc
        if (lsm == LSM_BUF1 | lsm == LSM_BUF2)
        begin
            dmadatao <= fifodata ; 
        end
        else
        begin
            case (DATAWIDTH)
                8 :
                            begin
                                //---------------------------------------
                                case (addr10)
                                    //---------------------------------------
                                    2'b00 :
                                                begin
                                                    dmadatao <= fstat[7:0] ; 
                                                end
                                    2'b01 :
                                                begin
                                                    dmadatao <= fstat[15:8] ; 
                                                end
                                    2'b10 :
                                                begin
                                                    dmadatao <= fstat[23:16] ; 
                                                end
                                    default :
                                                begin
                                                    dmadatao <= fstat[31:24] ; 
                                                end
                                endcase 
                            end
                //---------------------------------------
                16 :
                            begin
                                //---------------------------------------
                                if (addr10 == 2'b00)
                                begin
                                    dmadatao <= fstat[15:0] ; 
                                end
                                else
                                begin
                                    dmadatao <= fstat[31:16] ; 
                                end 
                            end
                //---------------------------------------
                default :
                            begin
                                // 32
                                //---------------------------------------
                                dmadatao <= fstat ; 
                            end
            endcase 
        end 
    end // dmadatao_proc
    //-------------------------------------------------------------------
    // dma request
    // registered output
    //-------------------------------------------------------------------
    assign dmareq = req ;

    //===================================================================--
    //                                 lsm                               --
    //===================================================================--
    //-------------------------------------------------------------------
    // receive linked list state machine combinatorial
    //-------------------------------------------------------------------
    always @(lsm or rcpoll_r or rcpoll_r2 or rpoll or dmaack or dmaeob or own_c or 
             bs1 or bs2 or whole or rch or stop_r or own or bcnt or dbadc_r)
    begin : lsm_proc
        case (lsm)
            //-----------------------------------------
            LSM_IDLE :
                        begin
                            //-----------------------------------------
                            if (dbadc_r == 1'b0 & stop_r == 1'b0 & ((rcpoll_r == 1'b1 & rcpoll_r2 == 1'b0) | rpoll == 1'b1))
                            begin
                                lsm_c <= LSM_DES0 ; 
                            end
                            else
                            begin
                                lsm_c <= LSM_IDLE ; 
                            end 
                        end
            //-----------------------------------------
            LSM_DES0 :
                        begin
                            if (dmaack == 1'b1 & dmaeob == 1'b1)
                            begin
                                //-----------------------------------------
                                if (own_c == 1'b1)
                                begin
                                    lsm_c <= LSM_DES1 ; 
                                end
                                else
                                begin
                                    lsm_c <= LSM_IDLE ; 
                                end 
                            end
                            else
                            begin
                                lsm_c <= LSM_DES0 ; 
                            end 
                        end
            //-----------------------------------------
            LSM_DES0P :
                        begin
                            if (dmaack == 1'b1 & dmaeob == 1'b1)
                            begin
                                //-----------------------------------------
                                if (own_c == 1'b0 | whole == 1'b1)
                                begin
                                    lsm_c <= LSM_FSTAT ; 
                                end
                                else
                                begin
                                    lsm_c <= LSM_STAT ; 
                                end 
                            end
                            else
                            begin
                                lsm_c <= LSM_DES0P ; 
                            end 
                        end
            //-----------------------------------------
            LSM_DES1 :
                        begin
                            //-----------------------------------------
                            if (dmaack == 1'b1 & dmaeob == 1'b1)
                            begin
                                lsm_c <= LSM_DES2 ; 
                            end
                            else
                            begin
                                lsm_c <= LSM_DES1 ; 
                            end 
                        end
            //-----------------------------------------
            LSM_DES2 :
                        begin
                            if (dmaack == 1'b1 & dmaeob == 1'b1)
                            begin
                                //-----------------------------------------
                                if (bs1 == 11'b00000000000)
                                begin
                                    lsm_c <= LSM_DES3 ; 
                                end
                                else
                                begin
                                    lsm_c <= LSM_BUF1 ; 
                                end 
                            end
                            else
                            begin
                                lsm_c <= LSM_DES2 ; 
                            end 
                        end
            //-----------------------------------------
            LSM_DES3 :
                        begin
                            if (dmaack == 1'b1 & dmaeob == 1'b1)
                            begin
                                //-----------------------------------------
                                if (bs2 != 11'b00000000000 & rch == 1'b0)
                                begin
                                    lsm_c <= LSM_BUF2 ; 
                                end
                                else
                                begin
                                    lsm_c <= LSM_NXT ; 
                                end 
                            end
                            else
                            begin
                                lsm_c <= LSM_DES3 ; 
                            end 
                        end
            //-----------------------------------------
            LSM_BUF1 :
                        begin
                            //-----------------------------------------
                            if (whole == 1'b1 | bcnt == 11'b00000000000)
                            begin
                                lsm_c <= LSM_DES3 ; 
                            end
                            else if (dbadc_r == 1'b1)
                            begin
                                lsm_c <= LSM_IDLE ; 
                            end
                            else
                            begin
                                lsm_c <= LSM_BUF1 ; 
                            end 
                        end
            //-----------------------------------------
            LSM_BUF2 :
                        begin
                            //-----------------------------------------
                            if (whole == 1'b1 | bcnt == 11'b00000000000)
                            begin
                                lsm_c <= LSM_NXT ; 
                            end
                            else if (dbadc_r == 1'b1)
                            begin
                                lsm_c <= LSM_IDLE ; 
                            end
                            else
                            begin
                                lsm_c <= LSM_BUF2 ; 
                            end 
                        end
            //-----------------------------------------
            LSM_NXT :
                        begin
                            if (whole == 1'b1)
                            begin
                                //-----------------------------------------
                                if (stop_r == 1'b1)
                                begin
                                    lsm_c <= LSM_FSTAT ; 
                                end
                                else
                                begin
                                    lsm_c <= LSM_DES0P ; 
                                end 
                            end
                            else
                            begin
                                lsm_c <= LSM_DES0P ; 
                            end 
                        end
            //-----------------------------------------
            LSM_STAT :
                        begin
                            //-----------------------------------------
                            if (dmaack == 1'b1 & dmaeob == 1'b1)
                            begin
                                lsm_c <= LSM_DES1 ; 
                            end
                            else
                            begin
                                lsm_c <= LSM_STAT ; 
                            end 
                        end
            //-----------------------------------------
            default :
                        begin
                            if (dmaack == 1'b1 & dmaeob == 1'b1)
                            begin
                                // LSM_FSTAT
                                //-----------------------------------------
                                if (own == 1'b1 & stop_r == 1'b0)
                                begin
                                    lsm_c <= LSM_DES1 ; 
                                end
                                else
                                begin
                                    lsm_c <= LSM_IDLE ; 
                                end 
                            end
                            else
                            begin
                                lsm_c <= LSM_FSTAT ; 
                            end 
                        end
        endcase 
    end // lsm_proc

    //-------------------------------------------------------------------
    // receive linked list manager registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : rlsm_reg_proc
        if (rst == 1'b0)
        begin
            lsm <= LSM_IDLE ; 
            lsm_r <= LSM_IDLE ; 
        end
        else
        begin
            lsm <= lsm_c ; 
            lsm_r <= lsm ; 
        end 
    end // rlsm_reg_proc

    //-------------------------------------------------------------------
    // receive poll acknowledge
    // registered output
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : rpollack_reg_proc
        if (rst == 1'b0)
        begin
            rpollack <= 1'b0 ; 
        end
        else
        begin
            if (rpoll == 1'b1 & dbadc_r == 1'b0)
            begin
                rpollack <= 1'b1 ; 
            end
            else if (rpoll == 1'b0)
            begin
                rpollack <= 1'b0 ; 
            end 
        end 
    end // rpollack_reg_proc

    //-------------------------------------------------------------------
    // buffer byte counter registered
    //-------------------------------------------------------------------
   
// SAR57010
// if the bcnt is a non multiple of datawidth then on the first transfer
// the odd number of transfers is removed from the count.
 
   
    always @(posedge clk or negedge rst)
    begin : bcnt_reg_proc
        if (rst == 1'b0)
        begin
            bcnt <= {11{1'b1}} ; 
        end
        else
        begin
            if (lsm == LSM_DES2)
            begin
                bcnt <= bs1 ; 
            end
            else if (lsm == LSM_DES3)
            begin
                bcnt <= bs2 ; 
            end
            else
            begin
                if (dmaack == 1'b1)
                begin
                    case (DATAWIDTH)
                        //---------------------------------
                        8 :
                                    begin
                                        //---------------------------------
                                        bcnt <= bcnt - 1 ; 
                                    end
                        //---------------------------------
                        16 :
                                    begin	 // do minus 2
                                        //---------------------------------
                                        if ( bcnt[0]==1'b0) bcnt <= {(bcnt[10:1] - 1), 1'b0} ; 
                                        bcnt[0] <=1'b0;
                                        
                                    end
                        //---------------------------------
                        default :
                                    begin
                                        //  // do minus 4
                                        //---------------------------------
                                       if ( bcnt[1:0]==2'b00) bcnt <= {(bcnt[10:2] - 1), 2'b00} ; 
                                       bcnt[1:0] <=2'b00;
                          			end
                    endcase 
                end 
            end 
        end 
    end // bcnt_reg_proc

    //-------------------------------------------------------------------
    // desriptor ownership bit combinatorial
    //-------------------------------------------------------------------
    always @(own or dmaack or dmaeob or lsm or dmadatai)
    begin : own_proc
        own_c <= own ; 
        if (dmaack == 1'b1 & dmaeob == 1'b1 & (lsm == LSM_DES0 | lsm == LSM_DES0P))
        begin
            own_c <= dmadatai[DATAWIDTH - 1] ; 
        end 
    end // own_proc

    //-------------------------------------------------------------------
    // des1 status registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : des1_reg_proc
        if (rst == 1'b0)
        begin
            rer <= 1'b0 ; 
            rch <= 1'b0 ; 
            bs2 <= {11{1'b0}} ; 
            bs1 <= {11{1'b0}} ; 
        end
        else
        begin
            if (lsm == LSM_DES1 & dmaack == 1'b1)
            begin
                case (DATAWIDTH)
                    8 :
                                begin
                                    //-------------------------------------
                                    case (dmaaddr20)
                                        //-------------------------------------
                                        3'b000, 3'b100 :
                                                    begin
                                                        bs1[7:0] <= dmadatai_max[7:0] ; 
                                                    end
                                        3'b001, 3'b101 :
                                                    begin
                                                        bs1[10:8] <= dmadatai_max[2:0] ; 
                                                        bs2[4:0] <= dmadatai_max[7:3] ; 
                                                    end
                                        3'b010, 3'b110 :
                                                    begin
                                                        bs2[10:5] <= dmadatai_max[5:0] ; 
                                                    end
                                        default :
                                                    begin
                                                        // "011" | "111";
                                                        rer <= dmadatai_max[1] ; 
                                                        rch <= dmadatai_max[0] ; 
                                                    end
                                    endcase 
                                end
                    16 :
                                begin
                                    //-------------------------------------
                                    case (dmaaddr20)
                                        //-------------------------------------
                                        3'b000, 3'b100 :
                                                    begin
                                                        bs1[10:0] <= dmadatai_max[10:0] ; 
                                                        bs2[4:0] <= dmadatai_max[15:11] ; 
                                                    end
                                        default :
                                                    begin
                                                        // "010" | "110"
                                                        bs2[10:5] <= dmadatai_max[5:0] ; 
                                                        rer <= dmadatai_max[9] ; 
                                                        rch <= dmadatai_max[8] ; 
                                                    end
                                    endcase 
                                end
                    //-------------------------------------
                    default :
                                begin
                                    // 32
                                    //-------------------------------------
                                    rer <= dmadatai_max[25] ; 
                                    rch <= dmadatai_max[24] ; 
                                    bs2 <= dmadatai_max[21:11] ; 
                                    bs1 <= dmadatai_max[10:0] ; 
                                end
                endcase 
            end 
        end 
    end // des1_reg_proc
    //-------------------------------------------------------------------
    // dmadatai of DATAWIDTH_MAX length
    //-------------------------------------------------------------------
    assign dmadatai_max = {dzero_max[DATAWIDTH_MAX:DATAWIDTH], dmadatai} ;

    //-------------------------------------------------------------------
    // receive descriptor control registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : rdes_reg_proc
        if (rst == 1'b0)
        begin
            own <= 1'b0 ; 
            rfs <= 1'b1 ; 
            rls <= 1'b0 ; 
            rde <= 1'b0 ; 
        end
        else
        begin
            // receive first descriptor
            if (lsm == LSM_FSTAT & dmaack == 1'b1 & dmaeob == 1'b1)
            begin
                rfs <= 1'b1 ; 
            end
            else if (lsm == LSM_STAT & dmaack == 1'b1 & dmaeob == 1'b1)
            begin
                rfs <= 1'b0 ; 
            end 
            // receive last descriptor
            if (lsm == LSM_FSTAT)
            begin
                rls <= 1'b1 ; 
            end
            else
            begin
                rls <= 1'b0 ; 
            end 
            // receive descriptor error
            if (lsm == LSM_FSTAT & whole == 1'b0)
            begin
                rde <= 1'b1 ; 
            end
            else if (lsm == LSM_IDLE)
            begin
                rde <= 1'b0 ; 
            end 
            // ownership bit
            own <= own_c ; 
        end 
    end // rdes_reg_proc
    //-------------------------------------------------------------------
    // receive error summary combinatorial
    //-------------------------------------------------------------------
    assign res_c = rf | ce | rde | cs | tl ;

    //===================================================================--
    //                             lsm addresses                         --
    //===================================================================--
    //-------------------------------------------------------------------
    // address write enable registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : adwrite_reg_proc
        if (rst == 1'b0)
        begin
            adwrite <= 1'b0 ; 
            dbadc_r <= 1'b0 ; 
        end
        else
        begin
            // address write enable
            if (dmaack == 1'b1 & dmaeob == 1'b1)
            begin
                adwrite <= 1'b1 ; 
            end
            else
            begin
                adwrite <= 1'b0 ; 
            end 
            // descriptor base address changed
            dbadc_r <= rdbadc ; 
        end 
    end // adwrite_reg_proc

    //-------------------------------------------------------------------
    // descriptor addresses registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : dad_reg_proc
        if (rst == 1'b0)
        begin
            dad <= {DATADEPTH - 1-(0)+1{1'b1}} ; 
        end
        else
        begin
            // assign base address when it is changed
            if (dbadc_r == 1'b1)
            begin
                dad <= rdbad ; 
            end
            else if (adwrite == 1'b1 & lsm == LSM_NXT & rch == 1'b1)
            begin
                dad <= dataimax_r[DATADEPTH - 1:0] ; 
            end
            else if (adwrite == 1'b1)
            begin
                case (lsm_r)
                    // address of the next descriptor
                    //-----------------------------------
                    LSM_DES3 :
                                begin
                                    //-----------------------------------
                                    if (rer == 1'b1)
                                    begin
                                        dad <= rdbad ; 
                                    end
                                    else
                                    begin
                                        dad <= dmaaddr + ({dsl, 2'b00}) ; 
                                    end 
                                end
                    //-----------------------------------
                    LSM_DES0, LSM_DES0P :
                                begin
                                    //-----------------------------------
                                    if (own == 1'b1)
                                    begin
                                        dad <= dmaaddr ; 
                                    end 
                                end
                    //-----------------------------------
                    LSM_DES2 :
                                begin
                                    //-----------------------------------
                                    dad <= dmaaddr ; 
                                end
                    //-----------------------------------
                    LSM_DES1 :
                                begin
                                    //-----------------------------------
                                    dad <= dmaaddr ; 
                                end
                    //-----------------------------------
                    default :
                                begin
                                    // LSM_BUF1 | LSM_BUF2
                                    //-----------------------------------
                                    dad <= dad ; 
                                end
                endcase 
            end 
        end 
    end // dad_reg_proc

    //-------------------------------------------------------------------
    // buffer addresses registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : bad_reg_proc
        if (rst == 1'b0)
        begin
            bad <= {DATADEPTH - 1-(0)+1{1'b1}} ; 
        end
        else
        begin
            if (adwrite == 1'b1)
            begin
                if (lsm_r == LSM_BUF1 | lsm_r == LSM_BUF2)
                begin
                    bad <= dmaaddr ; 
                end
                else
                begin
                    bad <= dataimax_r[DATADEPTH - 1:0] ; 
                end 
            end 
        end 
    end // bad_reg_proc

    //-------------------------------------------------------------------
    // descriptor status address registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : stataddr_reg_proc
        if (rst == 1'b0)
        begin
            statad <= {DATADEPTH - 1-(0)+1{1'b1}} ; 
            tstatad <= {DATADEPTH - 1-(0)+1{1'b1}} ; 
        end
        else
        begin
            // address of DES0 field is current status address
            if (lsm == LSM_DES1 & adwrite == 1'b1)
            begin
                statad <= tstatad ; 
            end 
            // temporary descriptor status address registered
            // address of DES0 field is current status address
            if ((lsm == LSM_DES0 | lsm == LSM_DES0P) & dmaack == 1'b1 & dmaeob == 1'b1)
            begin
                tstatad <= dad ; 
            end 
        end 
    end // stataddr_reg_proc

    //===================================================================--
    //                                fifo                               --
    //===================================================================--
    //-------------------------------------------------------------------
    // fifo byte counter registered
    //-------------------------------------------------------------------
    always @(fbcnt or icachere or ififore)
    begin : fbcnt_proc
        if (icachere == 1'b1)
        begin
            fbcnt_c <= {14{1'b0}} ; 
        end
        else
        begin
            if (ififore == 1'b1)
            begin
                case (DATAWIDTH)
                    //---------------------------------
                    8 :
                                begin
                                    //---------------------------------
                                    fbcnt_c <= fbcnt + 1 ; 
                                end
                    //---------------------------------
                    16 :
                                begin
                                    //---------------------------------
                                    fbcnt_c <= fbcnt + 2'b10 ; 
                                end
                    //---------------------------------
                    default :
                                begin
                                    // 32
                                    //---------------------------------
                                    fbcnt_c <= fbcnt + 3'b100 ; 
                                end
                endcase 
            end
            else
            begin
                fbcnt_c <= fbcnt ; 
            end 
        end 
    end // fbcnt_reg_proc

    //-------------------------------------------------------------------
    // fifo byte counter registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : fbcnt_reg_proc
        if (rst == 1'b0)
        begin
            fbcnt <= {14{1'b0}} ; 
        end
        else
        begin
            fbcnt <= fbcnt_c ; 
        end 
    end // fbcnt_reg_proc

    //-------------------------------------------------------------------
    // whole frame transferred combinatorial
    //-------------------------------------------------------------------
    always @(fbcnt or length or fifocne)
    begin : whole_proc
        whole <= 1'b0 ; 
        if (fbcnt >= length & fifocne == 1'b1)
        begin
            whole <= 1'b1 ; 
        end 
    end // whole_proc
    //-------------------------------------------------------------------
    // internal fifo read enable combinatorial
    //-------------------------------------------------------------------
    assign ififore = (((lsm == LSM_BUF1 | lsm == LSM_BUF2) & dmaack == 1'b1) | (lsm == LSM_FSTAT & whole == 1'b0 & flmax != fzero_max[14:0] & ififore_r == 1'b0) | (lsm == LSM_FSTAT & whole == 1'b0 & fifocne == 1'b1 & ififore_r == 1'b0)) ? 1'b1 : 1'b0 ;

    //-------------------------------------------------------------------
    // fifo/cache read enable registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : ififore_reg_proc
        if (rst == 1'b0)
        begin
            ififore_r <= 1'b0 ; 
            icachere <= 1'b0 ; 
        end
        else
        begin
            // fifo read enable
            ififore_r <= ififore ; 
            // internal cache read enable
            if (lsm == LSM_FSTAT & dmaack == 1'b1 & dmaeob == 1'b1)
            begin
                icachere <= 1'b1 ; 
            end
            else
            begin
                icachere <= 1'b0 ; 
            end 
        end 
    end // ififore_reg_proc
    //-------------------------------------------------------------------
    // fifo read enable
    // combinatorial output
    //-------------------------------------------------------------------
    assign fifore = ififore ;
    //-------------------------------------------------------------------
    // status cache read enable
    // registered output
    //-------------------------------------------------------------------
    assign cachere = icachere ;

    //===================================================================--
    //                          receive control                          --
    //===================================================================--
    //-------------------------------------------------------------------
    // receive in progress registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : rprog_reg_proc
        if (rst == 1'b0)
        begin
            rprog_r <= 1'b0 ; 
            rcpoll_r <= 1'b0 ; 
            rcpoll_r2 <= 1'b0 ; 
        end
        else
        begin
            rprog_r <= rprog ; 
            rcpoll_r <= rcpoll ; 
            if (lsm == LSM_IDLE)
            begin
                rcpoll_r2 <= rcpoll_r ; 
            end 
        end 
    end // rprog_reg_proc

    //-------------------------------------------------------------------
    // descriptor/buffer processing status registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : stat_reg_proc
        if (rst == 1'b0)
        begin
            des <= 1'b0 ; 
            fbuf <= 1'b0 ; 
            stat <= 1'b0 ; 
            rcomp <= 1'b0 ; 
            bufcomp <= 1'b0 ; 
            ru <= 1'b0 ; 
        end
        else
        begin
            // fetching receive descriptor
            if (lsm == LSM_DES0 | lsm == LSM_DES1 | lsm == LSM_DES2 | lsm == LSM_DES3 | lsm == LSM_DES0P)
            begin
                des <= 1'b1 ; 
            end
            else
            begin
                des <= 1'b0 ; 
            end 
            // fetching buffer
            if ((lsm == LSM_BUF1 | lsm == LSM_BUF2) & req == 1'b1)
            begin
                fbuf <= 1'b1 ; 
            end
            else
            begin
                fbuf <= 1'b0 ; 
            end 
            // writting descriptor status
            if (lsm == LSM_STAT | lsm == LSM_FSTAT)
            begin
                stat <= 1'b1 ; 
            end
            else
            begin
                stat <= 1'b0 ; 
            end 
            // receive completition
            if (lsm == LSM_FSTAT & dmaack == 1'b1 & dmaeob == 1'b1)
            begin
                rcomp <= 1'b1 ; 
            end
            else if (rcompack == 1'b1)
            begin
                rcomp <= 1'b0 ; 
            end 
            // buffer completition
            if (lsm == LSM_STAT & dmaack == 1'b1 & dmaeob == 1'b1)
            begin
                bufcomp <= 1'b1 ; 
            end
            else if (bufack == 1'b1)
            begin
                bufcomp <= 1'b0 ; 
            end 
            // receive descriptor unavailable
            if (own == 1'b1 & own_c == 1'b0)
            begin
                ru <= 1'b1 ; 
            end
            else if (own == 1'b1)
            begin
                ru <= 1'b0 ; 
            end 
        end 
    end // stat_reg_proc

    //=================================================================--
    //                       power management                          --
    //=================================================================--
    //-------------------------------------------------------------------
    // stop receive process registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : stop_reg_proc
        if (rst == 1'b0)
        begin
            stop_r <= 1'b1 ; 
            stopo <= 1'b1 ; 
        end
        else
        begin
            // stop input
            stop_r <= stopi ; 
            // stop output
            // can enter stopped state if the linked list state machine
            // is idle, or if it prefetched next descriptor
            // but no frame is waiting for transfer into the host
            if (stop_r == 1'b1 & (lsm == LSM_IDLE | ((lsm == LSM_BUF1 | lsm == LSM_BUF2) & fifocne == 1'b0 & rprog_r == 1'b0)))
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
    //                               others                              --
    //===================================================================--
    //-------------------------------------------------------------------
    // zero vector of DATAWIDTH_MAX length
    //-------------------------------------------------------------------
    assign dzero_max = {2{1'b0}} ;
    //-------------------------------------------------------------------
    // zero vector of FIFODEPTH_MAX length
    //-------------------------------------------------------------------
    assign fzero_max = {FIFODEPTH_MAX - 1-(0)+1{1'b0}} ;
    //-------------------------------------------------------------------
    // 3 least significant bits of dma address
    //-------------------------------------------------------------------
    assign dmaaddr20 = dmaaddr[2:0] ;
    //-------------------------------------------------------------------
    // 2 least significant bits of dma address
    //-------------------------------------------------------------------
    assign addr10 = dmaaddr[1:0] ;
endmodule
