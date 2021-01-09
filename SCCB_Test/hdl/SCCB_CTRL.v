// SCCB_CTRL.v

// 2-Wire SCCB Interface only
module SCCB_CTRL
(
    input            XCLK,       // Master clock to camera
                     RST_N,      // Reset 
    //               PWDN,       // Power down (camera)
    //input            RW,         // Read/Write request
    input reg  [7:0] data_in,    // Data write to register
    input reg  [7:0] addr_id,    // Device ID + RW signal
    input reg  [7:0] addr_reg,   // Register address
    output reg [7:0] data_out,   // Data read from register
    //output VSYNC, HREF, PCLK,  // used when retrieving pixels
    inout            SIO_D,      // SCCB data
    output reg       SIO_C       // SCCB clock
);

/* SCCB_E
   - driven by master (active-low)
   - indicates start or stop of data transmission
   - H-to-L transition indicates start, while L-to-H indicates stop
   - must remain logical 0 during data transmission
   - logical 1 = bus is idle
   - in 2-wire, SCCB_E is not available (default: enabled and held low)
*/
 
 /* SIO_C
    - driven by master (active-high)
    - indicates each transmistted bit
    - master drives it at logical 1 when bus is idle
    - data transmission starts when SIO_C is driven at logical 0 after start transmission
    - logical 1 during transmission indicates single transmitted bit
       --> SIO_D can occur only when SIO_C is driven at 0
    - period of single transmitted bit = t_CYC = 10 us (typical)
       --> frequency of 100kHz
*/

/* SIO_D
   - bi-directional
   - remains floating or tri-state when bus is idle
   - bus float and contention are allowed during transmission of DC or NA bits
   - Don't Care (DC)
      - ninth-bit of master-issude transmission
      - purpose of DC bit is to indicate completion of transmission
      - slave(s) responding to DC bit
        (1) if slave 1 is selected and data is written to specific slave,
            slave 1 will drive SIO_D to 0 for DC bit
        (2) slave(s) do not respond to DC bit of current phase (SIO_D must remain
            at float for whole DC bit)
*/

/* Start transmission
   SIO_D = 1 (driven to 1 for min of tPRC = 15 ns)
   SCCB_E high-to-low (3-wire, but since this is 2-wire not neccessary)
   SIO_C = 0 (after start of transmission)
*/
    

    // Generating clock for SCCB
    // Depending on the device, the SIO_C can go up to 40MHz
    localparam XCLK_FREQ = 50_000_000;                          // incoming clock = XCLK = 50MHz 
    localparam SCCB_CLK_FREQ = 100_000;                         // divide clock such that SIO_C = 100kHz
    localparam SCCB_CLK_PERIOD = XCLK_FREQ/SCCB_CLK_FREQ/2;     // number of clocks to obtain 100kHz
    localparam SCCB_MID_AMT = SCCB_CLK_PERIOD/2-1;              // impulse signfying the mid of SCCB_clk
    reg [$clog2(SCCB_CLK_PERIOD):0] SCCB_CLK_CNTR = 0;
    reg SCCB_CLK;
    reg SCCB_MID_PULSE;

    always @(posedge XCLK or negedge RST_N) begin
        if(!RST_N) begin // RST is acitve-low
            SCCB_CLK_CNTR <=0;
            SCCB_CLK <= 0;
        end else begin
            if(SCCB_CLK_CNTR < SCCB_CLK_PERIOD) begin
                SCCB_CLK_CNTR <= SCCB_CLK_CNTR + 1;
            end else begin
                SCCB_CLK_CNTR <= 0;
                SCCB_CLK <= ~SCCB_CLK;
            end
            if(SCCB_CLK_CNTR == SCCB_MID_AMT && SCCB_CLK == 0) begin
                SCCB_MID_PULSE = 1'b1;
            end else begin
                SCCB_MID_PULSE = 1'b0;
            end
        end
    end
    
    reg [7:0] step;     // state machine identifier
    reg idle;
    reg data_send;      // data to send through SCCB
    reg sccb_clk_step;
//    reg start;
//    reg RW;
    
    // start signal
//    assign start = (SIO_D && !SIO_C)? 1: 0;
    // read/write signal
//    assign RW = addr_id[7];
    // tristate SIO_D bus when idle
    assign SIO_D = (idle) ? 1'bz : data_send;
    // SIO_C is driven high when idle
    assign SIO_C = (idle) ? sccb_clk_step : SCCB_CLK;
    
    // To determine which state to go to
    always @(posedge SCCB_CLK or negedge RST_N) begin
        // I'm not sure about this part yet
        if(!RST_N)
            step <= 7'd0;
        else if(addr_id[7] == 0 && step == 7'd20) // 3-phase write
            step <= 7'd39; // stop transmission after write
//        else if(RW == 1 && step == 7'd29) // 2-phase write
//            step <= 7'd30; // go directly to 2-phases read
//        else if(RW == 1 && step == 7'd38) // 2-phase read
//            step <= 7'd39; // stop transmission after read
        else if(step > 42)
            step <= 7'd0;
        else
            step <= step + 1;
    end
    
    always @(posedge XCLK or negedge RST_N) begin
        if(!RST_N) begin
            data_send <= 0;
            data_out <= 0;
            sccb_clk_step <= 1;
            idle <= 1;
        end else if(SCCB_MID_PULSE) begin
            // default values
            
            // Note: I will number the states once I finalize total states required
            case(step)
                // initialize
                7'd0  : data_send <= 1;
                
                // start transaction
                7'd1  : data_send <= 1;
                7'd2  : begin
                    sccb_clk_step <= 0;
                    idle <= 0;
                end
                
                // write device's ID address (write 0x60 OV2640)
                7'd3  : data_send <= addr_id[7];
                7'd4  : data_send <= addr_id[6];
                7'd5  : data_send <= addr_id[5];
                7'd6  : data_send <= addr_id[4];
                7'd7  : data_send <= addr_id[3];
                7'd8  : data_send <= addr_id[2];
                7'd9  : data_send <= addr_id[1];
                7'd10 : data_send <= addr_id[0]; // read/write bit
                7'd11 : data_send <= 0;// Don't care bit
                
                // write to reg address
                7'd12 : data_send <= addr_reg[7];
                7'd13 : data_send <= addr_reg[6];
                7'd14 : data_send <= addr_reg[5];
                7'd15 : data_send <= addr_reg[4];
                7'd16 : data_send <= addr_reg[3];
                7'd17 : data_send <= addr_reg[2];
                7'd18 : data_send <= addr_reg[1];
                7'd19 : data_send <= addr_reg[0];
                7'd20 : data_send <= 0; // Don't care bit
                
                // write data
                7'd21 : data_send <= data_in[7];
                7'd22 : data_send <= data_in[6];
                7'd23 : data_send <= data_in[5];
                7'd24 : data_send <= data_in[4];
                7'd25 : data_send <= data_in[3];
                7'd26 : data_send <= data_in[2];
                7'd27 : data_send <= data_in[1];
                7'd28 : data_send <= data_in[0];
                7'd29 : data_send <= 0; // Don't care bit
                
                // read data (Recall: 2-phase is write-to-reg-address then read)
                // hence, if read it must go to write device's ID first then jump to here
                7'd30 : data_out <= SIO_D;
                7'd31 : data_out <= SIO_D;
                7'd32 : data_out <= SIO_D;
                7'd33 : data_out <= SIO_D;
                7'd34 : data_out <= SIO_D;
                7'd35 : data_out <= SIO_D;
                7'd36 : data_out <= SIO_D;
                7'd37 : data_out <= SIO_D;
                7'd38 : data_out <= 1; // Don't care bit (Driven to 1 during read by master)
                
                // stop transaction
                // SIO_C = 1
                // SIO_D = 1 (for tPCS = 15ns) before SCCB_E deasserted
                7'd39 : sccb_clk_step <= 0;
                7'd40 : sccb_clk_step <= 1;
                7'd41 : data_send <= 1;
                
                // go into idle
                7'd42 : idle <= 1;
                
                default: begin
                    sccb_clk_step <= 1;
                    idle <= 1;
                end
            endcase
        end
    end
endmodule