`timescale 1ns/10ps

module testbench;

parameter SYSCLK_PERIOD = 100;// 10MHZ

reg SYSCLK;
reg NSYSRESET;

initial begin
    SYSCLK = 1'b0;
    NSYSRESET = 1'b0;
end

initial begin
    #(SYSCLK_PERIOD * 10 )
        NSYSRESET = 1'b1;
end

always @(SYSCLK)
    #(SYSCLK_PERIOD / 2.0) SYSCLK <= !SYSCLK;

    
wire sio_c;
wire led1;
wire led2;
wire xclk;
wire sio_d;

reg en;
reg test;

sccb_design sccb_design_0 (
    .DEVRST_N(NSYSRESET),
    .sio_c(sio_c),
    .led1(led1),
    .led2(led2),
    .xclk(xclk),
    .sio_d(sio_d)
);

assign sio_d = (en)? test : 1'bz;

initial begin
    en = 0;
    test = 0;
    #554345;
    en = 1;
    test = 1;
    #10000; test = 1;
    #10000; test = 1;
    #10000; test = 1;
    #10000; test = 0;
    #10000; test = 1;
    #10000; test = 1;
    #10000; test = 0;
    #11650; en = 0;
end

endmodule

