// CoreSCCB_APB.v

module CoreSCCB_APB (
	PCLK,
    PRESETN,
    PSEL,
    PENABLE,
    PWRITE,
	PSLVERR,
    PREADY,
    PADDR,
    PWDATA,
    PRDATA,
    SIO_D,
    SIO_C
);

input           PCLK, PRESETN, PSEL, PENABLE, PWRITE;
input	[23:0]	PWDATA;
input   [7:0]   PADDR;
output  [7:0]   PRDATA;
output reg		PREADY; 
output			PSLVERR;
output          SIO_C;
inout           SIO_D;

// APB registers
parameter   START_REG       = 8'h04;
parameter   IPADDR_REG      = 8'h08;
parameter   READWRITE_REG   = 8'h0C;
parameter   SUBADDR_REG     = 8'h10;
parameter   WDATA_REG       = 8'h14;
parameter   RDATA_REG       = 8'h18;
parameter   DONE_REG        = 8'h1C;


// States
parameter	INIT		= 4'd0;
parameter	TRANSFER	= 4'd1;
parameter   DONE        = 4'd2;



// variables for CoreSCCB
wire 			pwdn;
reg				start = 1'b0;
reg				rw;
reg     [7:0]   data_in, ip_addr, sub_addr;
wire			done_c;
reg				done;
wire	[7:0]	data_out;

// this module's variables
wire			sio_c_o;
reg		[3:0]	state;
wire            SCCB_CLK;
wire            SCCB_MID_PULSE;

assign SIO_C = sio_c_o;

CoreSCCB coresccb_c0(
    .XCLK(PCLK),            // Master clock to camera
    .RST_N(PRESETN),        // Reset 
    .PWDN(pwdn),            // Power down (camera)
    .start(start),
    .RW(rw),                // Read/Write request
    .data_in(data_in),      // Data write to register
    .ip_addr(ip_addr),      // Device ID + RW signal
    .sub_addr(sub_addr),    // Register address
    .data_out(data_out),    // Data read from register
    .done(done_c),          // basically, this is ACK
    .SIO_D(SIO_D),          // SCCB data
    .SIO_C(sio_c_o),        // SCCB clock
	.SCCB_CLK(SCCB_CLK),
	.SCCB_MID_PULSE(SCCB_MID_PULSE)
);

clock_divider #(10_000_000, 100_000) cd_0(
    .PCLK(PCLK),
    .PRESETN(PRESETN),
    .SCCB_CLK(SCCB_CLK),
    .SCCB_MID_PULSE(SCCB_MID_PULSE)
);

//assign PREADY = 1'b1;
assign PSLVERR = 1'b0;
// assign PWRITE = rw;
// assign done = (state == DONE)? 1'b1 : 1'b0;



// Read Registers
assign PRDATA = (PADDR[7:0] == START_REG)  ? {7'd0,start} :
                (PADDR[7:0] == IPADDR_REG) ? ip_addr :
                (PADDR[7:0] == SUBADDR_REG)? sub_addr :
                (PADDR[7:0] == WDATA_REG)  ? data_in :
                (PADDR[7:0] == RDATA_REG)  ? data_out :
                (PADDR[7:0] == DONE_REG)   ? done : 8'hff; // I'm using 0xff for testing

// Write Registers
// To stop data transfer, PWDATA = 24'bff_ff_ff
always @(posedge PCLK or negedge PRESETN) begin
    if(!PRESETN) begin
		start <= 1'b0;
		ip_addr <= 8'h00;
		sub_addr <= 8'h00;
		data_in <= 8'h00;
		state <= 2'b00;
		done <= 1'b0;
    end else if(PWRITE && PENABLE && PSEL) begin
		if(SCCB_MID_PULSE && (PWDATA[23:0] != 24'hff_ff_ff)) begin
			done <= 1'b0;
            
            // Testing SCCB on FPGA only
			case(state)
				INIT : begin
						ip_addr <= PWDATA[23:16];
						rw <= PWDATA[16];
						sub_addr <= PWDATA[15:8];
						data_in <= PWDATA[7:0];
						
						PREADY <= 1'b1;
						
						if(done_c)
							state <= INIT;
						else
							state <= TRANSFER;
					end
				TRANSFER : begin
						PREADY <= 1'b0;
						if(done_c) begin
							state <= DONE;
							start <= 1'b0;
						end else begin
							state <= TRANSFER;
							start <= 1'b1;
						end
					end
				DONE : begin
						PREADY <= 1'b0;
						start <= 1'b0;
						state <= INIT;
						done <= 1;
					end
				default : begin
						
					end
			endcase
		end
		
        
		/* if(done) begin
			start <= 1'b0;
		end else begin
			ip_addr <= PWDATA[23:16];
			rw <= PWDATA[16];
			sub_addr <= PWDATA[15:8];
			data_in <= PWDATA[7:0];
			start <= 1'b1;
		end */
		
		// Actual SCCB Registers when used on software side
        /* case(PADDR[7:0])
            START_REG   : begin
                    start <= PWDATA[0];
                end
            IPADDR_REG  : begin
                    ip_addr <= PWDATA[7:0];
                end
            READWRITE_REG : begin
                    rw  <= PWDATA[0];
                end
            SUBADDR_REG : begin
                    sub_addr <= PWDATA[7:0];
                end
            WDATA_REG   : begin
                    data_in <= PWDATA[7:0];
                end
            default : begin
                end
        endcase */
    end
end

endmodule

