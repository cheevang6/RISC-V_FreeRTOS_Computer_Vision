`timescale 1ns/1ps

module SCCB_APB_tb;

reg				pclk, presetn, psel, pwrite, penable;
reg		[23:0]	pwdata;
reg		[7:0]	paddr;
wire	[7:0]	prdata;
wire			pready, pslverr;
wire			sio_c;
wire			sio_d;


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
	presetn = 1'b0;
	psel = 1'b1;
	pwrite = 1'b1;
	penable = 1'b1;
	#15; presetn = 1'b1;
	
	pwdata = 24'h60_56_e3;
	//paddr = 8'h;
end

endmodule