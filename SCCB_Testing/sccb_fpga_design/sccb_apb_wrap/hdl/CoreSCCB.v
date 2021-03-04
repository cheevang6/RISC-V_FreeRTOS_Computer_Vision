// CoreSCCB.v
// 2-Wire SCCB Interface only
module CoreSCCB #(
    parameter XCLK_FREQ = 10_000_000
)(
    input            xclk,			// Master clock to camera
    input			 resetn,		// Reset
    output           cam_rstn,	// Camera Power down
    output           cam_pwdn,		// Camera Power down (Grounded)
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
    reg ack_id, ack_sub, ack_wr;
    
    // TIMING REQUIREMENTS:
    //   Need at least 1.3 us delay before new START.
    //   However, each sccb_clk period is: 
    //        10 us (f_SIO_C = 100 kHz) -- to -- 2.5 us (f_SIO_C = 400 kHz)
    //   and there are multiple sccb_clk period between each START and STOP, hence 
    //   we do not need to delay it here. Possibly, the only delay needed is to 
    //   wait after system reset (t_S:RESET = 1 ms) and settling time for register
    //   to change (t_S:REG = 300 ms). (is this after each register or for the whole???)
    //
    // MAXIMUM f_SIO_C:
    //   Note that SIOC needs to be low for at least t_LOW = 1.3 us. This means 
    //   that for f_SIO_C = 400kHz, the period is 2.5 us and half of that time
    //   (1.25 us) is when this clock is low. Meaning that for 400 kHz, the clock
    //   is too fast for for t_LOW. Maximum f_SIO_C is actually 
    //                 1/(2*t_LOW) = 1/(2.6 us) = 384,615 kHz.
    
    localparam DELAY_FREQ = 4; // 1/(300 ms) = 3.33333 Hz (rounded to 4)
    localparam DELAY = XCLK_FREQ/DELAY_FREQ;
    reg [$clog2(DELAY):0] delay_cntr;
    
    always @(posedge xclk or negedge resetn) begin
        if(!resetn) begin
            delay_cntr <= 0;
        end else begin
            if((step == 39 || step == 0) && start) begin
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
	
	assign cam_pwdn = 1'b0;
    assign cam_rstn = 1'b1; // active-low camera reset
    
    always @(posedge xclk or negedge resetn) begin
        if(!resetn) begin
            bit_send <= 1;
            data_out <= 0;
            sccb_clk_step <= 1;
			step <= 0;
			done <= 0;
            ack_id <= 1;
            ack_sub <= 1;
            ack_wr <= 1;
        end else if(mid_pulse) begin
			if(!start || step > 67 )//|| done)
				step <= 0;
			else if(rw == 0 && step == 36) // 3-phase write
				step <= 65; // stop transmission
	        else if(rw == 1 && step == 25) // 2-phase write
	            step <= 37; // 2-phase read
            //else if(step == 39 && delay_cntr < DELAY)
            //    step <= 39; // delay between 2-write and 2-read
            //else if(step == 0 && delay_cntr < DELAY)
            //    step <= 0; // delay between 2-write and 2-read
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
					7'd13 : ack_id <= siod;// Don't care bit
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
					7'd24 : ack_sub <= siod; // Don't care bit
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
					7'd35 : ack_wr <= siod; // Don't care bit
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
					7'd52 : ack_id <= siod;// Don't care bit
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
                ack_id <= 1;
                ack_sub <= 1;
                ack_wr <= 1;
			end
        end
    end
endmodule