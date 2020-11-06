`timescale 1 ns / 100 ps
// ********************************************************************/ 
// Copyright 2013 Microsemi Corporation.  All rights reserved.
// IP Solutions Group
//
// ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
// ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED 
// IN ADVANCE IN WRITING.  
//  
// File:  rfifo.v
//     
// Description: Core10100
//              See below  
//
// Notes: 
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
// File name            : rfifo.vhd
// File contents        : Entity HC
//                        Architecture RTL of RFIFO
// Purpose              : Receive FIFO for MAC
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
// 2003.03.21 : T.K. - synchronous reset in CSMEM_REG_PROC added
// 2003.03.21 : T.K. - watchdog functionality removed
// 2.00.E02   :
// 2003.04.15 : T.K. - flev unused port removed
// 2.00.E03   :
// 2003.05.12 : T.K. - fzero signal added
// 2003.05.12 : T.K. - condition for entering stopped state changed
// 2.00.E06   :  
// 2004.01.20 : T.K. - fixed mfc counter (F200.05.mfc) &
//              B.W.   statistical counters module integration
//                     support (I200.05.sc) : 
//                      * cswadi signal added
//                      * csnf_reg_proc process changed  
//
// 2004.01.20 : B.W. - RTL code chandes due to VN Check
//                     and code coverage (I200.06.vn) :
//                      * rad_proc process modified
// 2.00.E06a  :
// 2004.02.20 : T.K. - cs collision seen functionality fixed (F200.06.cs)
// *******************************************************************--
// *****************************************************************--
module RFIFO (clk, rst, ramdata, ramaddr, fifore, ffo, rfo, mfo, tlo, reo, dbo, ceo, ovo, cso, flo, fifodata, cachere, cachene, cachenf, radg, rireq, ffi, rfi, mfi, tli, rei, dbi, cei, ovi, csi, fli, wadg, riack, stopi, stopo);

     // 8|16|32|64
    parameter DATAWIDTH = 32;
    parameter DATADEPTH  = 32;
    parameter FIFODEPTH  = 9;
    parameter CACHEDEPTH  = 2;
    input clk; 
    input rst; 
    input[DATAWIDTH - 1:0] ramdata; 
    output[FIFODEPTH - 1:0] ramaddr; 
    wire[FIFODEPTH - 1:0] ramaddr;
    input fifore; 
    output ffo; 
    wire ffo;
    output rfo; 
    wire rfo;
    output mfo; 
    wire mfo;
    output tlo; 
    wire tlo;
    output reo; 
    wire reo;
    output dbo; 
    wire dbo;
    output ceo; 
    wire ceo;
    output ovo; 
    wire ovo;
    output cso; 
    wire cso;
    output[13:0] flo; 
    wire[13:0] flo;
    output[DATAWIDTH - 1:0] fifodata; 
    wire[DATAWIDTH - 1:0] fifodata;
    input cachere; 
    output cachene; 
    wire cachene;
    output cachenf; 
    wire cachenf;
    output[FIFODEPTH - 1:0] radg; 
    reg[FIFODEPTH - 1:0] radg;
    input rireq; 
    input ffi; 
    input rfi; 
    input mfi; 
    input tli; 
    input rei; 
    input dbi; 
    input cei; 
    input ovi; 
    input csi; 
    input[13:0] fli; 
    input[FIFODEPTH - 1:0] wadg; 
    output riack; 
    wire riack;
    input stopi; 
    output stopo; 
    reg stopo;

    //----------------------- frame status cache ------------------------
    // frame cache data width      
    parameter CSWIDTH = 23; 
    // frame configuration cache type
    // frame configuration cache
    reg[CSWIDTH - 1:0] csmem[2 ** CACHEDEPTH - 1:0]; 
    // frame cache write enable
    wire cswe; 
    // frame cache read enable
    wire csre; 
    // frame cache not full
    reg csnf; 
    // frame cache not empty
    reg csne; 
    // frame cache write address
    reg[CACHEDEPTH - 1:0] cswad; 
    // frame cache read address incremented
    wire[CACHEDEPTH - 1:0] cswad_i; 
    // frame cache read address
    reg[CACHEDEPTH - 1:0] csrad; 
    // frame cache write address registered
    reg[CACHEDEPTH - 1:0] csrad_r; 
    // frame cache write data
    wire[CSWIDTH - 1:0] csdi; 
    // frame cache read data
    wire[CSWIDTH - 1:0] csdo; 
    //----------------------------- fifo --------------------------------
    // fifo status registered
    reg[FIFODEPTH - 1:0] stat; 
    // fifo read address combinatorial
    reg[FIFODEPTH - 1:0] rad_c; 
    // fifo read address registered
    reg[FIFODEPTH - 1:0] rad; 
    // fifo write address combinatorial
    reg[FIFODEPTH - 1:0] wad_c; 
    // fifo write address registered
    reg[FIFODEPTH - 1:0] wad; 
    // fifo write address grey coded registered
    reg[FIFODEPTH - 1:0] wadg_r; 
    // frame length binary combinatorial
    reg[13:0] flibin_c; 
    // frame length binary registered
    reg[13:0] flibin; 
    //------------------------ receive status ---------------------------
    // interrupt registered
    reg rireq_r; 
    // interrupt acknowledge
    reg iriack; 
    //------------------------ power management -------------------------
    // stop receive process registered
    reg stop_r; 
    //--------------------------- others --------------------------------
    wire[FIFODEPTH - 1:0] fzero; 
    // frame length
    reg[13:0] fli_r; 

    //-------------------------------------------------------------------
    //                        frame status cache                       --
    //-------------------------------------------------------------------
    //-------------------------------------------------------------------
    // frame status cache registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : csmem_reg_proc
        if (rst == 1'b0)
        begin
            begin : xhdl_1
                integer i;
                for(i = 2 ** CACHEDEPTH - 1; i >= 0; i = i - 1)
                begin
                    csmem[i] <= {CSWIDTH - 1-(0)+1{1'b0}} ; 
                end
            end 
            //        csrad_r <= csrad;
            csrad_r <= {CACHEDEPTH - 1-(0)+1{1'b0}} ; 
        end
        else
        begin
            csmem[cswad] <= csdi ; 
            csrad_r <= csrad ; 
        end 
    end // csmem_reg_proc

    //-------------------------------------------------------------------
    // frame status cache write address
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : cswad_reg_proc
        if (rst == 1'b0)
        begin
            cswad <= {CACHEDEPTH - 1-(0)+1{1'b1}} ; 
        end
        else
        begin
            if (cswe == 1'b1)
            begin
                cswad <= cswad + 1 ; 
            end 
        end 
    end // cswad_reg_proc

    //-------------------------------------------------------------------
    // frame ststus cache read address
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : csrad_reg_proc
        if (rst == 1'b0)
        begin
            csrad <= {CACHEDEPTH - 1-(0)+1{1'b1}} ; 
        end
        else
        begin
            if (csre == 1'b1)
            begin
                csrad <= csrad + 1 ; 
            end 
        end 
    end // csrad_reg_proc

    //-------------------------------------------------------------------
    // frame status cache not empty registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : csne_reg_proc
        if (rst == 1'b0)
        begin
            csne <= 1'b0 ; 
        end
        else
        begin
            if (cswad == csrad)
            begin
                csne <= 1'b0 ; 
            end
            else
            begin
                csne <= 1'b1 ; 
            end 
        end 
    end // csne_reg_proc
    //-------------------------------------------------------------------
    // frame status cache not full incremented
    //-------------------------------------------------------------------
    assign cswad_i = cswad + 1 ;

    //-------------------------------------------------------------------
    // frame status cache not full registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : csnf_reg_proc
        if (rst == 1'b0)
        begin
            csnf <= 1'b0 ; 
        end
        else
        begin
            if (cswad_i == csrad)
            begin
                csnf <= 1'b0 ; 
            end
            else
            begin
                csnf <= 1'b1 ; 
            end 
        end 
    end // csnf_reg_proc

    //-------------------------------------------------------------------
    // frame length binary combinatorial
    //-------------------------------------------------------------------
    always @(fli_r)
    begin : flibin_proc
        reg[13:0] flibin_v; 
        flibin_v[13] = fli_r[13]; 
        begin : xhdl_13
            integer i;
            for(i = 12; i >= 0; i = i - 1)
            begin
                flibin_v[i] = flibin_v[i + 1] ^ fli_r[i]; 
            end
        end 
        flibin_c <= flibin_v ; 
    end // flibin_proc

    //-------------------------------------------------------------------
    // fifo addresses binary registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : flibin_reg_proc
        if (rst == 1'b0)
        begin
            fli_r <= {14{1'b0}} ; 
            flibin <= {14{1'b0}} ; 
        end
        else
        begin
            fli_r <= fli ; 
            flibin <= flibin_c ; 
        end 
    end // flibin_reg_proc
    //-------------------------------------------------------------------
    // frame status cache not empty
    // registered output
    //-------------------------------------------------------------------
    assign cachene = csne ;
    //-------------------------------------------------------------------
    // frame status cache not full
    // registered output
    //-------------------------------------------------------------------
    assign cachenf = csnf ;
    //-------------------------------------------------------------------
    // frame status cache write enable
    //-------------------------------------------------------------------
    assign cswe = rireq_r & ~iriack ;
    //-------------------------------------------------------------------
    // frame status cache data output
    //-------------------------------------------------------------------
    assign csdo = csmem[csrad_r] ;
    //-------------------------------------------------------------------
    // frame status cache data input
    //-------------------------------------------------------------------
    assign csdi = {ffi, rfi, mfi, tli, rei, dbi, cei, ovi, csi, flibin} ;
    //-------------------------------------------------------------------
    // filtering fail
    // combinatorial output
    //-------------------------------------------------------------------
    assign ffo = csdo[CSWIDTH - 1] ;
    //-------------------------------------------------------------------
    // runt frame
    // combinatorial output
    //-------------------------------------------------------------------
    assign rfo = csdo[CSWIDTH - 2] ;
    //-------------------------------------------------------------------
    // multicast frame
    // combinatorial output
    //-------------------------------------------------------------------
    assign mfo = csdo[CSWIDTH - 3] ;
    //-------------------------------------------------------------------
    // too long
    // combinatorial output
    //-------------------------------------------------------------------
    assign tlo = csdo[CSWIDTH - 4] ;
    //-------------------------------------------------------------------
    // report on mii error
    // combinatorial output
    //-------------------------------------------------------------------
    assign reo = csdo[CSWIDTH - 5] ;
    //-------------------------------------------------------------------
    // report on gmii/mii error
    // combinatorial output
    //-------------------------------------------------------------------
    assign dbo = csdo[CSWIDTH - 6] ;
    //-------------------------------------------------------------------
    // crc error
    // combinatorial output
    //-------------------------------------------------------------------
    assign ceo = csdo[CSWIDTH - 7] ;
    //-------------------------------------------------------------------
    // fifo overflow
    // combinatorial output
    //-------------------------------------------------------------------
    assign ovo = csdo[CSWIDTH - 8] ;
    //-------------------------------------------------------------------
    // collision seen
    // combinatorial output
    //-------------------------------------------------------------------
    assign cso = csdo[CSWIDTH - 9] ;
    //-------------------------------------------------------------------
    // frame length
    // combinatorial output
    //-------------------------------------------------------------------
    assign flo = csdo[13:0] ;
    //-------------------------------------------------------------------
    // frame status cache read enable
    //-------------------------------------------------------------------
    assign csre = cachere ;

    //-------------------------------------------------------------------
    //                            rc status                            --
    //-------------------------------------------------------------------
    //-------------------------------------------------------------------
    // interrupt registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : rireq_reg_proc
        if (rst == 1'b0)
        begin
            rireq_r <= 1'b0 ; 
        end
        else
        begin
            rireq_r <= rireq ; 
        end 
    end // rireq_reg_proc

    //-------------------------------------------------------------------
    // receive acknowledge
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : irecack_reg_proc
        if (rst == 1'b0)
        begin
            iriack <= 1'b0 ; 
        end
        else
        begin
            iriack <= rireq_r ; 
        end 
    end // irecack_reg_proc
    //-------------------------------------------------------------------
    // interrupt acknowledge
    // registered output
    //-------------------------------------------------------------------
    assign riack = iriack ;

    //===================================================================--
    //                                fifo                               --
    //===================================================================--
    //-------------------------------------------------------------------
    // fifo read address combinatorial
    //-------------------------------------------------------------------
    always @(rad or fifore)
    begin : rad_proc
        rad_c <= rad ; 
        if (fifore == 1'b1)
        begin
            rad_c <= rad + 1 ; 
        end 
    end // rad_proc

    //-------------------------------------------------------------------
    // fifo read address registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : rad_reg_proc
        if (rst == 1'b0)
        begin
            rad <= {FIFODEPTH - 1-(0)+1{1'b0}} ; 
        end
        else
        begin
            rad <= rad_c ; 
        end 
    end 

    //-------------------------------------------------------------------
    // fifo read address grey coded registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : radg_reg_proc
        if (rst == 1'b0)
        begin
            radg <= {FIFODEPTH - 1-(0)+1{1'b0}} ; 
        end
        else
        begin
            radg[FIFODEPTH - 1] <= rad[FIFODEPTH - 1] ; 
            begin : xhdl_42
                integer i;
                for(i = FIFODEPTH - 2; i >= 0; i = i - 1)
                begin
                    radg[i] <= rad[i] ^ rad[i + 1] ; 
                end
            end 
        end 
    end // radg_reg_proc

    //-------------------------------------------------------------------
    // write address grey coded registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : wadg_reg_proc
        if (rst == 1'b0)
        begin
            wadg_r <= {FIFODEPTH - 1-(0)+1{1'b0}} ; 
        end
        else
        begin
            wadg_r <= wadg ; 
        end 
    end // wad_reg_proc

    //-------------------------------------------------------------------
    // write address binary combinatorial
    //-------------------------------------------------------------------
    always @(wadg_r)
    begin : wad_proc
        reg[FIFODEPTH - 1:0] wad_v; 
        wad_v[FIFODEPTH - 1] = wadg_r[FIFODEPTH - 1]; 
        begin : xhdl_46
            integer i;
            for(i = FIFODEPTH - 2; i >= 0; i = i - 1)
            begin
                wad_v[i] = wad_v[i + 1] ^ wadg_r[i]; 
            end
        end 
        wad_c <= wad_v ; 
    end // wad_proc

    //-------------------------------------------------------------------
    // fifo addresses binary registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : ad_reg_proc
        if (rst == 1'b0)
        begin
            wad <= {FIFODEPTH - 1-(0)+1{1'b0}} ; 
        end
        else
        begin
            wad <= wad_c ; 
        end 
    end // ad_reg_proc

    //-------------------------------------------------------------------
    // fifo status registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : stat_reg_proc
        if (rst == 1'b0)
        begin
            stat <= {FIFODEPTH - 1-(0)+1{1'b0}} ; 
        end
        else
        begin
            stat <= wad - rad ; 
        end 
    end // stat_reg_proc
    //-------------------------------------------------------------------
    // DP RAM address
    // combinatorial output
    //-------------------------------------------------------------------
    assign ramaddr = rad_c ;
    //-------------------------------------------------------------------
    // FIFO data
    // redirection
    //-------------------------------------------------------------------
    assign fifodata = ramdata ;

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
        end
        else
        begin
            stop_r <= stopi ; 
        end 
    end // stop_reg_proc

    //-------------------------------------------------------------------
    // stop receive process output
    // registered output
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : stopo_reg_proc
        if (rst == 1'b0)
        begin
            stopo <= 1'b0 ; 
        end
        else
        begin
            // can enter stopped state if the receive fifo
            // and the receive cache are both empty
            // i.e no frame waiting for transfer to the host
            if (stop_r == 1'b1 & stat == fzero & csne == 1'b0)
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
    //                               others                              --
    //===================================================================--
    assign fzero = {FIFODEPTH - 1-(0)+1{1'b0}} ;
endmodule
