// clock_divider.v

module clock_divider #(
    parameter APB_CLK_FREQ = 50_000_000,
    parameter XCLK_FREQ = 10_000_000,   // incoming clock = XCLK = 50MHz 
    parameter SCCB_CLK_FREQ = 100_000   // divide clock such that SIO_C = 100kHz
)(
    input clk,
    input resetn,
    output reg sccb_clk,
    output reg mid_pulse,
    output reg xclk
);

// varaibles to calculate sccb_clk and mid_pulse
localparam SCCB_CLK_PERIOD = APB_CLK_FREQ/SCCB_CLK_FREQ/2-1;     // number of clocks to obtain 100kHz
localparam SCCB_MID_AMT = (SCCB_CLK_PERIOD+1)/2-1;           // amount of clk for mid of sccb_clk
reg [$clog2(SCCB_CLK_PERIOD):0] count_sccb = 0;

// calculate counter for xclk
localparam APB_CLK_PERIOD = APB_CLK_FREQ/XCLK_FREQ/2-1;
reg [$clog2(APB_CLK_PERIOD):0] count_xclk = 0;

// Generating clock for SCCB and mid pulse
// Depending on the device, the SIO_C can go up to 400KHz
always @(posedge clk or negedge resetn) begin
	if(!resetn) begin // RST is acitve-low
		count_sccb <= 0;
		sccb_clk <= 0;
		mid_pulse <= 0;
        xclk <= 0;
	end else begin
		if(count_sccb < SCCB_CLK_PERIOD) begin
			count_sccb <= count_sccb + 1;
		end else begin
			count_sccb <= 0;
			sccb_clk <= ~sccb_clk;
		end
		
		if(count_sccb == SCCB_MID_AMT && sccb_clk == 0) begin
			mid_pulse <= 1'b1;
		end else begin
			mid_pulse <= 1'b0;
		end
        
        if(count_xclk < APB_CLK_PERIOD) begin
            count_xclk <= count_xclk + 1;
        end else begin
            count_xclk <= 0;
            xclk <= ~xclk;
        end
	end
end

endmodule