// top_ov7670.v
`timescale 10ns/1ns

module top_ov7670 (
    input rst,
    input clk,
    output ov7670_sioc,
    output ov7670_siod,
    output ov7670_rst_n,
    output ov7670_pwdn,
    output ov7670_xclk,
    output done
);

parameter SYSCLK_PERIOD = 100;// 10MHZ
wire sw0_test_cmd;
wire btnr_test_1p;
wire [1:0] sw56_regs;
wire resend;
wire sdat_on;
wire sdat_out;

assign sw0_test_cmd = 1;
assign btnr_test_1p = 1;
assign sw56_regs = 0;
assign resend = 0;

ov7670_top_ctrl controller 
(
    .rst          (rst),
    .clk          (clk),
    .test_mode    (sw0_test_cmd),
    .test_send    (btnr_test_1p),
    .sw_regs      (sw56_regs),
    .resend       (resend),
    .done         (done),
    .sclk         (ov7670_sioc),
    .sdat_on      (sdat_on),
    .sdat_out     (sdat_out),
    .ov7670_rst_n (ov7670_rst_n),
    .ov7670_clk   (ov7670_xclk),
    .ov7670_pwdn  (ov7670_pwdn)
);

assign ov7670_siod = sdat_on ? sdat_out : 1'bz;

endmodule

