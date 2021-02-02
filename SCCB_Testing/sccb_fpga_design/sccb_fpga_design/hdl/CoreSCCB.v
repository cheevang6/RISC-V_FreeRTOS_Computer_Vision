// CoreSCCB.v
// 2-Wire SCCB Interface only
module CoreSCCB
(
    input            XCLK,			// Master clock to camera
    input			 RST_N,			// Reset 
    output           PWDN,			// Power down
	input			 start,
    input            RW,			// Read/Write request
    input	   [7:0] data_in,		// Data write to register
    input	   [7:0] ip_addr,		// Device ID + RW signal
    input 	   [7:0] sub_addr,		// Register address
    output reg [7:0] data_out,		// Data read from register
    //output VSYNC, HREF, PCLK,		// used when retrieving pixels
	output reg		 done,
    inout            SIO_D,			// SCCB data
    output			 SIO_C,			// SCCB clock
	input			 SCCB_MID_PULSE,
	input			 SCCB_CLK
);    
    
    reg [6:0] step;     // state machine identifier
    reg data_send;      // data to send through SCCB
    reg sccb_clk_step;
    
    // 1 ms delay
    localparam XCLK_FREQ = 8_000_000;
    localparam DELAY_FREQ = 1_000;
    localparam DELAY = XCLK_FREQ/DELAY_FREQ;
    reg [$clog2(DELAY):0] delay_cntr;
    
    always @(posedge XCLK or negedge RST_N) begin
        if(!RST_N) begin
            delay_cntr <= 0;
        end else begin
            if(step == 33) begin
                delay_cntr <= delay_cntr + 1;
            end else begin
                delay_cntr <= 0;
            end
        end
    end
    
    // tristate SIO_D bus when idle
    assign SIO_D =	(//step == 13 || step == 22 || step == 31 || step == 45 || 
                    (step == 54 && !ip_addr[0]) ||
					(step > 45  && step <= 53)) ? 1'bz : data_send;
    
    // SIO_C is driven high when idle
    assign SIO_C =  (start && ((step > 4  && step <= 31) || //<= 31 ||
                    (step > 36 && step <= 54))) ? SCCB_CLK : sccb_clk_step;
	
	assign PWDN = 1'b0;
	
    always @(posedge XCLK or negedge RST_N) begin
        if(!RST_N) begin
            data_send <= 1;
            data_out <= 0;
            sccb_clk_step <= 1;
			step <= 0;
			done <= 0;
        end else if(SCCB_MID_PULSE) begin
			if(!start || step > 56 )//|| done)
				step <= 0;
			else if(RW == 0 && step == 30) // 3-phase write
				step <= 53; // stop transmission
	        else if(RW == 1 && step == 21) // 2-phase write
	            step <= 31; // 2-phase read
            else if(step == 33 && delay_cntr < DELAY/10)
                step <= 33; // delay between 2-write and 2-read
            //else if(step == 0 && delay_cntr < DELAY)
            //    step <= 0; // delay between 2-write and 2-read
			else
				step <= step + 1;
				
            if(start) begin
				case(step)
					// initialize
					7'd0  : data_send <= 1'b1;
					7'd1  : data_send <= 1'b1;
					
					// 3-phase write or 2-phase write
					// Phase 1: ID Address
					// start transaction
					7'd2  : data_send <= 1'b0;
                    7'd3  : sccb_clk_step <= 1'b0;
					
					//ID Address
					7'd4  : data_send <= ip_addr[7];
					7'd5  : data_send <= ip_addr[6];
					7'd6  : data_send <= ip_addr[5];
					7'd7  : data_send <= ip_addr[4];
					7'd8  : data_send <= ip_addr[3];
					7'd9  : data_send <= ip_addr[2];
					7'd10 : data_send <= ip_addr[1];
					7'd11 : data_send <= 1'b0; // read/write bit (Write)
					7'd12 : data_send <= 0;// Don't care bit
					
					// Phase 2: Sub-Address
					7'd13 : data_send <= sub_addr[7];
					7'd14 : data_send <= sub_addr[6];
					7'd15 : data_send <= sub_addr[5];
					7'd16 : data_send <= sub_addr[4];
					7'd17 : data_send <= sub_addr[3];
					7'd18 : data_send <= sub_addr[2];
					7'd19 : data_send <= sub_addr[1];
					7'd20 : data_send <= sub_addr[0];
					7'd21 : data_send <= 0; // Don't care bit
					
					// Phase 3: Write Data
					7'd22 : data_send <= data_in[7];
					7'd23 : data_send <= data_in[6];
					7'd24 : data_send <= data_in[5];
					7'd25 : data_send <= data_in[4];
					7'd26 : data_send <= data_in[3];
					7'd27 : data_send <= data_in[2];
					7'd28 : data_send <= data_in[1];
					7'd29 : data_send <= data_in[0];
					7'd30 : data_send <= 0; // Don't care bit
					
					// stop transaction for 2-phase write 
					// (continues to 2-phase read)
                    7'd31 : sccb_clk_step <= 1'b0;
					7'd32 : sccb_clk_step <= 1'b1;
					7'd33 : data_send <= 1'b1;
                    
					// 2-phase read
					// Phase 1: ID Address
					// start transaction
					7'd34 : data_send <= 1'b0;
					7'd35 : sccb_clk_step <= 1'b0;
					// ID Address
					7'd36 : data_send <= ip_addr[7];
					7'd37 : data_send <= ip_addr[6];
					7'd38 : data_send <= ip_addr[5];
					7'd39 : data_send <= ip_addr[4];
					7'd40 : data_send <= ip_addr[3];
					7'd41 : data_send <= ip_addr[2];
					7'd42 : data_send <= ip_addr[1];
					7'd43 : data_send <= 1'b1; // read/write bit (Read)
					7'd44 : data_send <= 0;// Don't care bit
                    
					// Phase 2: Read Data
					7'd45 : data_out[7] <= SIO_D;
					7'd46 : data_out[6] <= SIO_D;
					7'd47 : data_out[5] <= SIO_D;
					7'd48 : data_out[4] <= SIO_D;
					7'd49 : data_out[3] <= SIO_D;
					7'd50 : data_out[2] <= SIO_D;
					7'd51 : data_out[1] <= SIO_D;
					7'd52 : data_out[0] <= SIO_D;
					7'd53 : data_send <= 1'b1; // Don't care bit (Driven to 1 by master during read)
                
					// stop transaction
					7'd54 : data_send <= 1'b0;
					7'd55 : sccb_clk_step <= 1'b1;
					7'd56 : begin
						data_send <= 1'b1;
						done <= 1'b1;
					end
                    
					default: begin
						data_send <= 1'b1;
						data_out <= data_out;
						sccb_clk_step <= 1'b1;
						//done <= 1'b0;
					end
				endcase
			end else begin
				data_send <= 1'b1;
				data_out <= data_out;
				sccb_clk_step <= 1'b1;
				done <= 1'b0;
			end
        end
    end
endmodule