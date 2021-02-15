// CoreSCCB.v
// 2-Wire SCCB Interface only
module CoreSCCB #(
    parameter XCLK_FREQ = 10_000_000
)(
    input            xclk,			// Master clock to camera
    input			 resetn,		// Reset
    output           cam_resetn,	// Camera Power down
    output           cam_pwdn,		// Camera Power down
	input			 start,
    input            rw,			// Read/Write request
    input	   [7:0] id_addr,		// Device ID + rw signal
    input 	   [7:0] sub_addr,		// Register address
    input	   [7:0] data_in,		// Data write to register
    output reg [7:0] data_out,		// Data read from register
    output			 sioc,			// SCCB clock
    inout            siod,  		// SCCB data
    output reg		 done,
	input			 mid_pulse,
	input			 sccb_clk
);    
    
    reg [6:0] step;    // state machine identifier
    reg bit_send;      // data to send through SCCB
    reg sccb_clk_step;
    reg ack;
    
    // 1 ms delay
    localparam DELAY_FREQ = 1_000;
    localparam DELAY = XCLK_FREQ/DELAY_FREQ;
    reg [$clog2(DELAY):0] delay_cntr;
    
    always @(posedge xclk or negedge resetn) begin
        if(!resetn) begin
            delay_cntr <= 0;
        end else begin
            if(step == 39 || step == 0) begin
            //if(step == 0) begin
                delay_cntr <= delay_cntr + 1;
            end else begin
                delay_cntr <= 0;
            end
        end
    end
    
    // tristate SIO_D bus when idle
    assign siod =	(step == 13 || step == 14 || 
                     step == 24 || step == 25 ||
                     step == 35 || step == 36 ||
                     step == 52 || step == 53 || 
                    //(step == 54 && !id_addr[0]) ||
					(step >= 54  && step <= 62)) ? 1'bz : bit_send;
    
    // SIO_C is driven high when idle
    assign sioc =  (start &&
                    (step >  4  && step <= 12) || step == 14 ||
                    (step > 15  && step <= 23) || step == 25 ||
                    (step > 26  && step <= 34) || step == 36 ||
                    (step > 43  && step <= 51) || step == 53 ||
                    (step > 54  && step <= 62) || step == 64) ? sccb_clk : sccb_clk_step;
	
	assign pwdn = 1'b0;
    
    always @(posedge xclk or negedge resetn) begin
        if(!resetn) begin
            bit_send <= 1;
            data_out <= 0;
            sccb_clk_step <= 1;
			step <= 0;
			done <= 0;
            ack <= 1;
        end else if(mid_pulse) begin
			if(!start || step > 67 )//|| done)
				step <= 0;
			else if(rw == 0 && step == 36) // 3-phase write
				step <= 65; // stop transmission
	        else if(rw == 1 && step == 25) // 2-phase write
	            step <= 37; // 2-phase read
            else if(step == 39 && delay_cntr < DELAY/10)
                step <= 39; // delay between 2-write and 2-read
            else if(step == 0 && delay_cntr < DELAY/10)
                step <= 0; // delay between 2-write and 2-read
			else begin
				step <= step + 1;
            end
            
            if(start) begin
				case(step)
					// initialize
					7'd0  : begin
                            bit_send <= 1'b1;
                            sccb_clk_step <= 1'b1;
                        end
					7'd1  : bit_send <= 1'b1;
					
					// 3-phase write or 2-phase write
					// Phase 1: ID Address
					// start transaction
					7'd2  : bit_send <= 1'b0;
                    7'd3  : sccb_clk_step <= 1'b0;
					
					//ID Address
					7'd4  : bit_send <= id_addr[7];
					7'd5  : bit_send <= id_addr[6];
					7'd6  : bit_send <= id_addr[5];
					7'd7  : bit_send <= id_addr[4];
					7'd8  : bit_send <= id_addr[3];
					7'd9  : bit_send <= id_addr[2];
					7'd10 : bit_send <= id_addr[1];
					7'd11 : bit_send <= 1'b0; // read/write bit (Write)
                    7'd12 : bit_send <= 1'b0;
					7'd13 : ack <= siod;// Don't care bit
                    7'd14 : bit_send <= 1'b0;
					
					// Phase 2: Sub-Address
					7'd15 : bit_send <= sub_addr[7];
					7'd16 : bit_send <= sub_addr[6];
					7'd17 : bit_send <= sub_addr[5];
					7'd18 : bit_send <= sub_addr[4];
					7'd19 : bit_send <= sub_addr[3];
					7'd20 : bit_send <= sub_addr[2];
					7'd21 : bit_send <= sub_addr[1];
					7'd22 : bit_send <= sub_addr[0];
                    7'd23 : bit_send <= 1'b0;
					7'd24 : ack <= siod; // Don't care bit
                    7'd25 : bit_send <= 1'b0;
					
					// Phase 3: Write Data
					7'd26 : bit_send <= data_in[7];
					7'd27 : bit_send <= data_in[6];
					7'd28 : bit_send <= data_in[5];
					7'd29 : bit_send <= data_in[4];
					7'd30 : bit_send <= data_in[3];
					7'd31 : bit_send <= data_in[2];
					7'd32 : bit_send <= data_in[1];
					7'd33 : bit_send <= data_in[0];
                    7'd34 : bit_send <= 1'b0;
					7'd35 : ack <= siod; // Don't care bit
                    7'd36 : bit_send <= 1'b0;
					
					// stop transaction for 2-phase write 
					// (continues to 2-phase read)
                    7'd37 : sccb_clk_step <= 1'b0;
					7'd38 : sccb_clk_step <= 1'b1;
					7'd39 : bit_send <= 1'b1;
                    
					// 2-phase read
					// Phase 1: ID Address
					// start transaction
                    7'd40 : sccb_clk_step <= 1'b1;
					7'd41 : bit_send <= 1'b0;
					7'd42 : sccb_clk_step <= 1'b0;
					
                    // ID Address
					7'd43 : bit_send <= id_addr[7];
					7'd44 : bit_send <= id_addr[6];
					7'd45 : bit_send <= id_addr[5];
					7'd46 : bit_send <= id_addr[4];
					7'd47 : bit_send <= id_addr[3];
					7'd48 : bit_send <= id_addr[2];
					7'd49 : bit_send <= id_addr[1];
					7'd50 : bit_send <= 1'b1; // read/write bit (Read)
                    7'd51 : bit_send <= 1'b0;
					7'd52 : ack <= siod;// Don't care bit
                    7'd53 : bit_send <= 1'b0;
                    
					// Phase 2: Read Data
                    7'd54 : bit_send <= 1'b0;
					7'd55 : data_out[7] <= siod;
					7'd56 : data_out[6] <= siod;
					7'd57 : data_out[5] <= siod;
					7'd58 : data_out[4] <= siod;
					7'd59 : data_out[3] <= siod;
					7'd60 : data_out[2] <= siod;
					7'd61 : data_out[1] <= siod;
					7'd62 : data_out[0] <= siod;
					7'd63 : bit_send <= 1'b1; // NA bit (Driven to 1 by master during read)
                    7'd64 : bit_send <= 1'b0;
                    
					// stop transaction
                    7'd65 : sccb_clk_step <= 1'b0;
					7'd66 : sccb_clk_step <= 1'b1;
					7'd67 : begin
						bit_send <= 1'b1;
						done <= 1'b1;
					end
                    
					default: begin
						bit_send <= 1'b1;
						data_out <= data_out;
						sccb_clk_step <= 1'b1;
						//done <= 1'b0;
					end
				endcase
			end else begin
				bit_send <= 1'b1;
				data_out <= data_out;
				sccb_clk_step <= 1'b1;
				done <= 1'b0;
			end
        end
    end
endmodule