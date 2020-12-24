`timescale 1ns/1ps

module SCCB_tb;

reg clk, rst_n;
//reg rw;
reg [7:0] data_in;
reg [7:0] data_out;
reg [7:0] addr_id;
reg [7:0] addr_reg;
wire sio_d;
wire sio_c;

SCCB_CTRL S0 (
    .XCLK(clk),
    .RST_N(rst_n),
//    .RW(rw),
    .data_in(data_in),
    .addr_id(addr_id),
    .addr_reg(addr_reg),
    .data_out(data_out),
    .SIO_D(sio_d),
    .SIO_C(sio_c)
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
    
    // start
    //sio_d = 1'b1;
    #20; // at least 15 ns
    
    // write device id
    addr_id = 8'h60; // 0x60 write and 0x61 read (OV2640)
    addr_reg = 8'hee;
    
    
end
endmodule

