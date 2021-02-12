`timescale 10ns/1ps

module testbench;

reg xclk;
reg resetn;

initial begin
	resetn = 0;
	#10; resetn = 1;
end

wire led1;
wire led2;
wire sioc;
wire siod;

sccb_design design_0 (
    .DEVRST_N(resetn),
    .sioc(sioc),
    .led1(led1),
    .xclk(xclk),
    .led2(led2),
    .siod(siod),
    .cam_rstn(cam_rstn),
    .pwdn(pwdn)
);

endmodule

