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
output          PREADY, PSLVERR;
output          SIO_C;
inout           SIO_D;

// APB registers
parameter   START_REG       = 8'h00;
parameter   IPADDR_REG      = 8'h01;
parameter   SUBADDR_REG     = 8'h02;
parameter   WDATA_REG       = 8'h03;
parameter   RDATA_REG       = 8'h04;
parameter   DONE_REG        = 8'h05;
//parameter   READWRITE_REG   = 8'h06;

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

// varaibles to calculate SCCB_CLK and SCCB_MID_PULSE
localparam XCLK_FREQ = 50_000_000;                          // incoming clock = XCLK = 50MHz 
localparam SCCB_CLK_FREQ = 100_000;                         // divide clock such that SIO_C = 100kHz
localparam SCCB_CLK_PERIOD = XCLK_FREQ/SCCB_CLK_FREQ/2;     // number of clocks to obtain 100kHz
localparam SCCB_MID_AMT = SCCB_CLK_PERIOD/2-1;              // amount of clk for mid of SCCB_clk
reg [$clog2(SCCB_CLK_PERIOD):0] SCCB_CLK_CNTR = 0;
reg SCCB_CLK;
reg SCCB_MID_PULSE;

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
    .done(done_c),            // basically, this is ACK
    .SIO_D(SIO_D),          // SCCB data
    .SIO_C(sio_c_o),         // SCCB clock
	.SCCB_CLK(SCCB_CLK),
	.SCCB_MID_PULSE(SCCB_MID_PULSE)
);


// Generating clock for SCCB and mid pulse
// Depending on the device, the SIO_C can go up to 40MHz
always @(posedge PCLK or negedge PRESETN) begin
	if(!PRESETN) begin // RST is acitve-low
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


assign PREADY = 1'b1;
assign PSLVERR = 1'b0;

// APB Read Registers
assign PRDATA = (PADDR[7:0] == START_REG)  ? {7'd0,start} :
                (PADDR[7:0] == IPADDR_REG) ? ip_addr :
                (PADDR[7:0] == SUBADDR_REG)? sub_addr :
                (PADDR[7:0] == WDATA_REG)  ? data_in :
                (PADDR[7:0] == RDATA_REG)  ? data_out :
                (PADDR[7:0] == DONE_REG)   ? done_c : 8'hff; // I'm using 0xff for testing

// APB Write Registers
// To stop data transfer, PWDATA = 24'bff_ff_ff
always @(posedge PCLK or negedge PRESETN) begin
    if(!PRESETN) begin
		start <= 1'b0;
		ip_addr <= 8'b0000_0000;
		sub_addr <= 8'b0000_0000;
		data_in <= 8'b0000_0000;
		state <= 2'b00;
    end else if(PWRITE && PENABLE && PSEL) begin
		if(SCCB_MID_PULSE && (PWDATA[23:0] != 24'hff_ff_ff)) begin
			done <= 0;
			case(state)
				INIT : begin
						ip_addr <= PWDATA[23:16];
						rw <= PWDATA[16];
						sub_addr <= PWDATA[15:8];
						data_in <= PWDATA[7:0];
						
						if(done_c)
							state <= INIT;
						else
							state <= TRANSFER;
					end
				TRANSFER : begin
						if(done_c) begin
							state <= DONE;
							start <= 1'b0;
						end else begin
							state <= TRANSFER;
							start <= 1'b1;
						end
					end
				DONE : begin
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
		
		// if we want to write registers separately
        /* case(PADDR[7:0])
            START   : begin
                    start <= PWDATA[0];
                end
            IPADDR  : begin
                    ip_addr <= PWDATA;
                    rw  <= PWDATA[0];
                end
            SUBADDR : begin
                    sub_addr <= PWDATA;
                end
            WDATA   : begin
                    data_in <= PWDATA;
                end
            default : begin
                end
        endcase */
    end
end

endmodule

