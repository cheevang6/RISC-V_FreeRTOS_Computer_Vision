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
// File:  csr.v
//     
// Description: Core10100
//              See below  
//
// Notes: 
//
// *********************************************************************/ 
//
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
// File name            : csr.vhd
// File contents        : Entity CSR
//                        Architecture RTL of CSR
// Purpose              : Control and Status Registers for MAC,
//                        Power state machines for MAC
//                        Interrupt control for MAC
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
// 2003.03.21 : T.K. - unused CSR registers removed
// 2003.03.21 : T.K. - flow control support removed
// 2003.04.01 : T.K. - interrupt section changed
//                     ("csr5_reg_proc", "iint_proc")
// 2.00.E02   :
// 2003.04.15 : T.K. - csrdata_proc changed for 16-bit interface
// 2003.04.15 : T.K. - behaviour of interrupt mitigation control
//                     counters/timers changed
// 2003.04.15 : T.K. - csr8read_reg_proc changed
// 2003.04.15 : T.K. - tap_reg_proc changed
// 2003.04.15 : T.K. - mfcg_r, focg_r signal added
// 2003.04.15 : T.K. - synchronous processes merged
// 2.00.E03   :
// 2003.05.12 : T.K. - csr0_drv changed
// 2003.05.12 : T.K. - rs_drv: default value changed
// 2003.05.12 : T.K. - csr6_sr_drv removed
// 2003.05.12 : T.K. - csr6_reg_proc changed
// 2.00.E05   :
// 2003.08.10 : H.C. - csr8_mfo initialization fixed
// 2003.08.10 : H.C. - csr8_oco initialization fixed
// 2003.08.10 : H.C. - tcs128 initialization fixed
// 2.00.E06   :  
// 2004.01.20 : B.W. - fixed receive address changing possibility 
//                     in unstopped states (F200.05.rxaddrchange) :
//                      * rdbadc_reg_proc process modified
//
// 2004.01.20 : B.W. - fixed foc counter (F200.05.foc) &
//                     fixed mfc counter (F200.05.mfc) &
//                     statistical counters module integration
//                     support (I200.05.sc) : 
//                      * csr8_reg_proc process modified
//                      * foc_proc process modified
//                      * mfc_proc process modified
//
// 2004.01.20 : B.W. - fixed gpt timer (F200.05.gpt) :
//                      * gpt_reg_proc process modified
//
// 2004.01.20 : B.W. - RTL code changes due to VN Check
//                     and code coverage (I200.06.vn):
//                      * csrmux_proc
// 2.00.E06a  :
// 2004.02.20 : T.K. - CSR11 reset value fixed (F200.06.gcnt) :
//                      * gpt_reg_proc process changed
// 2.00.E07   :
// 2004.03.22 : T.K. - unused comments removed
// *******************************************************************--
// *******************************************************************--
module CSR (clk, rst, int, csrreq, csrrw, csrbe, csraddr, csrdatai, csrack, csrdatao, rstsofto, tprog, tireq, unf, tcsreq, tiack, tcsack, fd, ic, etireq, etiack, tm, sf, tset, tdes, tbuf, tstat, tu, tpollack, ft, tpoll, tdbadc, tdbad, rcsreq, rprog, rcsack, ren, ra, pm, pr, pb, rif, ho, hp, foclack, mfclack, oco, mfo, focg, mfcg, focl, mfcl, rireq, erireq, ru, rpollack, rdes, rbuf, rstat, riack, eriack, rpoll, rdbadc, rdbad, ble, dbo, priority, pbl, dsl, stoptc, stoptlsm, stoptfifo, stopt, tps, stoprc, stoprlsm, stoprfifo, stopr, rps, sdi, sclk, scs, sdo, mdi, mdc, mdo, mden, csr6_ttm);

    parameter CSRWIDTH   = 32; 
    parameter ENDIANESS  = 0;
    parameter DATAWIDTH  = 32;
    parameter DATADEPTH  = 32;
    parameter RCDEPTH    = 2;
   
    `include "utility.v"

    input clk; 
    input rst; 
    output int; 
    wire int;
    input csrreq; 
    input csrrw; 
    input[CSRWIDTH / 8 - 1:0] csrbe; 
    input[7:0] csraddr; 
    input[CSRWIDTH - 1:0] csrdatai; 
    output csrack; 
    wire csrack;
    output[CSRWIDTH - 1:0] csrdatao; 
    reg[CSRWIDTH - 1:0] csrdatao;
    output rstsofto; 
    reg rstsofto;
    input tprog; 
    input tireq; 
    input unf; 
    input tcsreq; 
    output tiack; 
    wire tiack;
    output tcsack; 
    wire tcsack;
    output fd; 
    wire fd;
    input ic; 
    input etireq; 
    output etiack; 
    wire etiack;
    output[2:0] tm; 
    wire[2:0] tm;
    output sf; 
    wire sf;
    input tset; 
    input tdes; 
    input tbuf; 
    input tstat; 
    input tu; 
    input tpollack; 
    input[1:0] ft; 
    output tpoll; 
    wire tpoll;
    output tdbadc; 
    reg tdbadc;
    output[DATADEPTH - 1:0] tdbad; 
    wire[DATADEPTH - 1:0] tdbad;
    input rcsreq; 
    input rprog; 
    output rcsack; 
    wire rcsack;
    output ren; 
    wire ren;
    output ra; 
    wire ra;
    output pm; 
    wire pm;
    output pr; 
    wire pr;
    output pb; 
    wire pb;
    output rif; 
    wire rif;
    output ho; 
    wire ho;
    output hp; 
    wire hp;
    input foclack; 
    input mfclack; 
    input oco; 
    input mfo; 
    input[10:0] focg; 
    input[15:0] mfcg; 
    output focl; 
    reg focl;
    output mfcl; 
    reg mfcl;
    input rireq; 
    input erireq; 
    input ru; 
    input rpollack; 
    input rdes; 
    input rbuf; 
    input rstat; 
    output riack; 
    wire riack;
    output eriack; 
    wire eriack;
    output rpoll; 
    reg rpoll;
    output rdbadc; 
    reg rdbadc;
    output[DATADEPTH - 1:0] rdbad; 
    wire[DATADEPTH - 1:0] rdbad;
    output ble; 
    wire ble;
    output dbo; 
    wire dbo;
    output[1:0] priority; 
    wire[1:0] priority;
    output[5:0] pbl; 
    wire[5:0] pbl;
    output[4:0] dsl; 
    wire[4:0] dsl;
    input stoptc; 
    input stoptlsm; 
    input stoptfifo; 
    output stopt; 
    wire stopt;
    output tps; 
    reg tps;
    input stoprc; 
    input stoprlsm; 
    input stoprfifo; 
    output stopr; 
    wire stopr;
    output rps; 
    reg rps;
    input sdi; 
    output sclk; 
    wire sclk;
    output scs; 
    wire scs;
    output sdo; 
    wire sdo;
    input mdi; 
    output mdc; 
    wire mdc;
    output mdo; 
    wire mdo;
    output mden; 
    wire mden;
    output csr6_ttm;

    //------------------------ common csr -------------------------------
    // internal csr data
    reg[31:0] csrdata_c; 
    // internal csr byte enable
    reg[3:0] csrdbe_c; 
    // 2 least significant bits of CSR address
    wire[1:0] csraddr10; 
    // bits 7 downto 2 of CSR address
    wire[5:0] csraddr72; 
    // byte enable for 16-bit interface
    wire[1:0] csrbe10; 
    // CSR0 read value
    wire[31:0] csr0; 
    // CSR5 read value
    wire[31:0] csr5; 
    // CSR6 read value
    wire[31:0] csr6; 
    // CSR7 read value
    wire[31:0] csr7; 
    // CSR8 read value
    wire[31:0] csr8; 
    // CSR9 read value
    wire[31:0] csr9; 
    // CSR11 read value
    wire[31:0] csr11; 
    //--------------------------- csr0 ----------------------------------
    // descriptor byte ordering mode
    wire csr0_dbo; 
    // transmit automatic pooling
    reg[2:0] csr0_tap; 
    // programmable burst length
    reg[5:0] csr0_pbl; 
    // big/little endian
    wire csr0_ble; 
    // descriptor skip length
    reg[4:0] csr0_dsl; 
    // bus arbitration scheme
    reg csr0_bar; 
    // software reset
    reg csr0_swr; 
    //--------------------------- csr3 ----------------------------------
    // receive descriptor base address
    reg[31:0] csr3; 
    //--------------------------- csr4 ----------------------------------
    // transmit descriptor base address
    reg[31:0] csr4; 
    //--------------------------- csr5 ----------------------------------
    // transmit process state
    reg[2:0] csr5_ts; 
    // receive process state
    reg[2:0] csr5_rs; 
    // normal interrupt summary
    reg csr5_nis; 
    // abnormal interrupt summary
    reg csr5_ais; 
    // early receive interrupt
    reg csr5_eri; 
    // general purpose timer expiration
    reg csr5_gte; 
    // early transmit interrupt
    reg csr5_eti; 
    // receive process stopped
    reg csr5_rps; 
    // receive buffer unavailable
    reg csr5_ru; 
    // receive interrupt
    reg csr5_ri; 
    // transmit underflow
    reg csr5_unf; 
    // transmit buffer unavailable
    reg csr5_tu; 
    // transmit process stopped
    reg csr5_tps; 
    // transmit interrupt
    reg csr5_ti; 
    //--------------------------- csr6 ----------------------------------
    // receive all
    reg csr6_ra; 
    // transmit treshold mode
    reg csr6_ttm; 
    // store and forward
    reg csr6_sf; 
    // treshold control bits
    reg[1:0] csr6_tr; 
    // start/stop transmit command
    reg csr6_st; 
    // full duplex mode
    reg csr6_fd; 
    // pass all multicast
    reg csr6_pm; 
    // promiscous mode
    reg csr6_pr; 
    // inverse filtrering
    reg csr6_if; 
    // pass bad frames
    reg csr6_pb; 
    // hash only filtering mode
    reg csr6_ho; 
    // start/stop receive command
    reg csr6_sr; 
    // hash/perfect receive filtering mode
    reg csr6_hp; 
    //--------------------------- csr7 ----------------------------------
    // normal interrupt summary enable
    reg csr7_nie; 
    // abnormal interrupt enable
    reg csr7_aie; 
    // early receive interrupt enable
    reg csr7_ere; 
    // general purpose timer expiration enable
    reg csr7_gte; 
    // early transmit interrupt enable
    reg csr7_ete; 
    // receive stopped enable
    reg csr7_rse; 
    // receive buffer unavailable enable
    reg csr7_rue; 
    // receive interrupt enable
    reg csr7_rie; 
    // underflow interrupt enable
    reg csr7_une; 
    // transmit buffer unavailable enable
    reg csr7_tue; 
    // transmit stopped enable
    reg csr7_tse; 
    // transmit interrupt enable
    reg csr7_tie; 
    //--------------------------- csr8 ----------------------------------
    // fifo overflow counter
    reg[10:0] csr8_foc; 
    // fifo overflow counter overflow
    reg csr8_oco; 
    // missed frames counter
    reg[15:0] csr8_mfc; 
    // missed frames counter overflow
    reg csr8_mfo; 
    // csr8 read registered
    reg csr8read; 
    //--------------------------- csr9 ----------------------------------
    // mii management data in
    reg csr9_mdi; 
    // mii management operation mode
    reg csr9_mii; 
    // mii management write data
    reg csr9_mdo; 
    // mii management clock
    reg csr9_mdc; 
    // serial rom data input
    reg csr9_sdi; 
    // serial rom clock
    reg csr9_sclk; 
    // serial rom chip select
    reg csr9_scs; 
    // serial rom data output
    reg csr9_sdo; 
    //--------------------------- csr11 ---------------------------------
    // cycle size
    reg csr11_cs; 
    // transmit timer
    reg[3:0] csr11_tt; 
    // number of transmit packets
    reg[2:0] csr11_ntp; 
    // receive timer
    reg[3:0] csr11_rt; 
    // number of receive packets
    reg[2:0] csr11_nrp; 
    // continous mode
    reg csr11_con; 
    // timer value
    reg[15:0] csr11_tim; 
    // csr11 write registered
    reg csr11wr; 
    //------------------------------ tlsm -------------------------------
    // transmit automatic pooling write
    reg tapwr; 
    // transmit poll command
    reg tpollcmd; 
    // internal transmit poll
    reg itpoll; 
    // transmit automatic pooling counter
    reg[2:0] tapcnt; 
    //----------------------------- tpsm --------------------------------
    // transmit process state machine combinatorial
    reg[1:0] tpsm_c; 
    // transmit process state machine registered
    reg[1:0] tpsm; 
    // stop transmit process
    reg tstopcmd; 
    // stop transmit process
    reg tstartcmd; 
    // tc component stopped registered
    reg stoptc_r; 
    // tlsm component stopped registered
    reg stoptlsm_r; 
    // tfifo component stopped registered
    reg stoptfifo_r; 
    // internal transmit state
    wire[2:0] ts_c; 
    //----------------------------- rpsm --------------------------------
    // receive process state machine combinatorial
    reg[1:0] rpsm_c; 
    // receive process state machine registered
    reg[1:0] rpsm; 
    // stop receive process
    reg rstopcmd; 
    // stop receive process
    reg rstartcmd; 
    // rc component stopped registered
    reg stoprc_r; 
    // rlsm component stopped registered
    reg stoprlsm_r; 
    // rfifo component stopped registered
    reg stoprfifo_r; 
    // receive state for csr combinatorial
    wire[2:0] rs_c; 
    //----------------------------- rlsm --------------------------------
    // receive poll command
    reg rpollcmd; 
    //------------------------------ int --------------------------------
    // csr5 write combinatorial
    wire csr5wr_c; 
    // csr5 write registered
    reg csr5wr; 
    // general purpose timer expired regsistered
    reg gte; 
    // interrupt registered
    reg iint; 
    // receive interrupt request registered
    reg rireq_r; 
    // receive interrupt request double registered
    reg rireq_r2; 
    // early receive interrupt
    reg eri; 
    // early receive interrupt request registered
    reg erireq_r; 
    // early receive interrupt request double registered
    reg erireq_r2; 
    // transmit interrupt request registered
    reg tireq_r; 
    // transmit interrupt request double registered
    reg tireq_r2; 
    // early transmit interrupt
    reg eti; 
    // early transmit interrupt request registered
    reg etireq_r; 
    // early transmit interrupt request double registered
    reg etireq_r2; 
    // transmit underflow interrupt
    reg unfi; 
    // transmit underflow interrupt registered
    reg unf_r; 
    // transmit underflow interrupt double registered
    reg unf_r2; 
    // transmit buffer unavailable interrupt
    reg tui; 
    // transmit buffer unavailable registered
    reg tu_r; 
    // transmit buffer unavailable double registered
    reg tu_r2; 
    // receive buffer unavailable interrupt
    reg rui; 
    // receive buffer unavailable registered
    reg ru_r; 
    // receive buffer unavailable double registered
    reg ru_r2; 
    // interrupt on completition registered
    reg iic; 
    //-------------------------- receive tim ----------------------------
    // receive cycle size request
    reg rcsreq_r; 
    // receive cycle size request phase 1
    reg rcsreq_r1; 
    // receive interrupt mitigation in progress
    reg rimprog; 
    // receive cycle size counter
    reg[3:0] rcscnt; 
    // receive cycle size=2048*clkr
    reg rcs2048; 
    // receive cycle size=128*clkr
    reg rcs128; 
    // receive interrupt mitigation timer
    reg[3:0] rtcnt; 
    // receive interrupt mitigation counter
    reg[2:0] rcnt; 
    // receive interrupt mitigation control expired
    reg rimex; 
    //------------------------- transmit tim ----------------------------
    // transmit interrupt mitigation in progress
    reg timprog; 
    // transmit interrupt mitigation timer
    reg[7:0] ttcnt; 
    // transmit interrupt mitigation counter
    reg[2:0] tcnt; 
    // transmit interrupt mitigation control expired
    reg timex; 
    // transmitcycle size request registered
    reg tcsreq_r1; 
    // transmit cycle size request double registered
    reg tcsreq_r2; 
    // transmit cycle size counter
    reg[3:0] tcscnt; 
    // transmit cycle size=2048*clkt
    reg tcs2048; 
    // transmit cycle size=128*clkt
    reg tcs128; 
    //-------------------- statistical counters -------------------------
    // fifo overflow counter binary combinatorial
    reg[10:0] foc_c; 
    // missed frames counter binary combinatorial
    reg[15:0] mfc_c; 
    // fifo overflow counter grey coded
    reg[10:0] focg_r; 
    // missed frames counter grey coded
    reg[15:0] mfcg_r; 
    //--------------------------- others --------------------------------
    // general purpose timer timer start command
    reg gstart; 
    // general purpose timer timer start command
    reg gstart_r; 
    // general purpose timer
    reg[15:0] gcnt; 
    reg mcsr0_dbo; 
    reg mcsr0_ble; 

    //===================================================================--
    //                               csr                                 --
    //===================================================================--
    //-------------------------------------------------------------------
    // 2 least significant bits of CSR address
    //-------------------------------------------------------------------
    assign csraddr10 = csraddr[1:0] ;
    //-------------------------------------------------------------------
    // bits 7 downto 2 of CSR address
    //-------------------------------------------------------------------
    assign csraddr72 = csraddr[7:2] ;
    //-------------------------------------------------------------------
    // CSR byte enable for 16-bit interface
    //-------------------------------------------------------------------
    assign csrbe10 = (CSRWIDTH == 16) ? csrbe : {2{1'b1}} ;

    //-------------------------------------------------------------------
    // csr data mux combinatorial
    //-------------------------------------------------------------------  
    always @(csrdatai or csrbe or csraddr or csraddr10 or csrbe10)
    begin : csrdata_proc
        csrdata_c <= {32{1'b1}} ; 
        csrdbe_c <= {4{1'b1}} ; 
        case (CSRWIDTH)
            8 :
                        begin
                            //-----------------------------------
                            if ((csrbe[0]) == 1'b1)
                            begin
                                case (csraddr10)
                                    //-----------------------------------
                                    2'b00 :
                                                begin
                                                    csrdata_c[7:0] <= csrdatai ; 
                                                    csrdbe_c <= 4'b0001 ; 
                                                end
                                    2'b01 :
                                                begin
                                                    csrdata_c[15:8] <= csrdatai ; 
                                                    csrdbe_c <= 4'b0010 ; 
                                                end
                                    2'b10 :
                                                begin
                                                    csrdata_c[23:16] <= csrdatai ; 
                                                    csrdbe_c <= 4'b0100 ; 
                                                end
                                    default :
                                                begin
                                                    //"11"
                                                    csrdata_c[31:24] <= csrdatai ; 
                                                    csrdbe_c <= 4'b1000 ; 
                                                end
                                endcase 
                            end
                            else
                            begin
                                csrdbe_c <= 4'b0000 ; 
                            end 
                        end
            16 :
                        begin
                            //-----------------------------------
                            case (csrbe10)
                                //-----------------------------------
                                2'b11 :
                                            begin
                                                if ((csraddr[1]) == 1'b1)
                                                begin
                                                    csrdata_c[31:16] <= csrdatai ; 
                                                    csrdbe_c <= 4'b1100 ; 
                                                end
                                                else
                                                begin
                                                    csrdata_c[15:0] <= csrdatai ; 
                                                    csrdbe_c <= 4'b0011 ; 
                                                end 
                                            end
                                2'b10 :
                                            begin
                                                if ((csraddr[1]) == 1'b1)
                                                begin
                                                    csrdata_c[31:24] <= csrdatai[CSRWIDTH - 1:CSRWIDTH / 2] ; 
                                                    csrdbe_c <= 4'b1000 ; 
                                                end
                                                else
                                                begin
                                                    csrdata_c[23:16] <= csrdatai[CSRWIDTH - 1:CSRWIDTH / 2] ; 
                                                    csrdbe_c <= 4'b0010 ; 
                                                end 
                                            end
                                2'b01 :
                                            begin
                                                if ((csraddr[1]) == 1'b1)
                                                begin
                                                    csrdata_c[15:8] <= csrdatai[7:0] ; 
                                                    csrdbe_c <= 4'b0100 ; 
                                                end
                                                else
                                                begin
                                                    csrdata_c[7:0] <= csrdatai[7:0] ; 
                                                    csrdbe_c <= 4'b0001 ; 
                                                end 
                                            end
                                default :
                                            begin
                                                //"00"
                                                csrdbe_c <= 4'b0000 ; 
                                            end
                            endcase 
                        end
            //-----------------------------------
            default :
                        begin
                            // 32
                            //-----------------------------------
                            csrdata_c[CSRWIDTH-1:0]  <= csrdatai[CSRWIDTH-1:0] ; 
                            csrdbe_c[CSRWIDTH/8-1:0] <= csrbe[CSRWIDTH/8-1:0] ; 
                        end
        endcase 
    end // csrdata_proc

    //-------------------------------------------------------------------
    // csr0
    // registered outputs
    //-------------------------------------------------------------------  
    always @(posedge clk or negedge rst)
    begin : csr0_reg_proc
        if (rst == 1'b0)
        begin
            mcsr0_dbo <= CSR0_RV[20] ; // is zero
            csr0_tap <= CSR0_RV[19:17] ; 
            csr0_pbl <= CSR0_RV[13:8] ; 
            mcsr0_ble <= CSR0_RV[7] ; 
            csr0_dsl <= CSR0_RV[6:2] ; 
            csr0_bar <= CSR0_RV[1] ; 
            csr0_swr <= CSR0_RV[0] ; 
            tapwr <= 1'b0 ; 
        end
        else
        begin
            if (csrrw == 1'b0 & csrreq == 1'b1 & csraddr72 == CSR0_ID)
            begin
                // Host write ---------------------------
                if ((csrdbe_c[2]) == 1'b1)
                begin
                    mcsr0_dbo <= csrdata_c[20] ; 
                    csr0_tap <= csrdata_c[19:17] ; 
                    tapwr <= 1'b1 ; 
                end
                else
                begin
                    tapwr <= 1'b0 ; 
                end 
                if ((csrdbe_c[1]) == 1'b1)
                begin
                    csr0_pbl <= csrdata_c[13:8] ; 
                end 
                if ((csrdbe_c[0]) == 1'b1)
                begin
                    mcsr0_ble <= csrdata_c[7] ; 
                    csr0_dsl <= csrdata_c[6:2] ; 
                    csr0_bar <= csrdata_c[1] ; 
                    csr0_swr <= csrdata_c[0] ; 
                end 
            end
            else
            begin
                tapwr <= 1'b0 ; 
            end 
        end 
    end // csr0_reg_proc 
  
    assign csr0_dbo = (ENDIANESS == 1) ? 1'b0 : (ENDIANESS == 2) ? 1'b1 : mcsr0_dbo ;
    assign csr0_ble = (ENDIANESS == 1) ? 1'b0 : (ENDIANESS == 2) ? 1'b1 : mcsr0_ble ;


    //-------------------------------------------------------------------
    // transmit pool command
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : tpoolcmd_reg_proc
        if (rst == 1'b0)
        begin
            tpollcmd <= 1'b0 ; 
        end
        else
        begin
            // host write ---------------------------
            if (csrrw == 1'b0 & csrreq == 1'b1 & csraddr72 == CSR1_ID)
            begin
                tpollcmd <= 1'b1 ; 
            end
            else
            begin
                tpollcmd <= 1'b0 ; 
            end 
        end 
    end // tpoolcmd_reg_proc

    //-------------------------------------------------------------------
    // receive pool command
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : rpoolcmd_reg_proc
        if (rst == 1'b0)
        begin
            rpollcmd <= 1'b0 ; 
        end
        else
        begin
            // Host write ---------------------------
            if (csrrw == 1'b0 & csrreq == 1'b1 & csraddr72 == CSR2_ID)
            begin
                rpollcmd <= 1'b1 ; 
            end
            else
            begin
                rpollcmd <= 1'b0 ; 
            end 
        end 
    end // rpoolcmd_reg_proc

    //-------------------------------------------------------------------
    // CSR3
    //-------------------------------------------------------------------  
    always @(posedge clk or negedge rst)
    begin : csr3_reg_proc
        if (rst == 1'b0)
        begin
            csr3 <= CSR3_RV ; 
        end
        else
        begin
            if (csrrw == 1'b0 & csrreq == 1'b1 & csraddr72 == CSR3_ID)
            begin
                // Host write ---------------------------
                if ((csrdbe_c[0]) == 1'b1)
                begin
                    csr3[7:0] <= csrdata_c[7:0] ; 
                end 
                if ((csrdbe_c[1]) == 1'b1)
                begin
                    csr3[15:8] <= csrdata_c[15:8] ; 
                end 
                if ((csrdbe_c[2]) == 1'b1)
                begin
                    csr3[23:16] <= csrdata_c[23:16] ; 
                end 
                if ((csrdbe_c[3]) == 1'b1)
                begin
                    csr3[31:24] <= csrdata_c[31:24] ; 
                end 
            end 
        end 
    end // rdbad_reg_proc
    //-------------------------------------------------------------------
    // receive descriptor base address
    //-------------------------------------------------------------------
    assign rdbad = csr3[DATADEPTH - 1:0] ;

    //-------------------------------------------------------------------
    // receive descriptor base address changed
    // registered output
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : rdbadc_reg_proc
        if (rst == 1'b0)
        begin
            rdbadc <= 1'b1 ; 
        end
        else
        begin
            if (csrrw == 1'b0 & csrreq == 1'b1 & csraddr72 == CSR3_ID & rpsm == PSM_STOP)
            begin
                rdbadc <= 1'b1 ; 
            end
            else if (rpsm == PSM_RUN)
            begin
                rdbadc <= 1'b0 ; 
            end 
        end 
    end // rdbadc_reg_proc

    //-------------------------------------------------------------------
    // CSR4
    //-------------------------------------------------------------------  
    always @(posedge clk or negedge rst)
    begin : csr4_reg_proc
        if (rst == 1'b0)
        begin
            csr4 <= CSR4_RV ; 
        end
        else
        begin
            if (csrrw == 1'b0 & csrreq == 1'b1 & csraddr72 == CSR4_ID)
            begin
                // Host write ---------------------------
                if ((csrdbe_c[0]) == 1'b1)
                begin
                    csr4[7:0] <= csrdata_c[7:0] ; 
                end 
                if ((csrdbe_c[1]) == 1'b1)
                begin
                    csr4[15:8] <= csrdata_c[15:8] ; 
                end 
                if ((csrdbe_c[2]) == 1'b1)
                begin
                    csr4[23:16] <= csrdata_c[23:16] ; 
                end 
                if ((csrdbe_c[3]) == 1'b1)
                begin
                    csr4[31:24] <= csrdata_c[31:24] ; 
                end 
            end 
        end 
    end // csr4_reg_proc

    //-------------------------------------------------------------------
    // transmit descriptor base address changed
    // registered output
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : tdbadc_reg_proc
        if (rst == 1'b0)
        begin
            tdbadc <= 1'b1 ; 
        end
        else
        begin
            if (csrrw == 1'b0 & csrreq == 1'b1 & csraddr72 == CSR4_ID)
            begin
                tdbadc <= 1'b1 ; 
            end
            else if (tpsm == PSM_RUN)
            begin
                tdbadc <= 1'b0 ; 
            end 
        end 
    end // tdbadc_reg_proc
    //-------------------------------------------------------------------
    // csr5 host write combinatorial
    //-------------------------------------------------------------------
    assign csr5wr_c = (csrrw == 1'b0 & csrreq == 1'b1 & csraddr72 == CSR5_ID) ? 1'b1 : 1'b0 ;

    //-------------------------------------------------------------------
    // csr5 host write registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : csr5wr_reg_proc
        if (rst == 1'b0)
        begin
            csr5wr <= 1'b0 ; 
        end
        else
        begin
            csr5wr <= csr5wr_c ; 
        end 
    end // csr5wr_reg_proc

    //-------------------------------------------------------------------
    // csr5
    //-------------------------------------------------------------------  
    always @(posedge clk or negedge rst)
    begin : csr5_reg_proc
        if (rst == 1'b0)
        begin
            csr5_ts <= CSR5_RV[22:20] ; 
            csr5_rs <= CSR5_RV[19:17] ; 
            csr5_nis <= CSR5_RV[16] ; 
            csr5_ais <= CSR5_RV[15] ; 
            csr5_eri <= CSR5_RV[14] ; 
            csr5_gte <= CSR5_RV[11] ; 
            csr5_eti <= CSR5_RV[10] ; 
            csr5_rps <= CSR5_RV[8] ; 
            csr5_ru <= CSR5_RV[7] ; 
            csr5_ri <= CSR5_RV[6] ; 
            csr5_unf <= CSR5_RV[5] ; 
            csr5_tu <= CSR5_RV[2] ; 
            csr5_tps <= CSR5_RV[1] ; 
            csr5_ti <= CSR5_RV[0] ; 
        end
        else
        begin
            if (csr5wr_c == 1'b1)
            begin
                // Host write ---------------------------
                if ((csrdbe_c[2]) == 1'b1)
                begin
                    csr5_nis <= ~csrdata_c[16] & csr5_nis ; 
                end 
                if ((csrdbe_c[1]) == 1'b1)
                begin
                    csr5_ais <= ~csrdata_c[15] & csr5_ais ; 
                    csr5_eri <= ~csrdata_c[14] & csr5_eri ; 
                    csr5_gte <= ~csrdata_c[11] & csr5_gte ; 
                    csr5_eti <= ~csrdata_c[10] & csr5_eti ; 
                    csr5_rps <= ~csrdata_c[8] & csr5_rps ; 
                end 
                if ((csrdbe_c[0]) == 1'b1)
                begin
                    csr5_ru <= ~csrdata_c[7] & csr5_ru ; 
                    csr5_ri <= ~csrdata_c[6] & csr5_ri ; 
                    csr5_unf <= ~csrdata_c[5] & csr5_unf ; 
                    csr5_tu <= ~csrdata_c[2] & csr5_tu ; 
                    csr5_tps <= ~csrdata_c[1] & csr5_tps ; 
                    csr5_ti <= ~csrdata_c[0] & csr5_ti ; 
                end 
            end
            else
            begin
                // interrupt sources
                if (timex == 1'b1)
                begin
                    csr5_ti <= 1'b1 ; 
                end 
                if (rimex == 1'b1)
                begin
                    csr5_ri <= 1'b1 ; 
                end 
                if (eti == 1'b1)
                begin
                    csr5_eti <= 1'b1 ; 
                end 
                if (eri == 1'b1)
                begin
                    csr5_eri <= 1'b1 ; 
                end 
                if (gte == 1'b1)
                begin
                    csr5_gte <= 1'b1 ; 
                end 
                if (tpsm_c == PSM_STOP & (tpsm == PSM_RUN | tpsm == PSM_SUSPEND))
                begin
                    csr5_tps <= 1'b1 ; 
                end 
                if (rpsm_c == PSM_STOP & (rpsm == PSM_RUN | rpsm == PSM_SUSPEND))
                begin
                    csr5_rps <= 1'b1 ; 
                end 
                if (rui == 1'b1)
                begin
                    csr5_ru <= 1'b1 ; 
                end 
                if (tui == 1'b1)
                begin
                    csr5_tu <= 1'b1 ; 
                end 
                if (unfi == 1'b1)
                begin
                    csr5_unf <= 1'b1 ; 
                end 
                // normal interrupt summary
                if ((csr5_ri == 1'b1 & csr7_rie == 1'b1) | (csr5_ti == 1'b1 & csr7_tie == 1'b1) | (csr5_eri == 1'b1 & csr7_ere == 1'b1) | (csr5_tu == 1'b1 & csr7_tue == 1'b1) | (csr5_gte == 1'b1 & csr7_gte == 1'b1))
                begin
                    csr5_nis <= 1'b1 ; 
                end
                // MACs write ---------------------------
                else
                begin
                    csr5_nis <= 1'b0 ; 
                end 
                // abnormal interrupt summary
                if ((csr5_eti == 1'b1 & csr7_ete == 1'b1) | (csr5_rps == 1'b1 & csr7_rse == 1'b1) | (csr5_ru == 1'b1 & csr7_rue == 1'b1) | (csr5_unf == 1'b1 & csr7_une == 1'b1) | (csr5_tps == 1'b1 & csr7_tse == 1'b1))
                begin
                    csr5_ais <= 1'b1 ; 
                end
                else
                begin
                    csr5_ais <= 1'b0 ; 
                end 
                // process states
                csr5_ts <= ts_c ; 
                csr5_rs <= rs_c ; 
            end 
        end 
    end // csr5_reg_proc

    //-------------------------------------------------------------------
    // csr6
    //-------------------------------------------------------------------  
    always @(posedge clk or negedge rst)
    begin : csr6_reg_proc
        if (rst == 1'b0)
        begin
            csr6_ra <= CSR6_RV[30] ; 
            csr6_ttm <= CSR6_RV[22] ; 
            csr6_sf <= CSR6_RV[21] ; 
            csr6_tr <= CSR6_RV[15:14] ; 
            csr6_st <= CSR6_RV[13] ; 
            csr6_fd <= CSR6_RV[9] ; 
            csr6_pm <= CSR6_RV[7] ; 
            csr6_pr <= CSR6_RV[6] ; 
            csr6_if <= CSR6_RV[4] ; 
            csr6_pb <= CSR6_RV[3] ; 
            csr6_ho <= CSR6_RV[2] ; 
            csr6_sr <= CSR6_RV[1] ; 
            csr6_hp <= CSR6_RV[0] ; 
        end
        else
        begin
            if (csrrw == 1'b0 & csrreq == 1'b1 & csraddr72 == CSR6_ID)
            begin
                // Host write ---------------------------
                if ((csrdbe_c[3]) == 1'b1)
                begin
                    csr6_ra <= csrdata_c[30] ; 
                end 
                if ((csrdbe_c[2]) == 1'b1)
                begin
                    csr6_ttm <= csrdata_c[22] ; 
                    if (tpsm == PSM_STOP)
                    begin
                        csr6_sf <= csrdata_c[21] ; 
                    end 
                end 
                if ((csrdbe_c[1]) == 1'b1)
                begin
                    csr6_tr <= csrdata_c[15:14] ; 
                    csr6_st <= csrdata_c[13] ; 
                    csr6_fd <= csrdata_c[9] ; 
                end 
                if ((csrdbe_c[0]) == 1'b1)
                begin
                    csr6_pm <= csrdata_c[7] ; 
                    csr6_pr <= csrdata_c[6] ; 
                    csr6_pb <= csrdata_c[3] ; 
                    csr6_sr <= csrdata_c[1] ; 
                end 
            end 
            // mac write ----------------------------
            case (ft)
                FT_PERFECT :
                            begin
                                csr6_ho <= 1'b0 ; 
                                csr6_if <= 1'b0 ; 
                                csr6_hp <= 1'b0 ; 
                            end
                FT_HASH :
                            begin
                                csr6_ho <= 1'b0 ; 
                                csr6_if <= 1'b0 ; 
                                csr6_hp <= 1'b1 ; 
                            end
                FT_INVERSE :
                            begin
                                csr6_ho <= 1'b0 ; 
                                csr6_if <= 1'b1 ; 
                                csr6_hp <= 1'b0 ; 
                            end
                default :
                            begin
                                // FT_HONLY
                                csr6_ho <= 1'b1 ; 
                                csr6_if <= 1'b0 ; 
                                csr6_hp <= 1'b1 ; 
                            end
            endcase 
        end 
    end // csr6_reg_proc

    //-------------------------------------------------------------------
    // csr7
    //-------------------------------------------------------------------  
    always @(posedge clk or negedge rst)
    begin : csr7_reg_proc
        if (rst == 1'b0)
        begin
            csr7_nie <= CSR7_RV[16] ; 
            csr7_aie <= CSR7_RV[15] ; 
            csr7_ere <= CSR7_RV[14] ; 
            csr7_gte <= CSR7_RV[11] ; 
            csr7_ete <= CSR7_RV[10] ; 
            csr7_rse <= CSR7_RV[8] ; 
            csr7_rue <= CSR7_RV[7] ; 
            csr7_rie <= CSR7_RV[6] ; 
            csr7_une <= CSR7_RV[5] ; 
            csr7_tue <= CSR7_RV[2] ; 
            csr7_tse <= CSR7_RV[1] ; 
            csr7_tie <= CSR7_RV[0] ; 
        end
        else
        begin
            if (csrrw == 1'b0 & csrreq == 1'b1 & csraddr72 == CSR7_ID)
            begin
                // Host write ---------------------------
                if ((csrdbe_c[2]) == 1'b1)
                begin
                    csr7_nie <= csrdata_c[16] ; 
                end 
                if ((csrdbe_c[1]) == 1'b1)
                begin
                    csr7_aie <= csrdata_c[15] ; 
                    csr7_ere <= csrdata_c[14] ; 
                    csr7_gte <= csrdata_c[11] ; 
                    csr7_ete <= csrdata_c[10] ; 
                    csr7_rse <= csrdata_c[8] ; 
                end 
                if ((csrdbe_c[0]) == 1'b1)
                begin
                    csr7_rue <= csrdata_c[7] ; 
                    csr7_rie <= csrdata_c[6] ; 
                    csr7_une <= csrdata_c[5] ; 
                    csr7_tue <= csrdata_c[2] ; 
                    csr7_tse <= csrdata_c[1] ; 
                    csr7_tie <= csrdata_c[0] ; 
                end 
            end 
        end 
    end // csr7_reg_proc

    //-------------------------------------------------------------------
    // csr8 registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : csr8_reg_proc
        if (rst == 1'b0)
        begin
            csr8_oco <= 1'b0 ; 
            csr8_mfo <= 1'b0 ; 
            csr8_foc <= {11{1'b0}} ; 
            csr8_mfc <= {16{1'b0}} ; 
        end
        else
        begin
            // host read ----------------------------
            if (~(csrrw == 1'b1 & csrreq == 1'b1 & csraddr72 == CSR8_ID))
            begin
                // MAC write --------------------------
                // csr8 is updated only if
                // host read operation is not in progress
                if (csr8read == 1'b0)
                begin
                    csr8_foc <= foc_c ; 
                    csr8_mfc <= mfc_c ; 
                    csr8_oco <= oco ; 
                    csr8_mfo <= mfo ; 
                end 
            end 
        end 
    end // csr8_reg_proc

    //-------------------------------------------------------------------
    // csr8 read in progress registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : csr8read_reg_proc
        if (rst == 1'b0)
        begin
            csr8read <= 1'b0 ; 
        end
        else
        begin
            if (csrrw == 1'b1 & csrreq == 1'b1 & csraddr72 == CSR8_ID)
            begin
                csr8read <= csrdbe_c[3] ; 
            end
            else
            begin
                csr8read <= 1'b0 ; 
            end 
        end 
    end // csr8read_reg_proc

    //-------------------------------------------------------------------
    // csr9
    // registered outputs
    //-------------------------------------------------------------------  
    always @(posedge clk or negedge rst)
    begin : csr9_reg_proc
        if (rst == 1'b0)
        begin
            csr9_mdi <= CSR9_RV[19] ; 
            csr9_mii <= CSR9_RV[18] ; 
            csr9_mdo <= CSR9_RV[17] ; 
            csr9_mdc <= CSR9_RV[16] ; 
            csr9_sdi <= CSR9_RV[2] ; 
            csr9_sclk <= CSR9_RV[1] ; 
            csr9_scs <= CSR9_RV[0] ; 
            csr9_sdo <= CSR9_RV[3] ; 
        end
        else
        begin
            if (csrrw == 1'b0 & csrreq == 1'b1 & csraddr72 == CSR9_ID)
            begin
                // Host write ---------------------------
                if ((csrdbe_c[0]) == 1'b1)
                begin
                    csr9_sclk <= csrdata_c[1] ; 
                    csr9_scs <= csrdata_c[0] ; 
                    csr9_sdo <= csrdata_c[3] ; 
                end 
                if ((csrdbe_c[2]) == 1'b1)
                begin
                    csr9_mii <= csrdata_c[18] ; 
                    csr9_mdo <= csrdata_c[17] ; 
                    csr9_mdc <= csrdata_c[16] ; 
                end 
            end 
            // MACs write ---------------------------
            csr9_mdi <= mdi ; 
            csr9_sdi <= sdi ; 
        end 
    end // csr9_reg_proc

    //-------------------------------------------------------------------
    // csr11
    //-------------------------------------------------------------------  
    always @(posedge clk or negedge rst)
    begin : csr11_reg_proc
        if (rst == 1'b0)
        begin
            csr11_cs <= CSR11_RV[31] ; 
            csr11_tt <= CSR11_RV[30:27] ; 
            csr11_ntp <= CSR11_RV[26:24] ; 
            csr11_rt <= CSR11_RV[23:20] ; 
            csr11_nrp <= CSR11_RV[19:17] ; 
            csr11_con <= CSR11_RV[16] ; 
            csr11_tim <= CSR11_RV[15:0] ; 
        end
        else
        begin
            if (csrrw == 1'b0 & csrreq == 1'b1 & csraddr72 == CSR11_ID)
            begin
                // Host write ---------------------------
                if ((csrdbe_c[3]) == 1'b1)
                begin
                    csr11_cs <= csrdata_c[31] ; 
                    csr11_tt <= csrdata_c[30:27] ; 
                    csr11_ntp <= csrdata_c[26:24] ; 
                end 
                if ((csrdbe_c[2]) == 1'b1)
                begin
                    csr11_rt <= csrdata_c[23:20] ; 
                    csr11_nrp <= csrdata_c[19:17] ; 
                    csr11_con <= csrdata_c[16] ; 
                end 
                if ((csrdbe_c[1]) == 1'b1)
                begin
                    csr11_tim[15:8] <= csrdata_c[15:8] ; 
                end 
                if ((csrdbe_c[0]) == 1'b1)
                begin
                    csr11_tim[7:0] <= csrdata_c[7:0] ; 
                end 
            end 
        end 
    end // csr11_reg_proc

    //-------------------------------------------------------------------
    // csr11 write registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : csr11wr_reg_proc
        if (rst == 1'b0)
        begin
            csr11wr <= 1'b0 ; 
        end
        else
        begin
            if (csrrw == 1'b0 & csrreq == 1'b1 & csraddr72 == CSR11_ID)
            begin
                csr11wr <= 1'b1 ; 
            end
            else
            begin
                csr11wr <= 1'b0 ; 
            end 
        end 
    end // csr11wr_reg_proc
    //-------------------------------------------------------------------
    // csr0
    //-------------------------------------------------------------------
    // add not to fix async reset
    assign csr0 = {CSR0_RV[31:26], CSR0_RV[25:21], csr0_dbo, csr0_tap, CSR0_RV[16:14], csr0_pbl, csr0_ble, csr0_dsl, csr0_bar, ((~rst) | csr0_swr)} ;
    //-------------------------------------------------------------------
    // csr5
    //-------------------------------------------------------------------
    assign csr5 = {CSR5_RV[31:23], csr5_ts, csr5_rs, csr5_nis, csr5_ais, csr5_eri, CSR5_RV[13:12], csr5_gte, csr5_eti, CSR5_RV[9], csr5_rps, csr5_ru, csr5_ri, csr5_unf, CSR5_RV[4:3], csr5_tu, csr5_tps, csr5_ti} ;
    //-------------------------------------------------------------------
    // csr6
    //-------------------------------------------------------------------
    assign csr6 = {CSR6_RV[31], csr6_ra, CSR6_RV[29:26], CSR6_RV[25:23], csr6_ttm, csr6_sf, CSR6_RV[20], CSR6_RV[19], CSR6_RV[18], CSR6_RV[17], CSR6_RV[16], csr6_tr, csr6_st, CSR6_RV[13], CSR6_RV[12:11], csr6_fd, CSR6_RV[8], csr6_pm, csr6_pr, CSR6_RV[5], csr6_if, csr6_pb, csr6_ho, csr6_sr, csr6_hp} ;
    //-------------------------------------------------------------------
    // csr7
    //-------------------------------------------------------------------
    assign csr7 = {CSR7_RV[31:17], csr7_nie, csr7_aie, csr7_ere, CSR7_RV[13:12], csr7_gte, csr7_ete, CSR6_RV[9], csr7_rse, csr7_rue, csr7_rie, csr7_une, CSR7_RV[4:3], csr7_tue, csr7_tse, csr7_tie} ;
    //-------------------------------------------------------------------
    // csr8
    //-------------------------------------------------------------------
    assign csr8 = {CSR8_RV[31:29], csr8_oco, csr8_foc, csr8_mfo, csr8_mfc} ;
    //-------------------------------------------------------------------
    // csr9
    //-------------------------------------------------------------------
    assign csr9 = {CSR9_RV[31:20], csr9_mdi, csr9_mii, csr9_mdo, csr9_mdc, CSR9_RV[15:4], csr9_sdo, csr9_sdi, csr9_sclk, csr9_scs} ;
    //-------------------------------------------------------------------
    // csr11
    //-------------------------------------------------------------------
    assign csr11 = {csr11_cs, ttcnt[7:4], tcnt[2:0], rtcnt[3:0], rcnt[2:0], csr11_con, gcnt} ;

    //-------------------------------------------------------------------
    // output csr mux
    //-------------------------------------------------------------------
    always @(csr0 or csr3 or csr4 or csr5 or csr6 or csr7 or csr8 or csr9 or 
             csr11 or csraddr or csraddr72 or csraddr10)
    begin : csrmux_proc
        csrdatao <= {CSRWIDTH - 1-(0)+1{1'b0}} ; 
        case (CSRWIDTH)
            8 :
                        begin
                            //-----------------------------------------
                            case (csraddr10)
                                2'b00 :
                                            begin
                                                //-------------------------------------
                                                case (csraddr72)
                                                    //-------------------------------------
                                                    CSR0_ID :
                                                                begin
                                                                    csrdatao <= csr0[7:0] ; 
                                                                end
                                                    //-----------------------------------------
                                                    CSR3_ID :
                                                                begin
                                                                    csrdatao <= csr3[7:0] ; 
                                                                end
                                                    CSR4_ID :
                                                                begin
                                                                    csrdatao <= csr4[7:0] ; 
                                                                end
                                                    CSR5_ID :
                                                                begin
                                                                    csrdatao <= csr5[7:0] ; 
                                                                end
                                                    CSR6_ID :
                                                                begin
                                                                    csrdatao <= csr6[7:0] ; 
                                                                end
                                                    CSR7_ID :
                                                                begin
                                                                    csrdatao <= csr7[7:0] ; 
                                                                end
                                                    CSR8_ID :
                                                                begin
                                                                    csrdatao <= csr8[7:0] ; 
                                                                end
                                                    CSR9_ID :
                                                                begin
                                                                    csrdatao <= csr9[7:0] ; 
                                                                end
                                                    CSR11_ID :
                                                                begin
                                                                    csrdatao <= csr11[7:0] ; 
                                                                end
                                                    default :
                                                                begin
                                                                    csrdatao <= {CSRWIDTH - 1-(0)+1{1'b0}} ; 
                                                                end
                                                endcase 
                                            end
                                2'b01 :
                                            begin
                                                //-------------------------------------
                                                case (csraddr72)
                                                    //-------------------------------------
                                                    CSR0_ID :
                                                                begin
                                                                    csrdatao <= csr0[15:8] ; 
                                                                end
                                                    CSR3_ID :
                                                                begin
                                                                    csrdatao <= csr3[15:8] ; 
                                                                end
                                                    CSR4_ID :
                                                                begin
                                                                    csrdatao <= csr4[15:8] ; 
                                                                end
                                                    CSR5_ID :
                                                                begin
                                                                    csrdatao <= csr5[15:8] ; 
                                                                end
                                                    CSR6_ID :
                                                                begin
                                                                    csrdatao <= csr6[15:8] ; 
                                                                end
                                                    CSR7_ID :
                                                                begin
                                                                    csrdatao <= csr7[15:8] ; 
                                                                end
                                                    CSR8_ID :
                                                                begin
                                                                    csrdatao <= csr8[15:8] ; 
                                                                end
                                                    CSR9_ID :
                                                                begin
                                                                    csrdatao <= csr9[15:8] ; 
                                                                end
                                                    CSR11_ID :
                                                                begin
                                                                    csrdatao <= csr11[15:8] ; 
                                                                end
                                                    default :
                                                                begin
                                                                    csrdatao <= {CSRWIDTH - 1-(0)+1{1'b0}} ; 
                                                                end
                                                endcase 
                                            end
                                2'b10 :
                                            begin
                                                //-------------------------------------
                                                case (csraddr72)
                                                    //-------------------------------------
                                                    CSR0_ID :
                                                                begin
                                                                    csrdatao <= csr0[23:16] ; 
                                                                end
                                                    CSR3_ID :
                                                                begin
                                                                    csrdatao <= csr3[23:16] ; 
                                                                end
                                                    CSR4_ID :
                                                                begin
                                                                    csrdatao <= csr4[23:16] ; 
                                                                end
                                                    CSR5_ID :
                                                                begin
                                                                    csrdatao <= csr5[23:16] ; 
                                                                end
                                                    CSR6_ID :
                                                                begin
                                                                    csrdatao <= csr6[23:16] ; 
                                                                end
                                                    CSR7_ID :
                                                                begin
                                                                    csrdatao <= csr7[23:16] ; 
                                                                end
                                                    CSR8_ID :
                                                                begin
                                                                    csrdatao <= csr8[23:16] ; 
                                                                end
                                                    CSR9_ID :
                                                                begin
                                                                    csrdatao <= csr9[23:16] ; 
                                                                end
                                                    CSR11_ID :
                                                                begin
                                                                    csrdatao <= csr11[23:16] ; 
                                                                end
                                                    default :
                                                                begin
                                                                    csrdatao <= {CSRWIDTH - 1-(0)+1{1'b0}} ; 
                                                                end
                                                endcase 
                                            end
                                2'b11 :
                                            begin
                                                //-------------------------------------
                                                case (csraddr72)
                                                    //-------------------------------------
                                                    CSR0_ID :
                                                                begin
                                                                    csrdatao <= csr0[31:24] ; 
                                                                end
                                                    CSR3_ID :
                                                                begin
                                                                    csrdatao <= csr3[31:24] ; 
                                                                end
                                                    CSR4_ID :
                                                                begin
                                                                    csrdatao <= csr4[31:24] ; 
                                                                end
                                                    CSR5_ID :
                                                                begin
                                                                    csrdatao <= csr5[31:24] ; 
                                                                end
                                                    CSR6_ID :
                                                                begin
                                                                    csrdatao <= csr6[31:24] ; 
                                                                end
                                                    CSR7_ID :
                                                                begin
                                                                    csrdatao <= csr7[31:24] ; 
                                                                end
                                                    CSR8_ID :
                                                                begin
                                                                    csrdatao <= csr8[31:24] ; 
                                                                end
                                                    CSR9_ID :
                                                                begin
                                                                    csrdatao <= csr9[31:24] ; 
                                                                end
                                                    CSR11_ID :
                                                                begin
                                                                    csrdatao <= csr11[31:24] ; 
                                                                end
                                                    default :
                                                                begin
                                                                    csrdatao <= {CSRWIDTH - 1-(0)+1{1'b0}} ; 
                                                                end
                                                endcase 
                                            end
                                //-------------------------------------
                                default :
                                            begin
                                                //-------------------------------------
                                            end
                            endcase 
                        end
            16 :
                        begin
                            //-----------------------------------------
                            case (csraddr[1])
                                1'b0 :
                                            begin
                                                //-------------------------------------
                                                case (csraddr72)
                                                    //-------------------------------------
                                                    CSR0_ID :
                                                                begin
                                                                    csrdatao <= csr0[15:0] ; 
                                                                end
                                                    //-----------------------------------------
                                                    CSR3_ID :
                                                                begin
                                                                    csrdatao <= csr3[15:0] ; 
                                                                end
                                                    CSR4_ID :
                                                                begin
                                                                    csrdatao <= csr4[15:0] ; 
                                                                end
                                                    CSR5_ID :
                                                                begin
                                                                    csrdatao <= csr5[15:0] ; 
                                                                end
                                                    CSR6_ID :
                                                                begin
                                                                    csrdatao <= csr6[15:0] ; 
                                                                end
                                                    CSR7_ID :
                                                                begin
                                                                    csrdatao <= csr7[15:0] ; 
                                                                end
                                                    CSR8_ID :
                                                                begin
                                                                    csrdatao <= csr8[15:0] ; 
                                                                end
                                                    CSR9_ID :
                                                                begin
                                                                    csrdatao <= csr9[15:0] ; 
                                                                end
                                                    CSR11_ID :
                                                                begin
                                                                    csrdatao <= csr11[15:0] ; 
                                                                end
                                                    default :
                                                                begin
                                                                    csrdatao <= {CSRWIDTH - 1-(0)+1{1'b0}} ; 
                                                                end
                                                endcase 
                                            end
                                1'b1 :
                                            begin
                                                //-------------------------------------
                                                case (csraddr72)
                                                    //-------------------------------------
                                                    CSR0_ID :
                                                                begin
                                                                    csrdatao <= csr0[31:16] ; 
                                                                end
                                                    CSR3_ID :
                                                                begin
                                                                    csrdatao <= csr3[31:16] ; 
                                                                end
                                                    CSR4_ID :
                                                                begin
                                                                    csrdatao <= csr4[31:16] ; 
                                                                end
                                                    CSR5_ID :
                                                                begin
                                                                    csrdatao <= csr5[31:16] ; 
                                                                end
                                                    CSR6_ID :
                                                                begin
                                                                    csrdatao <= csr6[31:16] ; 
                                                                end
                                                    CSR7_ID :
                                                                begin
                                                                    csrdatao <= csr7[31:16] ; 
                                                                end
                                                    CSR8_ID :
                                                                begin
                                                                    csrdatao <= csr8[31:16] ; 
                                                                end
                                                    CSR9_ID :
                                                                begin
                                                                    csrdatao <= csr9[31:16] ; 
                                                                end
                                                    CSR11_ID :
                                                                begin
                                                                    csrdatao <= csr11[31:16] ; 
                                                                end
                                                    default :
                                                                begin
                                                                    csrdatao <= {CSRWIDTH - 1-(0)+1{1'b0}} ; 
                                                                end
                                                endcase 
                                            end
                                //-------------------------------------
                                default :
                                            begin
                                                //-------------------------------------
                                                csrdatao <= {CSRWIDTH - 1-(0)+1{1'b0}} ; 
                                            end
                            endcase 
                        end
            default :
                        begin
                            // 32
                            //-----------------------------------------
                            case (csraddr72)
                                //-----------------------------------------
                                CSR0_ID :
                                            begin
                                                csrdatao <= csr0 ; 
                                            end
                                CSR3_ID :
                                            begin
                                                csrdatao <= csr3 ; 
                                            end
                                CSR4_ID :
                                            begin
                                                csrdatao <= csr4 ; 
                                            end
                                CSR5_ID :
                                            begin
                                                csrdatao <= csr5 ; 
                                            end
                                CSR6_ID :
                                            begin
                                                csrdatao <= csr6 ; 
                                            end
                                CSR7_ID :
                                            begin
                                                csrdatao <= csr7 ; 
                                            end
                                CSR8_ID :
                                            begin
                                                csrdatao <= csr8 ; 
                                            end
                                CSR9_ID :
                                            begin
                                                csrdatao <= csr9 ; 
                                            end
                                CSR11_ID :
                                            begin
                                                csrdatao <= csr11 ; 
                                            end
                                default :
                                            begin
                                                csrdatao <= {CSRWIDTH - 1-(0)+1{1'b0}} ; 
                                            end
                            endcase 
                        end
        endcase 
    end // csrmux_proc
    //-------------------------------------------------------------------
    // csr acknowledge
    // stuck at '1'
    //-------------------------------------------------------------------
    assign csrack = 1'b1 ;
    //===================================================================--
    //                                 dma                               --
    //===================================================================--
    //-------------------------------------------------------------------
    // dma channel priority
    // combinatorial output
    //-------------------------------------------------------------------
    assign priority = (csr0_bar == 1'b1 & tprog == 1'b0) ? 2'b01 : (csr0_bar == 1'b1 & tprog == 1'b1) ? 2'b10 : 2'b00 ;
    //-------------------------------------------------------------------
    // descriptor byte ordering
    // registered output
    //-------------------------------------------------------------------
    assign dbo = csr0_dbo ;
    //-------------------------------------------------------------------
    // programmable burst length
    // registered output
    //-------------------------------------------------------------------
    assign pbl = csr0_pbl ;
    //-------------------------------------------------------------------
    // descriptor skip length
    // registered output
    //-------------------------------------------------------------------
    assign dsl = csr0_dsl ;
    //-------------------------------------------------------------------
    // big/little endian for data buffers
    // registered output
    //-------------------------------------------------------------------
    assign ble = csr0_ble ;
    //===================================================================--
    //                                tlsm                               --
    //===================================================================--
    //-------------------------------------------------------------------
    // transmit descriptor base address
    //-------------------------------------------------------------------
    assign tdbad = csr4[DATADEPTH - 1:0] ;

    //-------------------------------------------------------------------
    // internal transmit poll command registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : itpoll_reg_proc
        if (rst == 1'b0)
        begin
            itpoll <= 1'b0 ; 
        end
        else
        begin
            if (((((csr0_tap == 3'b001 | csr0_tap == 3'b010 | csr0_tap == 3'b011) & tcs2048 == 1'b1) | ((csr0_tap == 3'b100 | csr0_tap == 3'b101 | csr0_tap == 3'b110 | csr0_tap == 3'b111) & tcs128 == 1'b1)) & tapcnt == 3'b000 & tpsm == PSM_SUSPEND) | tpollcmd == 1'b1 | tstartcmd == 1'b1)
            begin
                itpoll <= 1'b1 ; 
            end
            else if (tpollack == 1'b1)
            begin
                itpoll <= 1'b0 ; 
            end 
        end 
    end // itpoll_reg_proc
    //-------------------------------------------------------------------
    // transmit poll command
    // registered output
    //-------------------------------------------------------------------
    assign tpoll = itpoll ;

    //-------------------------------------------------------------------
    // tap counter
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : tap_reg_proc
        if (rst == 1'b0)
        begin
            tapcnt <= {3{1'b1}} ; 
        end
        else
        begin
            if (((csr0_tap == 3'b001 | csr0_tap == 3'b010 | csr0_tap == 3'b011) & (tcs2048 == 1'b1 | tapwr == 1'b1)) | ((csr0_tap == 3'b100 | csr0_tap == 3'b101 | csr0_tap == 3'b110 | csr0_tap == 3'b111) & (tcs128 == 1'b1 | tapwr == 1'b1)))
            begin
                if (tapcnt == 3'b000 | tapwr == 1'b1)
                begin
                    case (csr0_tap)
                        3'b001 :
                                    begin
                                        tapcnt <= 3'b000 ; 
                                    end
                        3'b010 :
                                    begin
                                        tapcnt <= 3'b010 ; 
                                    end
                        3'b011 :
                                    begin
                                        tapcnt <= 3'b110 ; 
                                    end
                        3'b100 :
                                    begin
                                        tapcnt <= 3'b000 ; 
                                    end
                        3'b101 :
                                    begin
                                        tapcnt <= 3'b001 ; 
                                    end
                        3'b110 :
                                    begin
                                        tapcnt <= 3'b010 ; 
                                    end
                        default :
                                    begin
                                        tapcnt <= 3'b111 ; 
                                    end
                    endcase 
                end
                else
                begin
                    tapcnt <= tapcnt - 1 ; 
                end 
            end 
        end 
    end // tap_reg_proc
    //===================================================================--
    //                               tfifo                               --
    //===================================================================--
    //-------------------------------------------------------------------
    // treshold mode
    // registered output
    //-------------------------------------------------------------------
    assign tm = {csr6_ttm, csr6_tr} ;
    //-------------------------------------------------------------------
    // store and forward mode
    // registered output
    //-------------------------------------------------------------------
    assign sf = csr6_sf ;

    //===================================================================--
    //             transmit interrupt mitigation control                 --
    //===================================================================--
    //-------------------------------------------------------------------
    // transmit interrupt mitigation
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : tim_reg_proc
        if (rst == 1'b0)
        begin
            timprog <= 1'b0 ; 
            timex <= 1'b0 ; 
            ttcnt <= {8{1'b1}} ; 
            tcnt <= {3{1'b1}} ; 
        end
        else
        begin
            // transmit interrupt mitigation in progress
            if (csr5_ti == 1'b1)
            begin
                timprog <= 1'b0 ; 
            end
            else if (tireq_r == 1'b1 & tireq_r2 == 1'b0)
            begin
                timprog <= 1'b1 ; 
            end 
            // transmit interrupt mitigation expired
            if (csr5_ti == 1'b1)
            begin
                timex <= 1'b0 ; 
            end
            else if (timprog == 1'b1 & ((ttcnt == 8'b00000000 & csr11_tt != 4'b0000) | (tcnt == 3'b000 & csr11_ntp != 3'b000) | (iic == 1'b1) | (csr11_tt == 4'b0000 & csr11_ntp == 3'b000)))
            begin
                timex <= 1'b1 ; 
            end 
            // transmit timer
            if ((tireq_r == 1'b1 & tireq_r2 == 1'b0) | csr5_ti == 1'b1 | csr11wr == 1'b1)
            begin
                ttcnt <= {csr11_tt, 4'b0000} ; 
            end
            else if (((tcs128 == 1'b1 & csr11_cs == 1'b1) | (tcs2048 == 1'b1 & csr11_cs == 1'b0)) & ttcnt != 8'b00000000 & timprog == 1'b1)
            begin
                ttcnt <= ttcnt - 1 ; 
            end 
            // transmit counter
            if (csr5_ti == 1'b1 | csr11wr == 1'b1)
            begin
                tcnt <= csr11_ntp ; 
            end
            else if (tireq_r == 1'b1 & tireq_r2 == 1'b0 & tcnt != 3'b000 & csr11_ntp != 3'b000)
            begin
                tcnt <= tcnt - 1 ; 
            end 
        end 
    end // tim_reg_proc

    //-------------------------------------------------------------------
    // transmit cycle size counter registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : tcscnt_reg_proc
        if (rst == 1'b0)
        begin
            tcsreq_r1 <= 1'b0 ; 
            tcsreq_r2 <= 1'b0 ; 
            tcs128 <= 1'b0 ; 
            tcs2048 <= 1'b0 ; 
            tcscnt <= {4{1'b1}} ; 
        end
        else
        begin
            tcsreq_r1 <= tcsreq ; 
            tcsreq_r2 <= tcsreq_r1 ; 
            if (tcs128 == 1'b1)
            begin
                // transmit cycle size counter
                if (tcscnt == 4'b0000)
                begin
                    tcscnt <= 4'b1111 ; 
                end
                else
                begin
                    tcscnt <= tcscnt - 1 ; 
                end 
            end 
            // transmit cycle size=clkt/128
            if (tcsreq_r1 == 1'b1 & tcsreq_r2 == 1'b0)
            begin
                tcs128 <= 1'b1 ; 
            end
            else
            begin
                tcs128 <= 1'b0 ; 
            end 
            // transmit cycle size=clkt/2048
            if (tcscnt == 4'b0000 & tcs128 == 1'b1)
            begin
                tcs2048 <= 1'b1 ; 
            end
            else
            begin
                tcs2048 <= 1'b0 ; 
            end 
        end 
    end // tcscnt_reg_proc
    //-------------------------------------------------------------------
    // transmit cycle size acknowledge
    // registered output from rcsreq_r
    //-------------------------------------------------------------------
    assign tcsack = tcsreq_r2 ;

    //===================================================================--
    //                                 tpsm                              --
    //===================================================================--
    //-------------------------------------------------------------------
    // start/stop transmit command registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : st_reg_proc
        if (rst == 1'b0)
        begin
            tstopcmd <= 1'b1 ; 
            tstartcmd <= 1'b0 ; 
        end
        else
        begin
            // stop transmit command
            if (tstartcmd == 1'b1)
            begin
                tstopcmd <= 1'b0 ; 
            end
            else if (csrrw == 1'b0 & csrreq == 1'b1 & (csrdata_c[13]) == 1'b0 & csraddr72 == CSR6_ID & (csrdbe_c[1]) == 1'b1)
            begin
                tstopcmd <= 1'b1 ; 
            end 
            // start transmit command
            if (tpsm == PSM_RUN | tpsm == PSM_SUSPEND)
            begin
                tstartcmd <= 1'b0 ; 
            end
            else if (csrrw == 1'b0 & csrreq == 1'b1 & (csrdata_c[13]) == 1'b1 & csraddr72 == CSR6_ID & (csrdbe_c[1]) == 1'b1)
            begin
                tstartcmd <= 1'b1 ; 
            end 
        end 
    end // st_reg_proc
    //-------------------------------------------------------------------
    // Transmit state combinatorial
    //-------------------------------------------------------------------
    assign ts_c = (tpsm == PSM_STOP) ? 3'b000 : (tpsm == PSM_SUSPEND) ? 3'b110 : (tstat == 1'b1) ? 3'b111 : (tdes == 1'b1) ? 3'b001 : (tset == 1'b1) ? 3'b101 : (tbuf == 1'b1) ? 3'b011 : (tprog == 1'b1) ? 3'b010 : csr5_ts ;

    //-------------------------------------------------------------------
    // transmit process stopped registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : tpsack_reg_proc
        if (rst == 1'b0)
        begin
            stoptc_r <= 1'b0 ; 
            stoptlsm_r <= 1'b0 ; 
            stoptfifo_r <= 1'b0 ; 
        end
        else
        begin
            stoptc_r <= stoptc ; 
            stoptlsm_r <= stoptlsm ; 
            stoptfifo_r <= stoptfifo ; 
        end 
    end // tpsack_reg_proc

    //-------------------------------------------------------------------
    // transmit process state machine combinatorial
    //-------------------------------------------------------------------
    always @(tpsm or tstartcmd or tstopcmd or tu_r or stoptc_r or stoptlsm_r or 
             stoptfifo_r)
    begin : tpsm_proc
        case (tpsm)
            //-----------------------------------------
            PSM_STOP :
                        begin
                            //-----------------------------------------
                            if (tstartcmd == 1'b1 & stoptc_r == 1'b0 & stoptlsm_r == 1'b0 & stoptfifo_r == 1'b0)
                            begin
                                tpsm_c <= PSM_RUN ; 
                            end
                            else
                            begin
                                tpsm_c <= PSM_STOP ; 
                            end 
                        end
            //-----------------------------------------
            PSM_SUSPEND :
                        begin
                            //-----------------------------------------
                            if (tstopcmd == 1'b1 & stoptc_r == 1'b1 & stoptlsm_r == 1'b1 & stoptfifo_r == 1'b1)
                            begin
                                tpsm_c <= PSM_STOP ; 
                            end
                            else if (tu_r == 1'b0)
                            begin
                                tpsm_c <= PSM_RUN ; 
                            end
                            else
                            begin
                                tpsm_c <= PSM_SUSPEND ; 
                            end 
                        end
            //-----------------------------------------
            default :
                        begin
                            // PSM_RUN
                            //-----------------------------------------
                            if (tstopcmd == 1'b1 & stoptc_r == 1'b1 & stoptlsm_r == 1'b1 & stoptfifo_r == 1'b1)
                            begin
                                tpsm_c <= PSM_STOP ; 
                            end
                            else if (tu_r == 1'b1)
                            begin
                                tpsm_c <= PSM_SUSPEND ; 
                            end
                            else
                            begin
                                tpsm_c <= PSM_RUN ; 
                            end 
                        end
        endcase 
    end // tpsm_proc  

    //-------------------------------------------------------------------
    // transmit process state machine registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : tpsm_reg_proc
        if (rst == 1'b0)
        begin
            tpsm <= PSM_STOP ; 
        end
        else
        begin
            tpsm <= tpsm_c ; 
        end 
    end // tpsm_reg_proc

    //-------------------------------------------------------------------
    // transmit process stopped
    // registered output
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : tps_reg_proc
        if (rst == 1'b0)
        begin
            tps <= 1'b0 ; 
        end
        else
        begin
            if (tstartcmd == 1'b1)
            begin
                tps <= 1'b0 ; 
            end
            else if (tpsm == PSM_STOP)
            begin
                tps <= 1'b1 ; 
            end 
        end 
    end // tps_reg_proc
    //-------------------------------------------------------------------
    // stop transmit process request
    // registered output
    //-------------------------------------------------------------------
    assign stopt = tstopcmd ;
    //===================================================================--
    //                                 rc                                --
    //===================================================================--
    //-------------------------------------------------------------------
    // receive enable
    // registered output
    //-------------------------------------------------------------------
    assign ren = csr6_sr ;
    //-------------------------------------------------------------------
    // full duplex mode
    // registered output
    //-------------------------------------------------------------------
    assign fd = csr6_fd ;
    //-------------------------------------------------------------------
    // receive all
    // registered output
    //-------------------------------------------------------------------
    assign ra = csr6_ra ;
    //-------------------------------------------------------------------
    // pass all multicast
    // registered output
    //-------------------------------------------------------------------
    assign pm = csr6_pm ;
    //-------------------------------------------------------------------
    // promiscous mode
    // registered output
    //-------------------------------------------------------------------
    assign pr = csr6_pr ;
    //-------------------------------------------------------------------
    // inverse filtering
    // registered output
    //-------------------------------------------------------------------
    assign rif = csr6_if ;
    //-------------------------------------------------------------------
    // pass bad frame
    // registered output
    //-------------------------------------------------------------------
    assign pb = csr6_pb ;
    //-------------------------------------------------------------------
    // hash only filtering mode
    // registered output
    //-------------------------------------------------------------------
    assign ho = csr6_ho ;
    //-------------------------------------------------------------------
    // hash/perfect filtering mode
    // registered output
    //-------------------------------------------------------------------
    assign hp = csr6_hp ;

    //===================================================================--
    //                                rlsm                               --
    //===================================================================--
    //-------------------------------------------------------------------
    // receive poll
    // registered output
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : rpoll_reg_proc
        if (rst == 1'b0)
        begin
            rpoll <= 1'b0 ; 
        end
        else
        begin
            if (rpollcmd == 1'b1 | rstartcmd == 1'b1)
            begin
                rpoll <= 1'b1 ; 
            end
            else if (rpollack == 1'b1)
            begin
                rpoll <= 1'b0 ; 
            end 
        end 
    end // rpoll_reg_proc
    //-------------------------------------------------------------------
    // Receive state combinatorial
    //-------------------------------------------------------------------
    assign rs_c = (rpsm == PSM_STOP) ? 3'b000 : (rpsm == PSM_SUSPEND) ? 3'b100 : (rstat == 1'b1) ? 3'b101 : (rdes == 1'b1) ? 3'b001 : (rbuf == 1'b1) ? 3'b111 : (rprog == 1'b1) ? 3'b010 : 3'b011 ;

    //===================================================================--
    //                                 rpsm                              --
    //===================================================================--
    //-------------------------------------------------------------------
    // receive process stopped registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : rpsack_reg_proc
        if (rst == 1'b0)
        begin
            stoprc_r <= 1'b0 ; 
            stoprlsm_r <= 1'b0 ; 
            stoprfifo_r <= 1'b0 ; 
        end
        else
        begin
            stoprc_r <= stoprc ; 
            stoprlsm_r <= stoprlsm ; 
            stoprfifo_r <= stoprfifo ; 
        end 
    end // rpsack_reg_proc

    //-------------------------------------------------------------------
    // receive process state machine combinatorial
    //-------------------------------------------------------------------
    always @(rpsm or rstartcmd or rstopcmd or rui or ru_r or stoprc_r or stoprlsm_r or 
             stoprfifo_r)
    begin : rpsm_proc
        case (rpsm)
            //-----------------------------------------
            PSM_STOP :
                        begin
                            //-----------------------------------------
                            if (rstartcmd == 1'b1 & stoprc_r == 1'b0 & stoprlsm_r == 1'b0 & stoprfifo_r == 1'b0)
                            begin
                                rpsm_c <= PSM_RUN ; 
                            end
                            else
                            begin
                                rpsm_c <= PSM_STOP ; 
                            end 
                        end
            //-----------------------------------------
            PSM_SUSPEND :
                        begin
                            //-----------------------------------------
                            if (rstopcmd == 1'b1 & stoprc_r == 1'b1 & stoprlsm_r == 1'b1 & stoprfifo_r == 1'b1)
                            begin
                                rpsm_c <= PSM_STOP ; 
                            end
                            else if (ru_r == 1'b0)
                            begin
                                rpsm_c <= PSM_RUN ; 
                            end
                            else
                            begin
                                rpsm_c <= PSM_SUSPEND ; 
                            end 
                        end
            //-----------------------------------------
            default :
                        begin
                            // PSM_RUN
                            //-----------------------------------------
                            if (rstopcmd == 1'b1 & stoprc_r == 1'b1 & stoprlsm_r == 1'b1 & stoprfifo_r == 1'b1)
                            begin
                                rpsm_c <= PSM_STOP ; 
                            end
                            else if (rui == 1'b1)
                            begin
                                rpsm_c <= PSM_SUSPEND ; 
                            end
                            else
                            begin
                                rpsm_c <= PSM_RUN ; 
                            end 
                        end
        endcase 
    end // rpsm_proc  

    //-------------------------------------------------------------------
    // receive process state machine registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : rpsm_reg_proc
        if (rst == 1'b0)
        begin
            rpsm <= PSM_STOP ; 
        end
        else
        begin
            rpsm <= rpsm_c ; 
        end 
    end // rpsm_reg_proc

    //-------------------------------------------------------------------
    // receive process stopped
    // registered output
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : rps_reg_proc
        if (rst == 1'b0)
        begin
            rps <= 1'b0 ; 
        end
        else
        begin
            if (rstartcmd == 1'b1)
            begin
                rps <= 1'b0 ; 
            end
            else if (rpsm == PSM_STOP)
            begin
                rps <= 1'b1 ; 
            end 
        end 
    end // rps_reg_proc

    //-------------------------------------------------------------------
    // start/stop receive command registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : rstartcmd_reg_proc
        if (rst == 1'b0)
        begin
            rstartcmd <= 1'b0 ; 
            rstopcmd <= 1'b0 ; 
        end
        else
        begin
            // start receive command
            if (rpsm == PSM_RUN)
            begin
                rstartcmd <= 1'b0 ; 
            end
            else if (csrrw == 1'b0 & csrreq == 1'b1 & (csrdata_c[1]) == 1'b1 & csraddr72 == CSR6_ID & (csrdbe_c[0]) == 1'b1)
            begin
                rstartcmd <= 1'b1 ; 
            end 
            // stop receive command
            if (rpsm == PSM_STOP)
            begin
                rstopcmd <= 1'b0 ; 
            end
            else if (csrrw == 1'b0 & csrreq == 1'b1 & (csrdata_c[1]) == 1'b0 & csraddr72 == CSR6_ID & (csrdbe_c[0]) == 1'b1)
            begin
                rstopcmd <= 1'b1 ; 
            end 
        end 
    end // rstartcmd_reg_proc
    //-------------------------------------------------------------------
    // stop transmit process request
    // registered output
    //-------------------------------------------------------------------
    assign stopr = rstopcmd ;

    //===================================================================--
    //               receive interrupt mitigation control                --
    //===================================================================--
    //-------------------------------------------------------------------
    // receive interrupt mitigation registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : rim_reg_proc
        if (rst == 1'b0)
        begin
            rimex <= 1'b0 ; 
            rimprog <= 1'b0 ; 
            rtcnt <= {4{1'b1}} ; 
            rcnt <= {3{1'b1}} ; 
        end
        else
        begin
            // receive interrupt mitigation expired
            if (csr5_ri == 1'b1)
            begin
                rimex <= 1'b0 ; 
            end
            else if (rimprog == 1'b1 & ((rtcnt == 4'b0000 & csr11_rt != 4'b0000) | (rcnt == 3'b000 & csr11_nrp != 3'b000) | (csr11_rt == 4'b0000 & csr11_nrp == 3'b000)))
            begin
                rimex <= 1'b1 ; 
            end 
            // receive interrupt mitigation in progress
            if (csr5_ri == 1'b1)
            begin
                rimprog <= 1'b0 ; 
            end
            else if (rireq_r == 1'b1 & rireq_r2 == 1'b0)
            begin
                rimprog <= 1'b1 ; 
            end 
            // receive timer
            if ((rireq_r == 1'b1 & rireq_r2 == 1'b0) | csr5_ri == 1'b1)
            begin
                rtcnt <= csr11_rt ; 
            end
            else if (((rcs128 == 1'b1 & csr11_cs == 1'b1) | (rcs2048 == 1'b1 & csr11_cs == 1'b0)) & rtcnt != 4'b0000 & rimprog == 1'b1)
            begin
                rtcnt <= rtcnt - 1 ; 
            end 
            // receive counter
            if (csr5_ri == 1'b1 | csr11wr == 1'b1)
            begin
                rcnt <= csr11_nrp ; 
            end
            else if (rireq_r == 1'b1 & rireq_r2 == 1'b0 & rcnt != 3'b000 & csr11_nrp != 3'b000)
            begin
                rcnt <= rcnt - 1 ; 
            end 
        end 
    end // rim_reg_proc

    //-------------------------------------------------------------------
    // receive cycle size counter registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : rcscnt_reg_proc
        if (rst == 1'b0)
        begin
            rcsreq_r <= 1'b0 ; 
            rcsreq_r1 <= 1'b0 ; 
            rcs128 <= 1'b0 ; 
            rcs2048 <= 1'b0 ; 
            rcscnt <= {4{1'b1}} ; 
        end
        else
        begin
            rcsreq_r <= rcsreq ; 
            rcsreq_r1 <= rcsreq_r ; 
            if (rcs128 == 1'b1)
            begin
                // receive cycle size counter
                if (rcscnt == 4'b0000)
                begin
                    rcscnt <= 4'b1111 ; 
                end
                else
                begin
                    rcscnt <= rcscnt - 1 ; 
                end 
            end 
            // receive cycle size=clkr/128
            if (rcsreq_r == 1'b1 & rcsreq_r1 == 1'b0)
            begin
                rcs128 <= 1'b1 ; 
            end
            else
            begin
                rcs128 <= 1'b0 ; 
            end 
            // receive cycle size=clkr/2048
            if (rcscnt == 4'b0000 & rcs128 == 1'b1)
            begin
                rcs2048 <= 1'b1 ; 
            end
            else
            begin
                rcs2048 <= 1'b0 ; 
            end 
        end 
    end // rcscnt_reg_proc
    //-------------------------------------------------------------------
    // receive cycle size acknowledge
    // registered output from rcsreq_r
    //-------------------------------------------------------------------
    assign rcsack = rcsreq_r ;

    //===================================================================--
    //                        interrupt controller                       --
    //===================================================================--
    //-------------------------------------------------------------------
    // transmit interrupt requests registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : ireq_reg_proc
        if (rst == 1'b0)
        begin
            rireq_r <= 1'b0 ; 
            rireq_r2 <= 1'b0 ; 
            erireq_r <= 1'b0 ; 
            erireq_r2 <= 1'b0 ; 
            tireq_r <= 1'b0 ; 
            tireq_r2 <= 1'b0 ; 
            etireq_r <= 1'b0 ; 
            etireq_r2 <= 1'b0 ; 
            unf_r <= 1'b0 ; 
            unf_r2 <= 1'b0 ; 
            tu_r <= 1'b0 ; 
            tu_r2 <= 1'b0 ; 
            ru_r <= 1'b0 ; 
            ru_r2 <= 1'b0 ; 
        end
        else
        begin
            rireq_r <= rireq ; 
            rireq_r2 <= rireq_r ; 
            erireq_r <= erireq ; 
            erireq_r2 <= erireq_r ; 
            tireq_r <= tireq ; 
            tireq_r2 <= tireq_r ; 
            etireq_r <= etireq ; 
            etireq_r2 <= etireq_r ; 
            unf_r <= unf ; 
            unf_r2 <= unf_r ; 
            tu_r <= tu ; 
            tu_r2 <= tu_r ; 
            ru_r <= ru ; 
            ru_r2 <= ru_r ; 
        end 
    end // ireq_reg_proc

    //-------------------------------------------------------------------
    // interrupt on completition registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : iic_reg_proc
        if (rst == 1'b0)
        begin
            iic <= 1'b0 ; 
        end
        else
        begin
            if (tireq_r == 1'b1 & tireq_r2 == 1'b0)
            begin
                if (ic == 1'b0 & iint == 1'b0)
                begin
                    iic <= 1'b0 ; 
                end
                else
                begin
                    iic <= 1'b1 ; 
                end 
            end 
        end 
    end // ici_reg_proc

    //-------------------------------------------------------------------
    // early transmit interrupt registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : eti_reg_proc
        if (rst == 1'b0)
        begin
            eti <= 1'b0 ; 
        end
        else
        begin
            if (etireq_r == 1'b1 & etireq_r2 == 1'b0)
            begin
                eti <= 1'b1 ; 
            end
            else if (csr5wr_c == 1'b0)
            begin
                eti <= 1'b0 ; 
            end 
        end 
    end // eti_reg_proc
    //-------------------------------------------------------------------
    // early transmit interrupt acknowledge
    // registered output
    //-------------------------------------------------------------------
    assign etiack = etireq_r2 ;

    //-------------------------------------------------------------------
    // early receive interrupt registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : eri_reg_proc
        if (rst == 1'b0)
        begin
            eri <= 1'b0 ; 
        end
        else
        begin
            if (erireq_r == 1'b1 & erireq_r2 == 1'b0)
            begin
                eri <= 1'b1 ; 
            end
            else if (csr5wr_c == 1'b0)
            begin
                eri <= 1'b0 ; 
            end 
        end 
    end // eri_reg_proc

    //-------------------------------------------------------------------
    // transmit underflow registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : unfi_reg_proc
        if (rst == 1'b0)
        begin
            unfi <= 1'b0 ; 
        end
        else
        begin
            if (unf_r == 1'b1 & unf_r2 == 1'b0)
            begin
                unfi <= 1'b1 ; 
            end
            else if (csr5wr_c == 1'b0)
            begin
                unfi <= 1'b0 ; 
            end 
        end 
    end // unfi_reg_proc

    //-------------------------------------------------------------------
    // transmit buffer unavailable
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : tui_reg_proc
        if (rst == 1'b0)
        begin
            tui <= 1'b0 ; 
        end
        else
        begin
            if (tu_r == 1'b1 & tu_r2 == 1'b0)
            begin
                tui <= 1'b1 ; 
            end
            else if (csr5wr_c == 1'b0)
            begin
                tui <= 1'b0 ; 
            end 
        end 
    end // tui_reg_proc

    //-------------------------------------------------------------------
    // receive buffer unavailable
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : rui_reg_proc
        if (rst == 1'b0)
        begin
            rui <= 1'b0 ; 
        end
        else
        begin
            if (ru_r == 1'b1 & ru_r2 == 1'b0)
            begin
                rui <= 1'b1 ; 
            end
            else if (csr5wr_c == 1'b0)
            begin
                rui <= 1'b0 ; 
            end 
        end 
    end // rui_reg_proc

    //-------------------------------------------------------------------
    // interrupt registered
    //-------------------------------------------------------------------  
    always @(posedge clk or negedge rst)
    begin : iint_reg_proc
        if (rst == 1'b0)
        begin
            iint <= 1'b0 ; 
        end
        else
        begin
            iint <= ((csr5_nis & csr7_nie) | (csr5_ais & csr7_aie)) ;
             // SAR 73578  & ~csr5wr ; 

        end 
    end // iint_reg_proc
    //-------------------------------------------------------------------
    // interrupt
    // registered output from iint
    //-------------------------------------------------------------------
    assign int = iint ;
    //-------------------------------------------------------------------
    // receive interrupt acknowledge
    // registered output
    //-------------------------------------------------------------------
    assign riack = rireq_r2 ;
    //-------------------------------------------------------------------
    // early receive interrupt acknowledge
    // registered output
    //-------------------------------------------------------------------
    assign eriack = erireq_r2 ;
    //-------------------------------------------------------------------
    // transmit interrupt acknowledge
    // registered output
    //-------------------------------------------------------------------
    assign tiack = tireq_r2 ;

    //===================================================================--
    //                      statistical counters                         --
    //===================================================================--
    //-------------------------------------------------------------------
    // fifo overflow counter binary combinatorial
    //-------------------------------------------------------------------
    always @(focg_r)
    begin : foc_proc
        reg[10:0] foc_v; 
        foc_v[10] = focg_r[10]; 
        begin : xhdl_125
            integer i;
            for(i = 9; i >= 0; i = i - 1)
            begin
                foc_v[i] = foc_v[i + 1] ^ focg_r[i]; 
            end
        end 
        foc_c <= foc_v ; 
    end // foc_proc

    //-------------------------------------------------------------------
    // missed frames counter binary combinatorial
    //-------------------------------------------------------------------
    always @(mfcg_r)
    begin : mfc_proc
        reg[15:0] mfc_v; 
        mfc_v[15] = mfcg_r[10]; 
        begin : xhdl_127
            integer i;
            for(i = 14; i >= 0; i = i - 1)
            begin
                mfc_v[i] = mfc_v[i + 1] ^ mfcg_r[i]; 
            end
        end 
        mfc_c <= mfc_v ; 
    end // mfc_proc

    //-------------------------------------------------------------------
    // statistical counters registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : sc_reg_proc
        if (rst == 1'b0)
        begin
            focl <= 1'b0 ; 
            mfcl <= 1'b0 ; 
            focg_r <= {11{1'b0}} ; 
            mfcg_r <= {16{1'b0}} ; 
        end
        else
        begin
            // clear fifo overflow counter
            if (csr8read == 1'b1)
            begin
                focl <= 1'b1 ; 
            end
            else if (foclack == 1'b1)
            begin
                focl <= 1'b0 ; 
            end 
            // clear missed frames counter
            if (csr8read == 1'b1)
            begin
                mfcl <= 1'b1 ; 
            end
            else if (mfclack == 1'b1)
            begin
                mfcl <= 1'b0 ; 
            end 
            // fifo overflow counter grey coded
            mfcg_r <= mfcg ; 
            // missed frame counter
            focg_r <= focg ; 
        end 
    end // sc_reg_proc
    //===================================================================--
    //                          mii management                           --
    //===================================================================--
    //-------------------------------------------------------------------
    // mdo
    // registered output
    //-------------------------------------------------------------------
    assign mdo = csr9_mdo ;
    //-------------------------------------------------------------------
    // mden
    // registered output
    //-------------------------------------------------------------------
    assign mden = csr9_mii ;
    //-------------------------------------------------------------------
    // mdc
    // registered output
    //-------------------------------------------------------------------
    assign mdc = csr9_mdc ;
    //=================================================================--
    //                           serial rom                            --
    //=================================================================--
    //-------------------------------------------------------------------
    // serial rom clock
    // registered output
    //-------------------------------------------------------------------
    assign sclk = csr9_sclk ;
    //-------------------------------------------------------------------
    // serial rom chip select
    // registered output
    //-------------------------------------------------------------------
    assign scs = csr9_scs ;
    //-------------------------------------------------------------------
    // serial rom data output
    // registered output
    //-------------------------------------------------------------------
    assign sdo = csr9_sdo ;

    //===================================================================--
    //                              others                               --
    //===================================================================--
    //-------------------------------------------------------------------
    // general-purpose timer registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : gpt_reg_proc
        if (rst == 1'b0)
        begin
            gstart <= 1'b0 ; 
            gstart_r <= 1'b0 ; 
            gcnt <= {16{1'b0}} ; 
            gte <= 1'b0 ; 
        end
        else
        begin
            // general purpose timer start
            if (csrrw == 1'b0 & csrreq == 1'b1 & (csrdbe_c[3]) == 1'b1 & csraddr72 == CSR11_ID)
            begin
                gstart <= 1'b1 ; 
            end
            else if ((csr11_con == 1'b0 & gte == 1'b1) | csr11_tim == 16'b0000000000000000)
            begin
                gstart <= 1'b0 ; 
            end 
            if (csr11_tim != 16'b0000000000000000)
            begin
                gstart_r <= gstart ; 
            end
            else
            begin
                gstart_r <= 1'b0 ; 
            end 
            if (gstart == 1'b1 & gstart_r == 1'b0)
            begin
                gcnt <= csr11_tim ; 
            end
            else if (gcnt == 16'b0000000000000000)
            begin
                // general purpose timer
                if (csr11_con == 1'b1)
                begin
                    gcnt <= csr11_tim ; 
                end 
            end
            else if (tcs2048 == 1'b1)
            begin
                gcnt <= gcnt - 1 ; 
            end 
            // general purpose timer expired
            if (csr5wr_c == 1'b1)
            begin
                gte <= 1'b0 ; 
            end
            else if (gstart_r == 1'b1 & gcnt == 16'b0000000000000000 & csr11_tim != 16'b0000000000000000)
            begin
                gte <= 1'b1 ; 
            end 
        end 
    end // gpt_reg_proc

    //-------------------------------------------------------------------
    // software reset output
    // registered output
    //-------------------------------------------------------------------
    always @(posedge clk)
    begin : rstsofto_reg_proc
        rstsofto <= csr0_swr ;  
    end // rstsofto_reg_proc
endmodule
