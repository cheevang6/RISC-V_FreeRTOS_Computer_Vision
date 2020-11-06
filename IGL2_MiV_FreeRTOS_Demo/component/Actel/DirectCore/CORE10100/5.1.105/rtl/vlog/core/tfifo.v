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
// File:  tfifo.v
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
// File name            : tfifo.vhd
// File contents        : Entity TFIFO
//                        Architecture RTL of TFIFO
// Purpose              : Transmit FIFO for MAC
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
// 2003.03.21 : T.K. - synchronous reset in CCMEM_REG_PROC added
// 2003.03.21 : T.K. - synchronous reset in CSMEM_REG_PROC added
// 2003.03.21 : T.K. - frame status read enable is now registered
// 2.00.E02   :
// 2003.04.15 : T.K. - csnf unused port removed
// 2003.04.15 : T.K. - synchronous processes merged
// 2.00.E03   :
// 2003.05.12 : T.K. - fzero signal added
// 2003.05.12 : T.K. - icsne signal added
// 2003.05.12 : T.K. - condition for entering stopper state changed
// 2.00.E06   :  
// 2004.01.20 : B.W. - fixed transmit frame descriptor status
//                     assignment(F200.05.tx_status)
//                      * csmem_reg_proc process changed  
// 2.00.E07   :
// 2004.03.22 : T.K. - unused comments removed
// *******************************************************************--
// *****************************************************************--
module TFIFO (clk, rst, ramwe, ramaddr, ramdata, fifowe, fifoeof, fifobe, fifodata, fifonf, fifocnf, fifoval, flev, ici, dpdi, aci, statadi, cachere, deo, lco, loo, nco, eco, csne, ico, uro, cco, statado, sofreq, eofreq, dpdo, aco, beo, eofad, wadg, tireq, winp, dei, lci, loi, nci, eci, uri, cci, radg, tiack, sf, fdp, tm, pbl, etiack, etireq, stopi, stopo);

     // 8|16|32
    parameter DATAWIDTH = 32;
    parameter DATADEPTH  = 32;
    parameter FIFODEPTH  = 9;
    parameter CACHEDEPTH  = 1;
    `include "utility.v"

    input clk; 
    input rst; 
    output ramwe; 
    wire ramwe;
    output[FIFODEPTH - 1:0] ramaddr; 
    wire[FIFODEPTH - 1:0] ramaddr;
    output[DATAWIDTH - 1:0] ramdata; 
    wire[DATAWIDTH - 1:0] ramdata;
    input fifowe; 
    input fifoeof; 
    input[DATAWIDTH / 8 - 1:0] fifobe; 
    input[DATAWIDTH - 1:0] fifodata; 
    output fifonf; 
    reg fifonf;
    output fifocnf; 
    wire fifocnf;
    output fifoval; 
    reg fifoval;
    output[FIFODEPTH - 1:0] flev; 
    wire[FIFODEPTH - 1:0] flev;
    input ici; 
    input dpdi; 
    input aci; 
    input[DATADEPTH - 1:0] statadi; 
    input cachere; 
    output deo; 
    wire deo;
    output lco; 
    wire lco;
    output loo; 
    wire loo;
    output nco; 
    wire nco;
    output eco; 
    wire eco;
    output csne; 
    wire csne;
    output ico; 
    wire ico;
    output uro; 
    wire uro;
    output[3:0] cco; 
    wire[3:0] cco;
    output[DATADEPTH - 1:0] statado; 
    wire[DATADEPTH - 1:0] statado;
    output sofreq; 
    wire sofreq;
    output eofreq; 
    reg eofreq;
    output dpdo; 
    wire dpdo;
    output aco; 
    wire aco;
    output[DATAWIDTH / 8 - 1:0] beo; 
    wire[DATAWIDTH / 8 - 1:0] beo;
    output[FIFODEPTH - 1:0] eofad; 
    reg[FIFODEPTH - 1:0] eofad;
    output[FIFODEPTH - 1:0] wadg; 
    reg[FIFODEPTH - 1:0] wadg;
    input tireq; 
    input winp; 
    input dei; 
    input lci; 
    input loi; 
    input nci; 
    input eci; 
    input uri; 
    input[3:0] cci; 
    input[FIFODEPTH - 1:0] radg; 
    output tiack; 
    wire tiack;
    input sf; 
    input fdp; 
    input[2:0] tm; 
    input[5:0] pbl; 
    input etiack; 
    output etireq; 
    reg etireq;
    input stopi; 
    output stopo; 
    reg stopo;

    //------------------- frame configuration cache ---------------------
    // frame configuration cache data width
    parameter CCWIDTH = (3 + DATADEPTH + DATAWIDTH / 8 + FIFODEPTH); 
    // frame configuration cache type
    // frame configuration cache
    reg[CCWIDTH - 1:0] ccmem[2 ** CACHEDEPTH - 1:0]; 
    // frame cache write enable
    wire ccwe; 
    // frame cache read enable
    wire ccre; 
    // frame cache not empty
    reg ccne; 
    // frame cache not full
    reg iccnf; 
    // frame cache read address combinatorial
    wire[CACHEDEPTH - 1:0] ccwad_c; 
    // frame cache read address registered
    reg[CACHEDEPTH - 1:0] ccwad; 
    // frame cache write address
    reg[CACHEDEPTH - 1:0] ccrad; 
    // frame cache write enable double registered
    reg[CACHEDEPTH - 1:0] ccrad_r; 
    // frame cache write data
    wire[CCWIDTH - 1:0] ccdi; 
    // frame cache read data
    wire[CCWIDTH - 1:0] ccdo; 
    //------------------------ frame status cache -----------------------
    // frame status cache data width
    parameter CSWIDTH = (DATADEPTH + 11); 
    // frame status cache type
    // frame status cache
    reg[CSWIDTH - 1:0] csmem[2 ** CACHEDEPTH - 1:0]; 
    // frame cache write enable
    wire cswe; 
    // frame cache read enable
    reg csre; 
    // frame cache read address
    reg[CACHEDEPTH - 1:0] cswad; 
    // frame cache write address combinatorial
    wire[CACHEDEPTH - 1:0] csrad_c; 
    // frame cache write address registered
    reg[CACHEDEPTH - 1:0] csrad; 
    // frame cache write address registered
    reg[CACHEDEPTH - 1:0] csrad_r; 
    // frame cache write data
    wire[CSWIDTH - 1:0] csdi; 
    // frame cache read data
    wire[CSWIDTH - 1:0] csdo; 
    // frame descriptor status address
    wire[DATADEPTH - 1:0] statad; 
    // interrupt on completition
    wire ic; 
    // internal frame cache not empty
    reg icsne; 
    //------------------------ transmit control -------------------------
    // transmit in progress
    reg tprog; 
    // transmit in progress registered
    reg tprog_r; 
    //------------------------------ FIFO -------------------------------
    // collision window passed registered
    reg winp_r; 
    // fifo treshold level combinatorial
    reg[FIFODEPTH_MAX - 1:0] tlev_c; 
    // fifo treshold level registered
    reg tresh; 
    // fifo status registered
    reg[FIFODEPTH - 1:0] stat; 
    // fifo write address registered
    reg[FIFODEPTH - 1:0] wad; 
    // fifo read address combinatorial
    reg[FIFODEPTH - 1:0] rad_c; 
    // fifo read address registered
    reg[FIFODEPTH - 1:0] rad; 
    // fifo read grey coded address registered
    reg[FIFODEPTH - 1:0] radg_r; 
    // fifo start address
    reg[FIFODEPTH - 1:0] sad; 
    // eond of frame address binary
    wire[FIFODEPTH - 1:0] eofad_bin; 
    // programmable burst length=0 registered
    reg pblz; 
    // free fifo space combinatorial
    reg[FIFODEPTH_MAX - 1:0] sflev_c; 
    //----------------------- transmit control --------------------------
    // transmit interrupt request registered
    reg tireq_r; 
    // transmit interrupt request double registered
    reg tireq_r2; 
    //----------------------- power management --------------------------
    // stop transmit process registered
    reg stop_r; 
    //---------------------------- others -------------------------------
    // all ones vector for fifo
    wire[FIFODEPTH - 1:0] fone; 
    // all zeros vector for fifo
    wire[FIFODEPTH - 1:0] fzero; 

    //-------------------------------------------------------------------
    //                    Frame configuration cache                    --
    //-------------------------------------------------------------------
    //-------------------------------------------------------------------
    // frame configuration cache memory registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : ccmem_reg_proc
        if (rst == 1'b0)
        begin
            begin : xhdl_1
                integer i;
                for(i = 2 ** CACHEDEPTH - 1; i >= 0; i = i - 1)
                begin
                    ccmem[i] <= {CCWIDTH - 1-(0)+1{1'b0}} ; 
                end
            end 
            ccrad_r <= {CACHEDEPTH - 1-(0)+1{1'b0}} ; 
        end
        else
        begin
            if (fifowe == 1'b1 | fifoeof == 1'b1)
            begin
                ccmem[ccwad] <= ccdi ; 
            end 
            ccrad_r <= ccrad ; 
        end 
    end // ccmem_reg_proc
    //-------------------------------------------------------------------
    // frame configuration cache write address combinatorial
    //-------------------------------------------------------------------
    assign ccwad_c = (fifoeof == 1'b1) ? ccwad + 1 : ccwad ;

    //-------------------------------------------------------------------
    // frame configuration cache address registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : ccaddr_reg_proc
        if (rst == 1'b0)
        begin
            ccwad <= {CACHEDEPTH - 1-(0)+1{1'b0}} ; 
            ccrad <= {CACHEDEPTH - 1-(0)+1{1'b0}} ; 
        end
        else
        begin
            // write address
            ccwad <= ccwad_c ; 
            // read address
            if (ccre == 1'b1)
            begin
                ccrad <= ccrad + 1 ; 
            end 
        end 
    end // ccaddr_reg_proc

    //-------------------------------------------------------------------
    // frame configuration cache full/empty logic
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : ccfe_reg_proc
        if (rst == 1'b0)
        begin
            iccnf <= 1'b1 ; 
            ccne <= 1'b0 ; 
        end
        else
        begin
            // not full
            if ((ccwad_c == ccrad) & ccwe == 1'b1)
            begin
                iccnf <= 1'b0 ; 
            end
            else if (ccre == 1'b1)
            begin
                iccnf <= 1'b1 ; 
            end 
            // not empty
            if (ccwad == ccrad & iccnf == 1'b1)
            begin
                ccne <= 1'b0 ; 
            end
            else
            begin
                ccne <= 1'b1 ; 
            end 
        end 
    end // ccnf_reg_proc
    //-------------------------------------------------------------------
    // frame configuration cache not full
    // registered output
    //-------------------------------------------------------------------
    assign fifocnf = iccnf ;
    //-------------------------------------------------------------------
    // frame configuration cache data output
    //-------------------------------------------------------------------
    assign ccdo = ccmem[ccrad_r] ;
    //-------------------------------------------------------------------
    // frame configuration cache data input
    //-------------------------------------------------------------------
    assign ccdi = {ici, aci, dpdi, wad, fifobe, statadi} ;
    //-------------------------------------------------------------------
    // frame configuration cache write enable
    // write configuration after end of fetching frame via dma
    //-------------------------------------------------------------------
    assign ccwe = fifoeof ;
    //-------------------------------------------------------------------
    // frame configuration cache read enable
    // read configuration after end of previous transmission
    //-------------------------------------------------------------------
    assign ccre = tireq_r & ~tireq_r2 ;
    //-------------------------------------------------------------------
    // interrupt on completition
    //-------------------------------------------------------------------
    assign ic = ccdo[CCWIDTH - 1] ;
    //-------------------------------------------------------------------
    // add crc disable
    // combinatorial output
    //-------------------------------------------------------------------
    assign aco = ccdo[CCWIDTH - 2] ;
    //-------------------------------------------------------------------
    // disabled padding
    // combinatorial output
    //-------------------------------------------------------------------
    assign dpdo = ccdo[CCWIDTH - 3] ;
    //-------------------------------------------------------------------
    // end of frame fifo address binary
    //-------------------------------------------------------------------
    assign eofad_bin = ccdo[CCWIDTH - 4:CCWIDTH - 3 - FIFODEPTH] ;

    //-------------------------------------------------------------------
    // internal fifo write address grey coded
    // registered output
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : eofad_reg_proc
        if (rst == 1'b0)
        begin
            eofad <= {FIFODEPTH - 1-(0)+1{1'b0}} ; 
        end
        else
        begin
            eofad[FIFODEPTH - 1] <= eofad_bin[FIFODEPTH - 1] ; 
            begin : xhdl_19
                integer i;
                for(i = FIFODEPTH - 2; i >= 0; i = i - 1)
                begin
                    eofad[i] <= eofad_bin[i] ^ eofad_bin[i + 1] ; 
                end
            end 
        end 
    end // eofad_reg_proc
    //-------------------------------------------------------------------
    // last fifo byte enable
    // combinatorial output
    //-------------------------------------------------------------------
    assign beo = ccdo[DATADEPTH + DATAWIDTH / 8 - 1:DATADEPTH] ;
    //-------------------------------------------------------------------
    // frame descriptor status
    // combinatorial output
    //-------------------------------------------------------------------
    assign statad = ccdo[DATADEPTH - 1:0] ;

    //-------------------------------------------------------------------
    //                        Frame status cache                       --
    //-------------------------------------------------------------------
    //-------------------------------------------------------------------
    // frame status cache registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : csmem_reg_proc
        if (rst == 1'b0)
        begin
            begin : xhdl_23
                integer i;
                for(i = 2 ** CACHEDEPTH - 1; i >= 0; i = i - 1)
                begin
                    csmem[i] <= {CSWIDTH - 1-(0)+1{1'b0}} ; 
                end
            end 
            csrad_r <= {CACHEDEPTH - 1-(0)+1{1'b0}} ; 
        end
        else
        begin
            csmem[cswad] <= csdi ; 
            csrad_r <= csrad ; 
        end 
    end // csmem_reg_proc

    //-------------------------------------------------------------------
    // frame status cache address
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : csaddr_reg_proc
        if (rst == 1'b0)
        begin
            cswad <= {CACHEDEPTH - 1-(0)+1{1'b0}} ; 
            csrad <= {CACHEDEPTH - 1-(0)+1{1'b0}} ; 
        end
        else
        begin
            // write address
            if (cswe == 1'b1)
            begin
                cswad <= cswad + 1 ; 
            end 
            // read address
            csrad <= csrad_c ; 
        end 
    end // csaddr_reg_proc
    //-------------------------------------------------------------------
    // frame status cache read address combinatorial
    //-------------------------------------------------------------------
    assign csrad_c = (csre == 1'b1) ? csrad + 1 : csrad ;

    //-------------------------------------------------------------------
    // frame status cache empty logic
    // registered output
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : icsne_reg_proc
        if (rst == 1'b0)
        begin
            icsne <= 1'b0 ; 
        end
        else
        begin
            // not empty
            if (cswad == csrad | (csre == 1'b1 & cswad == csrad_c))
            begin
                icsne <= 1'b0 ; 
            end
            else
            begin
                icsne <= 1'b1 ; 
            end 
        end 
    end // icsne_reg_proc
    //-------------------------------------------------------------------
    // frame status cache not empty
    // registered output
    //-------------------------------------------------------------------
    assign csne = icsne ;
    //-------------------------------------------------------------------
    // frame status cache data output
    //-------------------------------------------------------------------
    assign csdo = csmem[csrad_r] ;
    //-------------------------------------------------------------------
    // frame status cache data input
    //-------------------------------------------------------------------
    assign csdi = {dei, lci, loi, nci, eci, ic, cci, uri, statad} ;
    //-------------------------------------------------------------------
    // deferred
    // combinatorial output
    //-------------------------------------------------------------------
    assign deo = csdo[CSWIDTH - 1] ;
    //-------------------------------------------------------------------
    // late collision
    // combinatorial output
    //-------------------------------------------------------------------
    assign lco = csdo[CSWIDTH - 2] ;
    //-------------------------------------------------------------------
    // loss of carrier
    // combinatorial output
    //-------------------------------------------------------------------
    assign loo = csdo[CSWIDTH - 3] ;
    //-------------------------------------------------------------------
    // no carrier
    // combinatorial output
    //-------------------------------------------------------------------
    assign nco = csdo[CSWIDTH - 4] ;
    //-------------------------------------------------------------------
    // excessive collision
    // combinatorial output
    //-------------------------------------------------------------------
    assign eco = csdo[CSWIDTH - 5] ;
    //-------------------------------------------------------------------
    // interrupt on completition output
    // combinatorial output
    //-------------------------------------------------------------------
    assign ico = csdo[CSWIDTH - 6] ;
    //-------------------------------------------------------------------
    // collision count
    // combinatorial output
    //-------------------------------------------------------------------
    assign cco = csdo[CSWIDTH - 7:CSWIDTH - 10] ;
    //-------------------------------------------------------------------
    // underrun
    // combinatorial output
    //-------------------------------------------------------------------
    assign uro = csdo[CSWIDTH - 11] ;
    //-------------------------------------------------------------------
    // frame descriptor address
    // combinatorial output
    //-------------------------------------------------------------------
    assign statado = csdo[DATADEPTH - 1:0] ;
    //-------------------------------------------------------------------
    // frame status cache write enable
    //-------------------------------------------------------------------
    assign cswe = tireq_r & tprog ;

    //-------------------------------------------------------------------
    // frame status cache read enable registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : csre_reg_proc
        if (rst == 1'b0)
        begin
            csre <= 1'b0 ; 
        end
        else
        begin
            csre <= cachere ; 
        end 
    end // csre_reg_proc

    //-------------------------------------------------------------------
    //                           TC control                            --
    //-------------------------------------------------------------------
    //-------------------------------------------------------------------
    // transmit in progress registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : tprog_reg_proc
        if (rst == 1'b0)
        begin
            tprog <= 1'b0 ; 
            tprog_r <= 1'b0 ; 
        end
        else
        begin
            tprog_r <= tprog ; 
            if (tireq_r == 1'b1)
            begin
                tprog <= 1'b0 ; 
            end
            else if ((sf == 1'b0 & tprog == 1'b0 & tireq_r == 1'b0 & tresh == 1'b1) | ccne == 1'b1)
            begin
                tprog <= 1'b1 ; 
            end 
        end 
    end // tprog_reg_proc

    //-------------------------------------------------------------------
    // end of frame
    // registered output
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : eofreq_reg_proc
        if (rst == 1'b0)
        begin
            eofreq <= 1'b0 ; 
        end
        else
        begin
            if (tprog == 1'b1 & ccne == 1'b1)
            begin
                eofreq <= 1'b1 ; 
            end
            else if (tireq_r == 1'b1)
            begin
                eofreq <= 1'b0 ; 
            end 
        end 
    end // eofreq_reg_proc

    //-------------------------------------------------------------------
    // transmit interrupt registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : tireq_reg_proc
        if (rst == 1'b0)
        begin
            tireq_r <= 1'b0 ; 
            tireq_r2 <= 1'b0 ; 
        end
        else
        begin
            tireq_r <= tireq ; 
            tireq_r2 <= tireq_r ; 
        end 
    end // tireq_reg_proc

    //-------------------------------------------------------------------
    // early transmit interrupt request
    // registered output
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : etireq_reg_proc
        if (rst == 1'b0)
        begin
            etireq <= 1'b0 ; 
        end
        else
        begin
            if (fifoeof == 1'b1)
            begin
                etireq <= 1'b1 ; 
            end
            else if (etiack == 1'b1)
            begin
                etireq <= 1'b0 ; 
            end 
        end 
    end // etireq_reg_proc
    //-------------------------------------------------------------------
    // transmit interrput acknowledge
    // registered output
    //-------------------------------------------------------------------
    assign tiack = tireq_r2 ;
    //-------------------------------------------------------------------
    // start of frame request
    // registered output
    //-------------------------------------------------------------------
    assign sofreq = tprog ;

    //===================================================================--
    //                                FIFO                               --
    //===================================================================--
    //-------------------------------------------------------------------
    // fifo address registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : addr_reg_proc
        if (rst == 1'b0)
        begin
            wad <= {FIFODEPTH - 1-(0)+1{1'b0}} ; 
            wadg <= {FIFODEPTH - 1-(0)+1{1'b0}} ; 
            radg_r <= {FIFODEPTH - 1-(0)+1{1'b0}} ; 
            rad <= {FIFODEPTH - 1-(0)+1{1'b0}} ; 
            sad <= {FIFODEPTH - 1-(0)+1{1'b0}} ; 
        end
        else
        begin
            // write address
            if (fifowe == 1'b1)
            begin
                wad <= wad + 1 ; 
            end 
            // write address grey coded
            wadg[FIFODEPTH - 1] <= wad[FIFODEPTH - 1] ; 
            begin : xhdl_57
                integer i;
                for(i = FIFODEPTH - 2; i >= 0; i = i - 1)
                begin
                    wadg[i] <= wad[i] ^ wad[i + 1] ; 
                end
            end 
            // read address grey coded
            radg_r <= radg ; 
            // read address binary
            rad <= rad_c ; 
            // start of frame address
            // the end address of the last transmitted frame
            if (tprog == 1'b0 & tprog_r == 1'b1)
            begin
                sad <= eofad_bin ; 
            end 
        end 
    end // addr_reg_proc

    //-------------------------------------------------------------------
    // read address binary combinatorial
    //-------------------------------------------------------------------
    always @(radg_r)
    begin : rad_proc
        reg[FIFODEPTH - 1:0] rad_v; 
        rad_v[FIFODEPTH - 1] = radg_r[FIFODEPTH - 1]; 
        begin : xhdl_59
            integer i;
            for(i = FIFODEPTH - 2; i >= 0; i = i - 1)
            begin
                rad_v[i] = rad_v[i + 1] ^ radg_r[i]; 
            end
        end 
        rad_c <= rad_v ; 
    end // rad_proc

    //-------------------------------------------------------------------
    // transmit fifo status registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : stat_reg_proc
        if (rst == 1'b0)
        begin
            stat <= {FIFODEPTH - 1-(0)+1{1'b0}} ; 
        end
        else
        begin
            if ((winp_r == 1'b0 & fdp == 1'b0 & tprog == 1'b1 & tireq_r == 1'b0) | tprog_r == 1'b0)
            begin
                stat <= wad - sad ; 
            end
            else
            begin
                stat <= wad - rad ; 
            end 
        end 
    end // stat_reg_proc

    //-------------------------------------------------------------------
    // collision window passed registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : winp_reg_proc
        if (rst == 1'b0)
        begin
            winp_r <= 1'b0 ; 
        end
        else
        begin
            winp_r <= winp ; 
        end 
    end // winp_reg_proc

    //-------------------------------------------------------------------
    // fifo treshold level combinatorial
    //-------------------------------------------------------------------
    always @(tm)
    begin : tresh_proc
        tlev_c <= {FIFODEPTH_MAX - 1-(0)+1{1'b0}} ; 
        case (DATAWIDTH)
            8 :
                        begin
                            //-----------------------------------------
                            case (tm)
                                //-----------------------------------------
                                3'b000, 3'b101, 3'b110 :
                                            begin
                                                //  128 bytes
                                                tlev_c[10:0] <= 11'b00010000000 ; 
                                            end
                                3'b001, 3'b111 :
                                            begin
                                                //  256 bytes
                                                tlev_c[10:0] <= 11'b00100000000 ; 
                                            end
                                3'b010 :
                                            begin
                                                //  512 bytes
                                                tlev_c[10:0] <= 11'b01000000000 ; 
                                            end
                                3'b011 :
                                            begin
                                                // 1024 bytes
                                                tlev_c[10:0] <= 11'b10000000000 ; 
                                            end
                                default :
                                            begin
                                                //   64 bytes
                                                tlev_c[10:0] <= 11'b00001000000 ; 
                                            end
                            endcase 
                        end
            16 :
                        begin
                            //-----------------------------------------
                            case (tm)
                                //-----------------------------------------
                                3'b000, 3'b101, 3'b110 :
                                            begin
                                                //  128 bytes
                                                tlev_c[10:0] <= 11'b00001000000 ; 
                                            end
                                3'b001, 3'b111 :
                                            begin
                                                //  256 bytes
                                                tlev_c[10:0] <= 11'b00010000000 ; 
                                            end
                                3'b010 :
                                            begin
                                                //  512 bytes
                                                tlev_c[10:0] <= 11'b00100000000 ; 
                                            end
                                3'b011 :
                                            begin
                                                // 1024 bytes
                                                tlev_c[10:0] <= 11'b01000000000 ; 
                                            end
                                default :
                                            begin
                                                //   64 bytes
                                                tlev_c[10:0] <= 11'b00000100000 ; 
                                            end
                            endcase 
                        end
            default :
                        begin
                            // 32
                            //-----------------------------------------
                            case (tm)
                                //-----------------------------------------
                                3'b000, 3'b101, 3'b110 :
                                            begin
                                                //  128 bytes
                                                tlev_c[10:0] <= 11'b00000100000 ; 
                                            end
                                3'b001, 3'b111 :
                                            begin
                                                //  256 bytes
                                                tlev_c[10:0] <= 11'b00001000000 ; 
                                            end
                                3'b010 :
                                            begin
                                                //  512 bytes
                                                tlev_c[10:0] <= 11'b00010000000 ; 
                                            end
                                3'b011 :
                                            begin
                                                // 1024 bytes
                                                tlev_c[10:0] <= 11'b00100000000 ; 
                                            end
                                default :
                                            begin
                                                //   64 bytes
                                                tlev_c[10:0] <= 11'b00000010000 ; 
                                            end
                            endcase 
                        end
        endcase 
    end // tlev_proc

    //-------------------------------------------------------------------
    // fifo treshold registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : tresh_reg_proc
        if (rst == 1'b0)
        begin
            tresh <= 1'b0 ; 
        end
        else
        begin
            if (stat >= tlev_c[FIFODEPTH - 1:0])
            begin
                tresh <= 1'b1 ; 
            end
            else
            begin
                tresh <= 1'b0 ; 
            end 
        end 
    end // tresh_reg_proc

    //-------------------------------------------------------------------
    // free fifo space combinatorial
    //-------------------------------------------------------------------
    always @(pbl or pblz)
    begin : sflev_proc
        sflev_c[FIFODEPTH_MAX - 1:6] <= {FIFODEPTH_MAX - 1-(0)+1{1'b1}} ; 
        if (pblz == 1'b1)
        begin
            sflev_c[5:0] <= 6'b000000 ; 
        end
        else
        begin
            sflev_c[5:0] <= ~pbl ; 
        end 
    end // sflev_proc

    //-------------------------------------------------------------------
    // fifo treshold level registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : fifoval_reg_proc
        if (rst == 1'b0)
        begin
            fifoval <= 1'b0 ; 
        end
        else
        begin
            if (stat <= sflev_c[FIFODEPTH - 1:0])
            begin
                fifoval <= 1'b1 ; 
            end
            else
            begin
                fifoval <= 1'b0 ; 
            end 
        end 
    end // fifoval_reg_proc

    //-------------------------------------------------------------------
    // programmable burst length=0 registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : pblz_reg_proc
        if (rst == 1'b0)
        begin
            pblz <= 1'b0 ; 
        end
        else
        begin
            if (pbl == 6'b000000)
            begin
                pblz <= 1'b1 ; 
            end
            else
            begin
                pblz <= 1'b0 ; 
            end 
        end 
    end // pblz_reg_proc

    //-------------------------------------------------------------------
    // fifo not full
    // registered output
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : fifonf_reg_proc
        if (rst == 1'b0)
        begin
            fifonf <= 1'b1 ; 
        end
        else
        begin
            if ((stat == {fone[FIFODEPTH - 1:1], 1'b0} & fifowe == 1'b1) | (stat == fone))
            begin
                fifonf <= 1'b0 ; 
            end
            else
            begin
                fifonf <= 1'b1 ; 
            end 
        end 
    end // fifonf_reg_proc
    //-------------------------------------------------------------------
    // FIFO level
    // registered output
    //-------------------------------------------------------------------
    assign flev = stat ;
    //-------------------------------------------------------------------
    // DP RAM address
    // registered output
    //-------------------------------------------------------------------
    assign ramaddr = wad ;
    //-------------------------------------------------------------------
    // DP RAM data
    // redirection
    //-------------------------------------------------------------------
    assign ramdata = fifodata ;
    //-------------------------------------------------------------------
    // DP RAM write enable
    // redirection
    //-------------------------------------------------------------------
    assign ramwe = fifowe ;

    //=================================================================--
    //                       Power management                          --
    //=================================================================--
    //-------------------------------------------------------------------
    // stop transmit process registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : tstop_reg_proc
        if (rst == 1'b0)
        begin
            stop_r <= 1'b1 ; 
            stopo <= 1'b0 ; 
        end
        else
        begin
            // stop transmit input
            stop_r <= stopi ; 
            // stop transmit output
            // can enter stopped state only if
            // transmit FIFO is empty and transmit cache is empty
            // i.e no frame is pending for transmission
            // and no transmission in progress
            if (stop_r == 1'b1 & ccne == 1'b0 & icsne == 1'b0 & stat == fzero & tprog == 1'b0)
            begin
                stopo <= 1'b1 ; 
            end
            else
            begin
                stopo <= 1'b0 ; 
            end 
        end 
    end // tstop_reg_proc
    //===================================================================--
    //                               others                              --
    //===================================================================--
    //-------------------------------------------------------------------
    // all ones vector of FIFODEPTH length
    //-------------------------------------------------------------------
    assign fone = {FIFODEPTH - 1-(0)+1{1'b1}} ;
    //-------------------------------------------------------------------
    // all zeros vector of FIFODEPTH length
    //-------------------------------------------------------------------
    assign fzero = {FIFODEPTH - 1-(0)+1{1'b0}} ;
endmodule
