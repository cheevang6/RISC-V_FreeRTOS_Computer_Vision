`timescale 10ns/1ns // 10 MHz clk

module testbench_apb;

// inputs
reg [7:0] paddr;
reg [7:0] pwdata;
reg pwrite;
reg resetn;
// outpus
wire pslverr;
wire pready;
wire [7:0] prdata;
wire xclk;
wire sioc;
wire siod;
wire cam_pwdn;
wire cam_rstn;

// APB registers
parameter   IDADDR_RW_REG   = 8'h00;
// If I wanted separate registers for ID addres and RW bit...
//parameter   IDADDR_REG   = 8'h00;
//parameter   READWRITE_REG   = 8'h04;
parameter   SUBADDR_REG     = 8'h04;
parameter   WDATA_REG       = 8'h08;
parameter   RDATA_REG       = 8'h0C;
parameter   START_REG       = 8'h10;
parameter	DONE_REG		= 8'h14;
parameter   IDLE            = 8'h18;
/* Not sure about these registers yet
parameter   ACK_ID          = 8'h1C;
parameter   ACK_SUB         = 8'h20;
parameter   ACK_WR          = 8'h24;
// or just make one ACK register for all three
parameter   ACK =           = 8'h28;
*/

initial begin
	resetn = 0;
    
	#1; resetn = 1;
end

/*sccb_design design_0 (
    .xclk(xclk),
    .DEVRST_N(resetn),
    .sioc(sioc),
    .siod(siod),
    .cam_rstn(cam_rstn),
    .cam_pwdn(cam_pwdn) // Grounded
);*/

sccb_apb sccb_apb_0 (
    .PADDR(paddr),
    .PWDATA(pwdata),
    .PWRITE(pwrite),
    .DEVRST_N(resetn),
    .PSLVERR(pslverr),
    .PREADY(pready),
    .PRDATA(prdata),
    .sioc(sioc),
    .siod(siod),
    .cam_pwdn(cam_pwdn),
    .cam_rstn(cam_rstn),
    .xclk(xclk)
);

initial begin
    // send id addr + rw(reg = 0x00)
    paddr = IDADDR_RW_REG;
    pwdata = 8'h42; // write = 0x42, read = 0x43
    pwrite = 1;
    #1; // delay one clock
    paddr = SUBADDR_REG;
    pwdata = 8'h12; // SCCB Reset Register
    #1;
    paddr = WDATA_REG;
    pwdata = 8'h80; // SCCB Reset Register
    
    // wait for DONE signal
end

endmodule