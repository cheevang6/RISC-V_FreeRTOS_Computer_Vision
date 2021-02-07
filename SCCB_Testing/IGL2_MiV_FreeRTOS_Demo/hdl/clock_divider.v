// clock_divider.v

module clock_divider #(
    parameter XCLK_FREQ = 10_000_000,   // incoming clock = XCLK = 50MHz 
    parameter SCCB_CLK_FREQ = 100_000   // divide clock such that SIO_C = 100kHz
)(
    input PCLK,
    input PRESETN,
    output reg SCCB_CLK,
    output reg SCCB_MID_PULSE
);

// varaibles to calculate SCCB_CLK and SCCB_MID_PULSE
localparam SCCB_CLK_PERIOD = XCLK_FREQ/SCCB_CLK_FREQ/2;     // number of clocks to obtain 100kHz
localparam SCCB_MID_AMT = SCCB_CLK_PERIOD/2-1;              // amount of clk for mid of SCCB_clk
reg [$clog2(SCCB_CLK_PERIOD):0] SCCB_CLK_CNTR = 0;
reg SCCB_CLK;
reg SCCB_MID_PULSE;

// Generating clock for SCCB and mid pulse
// Depending on the device, the SIO_C can go up to 400KHz
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

endmodule