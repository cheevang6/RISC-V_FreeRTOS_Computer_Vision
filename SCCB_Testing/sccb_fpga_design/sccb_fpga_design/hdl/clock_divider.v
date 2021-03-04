module clock_divider #(
	parameter CLK_FREQ = 10_000_000,
	parameter SCCB_CLK_FREQ = 100_000
)(
	input clk,
	input resetn,
	output reg sccb_clk,
	output reg mid_pulse
);

localparam SCCB_AMT	= (CLK_FREQ/SCCB_CLK_FREQ)/2 - 1;
localparam MID_AMT	= (SCCB_AMT+1)/2 - 1;

reg [9:0] count = 0;

initial sccb_clk = 1;
initial mid_pulse = 0;

always @(posedge clk) begin
	if(count == SCCB_AMT) begin
		sccb_clk <= ~sccb_clk;
		count <= 0;
	end else begin
		count <= count + 1;
	end
	
	if(count == MID_AMT && !sccb_clk) begin
		mid_pulse <= 1;
	end else begin
		mid_pulse <= 0;
	end
end

endmodule