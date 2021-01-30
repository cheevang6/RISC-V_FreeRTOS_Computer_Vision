`timescale 1ns/100ps

module testbench;

reg clk;
reg rstn;
wire sio_c;
wire sio_d;

sccb_design sccb_design_0 (
    //.clk(clk),
    //.reset(rstn),
    .sio_c(sio_c),
    .sio_d(sio_d)
);

initial begin
    clk = 1'b0;
    forever begin
        #5; clk = ~clk;
    end
end

initial begin
    rstn = 1'b0;
    #15; rstn = 1'b1;
end
endmodule

