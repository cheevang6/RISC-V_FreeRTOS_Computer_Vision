//
`timescale 1 ns / 100 ps
// ********************************************************************/ 
// Copyright 2013 Microsemi Corporation.  All rights reserved.
//
// ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
// ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED 
// IN ADVANCE IN WRITING.  
//  
// Description: Reset Controller
//                      
//
// Revision Information:
// Date     Description
// 18Oct07  Initial Release 
//
// SVN Revision Information:
// SVN $Revision: 6743 $
// SVN $Date $
//
// Resolved SARs
// SAR      Date     Who   Description
//
// Notes: 
//        
// *********************************************************************/
module RSTC (clkdma, clkcsr, clkr, rstcsr, rstsoft, hrstn, prstn, rrstn); 

    input clkdma; 
    input clkcsr; 
    input clkr; 
    input rstcsr; 
    input rstsoft; 
    output hrstn; 
    output prstn; 
    output rrstn; 

    // software reset registered in receive clock domain
    reg rstsoft_csr_syncr0 ;  
    reg rstsoft_csr_syncr ;  
    reg rstcsr_syncr0 ;  
    reg rstcsr_syncr ;  
    reg rrstn ; 
    // software reset registered in dma clock domain
    reg rstsoft_csr_syncdma0 ;  
    reg rstsoft_csr_syncdma ;  
    reg rstcsr_syncdma0 ;  
    reg rstcsr_syncdma ;  
    reg hrstn ; 
    // software reset registered in csr clock domain
    reg prstn ; 
    reg rstsoft_csr; 
    reg rrstn_sync0 ;  
    reg rrstn_sync ;  
    reg hrstn_sync0 ;  
    reg hrstn_sync ; 
    reg [4:0] count_csr; 
    reg [4:0] count_csrr; 
    reg [4:0] count_csrdma; 
    reg	rstcsr_en;
    reg	rstcsrr_en;
    reg	rstcsrdma_en;
    //===================================================================--
    //                         csr clock domain                          --
    //===================================================================--
    //-------------------------------------------------------------------
    // software reset registered in csr clock domain
    //-------------------------------------------------------------------
    always @(posedge clkcsr)
    begin : rstsoft_csr_reg_proc
        if (rstcsr == 1'b1)
        begin
            rstsoft_csr <= 1'b0 ; 
        end
        else
        begin
            // synchronous reset ----------------------
            if (rstsoft == 1'b1)
            begin
                rstsoft_csr <= 1'b1 ; 
            end
            else if (prstn == 1'b1 & rrstn_sync == 1'b1 & hrstn_sync == 1'b1)
            begin
                rstsoft_csr <= 1'b0 ; 
            end
        end  
    end // rstsoft_csr_reg_proc

    //-------------------------------------------------------------------
    // hardware/software reset registered in csr clock domain
    //-------------------------------------------------------------------
    always @(posedge clkcsr)
    begin : rstcsro_reg_proc
        prstn <= (~(rstcsr | rstsoft_csr) | rstcsr_en );  
	count_csr <= 0;
	rstcsr_en <= 1'b0;
	if (rstsoft_csr == 1'b1) 
         begin
           if (count_csr == 4) 
            begin
	      rstcsr_en <= 1'b1;
	      count_csr <= count_csr + 1;
	    end
           else if (count_csr == 5'b11111) 
            begin
	      count_csr <= 0;
	      rstcsr_en <= 1'b0;
	    end
	   else
            begin
	      count_csr <= count_csr + 1;
	      rstcsr_en <= rstcsr_en;
	    end
	 end
    end // rstcsro_reg_proc

    //-------------------------------------------------------------------
    // hardware/software reset registered in clkr clock domain
    //-------------------------------------------------------------------
    always @(posedge clkr)
    begin
        rstsoft_csr_syncr0 <= rstsoft_csr ;  
        rstsoft_csr_syncr <= rstsoft_csr_syncr0 ;  
        rstcsr_syncr0 <= rstcsr ;  
        rstcsr_syncr <= rstcsr_syncr0 ;  
        rrstn <= (~(rstcsr_syncr | rstsoft_csr_syncr) | rstcsrr_en );  
	count_csrr <= 0;
	rstcsrr_en <= 1'b0;
	if (rstsoft_csr_syncr == 1'b1) 
         begin
           if (count_csrr == 4) 
            begin
	      rstcsrr_en <= 1'b1;
	      count_csrr <= count_csrr + 1;
	    end
	  else if (count_csrr == 5'b11111) 
            begin
	      count_csrr <= 0;
	      rstcsrr_en <= 1'b0;
	    end
	   else
            begin
	      count_csrr <= count_csrr + 1;
	      rstcsrr_en <= rstcsrr_en;
	    end
	 end
    end // rstcsro_reg_proc

    //-------------------------------------------------------------------
    // hardware/software reset registered in dma clock domain
    //-------------------------------------------------------------------
    always @(posedge clkdma)
    begin 
        rstsoft_csr_syncdma0 <= rstsoft_csr ;  
        rstsoft_csr_syncdma <= rstsoft_csr_syncdma0 ;  
        rstcsr_syncdma0 <= rstcsr ;  
        rstcsr_syncdma <= rstcsr_syncdma0 ;  
        hrstn <= (~(rstcsr_syncdma | rstsoft_csr_syncdma) | rstcsrdma_en );  
	count_csrdma <= 0;
	rstcsrdma_en <= 1'b0;
	if (rstsoft_csr_syncdma == 1'b1) 
         begin
           if (count_csrdma == 4) 
            begin
 	      rstcsrdma_en <= 1'b1;
	      count_csrdma <= count_csrdma + 1;
	    end
           else if (count_csrdma == 5'b11111) 
            begin
	      count_csrdma <= 0;
	      rstcsrdma_en <= 1'b0;
	    end
	   else
            begin
	      count_csrdma <= count_csrdma + 1;
	      rstcsrdma_en <= rstcsrdma_en;

	    end
	 end
    end // rstcsro_reg_proc

    //===================================================================--
    //-------------------------------------------------------------------
    // Synchronization of different resets in pclk domain
    //-------------------------------------------------------------------
    always @(posedge clkcsr)
    begin : rstrc_reg_proc
        rrstn_sync0 <= rrstn ;  
        rrstn_sync <= rrstn_sync0 ;  
        hrstn_sync0 <= hrstn ;  
        hrstn_sync <= hrstn_sync0 ;  
    end // rstrc_rst_proc

endmodule
