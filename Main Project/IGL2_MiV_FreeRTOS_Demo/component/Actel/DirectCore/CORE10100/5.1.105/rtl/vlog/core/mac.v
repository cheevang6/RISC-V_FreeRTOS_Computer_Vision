// *********************************************************************/ 
// Copyright 2013 Microsemi Corporation.  All rights reserved.
// IP Solutions Group
//
// ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
// ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED 
// IN ADVANCE IN WRITING.  
//  
// File:  mac.v
//     
// Description: Core10100
//              MAC Core Engine  
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
// File name            : MAC.V
// File contents        : Entity MAC
//                        Architecture STR of MAC
// Purpose              : Top level structure of MAC
//
// Destination library  : work
// Dependencies         : work.UTILITY
//                        IEEE.STD_LOGIC_1164
//
// Design Engineer      : T.K.
// Quality Engineer     : M.B.
// Version              : 2.00.E08
// Last modification    : 2004-06-07
//---------------------------------------------------------------------
// *******************************************************************--
// Modifications with respect to Version 2.00.E00:
// 2.00.E01   :
// 2003.03.21 : T.K. - MIIWIDTH generic parameter removed
// 2003.04.01 : T.K. - components/port mappings changed
// 2.00.E02   :
// 2003.04.15 : T.K  - unused signals removed
// 2.00.E06   :  
// 2004.01.20 : B.W. - statistical counters module integration
//                     support (I200.05.sc) 
//                      * mfcnt_reg_proc process moved from RLSM to RC 
//                      * changed port mapping
//
// 2.00.E06a  :
// 2004.02.20 : T.K. - cs collision seen functionality fixed (F200.06.cs) :
//                      * cs and cs_o signals added
//                      * cs related port mapping changed
// 2.00.E07   :
// 2004.03.22 : T.K. - unused comments removed
// 2004.03.22 : L.C. - fixed backoff algorithm (F200.06.backoff)
//                      * crc signal width changed
// 2.00.E08   :
// 2004.05.16 : T.K. - modified "BD disable uncomment" section
// 2004.06.07 : T.K. - modified backoff algorithm (F200.08.backoff)
//                      * crc signal removed
//                      * port mapping for TC and BD components changed
// *******************************************************************--

`timescale 1 ns / 100 ps

module MAC (CLKDMA, CLKCSR, RSTCSR, CLKT, CLKR, RSTTCO, RSTRCO, INT, TPS, RPS, 
            CSRREQ, CSRRW, CSRBE, CSRDATAI, CSRADDR, CSRACK, CSRDATAO, 
            DATAACK, DATAREQ, DATARW, DATAEOB, DATAEOBE, DATAI, DATAADDR, DATAO, 
            TRDATA, TWE, TWADDR, TRADDR, TWDATA, 
            RRDATA, RWE, RWADDR, RRADDR, RWDATA, 
            FRDATA, FWE, FWADDR, FRADDR, FWDATA, 
            MATCH, MATCHVAL, MATCHEN, MATCHDATA, 
            SDI, SCLK, SCS, SDO, RXER, RXDV, COL, CRS, RXD, TXEN, TXER, TXD, 
            MDC, MDI, MDO, MDEN, SPEED, RMII_CLK, rrstn);

    parameter FAMILY      = 0;
    parameter FULLDUPLEX  = 0;
    parameter ENDIANESS   = 0;
    parameter CSRWIDTH    = 0;
    parameter DATAWIDTH   = 0;
    parameter DATADEPTH   = 0;
    parameter TFIFODEPTH  = 0;
    parameter RFIFODEPTH  = 0;
    parameter TCDEPTH     = 0;
    parameter RCDEPTH     = 0;
    parameter RMII        = 0;

    `include "utility.v"

    input CLKDMA; 
    input CLKCSR; 
    input RSTCSR; 
    input CLKT; 
    input CLKR; 
    output RSTTCO; 
    wire RSTTCO;
    output RSTRCO; 
    wire RSTRCO;
    output INT; 
    wire INT;
    output TPS; 
    wire TPS;
    output RPS; 
    wire RPS;
    input CSRREQ; 
    input CSRRW; 
    input[CSRWIDTH / 8 - 1:0] CSRBE; 
    input[CSRWIDTH - 1:0] CSRDATAI; 
    input[7:0] CSRADDR; 
    output CSRACK; 
    wire CSRACK;
    output[CSRWIDTH - 1:0] CSRDATAO; 
    wire[CSRWIDTH - 1:0] CSRDATAO;
    input DATAACK; 
    output DATAREQ; 
    wire DATAREQ;
    output DATARW; 
    wire DATARW;
    output DATAEOB; 
    wire DATAEOB;
    output DATAEOBE; 
    wire DATAEOBE;
    input[DATAWIDTH - 1:0] DATAI; 
    output[DATADEPTH - 1:0] DATAADDR; 
    wire[DATADEPTH - 1:0] DATAADDR;
    output[DATAWIDTH - 1:0] DATAO; 
    wire[DATAWIDTH - 1:0] DATAO;
    input[DATAWIDTH - 1:0] TRDATA; 
    output TWE; 
    wire TWE;
    output[TFIFODEPTH - 1:0] TWADDR; 
    wire[TFIFODEPTH - 1:0] TWADDR;
    output[TFIFODEPTH - 1:0] TRADDR; 
    wire[TFIFODEPTH - 1:0] TRADDR;
    output[DATAWIDTH - 1:0] TWDATA; 
    wire[DATAWIDTH - 1:0] TWDATA;
    input[DATAWIDTH - 1:0] RRDATA; 
    output RWE; 
    wire RWE;
    output[RFIFODEPTH - 1:0] RWADDR; 
    wire[RFIFODEPTH - 1:0] RWADDR;
    output[RFIFODEPTH - 1:0] RRADDR; 
    wire[RFIFODEPTH - 1:0] RRADDR;
    output[DATAWIDTH - 1:0] RWDATA; 
    wire[DATAWIDTH - 1:0] RWDATA;
    input[15:0] FRDATA; 
    output FWE; 
    wire FWE;
    output[5:0] FWADDR; 
    wire[5:0] FWADDR;
    output[5:0] FRADDR; 
    wire[5:0] FRADDR;
    output[15:0] FWDATA; 
    wire[15:0] FWDATA;
    input MATCH; 
    input MATCHVAL; 
    output MATCHEN; 
    wire MATCHEN;
    output[47:0] MATCHDATA; 
    wire[47:0] MATCHDATA;
    input SDI; 
    output SCLK; 
    wire SCLK;
    output SCS; 
    wire SCS;
    output SDO; 
    wire SDO;
    input RXER; 
    input RXDV; 
    input COL; 
    input CRS; 
    input[3:0] RXD; 
    output TXEN; 
    wire TXEN;
    output TXER; 
    wire TXER;
    output[3:0] TXD; 
    wire[3:0] TXD;
    output MDC; 
    wire MDC;
    input MDI; 
    output MDO; 
    wire MDO;
    output MDEN; 
    wire MDEN;
    output SPEED;
    input RMII_CLK;
    output rrstn;

    //------------------------ internal reset ---------------------------
    // software reset
    wire rstsoft; 
    // global reset active low
    wire rstn; 
    //----------------------- csr configuration -------------------------
    // programmable burst length
    wire[5:0] pbl; 
    // add crc disable
    wire ac; 
    // disable padding
    wire dpd; 
    // descriptor skip length
    wire[4:0] dsl; 
    // transmit pool demand
    wire tpoll; 
    // transmit descriptors base address
    wire[DATADEPTH - 1:0] tdbad; 
    // store and forward mode
    wire sf; 
    // transmit treshold mode
    wire[2:0] tm; 
    // full duplex
    wire fd; 
    // big/little endian for data buffers
    wire ble; 
    // descriptor byte ordering
    wire dbo; 
    // receive all
    wire ra; 
    // pass all multicast
    wire pm; 
    // promiscous mode
    wire pr; 
    // pass bad frames
    wire pb; 
    // inverse filtering mode
    wire rif; 
    // hash only filtering mode
    wire ho; 
    // hash/perfect filtering mode
    wire hp; 
    // receive poll demand
    wire rpoll; 
    // receive poll acknowledge
    wire rpollack; 
    // receive descriptors base address
    wire[DATADEPTH - 1:0] rdbad; 
    //----------------- csr status data -----------------------
    // fetching transmit descriptor
    wire tdes; 
    // fetching transmit buffer
    wire tbuf; 
    // processing setup frame
    wire tset; 
    // writing transmit descriptor status
    wire tstat; 
    // transmit descriptor unavailable
    wire tu; 
    // filtering type
    wire[1:0] ft; 
    // fetching receive descriptor
    wire rdes; 
    // writing receive descriptor status
    wire rstat; 
    // receive descriptor unavailable
    wire ru; 
    // receive completition
    wire rcomp; 
    // receive completition acknowledge
    wire rcompack; 
    // transmit completition
    wire tcomp; 
    // transmit completition acknowledge
    wire tcompack; 
    //------------------------------ dma --------------------------------
    // dma priority scheme
    wire[1:0] priority; 
    // transmit request
    wire treq; 
    // transmit write selection
    wire twrite; 
    // transmit transfer count
    wire[FIFODEPTH_MAX - 1:0] tcnt; 
    // transmit start address
    wire[DATADEPTH - 1:0] taddr; 
    // transmit data input
    wire[DATAWIDTH - 1:0] tdatai; 
    // transmit single transfer acknowledge
    wire tack; 
    // transmit end of burst
    wire teob; 
    // transmit data output
    wire[DATAWIDTH - 1:0] tdatao; 
    // receive request
    wire rreq; 
    // receive write selection
    wire rwrite; 
    // receive transfer count
    wire[FIFODEPTH_MAX - 1:0] rcnt; 
    // receive start address
    wire[DATADEPTH - 1:0] raddr; 
    // receive data input
    wire[DATAWIDTH - 1:0] rdatai; 
    // receive single transfer acknowledge
    wire rack; 
    // receive end of burst
    wire reob; 
    // receive data output
    wire[DATAWIDTH - 1:0] rdatao; 
    // internal data interface address
    wire[DATADEPTH - 1:0] idataaddr; 
    //------------------------- transmit FIFO ---------------------------
    // transmit fifo not full
    wire tfifonf; 
    // transmit frame cache not full
    wire tfifocnf; 
    // transmit fifo valid
    wire tfifoval; 
    // transmit write enable
    wire tfifowe; 
    // transmit end of frame
    wire tfifoeof; 
    // transmit last byte enable
    wire[DATAWIDTH / 8 - 1:0] tfifobe; 
    // transmit data output
    wire[DATAWIDTH - 1:0] tfifodata; 
    // transmit fifo level
    wire[TFIFODEPTH - 1:0] tfifolev; 
    // transmit fifo read address grey coded
    wire[TFIFODEPTH - 1:0] tradg; 
    //---------------------- transmit frame cache -----------------------
    // early transmit interrupt acknowledge
    wire etiack; 
    // early transmit interrupt request
    wire etireq; 
    // transmit cache not empty
    wire tcsne; 
    // transmit cache read enable
    wire tcachere; 
    // interrupt on completition input
    wire ic; 
    // interrupt on completition input
    wire ici; 
    // add carry disable input
    wire aci; 
    // disable padding input
    wire dpdi; 
    // loss of carrier output
    wire lo_o; 
    // no carrier output
    wire nc_o; 
    // late collision output
    wire lc_o; 
    // excessive collision output
    wire ec_o; 
    // deferred output
    wire de_o; 
    // underrun error output
    wire ur_o; 
    // collision count output
    wire[3:0] cc_o; 
    // loss of carrier input
    wire lo_i; 
    // no carrier input
    wire nc_i; 
    // late collision input
    wire lc_i; 
    // excessive collision input
    wire ec_i; 
    // deferred input
    wire de_i; 
    // underrun error input
    wire ur_i; 
    // collision count input
    wire[3:0] cc_i; 
    //---------------- transmit linked list management ------------------
    // transmit poll acknowldge
    wire tpollack; 
    // transmit descriptor base address changed
    wire tdbadc; 
    // frame status address output
    wire[DATADEPTH - 1:0] statado; 
    // frame status address input
    wire[DATADEPTH - 1:0] statadi; 
    //----------------------- transmit control --------------------------
    // start of frame request
    wire sofreq; 
    // end of frame request
    wire eofreq; 
    // last byte enable
    wire[DATAWIDTH / 8 - 1:0] be; 
    // end of frame fifo address
    wire[TFIFODEPTH - 1:0] eofad; 
    // transmit fifo write address grey coded
    wire[TFIFODEPTH - 1:0] twadg; 
    // transmit interrupt request
    wire tireq; 
    // transmit interrupt acknowledge
    wire tiack; 
    // collision window passed
    wire winp; 
    //--------------------- half duplex procedures ----------------------
    // collision detected
    wire coll; 
    // carrier sense
    wire carrier; 
    // backoff in progress
    wire bkoff; 
    // transmission pending
    wire tpend; 
    // transmission in progress
    wire tprog; 
    // preamble transmission in progress
    wire preamble; 
    //------------------------ transmit timers --------------------------
    // transmit timer request
    wire tcsreq; 
    // transmit timer acknowledge
    wire tcsack; 
    //------------------- transmit process management -------------------
    // stop transmit process
    wire stopt; 
    // tc component stopped
    wire stoptc; 
    // tfifo component stopped
    wire stoptfifo; 
    // tlsm component stopped
    wire stoptlsm; 
    //------------------------ receive fifo -----------------------------
    // fifo read address grey coded
    wire[RFIFODEPTH - 1:0] rradg; 
    // fifo write address grey coded
    wire[RFIFODEPTH - 1:0] rwadg; 
    // fifo read enable
    wire rfifore; 
    // fifo data
    wire[DATAWIDTH - 1:0] rfifodata; 
    // cache read enable
    wire rcachere; 
    // cache not empty
    wire rcachene; 
    // cache not full
    wire rcachenf; 
    // internal write receive data
    wire[DATAWIDTH - 1:0] irwdata; 
    // internal receieve write enable
    wire irwe; 
    //----------------------- receive control ---------------------------
    // interrupt acknowledge from csr
    wire riack; 
    // receive enable
    wire ren; 
    // receive interrupt request
    wire rireq; 
    // filtering fail
    wire ff; 
    // runt frame
    wire rf; 
    // multicast frame
    wire mf; 
    // dribbling bit
    wire db; 
    // mii error
    wire re; 
    // crc error
    wire ce; 
    // too long
    wire tl; 
    // frame type
    wire ftp; 
    // fifo overflow
    wire ov; 
    // collision seen
    wire cs; 
    // length of frame
    wire[13:0] length; 
    // receive in progress
    wire rprog; 
    // rc poll
    wire rcpoll; 
    //---------------------- receive frame cache ------------------------
    // filtering fail
    wire ff_o; 
    // runt frame
    wire rf_o; 
    // multicast frame
    wire mf_o; 
    // frame too long
    wire tl_o; 
    // report on mii error
    wire re_o; 
    // dribbling bit
    wire db_o; 
    // crc error
    wire ce_o; 
    // fifo overflow
    wire ov_o; 
    // collision seen
    wire cs_o; 
    // frame length
    wire[13:0] fl_o; 
    //----------------- receive linked list management ------------------
    // receive descriptor base address changed
    wire rdbadc; 
    // early receive interrupt request
    wire erireq; 
    // early receive interrupt acknowledge
    wire eriack; 
    // fetching receive buffer
    wire rbuf; 
    //----------------- statistical counters ----------------
    // clear fifo overflow counter acknowledge
    wire foclack; 
    // clear missed frames counter acknowledge
    wire mfclack; 
    // fifo overflow counter overflow
    wire oco; 
    // missed frames counter overflow
    wire mfo; 
    // fifo overflow counter grey coded
    wire[10:0] focg; 
    // missed frames counter grey coded
    wire[15:0] mfcg; 
    // clear fifo overflow counter request
    wire focl; 
    // clear missed frames counter
    wire mfcl; 
    //------------------- receive process management --------------------
    // stop receive process
    wire stopr; 
    // rc component stopped
    wire stoprc; 
    // rfifo component stopped
    wire stoprfifo; 
    // rlsm component stopped
    wire stoprlsm; 
    //------------------------ receive timers ---------------------------
    // cycle size acknowledge
    wire rcsack; 
    // cycle size request
    wire rcsreq;
    // Speed bit to decide whether it is 10Mbs or 100Mbs
    wire SPEED; 

    //-------------------------------------------------------------------
    // Direct Memory Access Controller
    //-------------------------------------------------------------------
    //----------------------- common --------------------------
    //-------------------- configuration ----------------------
    //-------------------- data interface ---------------------
    //----------------------- channel 1 -----------------------
    //----------------------- channel 2 -----------------------

    DMA #(DATAWIDTH, DATADEPTH, ENDIANESS ) U_DMA(
        .clk(CLKDMA), 
        .rst(hrstn), 
        .priority(priority), 
        .ble(ble), 
        .dbo(dbo), 
        .rdes(rdes), 
        .rbuf(rbuf), 
        .rstat(rstat), 
        .tdes(tdes), 
        .tbuf(tbuf), 
        .tstat(tstat), 
        .dataack(DATAACK), 
        .datai(DATAI), 
        .datareq(DATAREQ), 
        .datarw(DATARW), 
        .dataeob(DATAEOB), 
        .dataeobe(DATAEOBE), 
        .datao(DATAO), 
        .dataaddr(DATAADDR), 
        .idataaddr(idataaddr), 
        .req1(treq), 
        .write1(twrite), 
        .tcnt1(tcnt), 
        .addr1(taddr), 
        .datai1(tdatao), 
        .ack1(tack), 
        .eob1(teob), 
        .datao1(tdatai), 
        .req2(rreq), 
        .write2(rwrite), 
        .tcnt2(rcnt), 
        .addr2(raddr), 
        .datai2(rdatao), 
        .ack2(rack), 
        .eob2(reob), 
        .datao2(rdatai)
    ); 
    //-------------------------------------------------------------------
    // Transmit linked List Management
    //-------------------------------------------------------------------
    //-------------------- common ports -----------------------
    //--------------- transmit FIFO control -------------------
    //--------------- transmit configuration ------------------
    //------------------ transmit status ----------------------
    //------------------------- dma ---------------------------
    //------------------- address DP RAM ----------------------
    //---------------- csr configuration data -----------------
    //------------------- csr status data ---------------------
    //------------------- power management --------------------

    TLSM #(DATAWIDTH, DATADEPTH, TFIFODEPTH) U_TLSM(
        .clk(CLKDMA), 
        .rst(hrstn), 
        .fifonf(tfifonf), 
        .fifocnf(tfifocnf), 
        .fifoval(tfifoval), 
        .fifowe(tfifowe), 
        .fifoeof(tfifoeof), 
        .fifobe(tfifobe), 
        .fifodata(tfifodata), 
        .fifolev(tfifolev), 
        .ic(ici), 
        .ac(aci), 
        .dpd(dpdi), 
        .statado(statadi), 
        .csne(tcsne), 
        .lo(lo_i), 
        .nc(nc_i), 
        .lc(lc_i), 
        .ec(ec_i), 
        .de(de_i), 
        .ur(ur_i), 
        .cc(cc_i), 
        .cachere(tcachere), 
        .statadi(statado), 
        .dmaack(tack), 
        .dmaeob(teob), 
        .dmadatai(tdatai), 
        .dmaaddr(idataaddr), 
        .dmareq(treq), 
        .dmawr(twrite), 
        .dmacnt(tcnt), 
        .dmaaddro(taddr), 
        .dmadatao(tdatao), 
        .fwe(FWE), 
        .fdata(FWDATA), 
        .faddr(FWADDR), 
        .dsl(dsl), 
        .pbl(pbl), 
        .poll(tpoll), 
        .dbadc(tdbadc), 
        .dbad(tdbad), 
        .pollack(tpollack), 
        .tcompack(tcompack), 
        .tcomp(tcomp), 
        .des(tdes), 
        .fbuf(tbuf), 
        .stat(tstat), 
        .setp(tset), 
        .tu(tu), 
        .ft(ft), 
        .stopi(stopt), 
        .stopo(stoptlsm)
    ); 
    //-------------------------------------------------------------------
    // Transmit FIFO
    //-------------------------------------------------------------------
    //----------------------- Common --------------------------
    //----------------------- DP RAM --------------------------
    //------------------------ tlsm ---------------------------
    //---------------- frame configuration cache --------------
    //------------------- frame status cache ------------------
    //---------------------- tc control -----------------------
    //----------------------- tc status -----------------------
    //---------------- CSR configuration data -----------------
    //--------------------- CSR status ------------------------
    //------------------- power management --------------------

    TFIFO #(DATAWIDTH, DATADEPTH, TFIFODEPTH, TCDEPTH) U_TFIFO(
        .clk(CLKDMA), 
        .rst(hrstn), 
        .ramwe(TWE), 
        .ramaddr(TWADDR), 
        .ramdata(TWDATA), 
        .fifowe(tfifowe), 
        .fifoeof(tfifoeof), 
        .fifobe(tfifobe), 
        .fifodata(tfifodata), 
        .fifonf(tfifonf), 
        .fifocnf(tfifocnf), 
        .fifoval(tfifoval), 
        .flev(tfifolev), 
        .ici(ici), 
        .dpdi(dpdi), 
        .aci(aci), 
        .statadi(statadi), 
        .cachere(tcachere), 
        .deo(de_i), 
        .lco(lc_i), 
        .loo(lo_i), 
        .nco(nc_i), 
        .eco(ec_i), 
        .ico(ic), 
        .uro(ur_i), 
        .csne(tcsne), 
        .cco(cc_i), 
        .statado(statado), 
        .sofreq(sofreq), 
        .eofreq(eofreq), 
        .dpdo(dpd), 
        .aco(ac), 
        .beo(be), 
        .eofad(eofad), 
        .wadg(twadg), 
        .tireq(tireq), 
        .winp(winp), 
        .dei(de_o), 
        .lci(lc_o), 
        .loi(lo_o), 
        .nci(nc_o), 
        .eci(ec_o), 
        .uri(ur_o), 
        .cci(cc_o), 
        .radg(tradg), 
        .tiack(tiack), 
        .sf(sf), 
        .fdp(fd), 
        .tm(tm), 
        .pbl(pbl), 
        .etiack(etiack), 
        .etireq(etireq), 
        .stopi(stopt), 
        .stopo(stoptfifo)
    ); 
    //-------------------------------------------------------------------
    // Transmit controller
    //-------------------------------------------------------------------
    //---------------------- common -------------------------
    //------------------------ mii --------------------------
    //---------------------- DP RAM -------------------------
    //-------------------- fifo control ---------------------
    //------------------ transmit control -------------------
    //---------------- half duplex procedures ---------------
    //-------------------- power management -----------------
    //----------------------- timers ------------------------

    TC #(TFIFODEPTH, DATAWIDTH) U_TC(
        .clk(CLKT), 
        .rst(rrstn), 
        .txen(TXEN), 
        .txer(TXER), 
        .txd(TXD), 
        .ramdata(TRDATA), 
        .ramaddr(TRADDR), 
        .wadg(twadg), 
        .radg(tradg), 
        .dpd(dpd), 
        .ac(ac), 
        .sofreq(sofreq), 
        .eofreq(eofreq), 
        .tiack(tiack), 
        .lastbe(be), 
        .eofadg(eofad), 
        .tireq(tireq), 
        .ur(ur_o), 
        .de(de_o), 
        .coll(coll), 
        .carrier(carrier), 
        .bkoff(bkoff), 
        .tpend(tpend), 
        .tprog(tprog), 
        .preamble(preamble), 
        .stopi(stopt), 
        .stopo(stoptc), 
        .tcsack(tcsack), 
        .tcsreq(tcsreq)
    ); 

    generate
        if (FULLDUPLEX == 0)
        begin : UBD1
            //-----------------------------------------------------------------
            // Backoff and deferring procedures
            BD U (
                .clk(CLKT), 
                .rst(rrstn), 
                .col(COL), 
                .crs(CRS), 
                .fdp(fd), 
                .tprog(tprog), 
                .preamble(preamble), 
                .tpend(tpend), 
                .winp(winp), 
                .tiack(tiack), 
                .coll(coll), 
                .carrier(carrier), 
                .bkoff(bkoff), 
                .lc(lc_o), 
                .lo(lo_o), 
                .nc(nc_o), 
                .ec(ec_o), 
                .cc(cc_o)
            ); 
        end
    endgenerate 

    generate
        if (FULLDUPLEX == 1)
        begin : UBD0
            //-----------------------------------------------------------------
            // deferring disabled
            // backoff disabled
            // retry transmission disabled
            // collision detection disabled
            // late collision detection disabled
            // loss of carrier detection disabled
            // no carrier detection disabled
            // excessive collision detection disabled
            // collision counter disabled
            assign carrier = 1'b0 ;
            assign bkoff = 1'b0 ;
            assign winp = 1'b1 ;
            assign coll = 1'b0 ;
            assign lc_o = 1'b0 ;
            assign lo_o = 1'b0 ;
            assign nc_o = 1'b0 ;
            assign ec_o = 1'b0 ;
            assign cc_o = {4{1'b0}} ;
        end
    endgenerate 
    //-----------------------------------------------------------------
    // Receive Controller
    //-----------------------------------------------------------------
    //---------------------- common -------------------------
    //------------------------ mii --------------------------
    //---------------------- dp ram -------------------------
    //------------------- filtering RAM ---------------------
    //-------------------- fifo control ---------------------
    //------------------ receive control --------------------
    //-------------- external address filtering -------------
    //----------------- statistical counters ----------------
    //------------------- power management ------------------
    //----------------------- timers ------------------------

    RC #(RFIFODEPTH, DATAWIDTH) U_RC(
        .clk(CLKR), 
        .rst(rrstn), 
        .rxdv(RXDV), 
        .rxer(RXER), 
        .col(COL), 
        .rxd(RXD), 
        .ramwe(irwe), 
        .ramaddr(RWADDR), 
        .ramdata(irwdata), 
        .fdata(FRDATA), 
        .faddr(FRADDR), 
        .cachenf(rcachenf), 
        .radg(rradg), 
        .wadg(rwadg), 
        .rprog(rprog), 
        .rcpoll(rcpoll), 
        .riack(riack), 
        .ren(ren), 
        .ra(ra), 
        .pm(pm), 
        .pr(pr), 
        .pb(pb), 
        .rif(rif), 
        .ho(ho), 
        .hp(hp), 
        .rireq(rireq), 
        .ff(ff), 
        .rf(rf), 
        .mf(mf), 
        .db(db), 
        .re(re), 
        .ce(ce), 
        .tl(tl), 
        .ftp(ftp), 
        .ov(ov), 
        .cs(cs), 
        .length(length), 
        .match(MATCH), 
        .matchval(MATCHVAL), 
        .matchen(MATCHEN), 
        .matchdata(MATCHDATA), 
        .focl(focl), 
        .foclack(foclack), 
        .oco(oco), 
        .focg(focg), 
        .mfcl(mfcl), 
        .mfclack(mfclack), 
        .mfo(mfo), 
        .mfcg(mfcg), 
        .stopi(stopr), 
        .stopo(stoprc), 
        .rcsack(rcsack), 
        .rcsreq(rcsreq)
    ); 
    //-----------------------------------------------------------------
    // Receive FIFO Controller
    //-----------------------------------------------------------------
    //----------------------- common --------------------------
    //----------------------- dp ram --------------------------
    //------------------------ rlsm ---------------------------
    //------------------- frame status cache ------------------
    //---------------------- rc control -----------------------
    //----------------------- rc status -----------------------
    //------------------- power management --------------------

    RFIFO #(DATAWIDTH, DATADEPTH, RFIFODEPTH, RCDEPTH) U_RFIFO(
        .clk(CLKDMA), 
        .rst(hrstn), 
        .ramdata(RRDATA), 
        .ramaddr(RRADDR), 
        .fifore(rfifore), 
        .ffo(ff_o), 
        .rfo(rf_o), 
        .mfo(mf_o), 
        .tlo(tl_o), 
        .reo(re_o), 
        .dbo(db_o), 
        .ceo(ce_o), 
        .ovo(ov_o), 
        .cso(cs_o), 
        .flo(fl_o), 
        .fifodata(rfifodata), 
        .cachere(rcachere), 
        .cachene(rcachene), 
        .cachenf(rcachenf), 
        .radg(rradg), 
        .rireq(rireq), 
        .ffi(ff), 
        .rfi(rf), 
        .mfi(mf), 
        .tli(tl), 
        .rei(re), 
        .dbi(db), 
        .cei(ce), 
        .ovi(ov), 
        .csi(cs), 
        .fli(length), 
        .wadg(rwadg), 
        .riack(riack), 
        .stopi(stopr), 
        .stopo(stoprfifo)
    ); 
    //-----------------------------------------------------------------
    // Receive linked list management
    //-----------------------------------------------------------------
    //---------------------- common ---------------------------
    //----------------------- fifo ----------------------------
    //------------------------ dma ----------------------------
    //------------------- receive status ----------------------
    //------------------ csr configuration --------------------
    //---------------------- csr status -----------------------
    //------------------- power management --------------------

    RLSM #(DATAWIDTH, DATADEPTH, RFIFODEPTH) U_RLSM(
        .clk(CLKDMA), 
        .rst(hrstn), 
        .cachenf(rcachenf), 
        .fifodata(rfifodata), 
        .fifore(rfifore), 
        .cachere(rcachere), 
        .dmaack(rack), 
        .dmaeob(reob), 
        .dmadatai(rdatai), 
        .dmaaddr(idataaddr), 
        .dmareq(rreq), 
        .dmawr(rwrite), 
        .dmacnt(rcnt), 
        .dmaaddro(raddr), 
        .dmadatao(rdatao), 
        .rprog(rprog), 
        .rcpoll(rcpoll), 
        .fifocne(rcachene), 
        .ff(ff_o), 
        .rf(rf_o), 
        .mf(mf_o), 
        .db(db_o), 
        .re(re_o), 
        .ce(ce_o), 
        .tl(tl_o), 
        .ftp(ftp), 
        .ov(ov_o), 
        .cs(cs_o), 
        .length(fl_o), 
        .pbl(pbl), 
        .dsl(dsl), 
        .rpoll(rpoll), 
        .rdbadc(rdbadc), 
        .rdbad(rdbad), 
        .rpollack(rpollack), 
        .bufack(eriack), 
        .rcompack(rcompack), 
        .des(rdes), 
        .fbuf(rbuf), 
        .stat(rstat), 
        .ru(ru), 
        .rcomp(rcomp), 
        .bufcomp(erireq), 
        .stopi(stopr), 
        .stopo(stoprlsm)
    ); 
    //-----------------------------------------------------------------
    // Control and Status Registers
    //-----------------------------------------------------------------
    //------------------------ common -------------------------
    //--------------------- reset control ---------------------
    //--------------------- csr interface ---------------------
    //--------------------------- tc --------------------------
    //------------------------- tfifo -------------------------
    //------------------------- tlsm --------------------------
    //------------------------- rc ----------------------------
    //----------------- statistical counters ------------------
    //-------------------------- rlsm -------------------------
    //-------------------------- dma --------------------------
    //-------------- transmit power management ----------------
    //-------------- transmit power management ----------------
    //------------ serial micro-wire rom interface ------------
    //-------------------- mii management ---------------------

    CSR #(CSRWIDTH, ENDIANESS, DATAWIDTH,  DATADEPTH, RCDEPTH) U_CSR(
        .clk(CLKCSR), 
        .rst(prstn), 
        .int(INT), 
        .rstsofto(rstsoft), 
        .csrreq(CSRREQ), 
        .csrrw(CSRRW), 
        .csrbe(CSRBE), 
        .csraddr(CSRADDR), 
        .csrdatai(CSRDATAI), 
        .csrack(CSRACK), 
        .csrdatao(CSRDATAO), 
        .tprog(tprog), 
        .tireq(tcomp), 
        .unf(ur_i), 
        .tiack(tcompack), 
        .tcsreq(tcsreq), 
        .tcsack(tcsack), 
        .fd(fd), 
        .ic(ic), 
        .etireq(etireq), 
        .etiack(etiack), 
        .tm(tm), 
        .sf(sf), 
        .tset(tset), 
        .tdes(tdes), 
        .tbuf(tbuf), 
        .tstat(tstat), 
        .tu(tu), 
        .tpollack(tpollack), 
        .ft(ft), 
        .tpoll(tpoll), 
        .tdbadc(tdbadc), 
        .tdbad(tdbad), 
        .rireq(rcomp), 
        .rcsreq(rcsreq), 
        .rprog(rprog), 
        .riack(rcompack), 
        .rcsack(rcsack), 
        .ren(ren), 
        .ra(ra), 
        .pm(pm), 
        .pr(pr), 
        .pb(pb), 
        .rif(rif), 
        .ho(ho), 
        .hp(hp), 
        .foclack(foclack), 
        .mfclack(mfclack), 
        .oco(oco), 
        .mfo(mfo), 
        .focg(focg), 
        .mfcg(mfcg), 
        .focl(focl), 
        .mfcl(mfcl), 
        .erireq(erireq), 
        .ru(ru), 
        .rpollack(rpollack), 
        .rdes(rdes), 
        .rbuf(rbuf), 
        .rstat(rstat), 
        .eriack(eriack), 
        .rpoll(rpoll), 
        .rdbadc(rdbadc), 
        .rdbad(rdbad), 
        .ble(ble), 
        .dbo(dbo), 
        .priority(priority), 
        .pbl(pbl), 
        .dsl(dsl), 
        .stoptc(stoptc), 
        .stoptlsm(stoptlsm), 
        .stoptfifo(stoptfifo), 
        .stopt(stopt), 
        .tps(TPS), 
        .stoprc(stoprc), 
        .stoprlsm(stoprlsm), 
        .stoprfifo(stoprfifo), 
        .stopr(stopr), 
        .rps(RPS), 
        .sdi(SDI), 
        .sclk(SCLK), 
        .scs(SCS), 
        .sdo(SDO), 
        .mdi(MDI), 
        .mdc(MDC), 
        .mdo(MDO), 
        .mden(MDEN),
	.csr6_ttm(SPEED)
    ); 
    //-------------------------------------------------------------------
    // Reset controller
    //-------------------------------------------------------------------
    //---------------------- clocks ---------------------------
    //----------------------- reset ---------------------------
   
   generate
        if (RMII == 1)	
         begin : U_RMII_RSTC
           //-------------------------------------------------------------------
           // RMII rst logic
	   //-------------------------------------------------------------------
           
    RSTC U_RSTC (
        .clkdma(CLKDMA), 
        .clkcsr(CLKCSR), 
       	.clkr(RMII_CLK), 
        .rstcsr(RSTCSR), 
        .rstsoft(rstsoft), 
        .hrstn(hrstn),
        .prstn(prstn),
        .rrstn(rrstn)
    ); 
         end
    endgenerate 
 generate
        if (RMII == 0)	
         begin : U_MII_RSTC
           //-------------------------------------------------------------------
           //  MII rst logic
           //-------------------------------------------------------------------
           
    RSTC U_RSTC (
        .clkdma(CLKDMA), 
        .clkcsr(CLKCSR), 
       	.clkr(CLKT), 
        .rstcsr(RSTCSR), 
        .rstsoft(rstsoft), 
        .hrstn(hrstn),
        .prstn(prstn),
        .rrstn(rrstn)
    ); 
         end
    endgenerate 


/*    RSTC U_RSTC (
        .clkdma(CLKDMA), 
        .clkcsr(CLKCSR), 
       	.clkr(RMII_CLK), 
        .rstcsr(RSTCSR), 
        .rstsoft(rstsoft), 
        .hrstn(hrstn),
        .prstn(prstn),
        .rrstn(rrstn)
    ); */
    //-------------------------------------------------------------------
    // receive dp ram write enable
    // registered output
    //-------------------------------------------------------------------
    assign RWE = irwe ;
    //-------------------------------------------------------------------
    // receive dp ram write data
    // registered output
    //-------------------------------------------------------------------
    assign RWDATA = irwdata ;
    //-------------------------------------------------------------------
    // transmit reset output
    // registered output
    //-------------------------------------------------------------------
    assign RSTTCO = rrstn ;
    //-------------------------------------------------------------------
    // receive reset output
    // registered output
    //-------------------------------------------------------------------
    assign RSTRCO = rrstn ;

endmodule
