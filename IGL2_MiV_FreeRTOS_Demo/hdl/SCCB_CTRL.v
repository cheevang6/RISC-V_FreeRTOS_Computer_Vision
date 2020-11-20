// SCCB_CTRL.v

// 2-Wire SCCB Interface only
module sccb 
(
    input XCLK, RST, PWDN,
    //output VSYNC, HREF, PCLK, // used when retrieving pixels
    inout SIO_D,
    output reg SIO_C
);

/* SCCB_E
 * - driven by master (active-low)
 * - indicates start or stop of data transmission
 * - H-to-L transition indicates start, while L-to-H indicates stop
 * - must remain logical 0 during data transmission
 * - logical 1 = bus is idle
 * - in 2-wire, SCCB_E is not available (default: enabled and held low)
 */
 
 /* SIO_C
  * - driven by master (active-high)
  * - indicates each transmistted bit
  * - master drives it at logical 1 when bus is idle
  * - data transmission starts when SIO_C is driven at logical 0 after start transmission
  * - logical 1 during transmission indicates single transmitted bit
  *    --> SIO_D can occur only when SIO_C is driven at 0
  * - period of single transmitted bit = t_CYC = 10 us (typical)
  *    --> frequency of 100kHz
  */

/* SIO_D
 * - bi-directional
 * - remains floating or tri-state when bus is idle
 * - bus float and contention are allowed during transmission of DC or NA bits
 * - Don't Care (DC)
 *    - ninth-bit of master-issude transmission
 *    - purpose of DC bit is to indicate completion of transmission
 *    - slave(s) responding to DC bit
        (1) if slave 1 is selected and data is written to specific slave,
            slave 1 will drive SIO_D to 0 for DC bit
        (2) slave(s) do not respond to DC bit of current phase (SIO_D must remain
            at float for whole DC bit)
 */
    

    // Generating clock for SCCB
    localparam XCLK_FREQ = 50_000_000;                  // Incoming clock = XCLK = 50MHz 
    localparam SCCB_CLK_FREQ = 100_000;                     // divide clock such that SIO_C = 100kHz
    localparam SCCB_CLK_PERIOD = XCLK_FREQ/SCCB_CLK_FREQ/2;     // number of clocks to obtain 100kHz
    reg [$clog2(SCCB_CLK_PERIOD):0] SCCB_CLK_cnt = 0;

    always @(posedge XCLK or negedge RST) begin
        if(!RST) begin // RST is acitve-low
            SCCB_CLK_cnt <=0;
            SCCB_CLK <= 0;
        end else begin
            if(SCCB_CLK_cnt < SCCB_CLK_PERIOD) begin
                SCCB_CLK_cnt <= SCCB_CLK_cnt + 1;
            end else begin
                SCCB_CLK_cnt <= 0;
                SCCB_CLK = ~SCCB_CLK;
            end
        end
    end
    
    // Finite State Machine for SCCB
//    reg [2:0] state, state_next;
//    reg = data;
//    parameter   IDLE        = 3'd0,
//                START       = 3'd1,
//                WRITE_ID    = 3'd2,
//                WRITE_REG   = 3'd3,
//                STOP        = 3'd4,
//                READ        = 3'd5,
//                WRITEREAD   = 3'd6;
    reg [7:0] step;
    reg idle;
    
    assign SIO_D = (idle) 1'bz : data_out; //
    
    // FF
    always @(posedge SCCB_CLK or negedge RST) begin
        if(!RST) begin
            data_in <= 0;
            data_out <= 0;
            SIO_C <= 0;
        end else begin
            // default values
            SIO_C <= ;
            SIO_D_send <= ;
            case(step)
                // initialize
                7'd : data_out <= 0;
                7'd : data_out <= 0;
                
                // Start transmission
                7'd : SIO_C <= 1;
                7'd : data_out <= 1; // driven to 1 for min of tPRC = 15 ns 
                
                // write device's ID address (write 0x60 OV2640)
                7'd : data_out <= addr_in[7]; // need to check
                7'd : data_out <= addr_in[6];
                7'd : data_out <= addr_in[5];
                7'd : data_out <= addr_in[4];
                7'd : data_out <= addr_in[3];
                7'd : data_out <= addr_in[2];
                7'd : data_out <= addr_in[1];
                7'd : data_out <= addr_in[0]; // read/write bit
                7'd : data_out <= ;// Don't care bit
                
                // write to reg address
                7'd : data_out <= data_in[7];
                7'd : data_out <= data_in[6];
                7'd : data_out <= data_in[5];
                7'd : data_out <= data_in[4];
                7'd : data_out <= data_in[3];
                7'd : data_out <= data_in[2];
                7'd : data_out <= data_in[1];
                7'd : data_out <= data_in[0];
                7'd : data_out <= 0; // Don't care bit
                
                // write data
                7'd : data_out <= [7];
                7'd : data_out <= [6];
                7'd : data_out <= [5];
                7'd : data_out <= [4];
                7'd : data_out <= [3];
                7'd : data_out <= [2];
                7'd : data_out <= [1];
                7'd : data_out <= [0];
                7'd : data_out <= 0; // Don't care bit
                
                // read data (Recall: 2-phase is write-to-reg-address then read)
                7'd : data_out <= [7];
                7'd : data_out <= [6];
                7'd : data_out <= [5];
                7'd : data_out <= [4];
                7'd : data_out <= [3];
                7'd : data_out <= [2];
                7'd : data_out <= [1];
                7'd : data_out <= [0];
                7'd : data_out <= 0; // Don't care bit
                
                // stop transmission
                7'd : SIO_C <= 0;
                7'd : SIO_C <= 1;
                7'd : data <= 1; // must be driven to 1 for tPSC = 15ns (min)
                
                
                default :
            endcase
        end
    end
endmodule
