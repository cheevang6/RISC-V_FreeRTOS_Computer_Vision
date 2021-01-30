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
// File:  dma.v
//     
// Description: Core10100
//              See below  
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
// File name            : dma.vhd
// File contents        : Entity DMA
//                        Architecture RTL of HC
// Purpose              : DMA Controller for MAC
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
// 2003.03.21 : T.K. - big/little endian support added
// 2.00.E02   :
// 2003.04.15 : T.K. - dataible_proc changed
// 2003.04.15 : T.K. - dataoble_proc changed
// 2.00.E03   :
// 2003.05.12 : T.K. - datarw signal is now registered
// 2003.05.12 : T.K. - dataeob signal is now registered  
// 2.00.E06   :  
// 2004.01.20 : B.W. - RTL code chandes due to VN Check
//                     and code coverage (I200.06.vn):
//                      * chmux_proc process modified
// *******************************************************************--
// *****************************************************************--
module DMA (clk, rst, priority, ble, dbo, rdes, rbuf, rstat, 
            tdes, tbuf, tstat, 
            dataack, datai, datareq, datarw, dataeob, 
            dataeobe, datao, dataaddr, idataaddr,
            req1, write1, tcnt1, addr1, datai1, ack1, eob1, datao1, 
            req2, write2, tcnt2, addr2, datai2, ack2, eob2, datao2);

     // 8|16|32
    parameter DATAWIDTH = 16;
    parameter DATADEPTH = 32;
    parameter ENDIANESS = 0;

    `include "utility.v"

    input clk; 
    input rst; 
    input[1:0] priority; 
    input ble; 
    input dbo; 
    input rdes; 
    input rbuf; 
    input rstat; 
    input tdes; 
    input tbuf; 
    input tstat; 
    input dataack; 
    input[DATAWIDTH - 1:0] datai; 
    output datareq; 
    output datarw; 
    reg datarw;
    output dataeob; 
    wire dataeob;
    output dataeobe; 
    wire dataeobe;
    output[DATAWIDTH - 1:0] datao; 
    wire[DATAWIDTH - 1:0] datao;
    output[DATADEPTH - 1:0] dataaddr; 
    wire[DATADEPTH - 1:0] dataaddr;
    output[DATADEPTH - 1:0] idataaddr; 
    wire[DATADEPTH - 1:0] idataaddr;
    input req1; 
    input write1; 
    input[FIFODEPTH_MAX - 1:0] tcnt1; 
    input[DATADEPTH - 1:0] addr1; 
    input[DATAWIDTH - 1:0] datai1; 
    output ack1; 
    wire ack1;
    output eob1; 
    wire eob1;
    output[DATAWIDTH - 1:0] datao1; 
    wire[DATAWIDTH - 1:0] datao1;
    input req2; 
    input write2; 
    input[FIFODEPTH_MAX - 1:0] tcnt2; 
    input[DATADEPTH - 1:0] addr2; 
    input[DATAWIDTH - 1:0] datai2; 
    output ack2; 
    wire ack2;
    output eob2; 
    wire eob2;
    output[DATAWIDTH - 1:0] datao2; 
    wire[DATAWIDTH - 1:0] datao2;

    // dma state machine combinatorial
    reg[1:0] dsm_c; 
    // dma state machine registered
    reg[1:0] dsm; 
    // dma history1 registered
    reg hist1; 
    // dma history2 registered
    reg hist2; 
    // dma requests
    wire[1:0] dmareq; 
    // burst transfer word counter
    reg[FIFODEPTH_MAX - 1:0] msmbcnt; 
    // data request 
    wire datareq;
    // data request registered
    reg idatareq; 
    reg idatareq_r1; 
    reg idatareq_r2; 
    // end of burst registered
    reg eob; 
    reg eobe; 
    // data address combinatorial
    reg[DATADEPTH - 1:0] addr_c; 
    // data address registered
    reg[DATADEPTH - 1:0] addr; 
    // big/little endian selection
    reg blesel_c; 
    // data input after big/little endian conversion
    reg[DATAWIDTH - 1:0] dataible_c; 
    // data output after big/little endian conversion
    reg[DATAWIDTH - 1:0] dataoble_c; 
    // datai of maximum length
    wire[DATAWIDTH_MAX:0] datai_max; 
    // request combinatorial
    reg req_c; 
    // write selection combinatorial
    reg write_c; 
    // transfer count combinatorial
    reg[FIFODEPTH_MAX - 1:0] tcnt_c; 
    // start address combinatorial
    reg[DATADEPTH - 1:0] saddr_c; 
    // data input combinatorial
    reg[DATAWIDTH - 1:0] datai_c; 
    // data input combinatorial of maximum length
    wire[DATAWIDTH_MAX:0] datai_max_c; 
    // zero vector of FIFODEPTH_MAX length
    wire[FIFODEPTH_MAX - 1:0] fzero; 
    // zero vector of DATAWIDTH_MAX length
    wire[DATAWIDTH_MAX:0] dzero_max; 
    wire[FIFODEPTH_MAX - 1:0] ZERO; 
    wire[FIFODEPTH_MAX - 1:0] ONE; 
    wire[FIFODEPTH_MAX - 1:0] TWO; 
    wire[FIFODEPTH_MAX - 1:0] THREE; 

    assign ZERO  = 0;
    assign ONE   = 1;
    assign TWO   = 2;
    assign THREE = 3;

    //-------------------------------------------------------------------
    // dma requests
    //-------------------------------------------------------------------
    assign dmareq = {req2, req1} ;

    //-------------------------------------------------------------------
    // dma state machine combinatorial
    //-------------------------------------------------------------------
    always @(dsm or dmareq or hist1 or hist2 or priority or eob or dataack)
    begin : dsm_proc
        case (dsm)
            DSM_IDLE :
                        begin
                            case (dmareq)
                                //-----------------------------------------
                                2'b11 :
                                            begin
                                                //-----------------------------------------
                                                case (priority)
                                                    //---------------------------------
                                                    2'b01 :
                                                                begin
                                                                    //---------------------------------
                                                                    if (hist1 == 1'b0 & hist2 == 1'b0)
                                                                    begin
                                                                        dsm_c <= DSM_CH2 ; 
                                                                    end
                                                                    else
                                                                    begin
                                                                        dsm_c <= DSM_CH1 ; 
                                                                    end 
                                                                end
                                                    //---------------------------------
                                                    2'b10 :
                                                                begin
                                                                    //---------------------------------
                                                                    if (hist1 == 1'b1 & hist2 == 1'b1)
                                                                    begin
                                                                        dsm_c <= DSM_CH1 ; 
                                                                    end
                                                                    else
                                                                    begin
                                                                        dsm_c <= DSM_CH2 ; 
                                                                    end 
                                                                end
                                                    //---------------------------------
                                                    default :
                                                                begin
                                                                    // "00"
                                                                    //---------------------------------
                                                                    if (hist1 == 1'b1)
                                                                    begin
                                                                        dsm_c <= DSM_CH1 ; 
                                                                    end
                                                                    else
                                                                    begin
                                                                        dsm_c <= DSM_CH2 ; 
                                                                    end 
                                                                end
                                                endcase 
                                            end
                                2'b01 :
                                            begin
                                                dsm_c <= DSM_CH1 ; 
                                            end
                                2'b10 :
                                            begin
                                                dsm_c <= DSM_CH2 ; 
                                            end
                                default :
                                            begin
                                                dsm_c <= DSM_IDLE ; 
                                            end
                            endcase 
                        end
            //-----------------------------------------
            DSM_CH1 :
                        begin
                            //-----------------------------------------
                            if (eob == 1'b1 & dataack == 1'b1)
                            begin
                                dsm_c <= DSM_IDLE ; 
                            end
                            else
                            begin
                                dsm_c <= DSM_CH1 ; 
                            end 
                        end
            //-----------------------------------------
            default :
                        begin
                            // DSM_CH2
                            //-----------------------------------------
                            if (eob == 1'b1 & dataack == 1'b1)
                            begin
                                dsm_c <= DSM_IDLE ; 
                            end
                            else
                            begin
                                dsm_c <= DSM_CH2 ; 
                            end 
                        end
        endcase 
    end // dsm_proc

    //------------------------------------------------------------------
    // dma state machine registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : dsm_reg_proc
        if (rst == 1'b0)
        begin
            dsm <= DSM_IDLE ; 
        end
        else
        begin
            dsm <= dsm_c ; 
        end 
    end // dsm_proc

    //-------------------------------------------------------------------
    // dma history registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : hist_reg_proc
        if (rst == 1'b0)
        begin
            hist1 <= 1'b1 ; 
            hist2 <= 1'b1 ; 
        end
        else
        begin
            if (eob == 1'b1)
            begin
                case (dsm)
                    DSM_CH1 :
                                begin
                                    hist1 <= 1'b1 ; 
                                end
                    DSM_CH2 :
                                begin
                                    hist1 <= 1'b0 ; 
                                end
                    default :
                                begin
                                    hist1 <= hist1 ; 
                                end
                endcase 
            end 
            hist2 <= hist1 ; 
        end 
    end // hist_reg_proc

    // big/little endian selection
    // -------------------------------------------------------------------
    always @(dbo or ble or dsm_c or dsm or tdes or tbuf or tstat or rdes or 
             rbuf or rstat)
    begin : blesel_proc
        if (dsm_c == DSM_CH1 | dsm == DSM_CH1)
        begin
            if ((tbuf == 1'b1 & ble == 1'b1) | ((tdes == 1'b1 | tstat == 1'b1) & dbo == 1'b1))
            begin
                blesel_c <= 1'b1 ; 
            end
            else
            begin
                blesel_c <= 1'b0 ; 
            end 
        end
        else
        begin
            if ((rbuf == 1'b1 & ble == 1'b1) | ((rdes == 1'b1 | rstat == 1'b1) & dbo == 1'b1))
            begin
                blesel_c <= 1'b1 ; 
            end
            else
            begin
                blesel_c <= 1'b0 ; 
            end 
        end 
        case (ENDIANESS)
            // force endianess setting
            1 :
                        begin
                            blesel_c <= 1'b0 ; 
                        end
            2 :
                        begin
                            blesel_c <= 1'b1 ; 
                        end
            default :
                        begin
                        end
        endcase 
    end // blesel_proc

    //-------------------------------------------------------------------
    // channel mux combinatorial
    //-------------------------------------------------------------------
    always @(dsm_c or dsm or req1 or write1 or tcnt1 or addr1 or datai1 or 
             req2 or write2 or tcnt2 or addr2 or datai2)
    begin : chmux_proc
        req_c <= req2 ; 
        write_c <= write2 ; 
        tcnt_c <= tcnt2 ; 
        saddr_c <= addr2 ; 
        datai_c <= datai2 ; 
        if (dsm_c == DSM_CH1 | dsm == DSM_CH1)
        begin
            req_c <= req1 ; 
            write_c <= write1 ; 
            tcnt_c <= tcnt1 ; 
            saddr_c <= addr1 ; 
            datai_c <= datai1 ; 
        end 
    end // chmux_proc
    //-------------------------------------------------------------------
    // data input combinatorial of maximum length
    //-------------------------------------------------------------------
    assign datai_max_c = {dzero_max[DATAWIDTH_MAX:DATAWIDTH], datai_c} ;

    //-------------------------------------------------------------------
    // data output big/little endian
    //-------------------------------------------------------------------
    always @(datai_max_c or blesel_c)
    begin : dataoble_proc
        case (DATAWIDTH)
            //-----------------------------------------
            32 :
                        begin
                            //-----------------------------------------
                            if (blesel_c == 1'b1)
                            begin
                                dataoble_c <= {datai_max_c[7:0], datai_max_c[15:8], datai_max_c[23:16], datai_max_c[31:24]} ; 
                            end
                            else
                            begin
                                dataoble_c <= datai_max_c[31:0] ; 
                            end 
                        end
            //-----------------------------------------
            16 :
                        begin
                            //-----------------------------------------
                            if (blesel_c == 1'b1)
                            begin
                                dataoble_c <= {datai_max_c[7:0], datai_max_c[15:8]} ; 
                            end
                            else
                            begin
                                dataoble_c <= datai_max_c[15:0] ; 
                            end 
                        end
            //-----------------------------------------
            default :
                        begin
                            // 8
                            //-----------------------------------------
                            dataoble_c <= datai_max_c[7:0] ; 
                        end
        endcase 
    end // dataoble_proc
    //-------------------------------------------------------------------
    // datai of maximum length
    //-------------------------------------------------------------------
    assign datai_max = {dzero_max[DATAWIDTH_MAX:DATAWIDTH], datai} ;

    //-------------------------------------------------------------------
    // data input big/little endian
    //-------------------------------------------------------------------
    always @(datai_max or blesel_c)
    begin : dataible_proc
        case (DATAWIDTH)
            //-----------------------------------------
            32 :
                        begin
                            //-----------------------------------------
                            if (blesel_c == 1'b1)
                            begin
                                dataible_c <= {datai_max[7:0], datai_max[15:8], datai_max[23:16], datai_max[31:24]} ; 
                            end
                            else
                            begin
                                dataible_c <= datai_max[31:0] ; 
                            end 
                        end
            //-----------------------------------------
            16 :
                        begin
                            //-----------------------------------------
                            if (blesel_c == 1'b1)
                            begin
                                dataible_c <= {datai_max[7:0], datai_max[15:8]} ; 
                            end
                            else
                            begin
                                dataible_c <= datai_max[15:0] ; 
                            end 
                        end
            //-----------------------------------------
            default :
                        begin
                            // 8
                            //-----------------------------------------
                            dataible_c <= datai_max[7:0] ; 
                        end
        endcase 
    end // dataible_proc

    //-------------------------------------------------------------------
    // master burst counter registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : msmbcnt_reg_proc
        if (rst == 1'b0)
        begin
            msmbcnt <= 0 ; 
            idatareq_r1 <=0;
            idatareq_r2 <=0;
        end
        else
        begin
          idatareq_r1 <=  idatareq;
          idatareq_r2 <=  idatareq_r1;
            if (idatareq == 1'b0 | idatareq_r2 == 1'b0)
            begin
                msmbcnt <= tcnt_c ; 
            end
            else if (dataack == 1'b1 & idatareq == 1'b1 & msmbcnt !=0)
            begin
                msmbcnt <= msmbcnt - 1 ; 
            end 
        end 
    end // msmbcnt_reg_proc

    //-------------------------------------------------------------------
    // data read/write
    // registered output
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : datarw_reg_proc
        if (rst == 1'b0)
        begin
            datarw <= 1'b1 ; 
        end
        else
        begin
            if (req_c == 1'b1)
            begin
                datarw <= ~write_c ; 
            end 
        end 
    end // datarw_reg_proc

    //-------------------------------------------------------------------
    // bus request registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : idatareq_reg_proc
        if (rst == 1'b0)
        begin
            idatareq <= 1'b0 ; 
        end
        else
        begin
            if (eob == 1'b1 & dataack == 1'b1 & idatareq == 1'b1)
            begin
                idatareq <= 1'b0 ; 
            end
            else if (req1 == 1'b1 | req2 == 1'b1)
            begin
                idatareq <= 1'b1 ; 
            end 
        end 
    end // idatareq_reg_proc
    //-------------------------------------------------------------------
    // data request
    // registered output
    //-------------------------------------------------------------------
    assign datareq = idatareq ;
    //-------------------------------------------------------------------
    // data end of burst
    // registered output
    //-------------------------------------------------------------------
    assign dataeob = eob ;
    //-------------------------------------------------------------------
    // data output channel1
    // combinatorial output
    //-------------------------------------------------------------------
    assign datao1 = dataible_c ;
    //-------------------------------------------------------------------
    // data output channel2
    // combinatorial output
    //-------------------------------------------------------------------
    assign datao2 = dataible_c ;
    //-------------------------------------------------------------------
    // data host output
    // combinatorial output
    //-------------------------------------------------------------------
    assign datao = dataoble_c ;

    //-------------------------------------------------------------------
    // data address combinatorial
    //-------------------------------------------------------------------
    always @(dataack or idatareq or addr or saddr_c or req_c or dsm)
    begin : addr_proc
        if (dataack == 1'b1 & idatareq == 1'b1)
        begin
            case (DATAWIDTH)
                //-----------------------------------
                8 :
                            begin
                                //-----------------------------------
                                addr_c <= addr + 1 ; 
                            end
                //-----------------------------------
                16 :
                            begin
                                //-----------------------------------
                                addr_c <= {addr[DATADEPTH - 1:1] + 1, 1'b0} ; 
                            end
                //-----------------------------------
                default :
                            begin
                                // 32
                                //-----------------------------------
                                addr_c <= {addr[DATADEPTH - 1:2] + 1, 2'b00} ; 
                            end
            endcase 
        end
        else if (req_c == 1'b1 & dsm == DSM_IDLE)
        begin
            addr_c <= saddr_c ; 
        end
        else
        begin
            addr_c <= addr ; 
        end 
    end // addr_proc

    //-------------------------------------------------------------------
    // data address registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : addr_reg_proc
        if (rst == 1'b0)
        begin
            addr <= {DATADEPTH{1'b1}} ; 
        end
        else
        begin
            addr <= addr_c ; 
        end 
    end // addr_proc
    //-------------------------------------------------------------------
    // data address
    // registered output
    //-------------------------------------------------------------------
    assign dataaddr = addr ;
    //-------------------------------------------------------------------
    // internal data address
    // combinatorial output
    //-------------------------------------------------------------------
    assign idataaddr = addr ;
    //-------------------------------------------------------------------
    // channel 1 acknowledge
    // combinatorial output
    //-------------------------------------------------------------------
    assign ack1 = (dataack == 1'b1 & dsm == DSM_CH1) ? 1'b1 : 1'b0 ;
    //-------------------------------------------------------------------
    // channel 2 acknowledge
    // combinatorial output
    //-------------------------------------------------------------------
    assign ack2 = (dataack == 1'b1 & dsm == DSM_CH2) ? 1'b1 : 1'b0 ;

    //-------------------------------------------------------------------
    // end of burst registered
    //-------------------------------------------------------------------
    always @(posedge clk or negedge rst)
    begin : eob_reg_proc
        if (rst == 1'b0)
        begin
            eob <= 1'b0 ; 
        end
        else
        begin
            if (req_c == 1'b1 | idatareq == 1'b1)
            begin
                if (  (idatareq == 1'b1 & (  msmbcnt == ZERO 
                                           | msmbcnt == ONE 
                                           | (msmbcnt == TWO & dataack == 1'b1)
                                          )
                      ) 
                    | (idatareq == 1'b0 & (  tcnt_c == ZERO 
                                           | tcnt_c == ONE)
                                          )
                      )
                begin
                    eob <= 1'b1 ; 
                end
                else
                begin
                    eob <= 1'b0 ; 
                end 
            end 
        end 
    end // eob_reg_proc

    // early eob signal to allow AHB master to stop 
    // Inserted for v3.0 of code
    always @(posedge clk or negedge rst)
    begin
        if (rst == 1'b0)
        begin
            eobe <= 1'b0 ; 
        end
        else
        begin
            if (req_c == 1'b1 | idatareq == 1'b1)
            begin
                if ((idatareq == 1'b1 & (msmbcnt == ZERO | msmbcnt == ONE | msmbcnt == TWO | (msmbcnt == THREE & dataack == 1'b1))) | (idatareq == 1'b0 & (tcnt_c == ZERO | tcnt_c == ONE | tcnt_c == TWO)))
                begin
                    // during burst
                    // starting transfer count
                    eobe <= 1'b1 ; 
                end
                else
                begin
                    eobe <= 1'b0 ; 
                end 
            end 
        end 
    end // eob_reg_proc
    assign dataeobe = eobe ;
    //-------------------------------------------------------------------
    // channel 1 end of burst
    // combinatorial output
    //-------------------------------------------------------------------
    assign eob1 = eob ;
    //-------------------------------------------------------------------
    // channel 2 end of burst
    // combinatorial output
    //-------------------------------------------------------------------
    assign eob2 = eob ;
    //-------------------------------------------------------------------
    // zero vector of FIFODEPTH_MAX length
    //-------------------------------------------------------------------
    assign fzero = 0 ;
    //-------------------------------------------------------------------
    // zero vector of DATAWIDTH_MAX length
    //-------------------------------------------------------------------
    assign dzero_max = 0 ;

endmodule
