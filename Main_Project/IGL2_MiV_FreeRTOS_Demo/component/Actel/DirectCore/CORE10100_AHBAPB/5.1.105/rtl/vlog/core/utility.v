    // ********************************************************************/ 
    // Copyright 2013 Microsemi Corporation.  All rights reserved.
    // IP Solutions Group
    //
    // ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
    // ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED 
    // IN ADVANCE IN WRITING.  
    //  
    // File:  utility.v
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
    // Project description  : Media Access Controller
    //
    // File name            : utility.vhd
    // File contents        : Package UTILITY
    // Purpose              : Constants for MAC
    //
    // Destination library  : work 
    // Dependencies         : IEEE.STD_LOGIC_1164
    //
    // Design Engineer      : T.K.
    // Quality Engineer     : M.B.
    // Version              : 2.00.E04
    // Last modification    : 2003-05-22
    //---------------------------------------------------------------------
    // *******************************************************************--
    // Modifications with respect to Version 2.00.E00:
    // 2.00.E01   :
    // 2003.03.21 : T.K. - references to MIIWIDTH=8 removed
    // 2003.03.21 : T.K. - unused CSR declarations removed
    // 2003.03.21 : T.K. - transmit state machine declaration removed
    // 2.00.E03   :
    // 2003.08.01 : T.K. - comments added    
    // 2.00.E06
    // 2004.01.20 : L.C. - SET0_RV set to 0x00000000 (F200.05.setup_status)
    // *******************************************************************--
    // *****************************************************************--
    //-----------------------------------------------------------------
    // 802.3 parameters
    //-----------------------------------------------------------------
    // interframe space 1 interval = 60 bit times
    parameter[3:0] IFS1_TIME = 4'b1110; 
    // interframe space 2 interval = 36 bit times
    parameter[3:0] IFS2_TIME = 4'b1000; 
    // slot time interfal =  512 bit times
    parameter[8:0] SLOT_TIME = 9'b001111111; 
    // maximum number of retransmission attempts = 16
    parameter[4:0] ATT_MAX = 5'b10000; 
    // proper crc remainder value = 0xc704dd7b
    parameter[31:0] CRCVAL = 32'b11000111000001001101110101111011; 
    // minimum frame size = 64
    parameter[6:0] MIN_FRAME = 7'b1000000; 
    // maximum ethernet frame length field value = 1500
    parameter[15:0] MAX_SIZE = 16'b0000010111011100; 
    // maximum frame size
    parameter[13:0] MAX_FRAME = 14'b00010111101111; // 1519
    //_________________________________________________________________
    // Control and Status Register summary
    //_________________________________________________________________
    // Register | ID  |      RV       | Description
    //_________________________________________________________________
    // CSR0     | 00h | fe000000h     | Bus mode
    // CSR1     | 08h | ffffffffh     | Transmit pool demand
    // CSR2     | 10h | ffffffffh     | Teceive pool demand
    // CSR3     | 18h | ffffffffh     | Receive list base address
    // CSR4     | 20h | ffffffffh     | Rransmit list base address
    // CSR5     | 28h | f0000000h     | Status
    // CSR6     | 30h | 32000040h     | Operation mode
    // CSR7     | 38h | f3fe0000h     | Interrupt enable
    // CSR8     | 40h | e0000000h     | Missed frames and overflow cnt
    // CSR9     | 48h | fff483ffh     | MII management
    // CSR11    | 58h | fffe0000h     | Timer and interrupt mitigation
    //_________________________________________________________________
    //-----------------------------------------------------------------
    // Special Function Register locations and reset values
    //-----------------------------------------------------------------
    // CSR0     : 00h : fe000000h     : Bus mode
    parameter[5:0] CSR0_ID = 6'b000000; 
    // CSR0 reset value
    parameter[31:0] CSR0_RV = 32'b11111110000000000000000000000000; 
    // CSR1     : 08h : ffffffffh     : Transmit pool demand
    parameter[5:0] CSR1_ID = 6'b000010; 
    // CSR1 reset value
    parameter[31:0] CSR1_RV = 32'b11111111111111111111111111111111; 
    // CSR2     : 10h : ffffffffh     : Receive pool demand
    parameter[5:0] CSR2_ID = 6'b000100; 
    // CSR2 reset value
    parameter[31:0] CSR2_RV = 32'b11111111111111111111111111111111; 
    // CSR3     : 18h : ffffffffh     : Receive list base address
    parameter[5:0] CSR3_ID = 6'b000110; 
    // CSR3 reset value
    parameter[31:0] CSR3_RV = 32'b11111111111111111111111111111111; 
    // CSR4     : 20h : ffffffffh     : Transmit list base address
    parameter[5:0] CSR4_ID = 6'b001000; 
    // CSR4 reset value
    parameter[31:0] CSR4_RV = 32'b11111111111111111111111111111111; 
    // CSR5     : 28h : f0000000h     : Status
    parameter[5:0] CSR5_ID = 6'b001010; 
    // CSR5 reset value
    parameter[31:0] CSR5_RV = 32'b11110000000000000000000000000000; 
    // CSR6     : 30h : 32000040h     : Operation mode
    parameter[5:0] CSR6_ID = 6'b001100; 
    // CSR6 reset value
    parameter[31:0] CSR6_RV = 32'b00110010000000000000000001000000; 
    // CSR7     : 38h : f3fe0000h     : Interrupt enable
    parameter[5:0] CSR7_ID = 6'b001110; 
    // CSR7 reset value
    parameter[31:0] CSR7_RV = 32'b11110011111111100000000000000000; 
    // CSR8     : 40h : e0000000h     : Missed frames and overflow cnt
    parameter[5:0] CSR8_ID = 6'b010000; 
    // CSR8 reset value
    parameter[31:0] CSR8_RV = 32'b11100000000000000000000000000000; 
    // CSR9     : 48h : fff483ffh     : MII menagement
    parameter[5:0] CSR9_ID = 6'b010010; 
    // CSR9 reset value
    parameter[31:0] CSR9_RV = 32'b11111111111101001000001111111111; 
    // CSR11    : 58h : fffe0000h     : Timer and interrupt mitigation
    parameter[5:0] CSR11_ID = 6'b010110; 
    // CSR11 reset value
    parameter[31:0] CSR11_RV = 32'b11111111111111100000000000000000; 
    // TDES0
    parameter[31:0] TDES0_RV = 32'b00000000000000000000000000000000; 
    // SET0
    parameter[31:0] SET0_RV = 32'b00000000000000000000000000000000; 
    // RDES0
    parameter[31:0] RDES0_RV = 32'b00000000000000000000000000000000; 
    //-----------------------------------------------------------------
    // Internal interface parameters
    //-----------------------------------------------------------------
    // Filtering RAM address width NOTE THESE ARE HARD CODED AT TOP LEVELS
    parameter ADDRDEPTH = 6; 
    // Filtering RAM data width
    parameter ADDRWIDTH = 16; 
    // Maximum FIFO depth
    parameter FIFODEPTH_MAX = 15; 
    // Maximum Data interface address width
    parameter DATADEPTH_MAX = 32; 
    // Maximum Data interface width
    parameter DATAWIDTH_MAX = 32; 
    //-----------------------------------------------------------------
    // Filtering modes
    //-----------------------------------------------------------------
    // Filtering mode - PREFECT --
    parameter[1:0] FT_PERFECT = 2'b00; 
    // Filtering mode - HASH --
    parameter[1:0] FT_HASH = 2'b01; 
    // Filtering mode - INVERSE --
    parameter[1:0] FT_INVERSE = 2'b10; 
    // Filtering mode - HONLY --
    parameter[1:0] FT_HONLY = 2'b11; 
    //-----------------------------------------------------------------
    // Phisical address position in setup frame
    //-----------------------------------------------------------------
    parameter[5:0] PERF1_ADDR = 6'b100111; 
    //-----------------------------------------------------------------
    // Ethernet frame fields
    //-----------------------------------------------------------------
    // jam field pattern
    parameter[63:0] JAM_PATTERN = 64'b1010101010101010101010101010101010101010101010101010101010101010; 
    // preamble field pattern
    parameter[63:0] PRE_PATTERN = 64'b0101010101010101010101010101010101010101010101010101010101010101; 
    // start of frame delimiter pattern
    parameter[63:0] SFD_PATTERN = 64'b1101010111010101110101011101010111010101110101011101010111010101; 
    // padding field pattern
    parameter[63:0] PAD_PATTERN = 64'b0000000000000000000000000000000000000000000000000000000000000000; 
    // carrier extension pattern
    parameter[63:0] EXT_PATTERN = 64'b0000111100001111000011110000111100001111000011110000111100001111; 
    //-----------------------------------------------------------------
    // Enumeration types
    //-----------------------------------------------------------------
    // DMA state machine
    parameter[1:0] DSM_IDLE = 0; 
    parameter[1:0] DSM_CH1 = 1; 
    parameter[1:0] DSM_CH2 = 2; 
    // process state machine type for HC
    parameter[1:0] PSM_RUN = 0; 
    parameter[1:0] PSM_SUSPEND = 1; 
    parameter[1:0] PSM_STOP = 2; 
    // receive state machine for HC
    // trying to acquire free descriptor
    // trying to acquire free descriptor
    // receiving frame
    // storing frame
    // status of the frame
    parameter[2:0] RSM_IDLE = 0; 
    parameter[2:0] RSM_ACQ1 = 1; 
    parameter[2:0] RSM_ACQ2 = 2; 
    parameter[2:0] RSM_REC = 3; 
    parameter[2:0] RSM_STORE = 4; 
    parameter[2:0] RSM_STAT = 5; 
    // linked list state machine for HC
    // des0 prefetching
    // des0 fetching
    // des1 fetching
    // des2 fetching
    // des3 fetching
    // buffer 1 fetching
    // buffer 2 fetching
    // descriptor status storing
    // frame status storing
    // next descriptor's address computing
    parameter[3:0] LSM_IDLE = 0; 
    parameter[3:0] LSM_DES0P = 1; 
    parameter[3:0] LSM_DES0 = 2; 
    parameter[3:0] LSM_DES1 = 3; 
    parameter[3:0] LSM_DES2 = 4; 
    parameter[3:0] LSM_DES3 = 5; 
    parameter[3:0] LSM_BUF1 = 6; 
    parameter[3:0] LSM_BUF2 = 7; 
    parameter[3:0] LSM_STAT = 8; 
    parameter[3:0] LSM_FSTAT = 9; 
    parameter[3:0] LSM_NXT = 10; 

    // descriptor's control state machine for HC
    // first descriptor
    // intermediate descriptor
    // last descriptor
    // first and last descriptor
    // setup frame descriptor
    // invalid descriptor
    parameter[2:0] CSM_IDLE = 0; 
    parameter[2:0] CSM_F = 1; 
    parameter[2:0] CSM_I = 2; 
    parameter[2:0] CSM_L = 3; 
    parameter[2:0] CSM_FL = 4; 
    parameter[2:0] CSM_SET = 5; 
    parameter[2:0] CSM_BAD = 6; 
    // master interface state machine for HC
    parameter[1:0] MSM_IDLE = 0; 
    parameter[1:0] MSM_REQ = 1; 
    parameter[1:0] MSM_BURST = 2; 
    // receive state machine for RC
    // flushing received frame from fifo
    parameter[3:0] RSM_IDLE_RCSMT = 0; 
    parameter[3:0] RSM_SFD = 1; 
    parameter[3:0] RSM_DEST = 2; 
    parameter[3:0] RSM_SOURCE = 3; 
    parameter[3:0] RSM_LENGTH = 4; 
    parameter[3:0] RSM_INFO = 5; 
    parameter[3:0] RSM_SUCC = 6; 
    parameter[3:0] RSM_INT = 7; 
    parameter[3:0] RSM_INT1 = 8; 
    parameter[3:0] RSM_BAD = 9; 
    // address filtering state machine
    // checking single physical address
    // checking 16 addresses
    // hash fitering
    // address match
    // address failed
    parameter[2:0] FSM_IDLE = 0; 
    parameter[2:0] FSM_PERF1 = 1; 
    parameter[2:0] FSM_PERF16 = 2; 
    parameter[2:0] FSM_HASH = 3; 
    parameter[2:0] FSM_MATCH = 4; 
    parameter[2:0] FSM_FAIL = 5; 
    // deffering state machine for TC
    // end of IFS, waiting for pending frame
    // calculating interframe space time 1
    // calculating interframe space time 2
    parameter[1:0] DSM_WAIT = 0; 
    parameter[1:0] DSM_IFS1 = 1; 
    parameter[1:0] DSM_IFS2 = 2; 
    // transmit state machine for TC
    parameter[3:0] TSM_IDLE = 0; 
    parameter[3:0] TSM_PREA = 1; 
    parameter[3:0] TSM_SFD = 2; 
    parameter[3:0] TSM_INFO = 3; 
    parameter[3:0] TSM_PAD = 4; 
    parameter[3:0] TSM_CRC = 5; 
    parameter[3:0] TSM_BURST = 6; 
    parameter[3:0] TSM_JAM = 7; 
    parameter[3:0] TSM_FLUSH = 8; 
    parameter[3:0] TSM_INT = 9; 

    //-------------------------------------------------------------------
    // Handle UNSIGNED to std_logic_vector conversions
    //
/*    function [31:0] to_std_logic;
        input x; 
           to_std_logic = x; 
    endfunction

    function [31:0] to_unsigned;
        input x; 
           to_unsigned = x; 
    endfunction

    function  to_logic;
        input x; 
            to_logic = x; 
    endfunction

    function [31:0] to_logic_xhdl2;
        input x; 
        integer x;

        reg y; 

        begin
            y = 1'b0; 
            if (x == 1)
            begin
                y = 1'b1; 
            end 
            to_logic_xhdl2 = y; 
        end
    endfunction

    function integer to_integer;
        input x; 

        integer y; 

        begin
            if (x)
            begin
                y = 1; 
            end
            else
            begin
                y = 0; 
            end 
            to_integer = y; 
        end
    endfunction
   */
