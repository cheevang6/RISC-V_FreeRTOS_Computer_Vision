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

    // Generating clock for SCCB and mid pulse
    // Depending on the device, the SIO_C can go up to 40MHz
    localparam XCLK_FREQ = 50_000_000;                          // incoming clock = XCLK = 50MHz 
    localparam SCCB_CLK_FREQ = 100_000;                         // divide clock such that SIO_C = 100kHz
    localparam SCCB_CLK_PERIOD = XCLK_FREQ/SCCB_CLK_FREQ/2;     // number of clocks to obtain 100kHz
    localparam SCCB_MID_AMT = SCCB_CLK_PERIOD/2-1;              // amount of clk fpr mid of SCCB_clk
    reg [$clog2(SCCB_CLK_PERIOD):0] SCCB_CLK_CNTR = 0;
    reg SCCB_CLK;
    reg SCCB_MID_PULSE;

    always @(posedge XCLK or negedge RST_N) begin
        if(!RST_N) begin // RST is acitve-low
            SCCB_CLK_CNTR <= 0;
            SCCB_CLK <= 0;
			SCCB_MID_PULSE <= 0;
        end else begin
            if(SCCB_CLK_CNTR < SCCB_CLK_PERIOD) begin
                SCCB_CLK_CNTR <= SCCB_CLK_CNTR + 1;
            end else begin
                SCCB_CLK_CNTR <= 0;
                SCCB_CLK <= ~SCCB_CLK;
            end
            if(SCCB_CLK_CNTR == SCCB_MID_AMT && SCCB_CLK == 0) begin
                SCCB_MID_PULSE <= 1'b1;
            end else begin
                SCCB_MID_PULSE <= 1'b0;
            end
        end
    end
    
    reg [6:0] step;     // state machine identifier
    reg data_send;      // data to send through SCCB
    reg sccb_clk_step;
    reg wait4start;
    reg RW;
    
    // read/write signal
    assign RW = addr_id[0];
    // tristate SIO_D bus when idle
    assign SIO_D = (idle) ? 1'b1 : data_send;
    // SIO_C is driven high when idle
    assign SIO_C = (idle || step < 4) ? 1'b1 : SCCB_CLK;
       
    always @(posedge XCLK or negedge RST_N) begin
//	always @(*) begin
        if(!RST_N) begin
            data_send <= 1'b1;
            data_out <= 1'b0;
            sccb_clk_step <= 1'b1;
			step <= 6'd0;
        end else if(SCCB_MID_PULSE) begin
            if(RW == 0 && step == 6'd30) // 3-phase write
				step <= 6'd43; // stop transmission after write
	        else if(RW == 1 && step == 6'd21) // 2-phase write
	            step <= 6'd31; // go directly to 2-phases read
	        else if(RW == 1 && step == 6'd38) // 2-phase read
	            step <= 6'd39; // stop transmission after read
			else if(step > 45)
				step <= 6'd0;
			else
				step <= step + 1;
            
            case(step)
                // initialize
                6'd0  : data_send <= 1'b1;
				6'd1  : data_send <= 1'b1;
                
                // start write transaction
                6'd2  : data_send <= 1'b0;
                6'd3  : sccb_clk_step <= 1'b0;
                
                // write device's ID address (write 0x60 OV2640)
                6'd4  : data_send <= addr_id[7];
                6'd5  : data_send <= addr_id[6];
                6'd6  : data_send <= addr_id[5];
                6'd7  : data_send <= addr_id[4];
                6'd8  : data_send <= addr_id[3];
                6'd9  : data_send <= addr_id[2];
                6'd10 : data_send <= addr_id[1];
                6'd11 : data_send <= RW; // read/write bit
                6'd12 : data_send <= 0;// Don't care bit
                
                // write to reg address
                6'd13 : data_send <= addr_reg[7];
                6'd14 : data_send <= addr_reg[6];
                6'd15 : data_send <= addr_reg[5];
                6'd16 : data_send <= addr_reg[4];
                6'd17 : data_send <= addr_reg[3];
                6'd18 : data_send <= addr_reg[2];
                6'd19 : data_send <= addr_reg[1];
                6'd20 : data_send <= addr_reg[0];
                6'd21 : data_send <= 0; // Don't care bit
                
                // write data
                6'd22 : data_send <= data_in[7];
                6'd23 : data_send <= data_in[6];
                6'd24 : data_send <= data_in[5];
                6'd25 : data_send <= data_in[4];
                6'd26 : data_send <= data_in[3];
                6'd27 : data_send <= data_in[2];
                6'd28 : data_send <= data_in[1];
                6'd29 : data_send <= data_in[0];
                6'd30 : data_send <= 0; // Don't care bit
                
				// start read transaction
				6'd31 : sccb_clk_step <= 1'b1;
				6'd32 : data_send <= 1'b0;
				6'd33 : sccb_clk_step <= 1'b0;
				
                // read data (Recall: 2-phase is write-to-reg-address then read)
                // hence, if read it must go to write device's ID first then jump to here
                6'd34 : data_out <= SIO_D;
                6'd35 : data_out <= SIO_D;
                6'd36 : data_out <= SIO_D;
                6'd37 : data_out <= SIO_D;
                6'd38 : data_out <= SIO_D;
                6'd39 : data_out <= SIO_D;
                6'd40 : data_out <= SIO_D;
                6'd41 : data_out <= SIO_D;
                6'd42 : data_out <= 1'b1; // Don't care bit (Driven to 1 during read by master)
                
                // stop transaction
                // SIO_C = 1
                // SIO_D = 1 (for tPCS = 15ns) before SCCB_E deasserted
                6'd43 : sccb_clk_step <= 1'b0;
                6'd44 : sccb_clk_step <= 1'b1;
                6'd45 : data_send <= 1'b1;
                
                default: begin
					data_send <= 1'b1;
					data_out <= data_out;
                    sccb_clk_step <= 1'b1;
                end
            endcase
        end
    end
endmodule