`timescale 1ns/1ps

module SCCB_APB_tb;

reg				pclk, presetn, psel, pwrite, penable;
reg		[23:0]	pwdata;
reg		[7:0]	paddr;
wire	[7:0]	prdata;
wire			pready, pslverr;
wire			sio_c;
wire			sio_d;

// APB registers
parameter   START_REG       = 8'h00;
parameter   IPADDR_REG      = 8'h01;
parameter   SUBADDR_REG     = 8'h02;
parameter   WDATA_REG       = 8'h03;
parameter   RDATA_REG       = 8'h04;
parameter   DONE_REG        = 8'h05;
//parameter   READWRITE_REG   = 8'h06;

reg [23:0] wdata_mem [9:0];
reg [4:0] index;
reg done;
reg start;

CoreSCCB_APB coresccb_c0(
	.PCLK(pclk),
	.PRESETN(presetn),
    .PSEL(psel),
    .PENABLE(penable),
    .PWRITE(pwrite),
	.PSLVERR(pslverr),
    .PREADY(pready),
    .PADDR(paddr),
    .PWDATA(pwdata),
    .PRDATA(prdata),
    .SIO_D(sio_d),
    .SIO_C(sio_c)
);

initial begin
	pclk = 1'b0;
	forever begin
		#5; pclk = ~pclk;
	end
end

initial begin
	wdata_mem[0] = 24'h60_56_e3;
	wdata_mem[1] = 24'h04_26_91;
	wdata_mem[2] = 24'hff_ff_ff; //24'h10_11_11;
	wdata_mem[3] = 24'h22_22_22;
	wdata_mem[4] = 24'h46_67_89;
	wdata_mem[5] = 24'h12_34_56;
	wdata_mem[6] = 24'h00_00_00;
	wdata_mem[7] = 24'hf0_ff_fe;
	wdata_mem[8] = 24'h00_00_01;
	wdata_mem[9] = 24'hff_ff_fe;
end

initial begin
	presetn = 1'b0;
	psel = 1'b1;
	pwrite = 1'b1;
	penable = 1'b1;
	#15; presetn = 1'b1;
end

always @(posedge pclk or negedge presetn) begin
	if(!presetn) begin
		pwdata <= 24'h00_00_00;
		index <= 4'b0000;
	end else if(start)begin
		pwdata <= wdata_mem[index]; //24'hff_ff_ff;//
		paddr <= DONE_REG;
		done <= prdata[7:0];
		if(done && index < 10) begin
			paddr <= START_REG;
			start <= prdata[7:0];
				if(!start)
					index <= index + 1;
		end
	end else begin
		paddr <= START_REG;
		start <= prdata[7:0];
	end
end

endmodule