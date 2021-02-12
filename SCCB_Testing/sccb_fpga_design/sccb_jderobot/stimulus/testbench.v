`timescale 10ns/1ns
`default_nettype none

module testbench;

reg rst, clk;
wire sioc, siod, cam_rstn, pwdn, led, xclk;

initial begin
    clk = 0;
    forever begin
        #5; clk = ~clk;
    end
end


initial begin
    rst = 1;
    #10; rst = 0;
end


sccb_test sccb_test_0 (
    .rst(rst),
    .clk(clk),
    .sioc(sioc),
    .siod(siod),
    .cam_rstn(cam_rstn),
    .pwdn(pwdn),
    .led(led),
    .xclk(xclk)
);

endmodule

