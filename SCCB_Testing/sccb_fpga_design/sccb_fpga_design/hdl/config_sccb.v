// config_sccb.v

module config_sccb(
    input PCLK,
    input PRESETN,
    output SIO_C,
    inout SIO_D
);

wire        pwdn;
reg         start;
reg         rw;
reg  [7:0]  data_in;
reg  [7:0]  ip_addr;
reg  [7:0]  sub_addr;
wire [7:0]  data_out;
wire        done; 

// varaibles to calculate SCCB_CLK and SCCB_MID_PULSE
localparam XCLK_FREQ = 8_000_000;                          // incoming clock = XCLK = 50MHz 
localparam SCCB_CLK_FREQ = 100_000;                         // divide clock such that SIO_C = 100kHz
localparam SCCB_CLK_PERIOD = XCLK_FREQ/SCCB_CLK_FREQ/2;     // number of clocks to obtain 100kHz
localparam SCCB_MID_AMT = SCCB_CLK_PERIOD/2;              // amount of clk for mid of SCCB_clk
reg [$clog2(SCCB_CLK_PERIOD):0] SCCB_CLK_CNTR = 0;
reg SCCB_CLK;
reg SCCB_MID_PULSE;

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
    .done(done),          // basically, this is ACK
    .SIO_D(SIO_D),          // SCCB data
    .SIO_C(SIO_C),        // SCCB clock
	.SCCB_CLK(SCCB_CLK),
	.SCCB_MID_PULSE(SCCB_MID_PULSE)
);

assign pwdn = 1'b0;

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

parameter   init_w  = 3'd0,
            write   = 3'd1,
            init_r  = 3'd2,
            read    = 3'd3,
            idle    = 3'd4;
            
reg [2:0] state;

always @(posedge PCLK or negedge PRESETN) begin
    if(!PRESETN) begin // RST is acitve-low
		ip_addr <= 8'h00; // write for ov2640
        sub_addr <= 8'h00; // register bank select (default: 0x00)
        data_in <= 8'h00;
        start <= 1'b0;
        state <= init_r; //init_w;
	end else if(SCCB_MID_PULSE) begin
        state <= idle;
        case(state)
        init_w : begin
                // SCCB IP address for ov7670 = 0x21
                ip_addr <= 8'h42; // write for ov7670
                sub_addr <= 8'h12; // COMCTRL7 - SCCB Register Reset
                data_in <= 8'h80;
                rw <= 0;
                start <= 1'b0;
                state <= write;
            end
        write : begin
                start <= 1'b1;
                if(done) begin
                    start <= 1'b0;
                    state <= init_r;
                end else begin
                    state <= write;
                end
            end
        init_r : begin
                ip_addr <= 8'h43; // read for ov7670
                sub_addr <= 8'h0a; // Product ID Number MSB (default 0x76)
                rw <= 1;
                start <= 1'b0;
                state <= read;
            end
        read : begin
                start <= 1'b1;
                if(done) begin
                    start <= 1'b0;
                    state <= init_r;
                end else begin
                    state <= read;
                end
            end
        idle : begin
                start <= 1'b0;
            end
        default : begin
                start <= 1'b0;
                state <= idle;
            end
        endcase
    end
end

endmodule