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
wire sio_c;
wire sio_d;

sccb_design design_0 (
    .DEVRST_N(resetn),
    .sio_c(sio_c),
    .led1(led1),
    .xclk(xclk),
    .led2(led2),
    .sio_d(sio_d),
    .cam_resetn(cam_resetn),
    .cam_pwdn(cam_pwdn)
);

endmodule

