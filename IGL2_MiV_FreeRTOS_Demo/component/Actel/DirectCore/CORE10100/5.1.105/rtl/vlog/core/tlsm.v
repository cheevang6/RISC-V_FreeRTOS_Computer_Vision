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
// File:  tlsm.v
//     
// Description: Core10100
//              See below  
//
//   
//
// Notes: 
//		  
//
// *********************************************************************/ 
//
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
// File name            : tlsm.vhd
// File contents        : Entity TLSM
//                        Architecture RTL of TLSM
// Purpose              : Transmit linked List Management for MAC
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
// 2003.03.21 : T.K. - "own_proc" process changed
// 2.00.E02   :
// 2003.04.15 : T.K. - synchronous processes merged
// 1.00.E03   :
// 2003.05.12 : T.K. - lsm_proc: condition for LSM_IDLE changed
// 1.00.E04   :
// 2003.05.21 : T.K. - lsm_proc: condition for LSM_IDLE changed
// 2.00.E05   :
// 2003.08.10 : H.C. - dmadatai_max width fixes
// 2.00.E06   : 
// 2004.01.20 : B.W. - req_r signal removed
// 2004.01.20 : B.W. - RTL code changes due to VN Check
//                     and code coverage (I200.06.vn) :
//                      * be_proc process changed
//                      * dmaaddro_proc process changed
// *******************************************************************--
// *****************************************************************--
module TLSM (clk, rst, fifonf, fifocnf, fifoval, fifolev, fifowe, fifoeof, fifobe, fifodata, 
             ic, ac, dpd, statado, csne, lo, nc, lc, ec, de, ur, cc, statadi, cachere,
             dmaack, dmaeob, dmadatai, dmaaddr, dmareq, dmawr, dmacnt, dmaaddro, dmadatao, 
             fwe, fdata, faddr, dsl, pbl, poll, dbadc, dbad, pollack, tcompack, tcomp, des, fbuf, stat, setp, tu, ft, stopi, stopo);

     // 8|16|32|64
    parameter DATAWIDTH = 32;
     // 8-32
    parameter DATADEPTH = 32;
    parameter FIFODEPTH  = 9;
    `include "utility.v"

    input clk; 
    input rst; 
    input fifonf; 
    input fifocnf; 
    input fifoval; 
    input[FIFODEPTH - 1:0] fifolev; 
    output fifowe; 
    wire fifowe;
    output fifoeof; 
    wire fifoeof;
    output[DATAWIDTH / 8 - 1:0] fifobe; 
    reg[DATAWIDTH / 8 - 1:0] fifobe;
    output[DATAWIDTH - 1:0] fifodata; 
    wire[DATAWIDTH - 1:0] fifodata;
    output ic; 
    reg ic;
    output ac; 
    reg ac;
    output dpd; 
    reg dpd;
    output[DATADEPTH - 1:0] statado; 
    wire[DATADEPTH - 1:0] statado;
    input csne; 
    input lo; 
    input nc; 
    input lc; 
    input ec; 
    input de; 
    input ur; 
    input[3:0] cc; 
    input[DATADEPTH - 1:0] statadi; 
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
    output fwe; 
    wire fwe;
    output[ADDRWIDTH - 1:0] fdata; 
    wire[ADDRWIDTH - 1:0] fdata;
    output[ADDRDEPTH - 1:0] faddr; 
    wire[ADDRDEPTH - 1:0] faddr;
    input[4:0] dsl; 
    input[5:0] pbl; 
    input poll; 
    input dbadc; 
    input[DATADEPTH - 1:0] dbad; 
    output pollack; 
    wire pollack;
    input tcompack; 
    output tcomp; 
    wire tcomp;
    output des; 
    reg des;
    output fbuf; 
    reg fbuf;
    output stat; 
    reg stat;
    output setp; 
    reg setp;
    output tu; 
    reg tu;
    output[1:0] ft; 
    reg[1:0] ft;
    input stopi; 
    output stopo; 
    reg stopo;

    parameter CWIDTH = DATAWIDTH * 2 - 8; 
    //------------------------ data interface ---------------------------
    // dmadatai of maximum length
    wire[DATAWIDTH_MAX - 1:0] dmadatai_max; 
    // data input extended to DATADEPTH_MAX registered
    reg[DATAWIDTH_MAX - 1:0] dataimax_r; 
    // data input extended to DATADEPTH_MAX registered 1..0
    wire[1:0] dataimax_r10; 
    // 3 least significant bits of dma address
    wire[2:0] dmaaddr20; 
    // dma request combinatorial
    reg req_c; 
    // dma request registered
    reg req; 
    // dma request double registered
    reg req_r; 
    // internal dma request registered
    reg idmareq; 
    // 32-bit data output
    wire[31:0] datao32; 
    // buffer byte size extended to FIFODEPTH_MAX
    wire[FIFODEPTH_MAX - 1:0] bsmax; 
    // free space in fifo extended to FIFODEPTH_MAX
    wire[FIFODEPTH_MAX - 1:0] flmax; 
    // programmable burst length extended to FIFODEPTH_MAX
    wire[FIFODEPTH_MAX - 1:0] blmax; 
    // free space in fifo greater then buffer byte size
    reg fl_g_bs; 
    // free space in fifo greater then programmable burst length
    reg fl_g_bl; 
    // programmable burst length greater then buffer byte size
    reg bl_g_bs; 
    // programmable burst length=0 registered
    reg pblz; 
    // buffer fetching registered
    reg buffetch; 
    // internal dma transfer acknowledge registered
    reg dmaack_r; 
    //----------------------------- lsm ---------------------------------
    // linked list state machine combinatorial
    reg[3:0] lsm_c; 
    // linked list state machine registered
    reg[3:0] lsm; 
    // linked lit state machine registered
    reg[3:0] lsm_r; 
    // control state machine combinatorial
    reg[2:0] csm_c; 
    // control state machine registered
    reg[2:0] csm; 
    // linked list machine wait state counter
    reg[2:0] lsmcnt; 
    // transmit frame status writing in progress
    reg tsprog; 
    // current descriptor's status address registered
    reg[DATADEPTH - 1:0] statad; 
    // error summary
    wire es_c; 
    // ownership combinatorial
    reg own_c; 
    // ownership registered
    reg own; 
    // chained registered
    reg tch; 
    // end of ring registered
    reg ter; 
    // setup frame registered
    reg set; 
    // last segment registered
    reg tls; 
    // first segment registered
    reg tfs; 
    // buffer size (common for buffer1 & 2) combinatorial
    wire[10:0] bs_c; 
    // 2 least significant bits of buffer size
    wire[1:0] bs_c10; 
    // buffer 1 size registered
    reg[10:0] bs1; 
    // buffer 2 size registered
    reg[10:0] bs2; 
    // address write enable registered
    reg adwrite; 
    // buffer address registered
    reg[DATADEPTH - 1:0] bad; 
    // descriptor address registered
    reg[DATADEPTH - 1:0] dad; 
    // descriptor base address changed registered
    reg dbadc_r; 
    // transmit frame status
    wire[31:0] tstat; 
    // last dma transaction registered
    reg lastdma; 
    // internal frame cache read enable registered
    reg icachere; 
    // poll demand registered
    reg poll_r; 
    //---------------------------- buffer -------------------------------
    // buffer add value selection for DATAWIDTH=16
    wire[1:0] addsel16; 
    // buffer add value selection for DATAWIDTH=32
    wire[3:0] addsel32; 
    // temporary add value
    reg[3:0] addv_c; 
    // buffer add value
    reg[1:0] badd_c; 
    // buffer counter
    reg[11:0] bcnt; 
    // fifo write enable
    reg ififowe; 
    // buffer write enable registered
    wire bufwe; 
    // first data dword transfer combinatorial
    wire firstb_c; 
    // first data dword transfer registered
    reg firstb; 
    // fifo buffer0 (for 8/16/24/32/64-bit data alignment)
    reg[DATAWIDTH - 1:0] buf0_c; 
    // fifo buffer combinatorial
    reg[CWIDTH - 1:0] buf_c; 
    // fifo buffer registered
    reg[CWIDTH - 1:0] buf_r; 
    // fifo buffer level (words) combinatorial
    reg[3:0] buflev_c; 
    // fifo buffer level (words) registered
    reg[3:0] buflev; 
    // byte enable for the first data dword registered
    reg[DATAWIDTH / 8 - 1:0] firstbe; 
    // byte enable for the last data dword registered
    reg[DATAWIDTH / 8 - 1:0] lastbe; 
    // byte enable registered
    reg[DATAWIDTH / 8 - 1:0] be; 
    // byte enable for DATAWIDTH=16
    wire[1:0] be10; 
    // byte enable for DATAWIDTH=32
    wire[3:0] be30; 
    //------------------------- csr interrupts --------------------------
    // internal transmit completition registered
    reg itcomp; 
    // transmit completition acknowledge registered
    reg tcompack_r; 
    //------------------------- filtering RAM ---------------------------
    // filtering RAM write enable registered
    reg ifwe; 
    // filtering RAM address
    reg[ADDRDEPTH - 1:0] ifaddr; 
    //------------------------ Power management -------------------------
    // stop transmit process registered
    reg stop_r; 
    //---------------------------- others -------------------------------
    // zero vector of FIFODEPTH_MAX length
    wire[FIFODEPTH_MAX - 1:0] fzero_max; 
    // zero vector of DATAWIDTH_MAX length
    wire[DATAWIDTH_MAX - 1:0] dzero_max; 

    //-------------------------------------------------------------------
    // internal dma request registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : idmareq_reg_proc
        if (rst == 1'b0)
        begin
            idmareq <= 1'b0 ; 
        end
        else
        begin
            if (req_c == 1'b1)
            begin
                idmareq <= 1'b1 ; 
            end
            else if (dmaack == 1'b1 & dmaeob == 1'b1)
            begin
                idmareq <= 1'b0 ; 
            end 
        end 
    end // idmareq_reg_proc

    //-------------------------------------------------------------------
    // internal frame status cache read enable registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : cachere_reg_proc
        if (rst == 1'b0)
        begin
            icachere <= 1'b0 ; 
        end
        else
        begin
            if (itcomp == 1'b1 & tcompack_r == 1'b1)
            begin
                icachere <= 1'b1 ; 
            end
            else
            begin
                icachere <= 1'b0 ; 
            end 
        end 
    end // cachere_reg_proc
    //-------------------------------------------------------------------
    // frame status read enable
    // registered output
    //-------------------------------------------------------------------
    assign cachere = icachere ;

    //===================================================================--
    //                                 lsm                               --
    //===================================================================--
    //-------------------------------------------------------------------
    // linked list state machine combinatorial
    //-------------------------------------------------------------------
    always @(lsm or csm or poll_r or dmaack or dmaeob or own_c or tch or bs1 or 
             bs2 or stop_r or lsmcnt or fifocnf or tsprog or lastdma or dbadc_r)
    begin : lsm_proc
        case (lsm)
            //-----------------------------------------
            LSM_IDLE :
                        begin
                            //-----------------------------------------
                            if (dbadc_r == 1'b0 & stop_r == 1'b0 & fifocnf == 1'b1 & (poll_r == 1'b1 | (tsprog == 1'b1 & dmaack == 1'b1 & dmaeob == 1'b1)))
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
                            if (dmaack == 1'b1 & dmaeob == 1'b1 & tsprog == 1'b0)
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
            LSM_DES1 :
                        begin
                            //-----------------------------------------
                            if (dmaack == 1'b1 & dmaeob == 1'b1 & tsprog == 1'b0)
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
                            if (dmaack == 1'b1 & dmaeob == 1'b1 & tsprog == 1'b0)
                            begin
                                //-----------------------------------------
                                if (bs1 == 11'b00000000000 | csm == CSM_IDLE)
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
                            if (dmaack == 1'b1 & dmaeob == 1'b1 & tsprog == 1'b0)
                            begin
                                //-----------------------------------------
                                if (bs2 == 11'b00000000000 | tch == 1'b1 | csm == CSM_IDLE)
                                begin
                                    lsm_c <= LSM_NXT ; 
                                end
                                else
                                begin
                                    lsm_c <= LSM_BUF2 ; 
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
                            if (tsprog == 1'b0 & dmaack == 1'b1 & dmaeob == 1'b1 & lastdma == 1'b1)
                            begin
                                lsm_c <= LSM_DES3 ; 
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
                            if (tsprog == 1'b0 & dmaack == 1'b1 & dmaeob == 1'b1 & lastdma == 1'b1)
                            begin
                                lsm_c <= LSM_NXT ; 
                            end
                            else
                            begin
                                lsm_c <= LSM_BUF2 ; 
                            end 
                        end
            //-----------------------------------------
            LSM_NXT :
                        begin
                            if (lsmcnt == 3'b000)
                            begin
                                if (csm == CSM_L | csm == CSM_FL)
                                begin
                                    //-----------------------------------------
                                    if (stop_r == 1'b1 | fifocnf == 1'b0)
                                    begin
                                        lsm_c <= LSM_IDLE ; 
                                    end
                                    else
                                    begin
                                        lsm_c <= LSM_DES0 ; 
                                    end 
                                end
                                else
                                begin
                                    lsm_c <= LSM_STAT ; 
                                end 
                            end
                            else
                            begin
                                lsm_c <= LSM_NXT ; 
                            end 
                        end
            //-----------------------------------------
            default :
                        begin
                            if (dmaack == 1'b1 & dmaeob == 1'b1 & tsprog == 1'b0)
                            begin
                                // LSM_STAT
                                //-----------------------------------------
                                if (stop_r == 1'b1)
                                begin
                                    lsm_c <= LSM_IDLE ; 
                                end
                                else
                                begin
                                    lsm_c <= LSM_DES0 ; 
                                end 
                            end
                            else
                            begin
                                lsm_c <= LSM_STAT ; 
                            end 
                        end
        endcase 
    end // lsm_proc

    //-------------------------------------------------------------------
    // transmit linked list manager registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : lsm_reg_proc
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
    end // lsm_reg_proc

    //-------------------------------------------------------------------
    // control state machine combinatorial
    //-------------------------------------------------------------------
    always @(csm or lsm or tfs or tls or own or set or bs1 or bs2)
    begin : csm_proc
        case (csm)
            //-----------------------------------------
            CSM_IDLE :
                        begin
                            if (lsm == LSM_DES2 & own == 1'b1)
                            begin
                                //-----------------------------------------
                                if (set == 1'b0 & tfs == 1'b1 & tls == 1'b1)
                                begin
                                    csm_c <= CSM_FL ; 
                                end
                                else if (set == 1'b0 & tfs == 1'b1 & tls == 1'b0)
                                begin
                                    csm_c <= CSM_F ; 
                                end
                                else if (set == 1'b1 & tfs == 1'b0 & tls == 1'b0)
                                begin
                                    csm_c <= CSM_SET ; 
                                end
                                else
                                begin
                                    csm_c <= CSM_IDLE ; 
                                end 
                            end
                            else
                            begin
                                csm_c <= CSM_IDLE ; 
                            end 
                        end
            //-----------------------------------------
            CSM_FL :
                        begin
                            //-----------------------------------------
                            if (lsm == LSM_DES0 | lsm == LSM_IDLE)
                            begin
                                csm_c <= CSM_IDLE ; 
                            end
                            else if (lsm == LSM_DES2 & bs1 == 11'b00000000000 & bs2 == 11'b00000000000)
                            begin
                                csm_c <= CSM_BAD ; 
                            end
                            else
                            begin
                                csm_c <= CSM_FL ; 
                            end 
                        end
            //-----------------------------------------
            CSM_F :
                        begin
                            //-----------------------------------------
                            if (lsm == LSM_DES2 & tls == 1'b1)
                            begin
                                csm_c <= CSM_L ; 
                            end
                            else if (lsm == LSM_DES1 & tfs == 1'b0)
                            begin
                                csm_c <= CSM_I ; 
                            end
                            else
                            begin
                                csm_c <= CSM_F ; 
                            end 
                        end
            //-----------------------------------------
            CSM_L :
                        begin
                            //-----------------------------------------
                            if (lsm == LSM_DES0 | lsm == LSM_IDLE)
                            begin
                                csm_c <= CSM_IDLE ; 
                            end
                            else
                            begin
                                csm_c <= CSM_L ; 
                            end 
                        end
            //-----------------------------------------
            CSM_SET :
                        begin
                            //-----------------------------------------
                            if (lsm == LSM_DES0 | lsm == LSM_IDLE)
                            begin
                                csm_c <= CSM_IDLE ; 
                            end
                            else
                            begin
                                csm_c <= CSM_SET ; 
                            end 
                        end
            //-----------------------------------------
            CSM_I :
                        begin
                            //-----------------------------------------
                            if (lsm == LSM_DES2 & tls == 1'b1)
                            begin
                                csm_c <= CSM_L ; 
                            end
                            else
                            begin
                                csm_c <= CSM_I ; 
                            end 
                        end
            //-----------------------------------------
            default :
                        begin
                            // CSM_BAD
                            //-----------------------------------------
                            if (lsm == LSM_NXT)
                            begin
                                csm_c <= CSM_IDLE ; 
                            end
                            else
                            begin
                                csm_c <= CSM_BAD ; 
                            end 
                        end
        endcase 
    end // csm_proc

    //-------------------------------------------------------------------
    // control state machine registered
    //-------------------------------------------------------------------  
    always @(posedge clk or negedge rst)
    begin : csm_reg_proc
        if (rst == 1'b0)
        begin
            csm <= CSM_IDLE ; 
        end
        else
        begin
            csm <= csm_c ; 
        end 
    end // csm_reg_proc

    //-------------------------------------------------------------------
    // linked list wait state counter
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : lsmcnt_reg_proc
        if (rst == 1'b0)
        begin
            lsmcnt <= {3{1'b1}} ; 
        end
        else
        begin
            if (lsm == LSM_NXT)
            begin
                lsmcnt <= lsmcnt - 1 ; 
            end
            else
            begin
                lsmcnt <= {3{1'b1}} ; 
            end 
        end 
    end // lsmcnt_reg_proc

    //-------------------------------------------------------------------
    // poll demand registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : poll_reg_proc
        if (rst == 1'b0)
        begin
            poll_r <= 1'b0 ; 
        end
        else
        begin
            if (poll == 1'b1)
            begin
                poll_r <= 1'b1 ; 
            end
            else if (poll == 1'b0 & dbadc_r == 1'b0)
            begin
                poll_r <= 1'b0 ; 
            end 
        end 
    end // poll_reg_proc
    //-------------------------------------------------------------------
    // poll acknowledge
    // registered output
    //-------------------------------------------------------------------
    assign pollack = poll_r ;

    //-------------------------------------------------------------------
    // desriptor ownership bit combinatorial
    //-------------------------------------------------------------------
    always @(own or dmaack or dmaeob or lsm or dmadatai)
    begin : own_proc
        own_c <= own ; 
        if (dmaack == 1'b1 & dmaeob == 1'b1 & lsm == LSM_DES0)
        begin
            own_c <= dmadatai[DATAWIDTH - 1] ; 
        end 
    end // own_proc

    //-------------------------------------------------------------------
    // descriptor ownership registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : own_reg_proc
        if (rst == 1'b0)
        begin
            own <= 1'b1 ; 
        end
        else
        begin
            own <= own_c ; 
        end 
    end // own_reg_proc

    //-------------------------------------------------------------------
    // des1 status registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : des1_reg_proc
        reg ft22; 
        if (rst == 1'b0)
        begin
            ft22 = 1'b0; 
            tls <= 1'b0 ; 
            tfs <= 1'b0 ; 
            set <= 1'b0 ; 
            ac <= 1'b0 ; 
            ter <= 1'b0 ; 
            tch <= 1'b0 ; 
            dpd <= 1'b0 ; 
            ic <= 1'b0 ; 
            bs2 <= {11{1'b0}} ; 
            bs1 <= {11{1'b0}} ; 
            ft <= {2{1'b0}} ; 
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
                                                        dpd <= dmadatai_max[7] ; 
                                                        ft22 = dmadatai_max[6]; 
                                                    end
                                        default :
                                                    begin
                                                        // "011" | "111"
                                                        ic <= dmadatai_max[7] ; 
                                                        tls <= dmadatai_max[6] ; 
                                                        tfs <= dmadatai_max[5] ; 
                                                        set <= dmadatai_max[3] ; 
                                                        ac <= dmadatai_max[2] ; 
                                                        ter <= dmadatai_max[1] ; 
                                                        tch <= dmadatai_max[0] ; 
                                                        // filtering type valid only for a setup frame
                                                        if ((dmadatai_max[3]) == 1'b1)
                                                        begin
                                                            ft <= {dmadatai_max[4], ft22} ; 
                                                        end 
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
                                                        ic <= dmadatai_max[15] ; 
                                                        tls <= dmadatai_max[14] ; 
                                                        tfs <= dmadatai_max[13] ; 
                                                        set <= dmadatai_max[11] ; 
                                                        ac <= dmadatai_max[10] ; 
                                                        ter <= dmadatai_max[9] ; 
                                                        tch <= dmadatai_max[8] ; 
                                                        dpd <= dmadatai_max[7] ; 
                                                        // filtering type valid only for a setup frame
                                                        if ((dmadatai_max[11]) == 1'b1)
                                                        begin
                                                            ft <= {dmadatai_max[12], dmadatai_max[6]} ; 
                                                        end 
                                                    end
                                    endcase 
                                end
                    //-------------------------------------
                    default :
                                begin
                                    // 32
                                    //-------------------------------------
                                    ic <= dmadatai_max[31] ; 
                                    tls <= dmadatai_max[30] ; 
                                    tfs <= dmadatai_max[29] ; 
                                    set <= dmadatai_max[27] ; 
                                    ac <= dmadatai_max[26] ; 
                                    ter <= dmadatai_max[25] ; 
                                    tch <= dmadatai_max[24] ; 
                                    dpd <= dmadatai_max[23] ; 
                                    bs2 <= dmadatai_max[21:11] ; 
                                    bs1 <= dmadatai_max[10:0] ; 
                                    // filtering type valid only for a setup frame
                                    if ((dmadatai_max[27]) == 1'b1)
                                    begin
                                        ft <= {dmadatai_max[28], dmadatai_max[22]} ; 
                                    end 
                                end
                endcase 
            end 
        end 
    end // des1_reg_proc
    //-------------------------------------------------------------------
    // dmadatai of DATAWIDTH_MAX length
    //-------------------------------------------------------------------
    assign dmadatai_max = (DATAWIDTH == 8) ? {dzero_max[31:8], dmadatai} : (DATAWIDTH == 16) ? {dzero_max[31:16], dmadatai} : dmadatai ;

    //---------------------------------------------------------------------
    //                           lsm addresses                           --
    //---------------------------------------------------------------------
    //-------------------------------------------------------------------
    // address write enable registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : adwrite_reg_proc
        if (rst == 1'b0)
        begin
            adwrite <= 1'b0 ; 
        end
        else
        begin
            if (dmaack == 1'b1 & dmaeob == 1'b1 & tsprog == 1'b0)
            begin
                adwrite <= 1'b1 ; 
            end
            else
            begin
                adwrite <= 1'b0 ; 
            end 
        end 
    end // adwrite_reg_proc

    //-------------------------------------------------------------------
    // descriptor base address changed registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : dbadc_reg_proc
        if (rst == 1'b0)
        begin
            dbadc_r <= 1'b0 ; 
        end
        else
        begin
            dbadc_r <= dbadc ; 
        end 
    end // dbadc_reg_proc

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
                dad <= dbad ; 
            end
            else if (adwrite == 1'b1)
            begin
                case (lsm_r)
                    //-----------------------------------
                    LSM_DES3 :
                                begin
                                    //-----------------------------------
                                    if (ter == 1'b1)
                                    begin
                                        dad <= dbad ; 
                                    end
                                    else if (tch == 1'b1)
                                    begin
                                        dad <= dataimax_r[DATADEPTH - 1:0] ; 
                                    end
                                    else
                                    begin
                                        dad <= dmaaddr + ({dsl, 2'b00}) ; 
                                    end 
                                end
                    //-----------------------------------
                    LSM_DES0 :
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
                                end
                    // LSM_BUF1 | LSM_BUF2
                    //-----------------------------------
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
                if (lsm_r == LSM_DES2 | lsm_r == LSM_DES3)
                begin
                    case (DATAWIDTH)
                        8 :
                                    begin
                                        bad <= dataimax_r[DATADEPTH - 1:0] ; 
                                    end
                        16 :
                                    begin
                                        bad <= {dataimax_r[DATADEPTH - 1:1], 1'b0} ; 
                                    end
                        default :
                                    begin
                                        // 32
                                        bad <= {dataimax_r[DATADEPTH - 1:2], 2'b00} ; 
                                    end
                    endcase 
                end
                else
                begin
                    bad <= dmaaddr ; 
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
        end
        else
        begin
            // address of DES0 field is current status address
            if (lsm_r == LSM_DES0 & adwrite == 1'b1 & own == 1'b1)
            begin
                statad <= dad ; 
            end 
        end 
    end // stataddr_reg_proc
    //-------------------------------------------------------------------
    // frame status address
    // registered output
    //-------------------------------------------------------------------
    assign statado = statad ;
    //---------------------------------------------------------------------
    //                   Buffer byte counter for lsm                    --
    //---------------------------------------------------------------------
    //-------------------------------------------------------------------
    // buffer size combinatorial
    //-------------------------------------------------------------------
    assign bs_c = (lsm_r == LSM_DES2) ? bs1 : bs2 ;
    //-------------------------------------------------------------------
    // buffer add selection value for DATAWIDTH=16
    //-------------------------------------------------------------------
    assign addsel16 = {dataimax_r[0], bs_c[0]} ;
    //-------------------------------------------------------------------
    // buffer add selection value for DATAWIDTH=32
    //-------------------------------------------------------------------
    assign addsel32 = {dataimax_r10, bs_c10} ;

    //-------------------------------------------------------------------
    // buffer byte counter add value combinatorial
    //-------------------------------------------------------------------
    always @(addsel16 or addsel32)
    begin : badd_proc
        case (DATAWIDTH)
            //-----------------------------------------
            8 :
                        begin
                            //-----------------------------------------
                            badd_c <= 2'b00 ; 
                        end
            //-----------------------------------------
            16 :
                        begin
                            //-----------------------------------------
                            if (addsel16 == 2'b01 | addsel16 == 2'b10 | addsel16 == 2'b11)
                            begin
                                badd_c <= 2'b01 ; 
                            end
                            else
                            begin
                                badd_c <= 2'b00 ; 
                            end 
                        end
            default :
                        begin
                            // 32
                            //-----------------------------------------
                            case (addsel32)
                                //-----------------------------------------
                                4'b0000 :
                                            begin
                                                badd_c <= 2'b00 ; 
                                            end
                                4'b1011, 4'b1110, 4'b1111 :
                                            begin
                                                badd_c <= 2'b10 ; 
                                            end
                                default :
                                            begin
                                                badd_c <= 2'b01 ; 
                                            end
                            endcase 
                        end
        endcase 
    end // badd_proc

    //-------------------------------------------------------------------
    // buffer byte counter registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : bcnt_reg_proc
        if (rst == 1'b0)
        begin
            bcnt <= {12{1'b1}} ; 
        end
        else
        begin
            case (DATAWIDTH)
                //-------------------------------------
                8 :
                            begin
                                //-------------------------------------
                                if (lsm_r == LSM_DES2 | lsm_r == LSM_DES3)
                                begin
                                    bcnt <= {1'b0, bs_c} ; 
                                end
                                else if (dmaack == 1'b1 & tsprog == 1'b0)
                                begin
                                    bcnt <= bcnt - 1 ; 
                                end 
                            end
                //-------------------------------------
                16 :
                            begin
                                //-------------------------------------
                                if (lsm_r == LSM_DES2 | lsm_r == LSM_DES3)
                                begin
                                    bcnt <= {(({1'b0, bs_c[10:1]}) + badd_c), 1'b0} ; 
                                end
                                else if (dmaack == 1'b1 & tsprog == 1'b0)
                                begin
                                    bcnt <= {(bcnt[11:1] - 1), 1'b0} ; 
                                end 
                            end
                //-------------------------------------
                default :
                            begin
                                // 32
                                //-------------------------------------
                                if (lsm_r == LSM_DES2 | lsm_r == LSM_DES3)
                                begin
                                    bcnt <= {(({1'b0, bs_c[10:2]}) + badd_c), 2'b00} ; 
                                end
                                else if (dmaack == 1'b1 & tsprog == 1'b0)
                                begin
                                    bcnt <= {(bcnt[11:2] - 1), 2'b00} ; 
                                end 
                            end
            endcase 
        end 
    end // bcnt_reg_proc
    //---------------------------------------------------------------------
    //                            TFIFO buffer                           --
    //---------------------------------------------------------------------
    //-------------------------------------------------------------------
    // 2 least significant bits of byte size
    //-------------------------------------------------------------------
    assign bs_c10 = bs_c[1:0] ;
    //-------------------------------------------------------------------
    // data input extended to DATADEPTH_MAX registered 1..0
    //-------------------------------------------------------------------
    assign dataimax_r10 = dataimax_r[1:0] ;

    //-------------------------------------------------------------------
    // first byte enable registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : firstbe_reg_proc
        if (rst == 1'b0)
        begin
            firstbe <= {DATAWIDTH / 8 - 1-(0)+1{1'b1}} ; 
        end
        else
        begin
            if (lsm_r == LSM_DES2 | lsm_r == LSM_DES3)
            begin
                case (DATAWIDTH)
                    //-----------------------------------
                    8 :
                                begin
                                    //-----------------------------------
                                    firstbe <= 1'b1 ; 
                                end
                    //-----------------------------------
                    16 :
                                begin
                                    //-----------------------------------
                                    if ((dataimax_r[0]) == 1'b1)
                                    begin
                                        firstbe <= 2'b10 ; 
                                    end
                                    else
                                    begin
                                        firstbe <= 2'b11 ; 
                                    end 
                                end
                    default :
                                begin
                                    // 32
                                    //-----------------------------------
                                    case (dataimax_r10)
                                        //-----------------------------------
                                        2'b00 :
                                                    begin
                                                        firstbe <= 4'b1111 ; 
                                                    end
                                        2'b01 :
                                                    begin
                                                        firstbe <= 4'b1110 ; 
                                                    end
                                        2'b10 :
                                                    begin
                                                        firstbe <= 4'b1100 ; 
                                                    end
                                        default :
                                                    begin
                                                        firstbe <= 4'b1000 ; 
                                                    end
                                    endcase 
                                end
                endcase 
            end 
        end 
    end // firstbe_reg_proc

    //-------------------------------------------------------------------
    // last byte enable registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : lastbe_reg_proc
        if (rst == 1'b0)
        begin
            lastbe <= {DATAWIDTH / 8 - 1-(0)+1{1'b1}} ; 
        end
        else
        begin
            if (lsm_r == LSM_DES2 | lsm_r == LSM_DES3)
            begin
                case (DATAWIDTH)
                    //-----------------------------------
                    8 :
                                begin
                                    //-----------------------------------
                                    lastbe <= 1'b1 ; 
                                end
                    //-----------------------------------
                    16 :
                                begin
                                    //-----------------------------------
                                    if (((dataimax_r[0]) == 1'b0 & (bs_c[0]) == 1'b0) | ((dataimax_r[0]) == 1'b1 & (bs_c[0]) == 1'b1))
                                    begin
                                        lastbe <= 2'b11 ; 
                                    end
                                    else
                                    begin
                                        lastbe <= 2'b01 ; 
                                    end 
                                end
                    default :
                                begin
                                    case (dataimax_r10)
                                        2'b00 :
                                                    begin
                                                        // 32
                                                        //-----------------------------------
                                                        case (bs_c10)
                                                            //-----------------------------------
                                                            2'b00 :
                                                                        begin
                                                                            lastbe <= 4'b1111 ; 
                                                                        end
                                                            2'b01 :
                                                                        begin
                                                                            lastbe <= 4'b0001 ; 
                                                                        end
                                                            2'b10 :
                                                                        begin
                                                                            lastbe <= 4'b0011 ; 
                                                                        end
                                                            default :
                                                                        begin
                                                                            lastbe <= 4'b0111 ; 
                                                                        end
                                                        endcase 
                                                    end
                                        2'b01 :
                                                    begin
                                                        case (bs_c10)
                                                            2'b00 :
                                                                        begin
                                                                            lastbe <= 4'b0001 ; 
                                                                        end
                                                            2'b01 :
                                                                        begin
                                                                            lastbe <= 4'b0011 ; 
                                                                        end
                                                            2'b10 :
                                                                        begin
                                                                            lastbe <= 4'b0111 ; 
                                                                        end
                                                            default :
                                                                        begin
                                                                            lastbe <= 4'b1111 ; 
                                                                        end
                                                        endcase 
                                                    end
                                        2'b10 :
                                                    begin
                                                        case (bs_c10)
                                                            2'b00 :
                                                                        begin
                                                                            lastbe <= 4'b0011 ; 
                                                                        end
                                                            2'b01 :
                                                                        begin
                                                                            lastbe <= 4'b0111 ; 
                                                                        end
                                                            2'b10 :
                                                                        begin
                                                                            lastbe <= 4'b1111 ; 
                                                                        end
                                                            default :
                                                                        begin
                                                                            lastbe <= 4'b0001 ; 
                                                                        end
                                                        endcase 
                                                    end
                                        default :
                                                    begin
                                                        //"11"
                                                        case (bs_c10)
                                                            2'b00 :
                                                                        begin
                                                                            lastbe <= 4'b0111 ; 
                                                                        end
                                                            2'b01 :
                                                                        begin
                                                                            lastbe <= 4'b1111 ; 
                                                                        end
                                                            2'b10 :
                                                                        begin
                                                                            lastbe <= 4'b0001 ; 
                                                                        end
                                                            default :
                                                                        begin
                                                                            lastbe <= 4'b0011 ; 
                                                                        end
                                                        endcase 
                                                    end
                                    endcase 
                                end
                endcase 
            end 
        end 
    end // lastbe_proc

    //-------------------------------------------------------------------
    // transmit fifo write enable registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : tfwe_reg_proc
        if (rst == 1'b0)
        begin
            ififowe <= 1'b0 ; 
        end
        else
        begin
            if (((DATAWIDTH == 8 & buflev_c >= 4'b0001 & bufwe == 1'b1) | (DATAWIDTH == 16 & buflev_c >= 4'b0010 & bufwe == 1'b1) | (DATAWIDTH == 32 & buflev_c >= 4'b0100 & bufwe == 1'b1) | (buflev_c != 4'b0000 & lsm == LSM_NXT & (csm == CSM_L | csm == CSM_FL))) & fifonf == 1'b1)
            begin
                ififowe <= 1'b1 ; 
            end
            else
            begin
                ififowe <= 1'b0 ; 
            end 
        end 
    end // tfwe_reg_proc
    //-------------------------------------------------------------------
    // fifo end of frame
    //-------------------------------------------------------------------
    assign fifoeof = ((csm == CSM_L | csm == CSM_FL) & lsm == LSM_NXT & lsmcnt == 3'b001) ? 1'b1 : 1'b0 ;
    //-------------------------------------------------------------------
    // fifo write enable
    // registered output
    //-------------------------------------------------------------------
    assign fifowe = ififowe ;
    //-------------------------------------------------------------------
    // first TFIFO buffer transfer combinatorial
    //------------------------------------------------------------------
    assign firstb_c = (bufwe == 1'b1) ? 1'b0 : (lsm == LSM_DES2 | lsm == LSM_DES3) ? 1'b1 : firstb ;

    //-------------------------------------------------------------------
    // TFIFO byte enable combinatorial
    //-------------------------------------------------------------------
    always @(firstb or firstbe or lastbe or dmaeob or lastdma)
    begin : be_proc
        be <= {DATAWIDTH / 8 - 1-(0)+1{1'b1}} ; 
        if (dmaeob == 1'b1 & lastdma == 1'b1)
        begin
            be <= lastbe ; 
        end
        else if (firstb == 1'b1)
        begin
            be <= firstbe ; 
        end 
    end // be_proc

    //-------------------------------------------------------------------
    // TFIFO buffer 0 combinatorial
    //-------------------------------------------------------------------
    always @(be or be30 or dmadatai_max)
    begin : tbuf0_proc
        reg[15:0] buf0_16; 
        reg[31:0] buf0_32; 
        buf0_c <= {DATAWIDTH - 1-(0)+1{1'b0}} ; 
        case (DATAWIDTH)
            //-----------------------------------------
            8 :
                        begin
                            //-----------------------------------------
                            buf0_c[DATAWIDTH - 1:0] <= dmadatai_max[7:0] ; 
                        end
            //-----------------------------------------
            16 :
                        begin
                            //-----------------------------------------
                            buf0_16 = {16{1'b0}}; 
                            if (be == 2'b10)
                            begin
                                buf0_16[7:0] = dmadatai_max[15:8]; 
                            end
                            else
                            begin
                                buf0_16 = dmadatai_max[15:0]; 
                            end 
                            buf0_c[DATAWIDTH - 1:0] <= buf0_16[DATAWIDTH - 1:0] ; 
                        end
            default :
                        begin
                            // 32
                            //-----------------------------------------
                            buf0_32 = {32{1'b0}}; 
                            case (be30)
                                //-----------------------------------------
                                4'b1110 :
                                            begin
                                                buf0_32[23:0] = dmadatai_max[31:8]; 
                                            end
                                4'b1100 :
                                            begin
                                                buf0_32[15:0] = dmadatai_max[31:16]; 
                                            end
                                4'b1000 :
                                            begin
                                                buf0_32[7:0] = dmadatai_max[31:24]; 
                                            end
                                default :
                                            begin
                                                buf0_32 = dmadatai_max[31:0]; 
                                            end
                            endcase 
                            buf0_c[DATAWIDTH - 1:0] <= buf0_32[DATAWIDTH - 1:0] ; 
                        end
        endcase 
    end // tbuf0_proc

    //-------------------------------------------------------------------
    // TFIFO buffer combinatorial
    //-------------------------------------------------------------------
    // Changes made to this process in v3.0 due to vector width misalignments SAR56860
    always @(buflev or buf_r or buf0_c or bufwe or ififowe)
    begin : tbuf_proc
        reg[55:0] buf_16; // only actually uses 23:0, other bits for bus width matching
        reg[55:0] buf_32; 
        reg[55:0] buf_32a; 
        buf_c <= {CWIDTH - 1-(0)+1{1'b0}} ; // default value	on all bits
        case (DATAWIDTH)
            //-----------------------------------------
            8 :
                        begin
                            //-----------------------------------------
                            buf_c[CWIDTH - 1:0] <= buf0_c[CWIDTH - 1:0] ; 
                        end
            16 :
                        begin
                            //-----------------------------------------
                            buf_16 = {56{1'b0}}; 
                            buf_16[23:0] = buf_r; 
                            if (bufwe == 1'b1)
                            begin
                                case (buflev)
                                    //-----------------------------------------
                                    4'b0000 :
                                                begin
                                                    buf_16[15:0] = buf0_c; 
                                                end
                                    4'b0001 :
                                                begin
                                                    buf_16[23:8] = buf0_c; 
                                                end
                                    4'b0010 :
                                                begin
                                                    buf_16[15:0] = buf0_c; 
                                                end
                                    default :
                                                begin
                                                    buf_16[23:8] = buf0_c; 
                                                    buf_16[7:0] = buf_r[23:16]; 
                                                end
                                endcase 
                            end
                            else if (ififowe == 1'b1)
                            begin
                                buf_16[23:0] = {buf_r[23:8], buf_r[23:16]}; 
                            end 
                            buf_c[CWIDTH - 1:0] <= buf_16[CWIDTH - 1:0] ; 
                        end
            default :
                        begin
                            // 32
                            //-----------------------------------------
                            buf_32  = buf_r; 
                            buf_32a = buf_r; 
                            if (bufwe == 1'b1)
                            begin
                                case (buflev)
                                    //-----------------------------------------
                                    4'b0000 :
                                                begin
                                                    buf_32[31:0] = buf0_c; 
                                                end
                                    4'b0001 :
                                                begin
                                                    buf_32[39:8] = buf0_c; 
                                                end
                                    4'b0010 :
                                                begin
                                                    buf_32[47:16] = buf0_c; 
                                                end
                                    4'b0011 :
                                                begin
                                                    buf_32[55:24] = buf0_c; 
                                                end
                                    4'b0100 :
                                                begin
                                                    buf_32[31:0] = buf0_c; 
                                                end
                                    4'b0101 :
                                                begin
                                                    buf_32[39:8] = buf0_c; 
                                                    buf_32[7:0]  = buf_32a[39:32]; 	
                                                end
                                    4'b0110 :
                                                begin
                                                    buf_32[47:16] = buf0_c; 
                                                    buf_32[15:0]  = buf_32a[47:32]; 	
                                                end
                                    default :
                                                begin
                                                    // "0111"
                                                    buf_32[55:24] = buf0_c; 
                                                    buf_32[23:0]  = buf_32a[55:32]; 	
                                                end
                                endcase 
                            end
                            else if (ififowe == 1'b1)
                            begin
                                buf_32 = {buf_32a[55:24], buf_32a[55:32]}; 
                            end 
                            buf_c[CWIDTH - 1:0] <= buf_32[CWIDTH - 1:0] ; 
                        end
        endcase 
    end // tbuf_proc
    //-------------------------------------------------------------------
    // buffer write enable
    //-------------------------------------------------------------------
    assign bufwe = (dmaack == 1'b1 & set == 1'b0 & fifonf == 1'b1 & tsprog == 1'b0 & (lsm == LSM_BUF1 | lsm == LSM_BUF2)) ? 1'b1 : 1'b0 ;
    //-------------------------------------------------------------------
    // fifo data
    // registered output
    //-------------------------------------------------------------------
    assign fifodata = buf_r[DATAWIDTH - 1:0] ;

    generate
        if (DATAWIDTH == 8)
        begin : be01_drv
            //-------------------------------------------------------------------
            // fifo byte enable for DATAWIDTH  8 16 32   SAR 56860
            //-------------------------------------------------------------------
            assign be10 = {2{1'b1}} ;
            assign be30 = {4{1'b1}} ;
        end
    endgenerate 

    generate
        if (DATAWIDTH == 16)
        begin : be10_drv
            assign be10 = be[1:0] ;
            assign be30 = {4{1'b1}} ;
        end
    endgenerate 

    generate
        if (DATAWIDTH == 32)
        begin : be30_drv
            assign be10 = {2{1'b1}} ;
            assign be30 = be[3:0] ;
        end
    endgenerate 

    //-------------------------------------------------------------------
    // temporary add value
    //-------------------------------------------------------------------
    always @(be10 or be30)
    begin : addv_proc
        case (DATAWIDTH)
            //-----------------------------------------
            8 :
                        begin
                            //-----------------------------------------
                            addv_c <= 4'b0000 ; 
                        end
            16 :
                        begin
                            //-----------------------------------------
                            case (be10)
                                //-----------------------------------------
                                2'b01, 2'b10 :
                                            begin
                                                addv_c <= 4'b0001 ; 
                                            end
                                default :
                                            begin
                                                addv_c <= 4'b0010 ; 
                                            end
                            endcase 
                        end
            default :
                        begin
                            // 32
                            //-----------------------------------------
                            case (be30)
                                //-----------------------------------------
                                4'b0001, 4'b1000 :
                                            begin
                                                addv_c <= 4'b0001 ; 
                                            end
                                4'b0011, 4'b1100 :
                                            begin
                                                addv_c <= 4'b0010 ; 
                                            end
                                4'b0111, 4'b1110 :
                                            begin
                                                addv_c <= 4'b0011 ; 
                                            end
                                default :
                                            begin
                                                addv_c <= 4'b0100 ; 
                                            end
                            endcase 
                        end
        endcase 
    end // addv_proc

    //-------------------------------------------------------------------
    // buffer level combinatorial
    //-------------------------------------------------------------------
    always @(buflev or bufwe or ififowe or addv_c)
    begin : buflev_proc
        case (DATAWIDTH)
            //-----------------------------------------
            8 :
                        begin
                            //-----------------------------------------
                            if (bufwe == 1'b1)
                            begin
                                buflev_c <= 4'b0001 ; 
                            end
                            else if (ififowe == 1'b1)
                            begin
                                buflev_c <= 4'b0000 ; 
                            end
                            else
                            begin
                                buflev_c <= buflev ; 
                            end 
                        end
            //-----------------------------------------
            16 :
                        begin
                            //-----------------------------------------
                            if (bufwe == 1'b1)
                            begin
                                buflev_c <= ({buflev[3:2], 1'b0, buflev[0]}) + addv_c ; 
                            end
                            else if (ififowe == 1'b1 & (buflev[1]) == 1'b1)
                            begin
                                buflev_c <= {buflev[3:2], 1'b0, buflev[0]} ; 
                            end
                            else if (ififowe == 1'b1 & (buflev[1]) == 1'b0)
                            begin
                                buflev_c <= {buflev[3:1], 1'b0} ; 
                            end
                            else
                            begin
                                buflev_c <= buflev ; 
                            end 
                        end
            //-----------------------------------------
            default :
                        begin
                            // 32
                            //-----------------------------------------
                            if (bufwe == 1'b1)
                            begin
                                buflev_c <= ({buflev[3:3], 1'b0, buflev[1:0]}) + addv_c ; 
                            end
                            else if (ififowe == 1'b1 & (buflev[2]) == 1'b1)
                            begin
                                buflev_c <= {buflev[3:3], 1'b0, buflev[1:0]} ; 
                            end
                            else if (ififowe == 1'b1 & (buflev[2]) == 1'b0)
                            begin
                                buflev_c <= {buflev[3:2], 2'b00} ; 
                            end
                            else
                            begin
                                buflev_c <= buflev ; 
                            end 
                        end
        endcase 
    end // buflev_proc

    //-------------------------------------------------------------------
    // fifo buffer registered
    //-------------------------------------------------------------------  
    always @(posedge clk or negedge rst)
    begin : buf_reg_proc
        if (rst == 1'b0)
        begin
            buflev <= {4{1'b0}} ; 
            firstb <= 1'b1 ; 
            buf_r <= {CWIDTH - 1-(0)+1{1'b0}} ; 
        end
        else
        begin
            buflev <= buflev_c ; 
            firstb <= firstb_c ; 
            buf_r <= buf_c ; 
        end 
    end // buf_reg_proc

    //-------------------------------------------------------------------
    // transmit last byte enable
    // registered output
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : lbe_reg_proc
        if (rst == 1'b0)
        begin
            fifobe <= {DATAWIDTH / 8 - 1-(0)+1{1'b1}} ; 
        end
        else
        begin
            if (ififowe == 1'b1)
            begin
                case (DATAWIDTH)
                    //-----------------------------------
                    8 :
                                begin
                                    //-----------------------------------
                                    fifobe <= 1'b1 ; 
                                end
                    16 :
                                begin
                                    //-----------------------------------
                                    case (buflev)
                                        //-----------------------------------
                                        4'b0001 :
                                                    begin
                                                        fifobe <= 2'b01 ; 
                                                    end
                                        default :
                                                    begin
                                                        fifobe <= 2'b11 ; 
                                                    end
                                    endcase 
                                end
                    default :
                                begin
                                    // 32
                                    //-----------------------------------
                                    case (buflev)
                                        //-----------------------------------
                                        4'b0001 :
                                                    begin
                                                        fifobe <= 4'b0001 ; 
                                                    end
                                        4'b0010 :
                                                    begin
                                                        fifobe <= 4'b0011 ; 
                                                    end
                                        4'b0011 :
                                                    begin
                                                        fifobe <= 4'b0111 ; 
                                                    end
                                        default :
                                                    begin
                                                        fifobe <= 4'b1111 ; 
                                                    end
                                    endcase 
                                end
                endcase 
            end 
        end 
    end // lbe_drv
    //-------------------------------------------------------------------
    // error summary combinatorial
    //-------------------------------------------------------------------
    assign es_c = ur | lc | lo | nc | ec ;
    //-------------------------------------------------------------------
    // transmit frame status
    //-------------------------------------------------------------------
    assign tstat = {1'b0, TDES0_RV[30:16], es_c, TDES0_RV[14:12], lo, nc, lc, ec, TDES0_RV[7], cc, TDES0_RV[2], ur, de} ;
    //-------------------------------------------------------------------
    // 32-bit data output
    //-------------------------------------------------------------------
    assign datao32 = (tsprog == 1'b1) ? tstat : (set == 1'b1) ? SET0_RV : TDES0_RV ;

    //-------------------------------------------------------------------
    // dma interface
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : dataimax_reg_proc
        if (rst == 1'b0)
        begin
            dataimax_r <= {DATAWIDTH_MAX - 1-(0)+1{1'b1}} ; 
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
    // data output
    // combinatorial output
    //-------------------------------------------------------------------
    always @(datao32 or dmaaddr)
    begin : datao_proc
        reg[1:0] addr10; 
        addr10 = dmaaddr[1:0]; 
        case (DATAWIDTH)
            8 :
                        begin
                            //-----------------------------------------
                            case (addr10)
                                //-----------------------------------------
                                2'b00 :
                                            begin
                                                dmadatao <= datao32[7:0] ; 
                                            end
                                2'b01 :
                                            begin
                                                dmadatao <= datao32[15:8] ; 
                                            end
                                2'b10 :
                                            begin
                                                dmadatao <= datao32[23:16] ; 
                                            end
                                default :
                                            begin
                                                dmadatao <= datao32[31:24] ; 
                                            end
                            endcase 
                        end
            //-----------------------------------------
            16 :
                        begin
                            //-----------------------------------------
                            if ((addr10[1]) == 1'b0)
                            begin
                                dmadatao <= datao32[15:0] ; 
                            end
                            else
                            begin
                                dmadatao <= datao32[31:16] ; 
                            end 
                        end
            //-----------------------------------------
            default :
                        begin
                            // 32
                            //-----------------------------------------
                            dmadatao <= datao32 ; 
                        end
        endcase 
    end // datao_proc
    //-------------------------------------------------------------------
    // free fifo space extended to FIFODEPTH_MAX
    //-------------------------------------------------------------------
   
    // XTEK CORRECTION 
	wire [FIFODEPTH - 1:0] XTEKFIX =  fzero_max[FIFODEPTH - 1:0] - 1 - fifolev;
    assign flmax = {fzero_max[FIFODEPTH_MAX - 1:FIFODEPTH], XTEKFIX } ;
   
  
    //assign flmax = {fzero_max[FIFODEPTH_MAX - 1:FIFODEPTH], (fzero_max[FIFODEPTH - 1:0] - 1 - fifolev)} ;
   
    //-------------------------------------------------------------------
    // programmable burst length extended to FIFODEPTH_MAX
    //-------------------------------------------------------------------
    assign blmax = {fzero_max[FIFODEPTH_MAX - 1:6], pbl} ;
    //-------------------------------------------------------------------
    // buffer size extended to FIFODEPTH_MAX
    //-------------------------------------------------------------------
    assign bsmax = (DATAWIDTH == 8) ?  {fzero_max[FIFODEPTH_MAX - 1:12], bcnt} 
                 : (DATAWIDTH == 16) ? {fzero_max[FIFODEPTH_MAX - 1:11], bcnt[11:1]} 
                                     : {fzero_max[FIFODEPTH_MAX - 1:10], bcnt[11:2]} ;

    //-------------------------------------------------------------------
    // free fifo space greater then buffer size
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : fifolev_reg_proc
        if (rst == 1'b0)
        begin
            fl_g_bs <= 1'b0 ; 
            fl_g_bl <= 1'b0 ; 
            bl_g_bs <= 1'b0 ; 
            pblz <= 1'b0 ; 
        end
        else
        begin
            // free fifo space greater then buffer size
            if (flmax >= bsmax)
            begin
                fl_g_bs <= 1'b1 ; 
            end
            else
            begin
                fl_g_bs <= 1'b0 ; 
            end 
            	
            // free fifo space greater then programmable burst length
            if (flmax >= blmax)
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
    end // fl_g_bs_reg_proc

    //-------------------------------------------------------------------
    // dma counter
    // combinatorial output
    //-------------------------------------------------------------------
    always @(csm or lsm or pblz or tsprog or fl_g_bs or fl_g_bl or bl_g_bs or 
             blmax or bsmax or flmax or fzero_max)
    begin : dmacnt_proc
        // descriptor fetch -------------------------
        if (lsm == LSM_DES0 | lsm == LSM_DES1 | lsm == LSM_DES2 | lsm == LSM_DES3 | lsm == LSM_STAT | tsprog == 1'b1)
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
                // fifo free space greater then buffer size
                // or setup frame processing
                if (fl_g_bs == 1'b1 | csm == CSM_SET)
                begin
                    dmacnt <= bsmax ; 
                end
                // fifo free space less then buffer size
                else
                begin
                    dmacnt <= flmax ; 
                end 
            end
            // programmable burst length
            else
            begin
                // fifo free space greater then programmable burst length
                // or setup frame processing
                if (fl_g_bl == 1'b1 | csm == CSM_SET)
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
                // fifo free space less then programmable burst length
                else
                begin
                    // fifo free space greater then buffer size
                    if (fl_g_bs == 1'b1)
                    begin
                        dmacnt <= bsmax ; 
                    end
                    // fifo free space less then buffer size
                    else
                    begin
                        dmacnt <= flmax ; 
                    end 
                end 
            end 
        end 
    end // dmacnt_proc

    //-------------------------------------------------------------------
    // last dma transaction registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : lastdma_reg_proc
        if (rst == 1'b0)
        begin
            lastdma <= 1'b1 ; 
        end
        else
        begin
            // descriptor fetch -------------------------
            if (lsm == LSM_DES0 | lsm == LSM_DES1 | lsm == LSM_DES2 | lsm == LSM_DES3 | lsm == LSM_STAT | tsprog == 1'b1)
            begin
                lastdma <= 1'b1 ; 
            end
            // buffer fetch -----------------------------
            else if (buffetch == 1'b0)
            begin
                // unlimited burst
                if (pblz == 1'b1)
                begin
                    // fifo free space greater then buffer size
                    // or setup frame processing
                    if (fl_g_bs == 1'b1 | csm == CSM_SET)
                    begin
                        lastdma <= 1'b1 ; 
                    end
                    // fifo free space less then buffer size
                    else
                    begin
                        lastdma <= 1'b0 ; 
                    end 
                end
                // programmable burst length
                else
                begin
                    // fifo free space greater then programmable burst length
                    // or setup frame processing
                    if (fl_g_bl == 1'b1 | csm == CSM_SET)
                    begin
                        // programmable burst length greater then buffer size
                        if (bl_g_bs == 1'b1)
                        begin
                            lastdma <= 1'b1 ; 
                        end
                        // programmable burst length less then buffer size
                        else
                        begin
                            lastdma <= 1'b0 ; 
                        end 
                    end
                    // fifo free space less then programmable burst length
                    else
                    begin
                        // fifo free space greater then buffer size
                        if (fl_g_bs == 1'b1)
                        begin
                            lastdma <= 1'b1 ; 
                        end
                        // fifo free space less then buffer size
                        else
                        begin
                            lastdma <= 1'b0 ; 
                        end 
                    end 
                end 
            end 
        end 
    end // lastdma_reg_proc

    //-------------------------------------------------------------------
    // dma address
    // combinatorial output
    //-------------------------------------------------------------------
    always @(tsprog or lsm or statadi or bad or dad or statad)
    begin : dmaaddro_proc
        dmaaddro <= statadi ; 
        if (tsprog != 1'b1)
        begin
            case (lsm)
                LSM_BUF1, LSM_BUF2 :
                            begin
                                dmaaddro <= bad ; 
                            end
                LSM_STAT :
                            begin
                                dmaaddro <= statad ; 
                            end
                default :
                            begin
                                // LSM_DES0|LSM_DES1|LSM_DES2|LSM_DES3
                                dmaaddro <= dad ; 
                            end
            endcase 
        end 
    end // dmaaddro_proc

    //-------------------------------------------------------------------
    // internal dma request combinatorial
    //-------------------------------------------------------------------
    always @(req or dmaack or dmaeob or lsm or tsprog or fifoval)
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
                            else if (fifoval == 1'b1 | tsprog == 1'b1)
                            begin
                                req_c <= 1'b1 ; 
                            end
                            else
                            begin
                                req_c <= req ; 
                            end 
                        end
            //-----------------------------------------
            LSM_DES0, LSM_DES1, LSM_DES2, LSM_DES3, LSM_STAT :
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
            default :
                        begin
                            // LSM_IDLE
                            //-----------------------------------------
                            if (dmaack == 1'b1)
                            begin
                                req_c <= 1'b0 ; 
                            end
                            else if (tsprog == 1'b1)
                            begin
                                req_c <= 1'b1 ; 
                            end
                            else
                            begin
                                req_c <= 1'b0 ; 
                            end 
                        end
        endcase 
    end // req_proc

    //-------------------------------------------------------------------
    // dma request/acknowledge registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : req_reg_proc
        if (rst == 1'b0)
        begin
            req <= 1'b0 ; 
            req_r <= 1'b0 ; 
            dmaack_r <= 1'b0 ; 
        end
        else
        begin
            req <= req_c ; 
            req_r <= req ; 
            dmaack_r <= dmaack & dmaeob ; 
        end 
    end // req_reg_proc
    //-------------------------------------------------------------------
    // dma write selection
    // combinatorial output
    //-------------------------------------------------------------------
    assign dmawr = (tsprog == 1'b1 | lsm == LSM_STAT) ? 1'b1 : 1'b0 ;
    //-------------------------------------------------------------------
    // dma request
    // registered output
    //-------------------------------------------------------------------
    assign dmareq = req ;

    //===================================================================--
    //                         STATE MACHINE STATUS                      --
    //===================================================================--
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
            tsprog <= 1'b0 ; 
            buffetch <= 1'b0 ; 
            tu <= 1'b0 ; 
        end
        else
        begin
            // fetching descriptor
            if (lsm == LSM_DES0 | lsm == LSM_DES1 | lsm == LSM_DES2 | lsm == LSM_DES3)
            begin
                des <= 1'b1 ; 
            end
            else
            begin
                des <= 1'b0 ; 
            end 
            // fetching buffer
            if (lsm == LSM_BUF1 | lsm == LSM_BUF2)
            begin
                fbuf <= 1'b1 ; 
            end
            else
            begin
                fbuf <= 1'b0 ; 
            end 
            // writting status
            if (tsprog == 1'b1)
            begin
                stat <= 1'b1 ; 
            end
            else
            begin
                stat <= 1'b0 ; 
            end 
            // transmit frame status writing in progress
            if ((dmaeob == 1'b1 & dmaack == 1'b1) | itcomp == 1'b1 | tcompack_r == 1'b1)
            begin
                tsprog <= 1'b0 ; 
            end
            else if (csne == 1'b1 & idmareq == 1'b0 & icachere == 1'b0)
            begin
                tsprog <= 1'b1 ; 
            end 
            // buffer fetching
            if (dmaack_r == 1'b1)
            begin
                buffetch <= 1'b0 ; 
            end
            else if (req_r == 1'b1 & (lsm == LSM_BUF1 | lsm == LSM_BUF2))
            begin
                buffetch <= 1'b1 ; 
            end 
            // transmit descriptor unavailable
            if (lsm == LSM_IDLE & own == 1'b0)
            begin
                tu <= 1'b1 ; 
            end
            else if (own_c == 1'b1)
            begin
                tu <= 1'b0 ; 
            end 
        end 
    end // stat_reg_proc

    //-------------------------------------------------------------------
    // transmit completition registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : tcompack_reg_proc
        if (rst == 1'b0)
        begin
            tcompack_r <= 1'b0 ; 
            itcomp <= 1'b0 ; 
        end
        else
        begin
            // transmit completition acknowledge
            tcompack_r <= tcompack ; 
            // internal transmit completition
            if (tsprog == 1'b1 & dmaeob == 1'b1 & dmaack == 1'b1)
            begin
                itcomp <= 1'b1 ; 
            end
            else if (tcompack_r == 1'b1)
            begin
                itcomp <= 1'b0 ; 
            end 
        end 
    end // tcompack_reg_proc
    //-------------------------------------------------------------------
    // transmit completition
    // registered output
    //-------------------------------------------------------------------
    assign tcomp = itcomp ;

    //=================================================================--
    //                         Filtering RAM                           --
    //=================================================================--
    //-------------------------------------------------------------------
    // setup frame processing
    // registered output
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : setp_reg_proc
        if (rst == 1'b0)
        begin
            setp <= 1'b0 ; 
        end
        else
        begin
            if (csm == CSM_SET)
            begin
                setp <= 1'b1 ; 
            end
            else
            begin
                setp <= 1'b0 ; 
            end 
        end 
    end // setp_reg_proc

    //-------------------------------------------------------------------
    // filtering ram address
    // registered output
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : ifaddr_reg_proc
        if (rst == 1'b0)
        begin
            ifaddr <= {ADDRDEPTH - 1-(0)+1{1'b0}} ; 
        end
        else
        begin
            if (csm == CSM_IDLE)
            begin
                ifaddr <= {ADDRDEPTH - 1-(0)+1{1'b0}} ; 
            end
            else if (ifwe == 1'b1)
            begin
                ifaddr <= ifaddr + 1 ; 
            end 
        end 
    end // ifaddr_reg_proc

    //-------------------------------------------------------------------
    // internal filtering ram write enable registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : ifwe_reg_proc
        if (rst == 1'b0)
        begin
            ifwe <= 1'b0 ; 
        end
        else
        begin
            case (DATAWIDTH)
                //-------------------------------------
                8 :
                            begin
                                //-------------------------------------
                                if (csm == CSM_SET & dmaack == 1'b1 & dmaaddr[1:0] == 2'b11 & (lsm == LSM_BUF1 | lsm == LSM_BUF2))
                                begin
                                    ifwe <= 1'b1 ; 
                                end
                                else
                                begin
                                    ifwe <= 1'b0 ; 
                                end 
                            end
                //-------------------------------------
                16 :
                            begin
                                //-------------------------------------
                                if (csm == CSM_SET & dmaack == 1'b1 & (dmaaddr[1]) == 1'b1 & (lsm == LSM_BUF1 | lsm == LSM_BUF2))
                                begin
                                    ifwe <= 1'b1 ; 
                                end
                                else
                                begin
                                    ifwe <= 1'b0 ; 
                                end 
                            end
                //-------------------------------------
                default :
                            begin
                                // 32
                                //-------------------------------------
                                if (csm == CSM_SET & dmaack == 1'b1 & (lsm == LSM_BUF1 | lsm == LSM_BUF2))
                                begin
                                    ifwe <= 1'b1 ; 
                                end
                                else
                                begin
                                    ifwe <= 1'b0 ; 
                                end 
                            end
            endcase 
        end 
    end // ifwe_reg_proc
    //-------------------------------------------------------------------
    // fifo address
    // registered output
    //-------------------------------------------------------------------
    assign faddr = ifaddr ;
    //-------------------------------------------------------------------
    // filtering ram write enable
    // registered output
    //-------------------------------------------------------------------
    assign fwe = ifwe ;
    //-------------------------------------------------------------------
    // filtering RAM data
    // registered output
    //-------------------------------------------------------------------
    assign fdata = dataimax_r[15:0] ;

    //=================================================================--
    //                       Power management                          --
    //=================================================================--
    //-------------------------------------------------------------------
    // stop transmit process registered
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
            // stop acknowledge
            // can enter stopped state only if
            // descriptor/buffer processing state machine is idle
            if (lsm == LSM_IDLE & stop_r == 1'b1)
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
    //                               OTHERS                              --
    //===================================================================--
    //-------------------------------------------------------------------
    // zero vector of DATAWIDTH_MAX length
    //-------------------------------------------------------------------
    assign dzero_max = {DATAWIDTH_MAX - 1-(0)+1{1'b0}} ;
    //-------------------------------------------------------------------
    // zero vector of FIFODEPTH_MAX length
    //-------------------------------------------------------------------
    assign fzero_max = {FIFODEPTH_MAX - 1-(0)+1{1'b0}} ;
    //-------------------------------------------------------------------
    // 3 least significant bits of dma address
    //-------------------------------------------------------------------
    assign dmaaddr20 = dmaaddr[2:0] ;
endmodule
