`timescale 10ns/1ps

module testbench;

reg xclk;
reg resetn;

initial begin
	resetn = 0;
	#1; resetn = 1;
end

wire sioc;
wire siod;

sccb_design design_0 (
    .DEVRST_N(resetn),
    .sioc(sioc),
    .xclk(xclk),
    .siod(siod),
    .cam_rstn(cam_rstn),
    .cam_pwdn(cam_pwdn)
);

endmodule

