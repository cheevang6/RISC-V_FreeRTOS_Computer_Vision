`timescale 1ns/1ps

module SCCB_tb;

reg clk, rst_n;
reg start;
//reg rw;
reg [7:0] data_in;
wire [7:0] data_out;
reg [7:0] addr_id;
reg [7:0] addr_reg;
wire sio_d_s0, sio_d_s1;
wire sio_c_s0, sio_c_s1;

SCCB_CTRL S0 (
    .XCLK(clk),
    .RST_N(rst_n),
	.start(start),
//    .RW(rw),
    .data_in(data_in),
    .addr_id(addr_id),
    .addr_reg(addr_reg),
    .data_out(data_out),
    .SIO_D(sio_d_s0),
    .SIO_C(sio_c_s0)
);

reg [15:0] data_i;
reg rw_i;
wire [7:0] data_o;
wire ack_error_o;
wire done_o;

// Generating clock for SCCB
// Depending on the device, the SIO_C can go up to 40MHz
localparam XCLK_FREQ = 50_000_000;                          // incoming clock = XCLK = 50MHz 
localparam SCCB_CLK_FREQ = 100_000;                         // divide clock such that SIO_C = 100kHz
localparam SCCB_CLK_PERIOD = XCLK_FREQ/SCCB_CLK_FREQ/2;     // number of clocks to obtain 100kHz
localparam SCCB_MID_AMT = SCCB_CLK_PERIOD/2-1;              // impulse signfying the mid of SCCB_clk
reg [$clog2(SCCB_CLK_PERIOD):0] SCCB_CLK_CNTR = 0;
reg SCCB_CLK;
reg SCCB_MID_PULSE;

SCCBCtrl S1(
	.clk_i(clk),
	.rst_i(rst_n), 
	.sccb_clk_i(SCCB_CLK),
	.data_pulse_i(SCCB_MID_PULSE),
	.addr_i(addr_id),
	.data_i(data_i),
	.data_o(data_o),
	.rw_i(rw_i),
	.start_i(start),
	.ack_error_o(ack_error_o), 
    .done_o(done_o),
	.sioc_o(sio_c_s1),
	.siod_io(sio_d_s1)
);

initial begin
    clk = 1'b1;
    forever begin
        #5; clk = ~clk;
    end
end

initial begin
    rst_n = 1'b0;
    #10; rst_n = 1'b1;
    
    //#20; 
    addr_id = 8'h60; // 0x60 write and 0x61 read (OV2640)
	rw_i = 1'b0; // write
    addr_reg = 8'hee;
	data_in = 8'hfe;
	data_i = {addr_reg,data_in};
	start = 1'b1;
	
	//
end

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin // RST is acitve-low
		SCCB_CLK_CNTR <=0;
		SCCB_CLK <= 0;
	end else begin
		if(SCCB_CLK_CNTR < SCCB_CLK_PERIOD) begin
			SCCB_CLK_CNTR <= SCCB_CLK_CNTR + 1;
		end else begin
			SCCB_CLK_CNTR <= 0;
			SCCB_CLK <= ~SCCB_CLK;
		end
		if(SCCB_CLK_CNTR == SCCB_MID_AMT && SCCB_CLK == 0) begin
			SCCB_MID_PULSE = 1'b1;
		end else begin
			SCCB_MID_PULSE = 1'b0;
		end
	end
end

endmodule

