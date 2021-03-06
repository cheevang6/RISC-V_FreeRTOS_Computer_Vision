// CoreSCCB.v
// 2-Wire SCCB Interface only
module CoreSCCB
(
    input            XCLK,			// Master clock to camera
    input			 RST_N,			// Reset 
    output           PWDN,			// Power down
	input			 start,
    //input            RW,			// Read/Write request
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
	//wire RW;
    
    // tristate SIO_D bus when idle
    assign SIO_D =	(step == 13 || step == 22 || step == 31 || 
					 step == 46 || (step == 55 && !ip_addr[0]) ||
					(step > 46  && step <= 54)) ? 1'bz : data_send;
    // SIO_C is driven high when idle
    assign SIO_C = (start && (step > 4  && step <= 31 ||
					step > 37 && step <= 55)) ? SCCB_CLK : sccb_clk_step;
    //assign done = (step == 53 && start)? 1'b1 : 1'b0;
	
	assign PWDN = 1'b0;
	//assign RW = ip_addr[0];
	
    always @(posedge XCLK or negedge RST_N) begin
        if(!RST_N) begin
            data_send <= 1'b1;
            data_out <= 1'b0;
            sccb_clk_step <= 1'b1;
			step <= 6'd0;
			done <= 1'b0;
        end else if(SCCB_MID_PULSE) begin
			if(!start || step > 57 || done)
				step <= 6'd0;
			//else if(RW == 0 && step == 6'd30) // 3-phase write
			else if(ip_addr[0] == 0 && step == 6'd30) // 3-phase write
				step <= 6'd55; // stop transmission
	        //else if(RW == 1 && step == 6'd21) // 2-phase write
			else if(ip_addr[0] == 1 && step == 6'd21) // 2-phase write
	            step <= 6'd31; // 2-phase read
			else
				step <= step + 1;
				
            if(start) begin
				case(step)
					// initialize
					6'd0  : data_send <= 1'b1;
					6'd1  : data_send <= 1'b1;
					
					// 3-phase write or 2-phase write
					// Phase 1: ID Address
					// start transaction
					6'd2  : data_send <= 1'b0;
					6'd3  : sccb_clk_step <= 1'b0;
					
					//ID Address
					6'd4  : data_send <= ip_addr[7];
					6'd5  : data_send <= ip_addr[6];
					6'd6  : data_send <= ip_addr[5];
					6'd7  : data_send <= ip_addr[4];
					6'd8  : data_send <= ip_addr[3];
					6'd9  : data_send <= ip_addr[2];
					6'd10 : data_send <= ip_addr[1];
					6'd11 : data_send <= ip_addr[0];//RW; // read/write bit
					6'd12 : data_send <= 0;// Don't care bit
					
					// Phase 2: Sub-Address
					6'd13 : data_send <= sub_addr[7];
					6'd14 : data_send <= sub_addr[6];
					6'd15 : data_send <= sub_addr[5];
					6'd16 : data_send <= sub_addr[4];
					6'd17 : data_send <= sub_addr[3];
					6'd18 : data_send <= sub_addr[2];
					6'd19 : data_send <= sub_addr[1];
					6'd20 : data_send <= sub_addr[0];
					6'd21 : data_send <= 0; // Don't care bit
					
					// Phase 3: Write Data
					6'd22 : data_send <= data_in[7];
					6'd23 : data_send <= data_in[6];
					6'd24 : data_send <= data_in[5];
					6'd25 : data_send <= data_in[4];
					6'd26 : data_send <= data_in[3];
					6'd27 : data_send <= data_in[2];
					6'd28 : data_send <= data_in[1];
					6'd29 : data_send <= data_in[0];
					6'd30 : data_send <= 0; // Don't care bit
					
					// stop transaction for 2-phase write 
					// (continues to 2-phase read)
					6'd31 : data_send <= 1'b0;
					//6'd33 : sccb_clk_step <= 1'b0;
					6'd32 : sccb_clk_step <= 1'b1;
					6'd33 : data_send <= 1'b1;
					
					// 2-phase read
					// Phase 1: ID Address
					// start transaction
					6'd34 : sccb_clk_step <= 1'b1;
					6'd35 : data_send <= 1'b0;
					6'd36 : sccb_clk_step <= 1'b0;
					// ID Address
					6'd37 : data_send <= ip_addr[7];
					6'd38 : data_send <= ip_addr[6];
					6'd39 : data_send <= ip_addr[5];
					6'd40 : data_send <= ip_addr[4];
					6'd41 : data_send <= ip_addr[3];
					6'd42 : data_send <= ip_addr[2];
					6'd43 : data_send <= ip_addr[1];
					6'd44 : data_send <= ip_addr[0];//RW; // read/write bit
					6'd45 : data_send <= 0;// Don't care bit
			
					// Phase 2: Read Data
					6'd46 : data_out <= SIO_D;
					6'd47 : data_out <= SIO_D;
					6'd48 : data_out <= SIO_D;
					6'd49 : data_out <= SIO_D;
					6'd50 : data_out <= SIO_D;
					6'd51 : data_out <= SIO_D;
					6'd52 : data_out <= SIO_D;
					6'd53 : data_out <= SIO_D;
					6'd54 : data_send <= 1'b1; // Don't care bit (Driven to 1 by master during read)
					
					// stop transaction
					6'd55 : data_send <= 1'b0;
					//6'58 : sccb_clk_step <= 1'b0;
					6'd56 : sccb_clk_step <= 1'b1;
					6'd57 : begin
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