`timescale 1 ns/100 ps
// Version: v12.3 12.800.0.16


module SCCB_CTRL(
       sio_c_c,
       xclk_c,
       data_send_1z,
       idle_i
    );
output sio_c_c;
input  xclk_c;
output data_send_1z;
output idle_i;

    wire [7:0] step;
    wire [7:0] step_s;
    wire [7:0] SCCB_CLK_cnt;
    wire [7:0] SCCB_CLK_cnt_s;
    wire [6:0] SCCB_CLK_cnt_cry;
    wire [6:0] SCCB_CLK_cnt_cry_Y;
    wire [7:7] SCCB_CLK_cnt_s_FCO;
    wire [7:7] SCCB_CLK_cnt_s_Y;
    wire [6:1] step_cry;
    wire [6:1] step_cry_Y;
    wire [7:7] step_s_FCO;
    wire [7:7] step_s_Y;
    wire SCCB_CLK_Z, SCCB_CLK_0, idle_Z, VCC, data_send_26, 
        un1_data_send42_1_0_i, GND, sccb_clk_step_Z, data_send79_2_0_i, 
        un1_data_send42_0_Z, N_92_i, un1_data_send40_0_Z, N_8_i, 
        SCCB_CLK_cnt_s_19_FCO, SCCB_CLK_cnt_s_19_S, 
        SCCB_CLK_cnt_s_19_Y, SCCB_CLK_cnt_lcry, step_s_20_FCO, 
        step_s_20_S, step_s_20_Y, N_18, N_14, N_21, 
        un1_data_send42_0_1_0_Z, N_31, N_32, N_9, N_10, 
        SCCB_CLK_cnt12lto7_3_Z, un1_data_send40_0_a4_0_1_Z, N_24, N_13, 
        un1_data_send42_1_1_0_1_Z, N_27;
    
    CFG4 #( .INIT(16'h0400) )  un1_data_send42_0_a4_2 (.A(step[5]), .B(
        step[1]), .C(N_10), .D(N_32), .Y(N_21));
    ARI1 #( .INIT(20'h4AA00) )  \step_cry[3]  (.A(VCC), .B(step[3]), 
        .C(GND), .D(GND), .FCI(step_cry[2]), .S(step_s[3]), .Y(
        step_cry_Y[3]), .FCO(step_cry[3]));
    SLE \SCCB_CLK_cnt[6]  (.D(SCCB_CLK_cnt_s[6]), .CLK(xclk_c), .EN(
        VCC), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        SCCB_CLK_cnt[6]));
    SLE \SCCB_CLK_cnt[2]  (.D(SCCB_CLK_cnt_s[2]), .CLK(xclk_c), .EN(
        VCC), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        SCCB_CLK_cnt[2]));
    CFG1 #( .INIT(2'h1) )  idle_RNIAA0D (.A(idle_Z), .Y(idle_i));
    SLE data_send (.D(data_send_26), .CLK(SCCB_CLK_Z), .EN(
        un1_data_send42_1_0_i), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(data_send_1z));
    SLE \SCCB_CLK_cnt[0]  (.D(SCCB_CLK_cnt_s[0]), .CLK(xclk_c), .EN(
        VCC), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        SCCB_CLK_cnt[0]));
    ARI1 #( .INIT(20'h48800) )  \SCCB_CLK_cnt_cry[1]  (.A(VCC), .B(
        SCCB_CLK_cnt[1]), .C(SCCB_CLK_cnt_lcry), .D(GND), .FCI(
        SCCB_CLK_cnt_cry[0]), .S(SCCB_CLK_cnt_s[1]), .Y(
        SCCB_CLK_cnt_cry_Y[1]), .FCO(SCCB_CLK_cnt_cry[1]));
    CFG4 #( .INIT(16'hFF57) )  SCCB_CLK_cnt12lto7 (.A(SCCB_CLK_cnt[5]), 
        .B(SCCB_CLK_cnt[2]), .C(SCCB_CLK_cnt[1]), .D(
        SCCB_CLK_cnt12lto7_3_Z), .Y(SCCB_CLK_cnt_lcry));
    SLE \step[7]  (.D(step_s[7]), .CLK(SCCB_CLK_Z), .EN(VCC), .ALn(VCC)
        , .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(step[7]));
    SLE \step[0]  (.D(step_s[0]), .CLK(SCCB_CLK_Z), .EN(VCC), .ALn(VCC)
        , .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(step[0]));
    SLE \SCCB_CLK_cnt[5]  (.D(SCCB_CLK_cnt_s[5]), .CLK(xclk_c), .EN(
        VCC), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        SCCB_CLK_cnt[5]));
    CFG4 #( .INIT(16'h8000) )  un1_data_send42_1_1_0_a4_0 (.A(step[2]), 
        .B(step[4]), .C(step[1]), .D(step[3]), .Y(N_24));
    ARI1 #( .INIT(20'h48800) )  \SCCB_CLK_cnt_cry[2]  (.A(VCC), .B(
        SCCB_CLK_cnt[2]), .C(SCCB_CLK_cnt_lcry), .D(GND), .FCI(
        SCCB_CLK_cnt_cry[1]), .S(SCCB_CLK_cnt_s[2]), .Y(
        SCCB_CLK_cnt_cry_Y[2]), .FCO(SCCB_CLK_cnt_cry[2]));
    CFG3 #( .INIT(8'hFE) )  idle_RNO (.A(step[7]), .B(step[6]), .C(
        step[5]), .Y(N_92_i));
    CFG4 #( .INIT(16'hFFFE) )  sccb_clk_step_RNO (.A(step[7]), .B(
        step[6]), .C(step[4]), .D(step[3]), .Y(data_send79_2_0_i));
    CFG4 #( .INIT(16'h8000) )  un1_data_send42_0_a4 (.A(step[5]), .B(
        N_10), .C(step[1]), .D(step[0]), .Y(N_18));
    SLE \SCCB_CLK_cnt[3]  (.D(SCCB_CLK_cnt_s[3]), .CLK(xclk_c), .EN(
        VCC), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        SCCB_CLK_cnt[3]));
    ARI1 #( .INIT(20'h4AA00) )  \step_cry[1]  (.A(VCC), .B(step[1]), 
        .C(GND), .D(GND), .FCI(step_s_20_FCO), .S(step_s[1]), .Y(
        step_cry_Y[1]), .FCO(step_cry[1]));
    CFG3 #( .INIT(8'h04) )  un1_data_send40_0_a4_0_1 (.A(step[5]), .B(
        N_32), .C(step[3]), .Y(un1_data_send40_0_a4_0_1_Z));
    SLE \step[2]  (.D(step_s[2]), .CLK(SCCB_CLK_Z), .EN(VCC), .ALn(VCC)
        , .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(step[2]));
    CFG2 #( .INIT(4'hB) )  data_send_26_0_a2_0_o2 (.A(N_9), .B(step[0])
        , .Y(N_13));
    CFG2 #( .INIT(4'hE) )  un1_data_send40_0_o3 (.A(step[1]), .B(
        step[2]), .Y(N_9));
    ARI1 #( .INIT(20'h48800) )  \SCCB_CLK_cnt_s[7]  (.A(VCC), .B(
        SCCB_CLK_cnt[7]), .C(SCCB_CLK_cnt_lcry), .D(GND), .FCI(
        SCCB_CLK_cnt_cry[6]), .S(SCCB_CLK_cnt_s[7]), .Y(
        SCCB_CLK_cnt_s_Y[7]), .FCO(SCCB_CLK_cnt_s_FCO[7]));
    SLE \SCCB_CLK_cnt[4]  (.D(SCCB_CLK_cnt_s[4]), .CLK(xclk_c), .EN(
        VCC), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        SCCB_CLK_cnt[4]));
    SLE \step[6]  (.D(step_s[6]), .CLK(SCCB_CLK_Z), .EN(VCC), .ALn(VCC)
        , .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(step[6]));
    CFG4 #( .INIT(16'h7FFF) )  SCCB_CLK_cnt12lto7_3 (.A(
        SCCB_CLK_cnt[7]), .B(SCCB_CLK_cnt[6]), .C(SCCB_CLK_cnt[4]), .D(
        SCCB_CLK_cnt[3]), .Y(SCCB_CLK_cnt12lto7_3_Z));
    ARI1 #( .INIT(20'h4AA00) )  \step_cry[2]  (.A(VCC), .B(step[2]), 
        .C(GND), .D(GND), .FCI(step_cry[1]), .S(step_s[2]), .Y(
        step_cry_Y[2]), .FCO(step_cry[2]));
    ARI1 #( .INIT(20'h48800) )  \SCCB_CLK_cnt_cry[0]  (.A(VCC), .B(
        SCCB_CLK_cnt[0]), .C(SCCB_CLK_cnt_lcry), .D(GND), .FCI(
        SCCB_CLK_cnt_s_19_FCO), .S(SCCB_CLK_cnt_s[0]), .Y(
        SCCB_CLK_cnt_cry_Y[0]), .FCO(SCCB_CLK_cnt_cry[0]));
    ARI1 #( .INIT(20'h4AA00) )  \step_cry[5]  (.A(VCC), .B(step[5]), 
        .C(GND), .D(GND), .FCI(step_cry[4]), .S(step_s[5]), .Y(
        step_cry_Y[5]), .FCO(step_cry[5]));
    CLKINT SCCB_CLK_inferred_clock_RNIPQ8 (.A(SCCB_CLK_0), .Y(
        SCCB_CLK_Z));
    SLE \step[4]  (.D(step_s[4]), .CLK(SCCB_CLK_Z), .EN(VCC), .ALn(VCC)
        , .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(step[4]));
    CFG2 #( .INIT(4'h1) )  un1_data_send42_0_a2_1 (.A(step[0]), .B(
        step[4]), .Y(N_32));
    CFG4 #( .INIT(16'h54FF) )  un1_data_send42_0_1_0 (.A(step[2]), .B(
        step[1]), .C(step[0]), .D(N_31), .Y(un1_data_send42_0_1_0_Z));
    SLE SCCB_CLK (.D(N_8_i), .CLK(xclk_c), .EN(VCC), .ALn(VCC), .ADn(
        VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(SCCB_CLK_0));
    SLE sccb_clk_step (.D(data_send79_2_0_i), .CLK(SCCB_CLK_Z), .EN(
        un1_data_send42_0_Z), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(GND)
        , .LAT(GND), .Q(sccb_clk_step_Z));
    SLE \SCCB_CLK_cnt[7]  (.D(SCCB_CLK_cnt_s[7]), .CLK(xclk_c), .EN(
        VCC), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        SCCB_CLK_cnt[7]));
    SLE \step[1]  (.D(step_s[1]), .CLK(SCCB_CLK_Z), .EN(VCC), .ALn(VCC)
        , .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(step[1]));
    ARI1 #( .INIT(20'h4AA00) )  \step_s[7]  (.A(VCC), .B(step[7]), .C(
        GND), .D(GND), .FCI(step_cry[6]), .S(step_s[7]), .Y(
        step_s_Y[7]), .FCO(step_s_FCO[7]));
    CFG4 #( .INIT(16'hFBF8) )  un1_data_send40_0 (.A(N_31), .B(N_9), 
        .C(N_14), .D(un1_data_send40_0_a4_0_1_Z), .Y(
        un1_data_send40_0_Z));
    CFG4 #( .INIT(16'hFEEE) )  un1_data_send42_0_o4 (.A(step[6]), .B(
        step[7]), .C(step[5]), .D(step[4]), .Y(N_14));
    SLE idle (.D(N_92_i), .CLK(SCCB_CLK_Z), .EN(un1_data_send40_0_Z), 
        .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        idle_Z));
    ARI1 #( .INIT(20'h48800) )  \SCCB_CLK_cnt_cry[3]  (.A(VCC), .B(
        SCCB_CLK_cnt[3]), .C(SCCB_CLK_cnt_lcry), .D(GND), .FCI(
        SCCB_CLK_cnt_cry[2]), .S(SCCB_CLK_cnt_s[3]), .Y(
        SCCB_CLK_cnt_cry_Y[3]), .FCO(SCCB_CLK_cnt_cry[3]));
    CFG4 #( .INIT(16'h0203) )  data_send_26_0_a2_0_a4 (.A(step[5]), .B(
        N_13), .C(step[4]), .D(step[3]), .Y(data_send_26));
    CFG2 #( .INIT(4'hE) )  un1_data_send42_0_o3 (.A(step[3]), .B(
        step[2]), .Y(N_10));
    ARI1 #( .INIT(20'h4AA00) )  SCCB_CLK_cnt_s_19 (.A(VCC), .B(
        SCCB_CLK_cnt_lcry), .C(GND), .D(GND), .FCI(VCC), .S(
        SCCB_CLK_cnt_s_19_S), .Y(SCCB_CLK_cnt_s_19_Y), .FCO(
        SCCB_CLK_cnt_s_19_FCO));
    ARI1 #( .INIT(20'h48800) )  \SCCB_CLK_cnt_cry[5]  (.A(VCC), .B(
        SCCB_CLK_cnt[5]), .C(SCCB_CLK_cnt_lcry), .D(GND), .FCI(
        SCCB_CLK_cnt_cry[4]), .S(SCCB_CLK_cnt_s[5]), .Y(
        SCCB_CLK_cnt_cry_Y[5]), .FCO(SCCB_CLK_cnt_cry[5]));
    GND GND_Z (.Y(GND));
    VCC VCC_Z (.Y(VCC));
    CFG4 #( .INIT(16'hFEFF) )  un1_data_send42_0 (.A(N_18), .B(N_14), 
        .C(N_21), .D(un1_data_send42_0_1_0_Z), .Y(un1_data_send42_0_Z));
    CFG2 #( .INIT(4'h8) )  un1_data_send42_0_a2_0 (.A(step[5]), .B(
        step[3]), .Y(N_31));
    CFG4 #( .INIT(16'h1033) )  data_send_RNO (.A(N_13), .B(
        un1_data_send42_1_1_0_1_Z), .C(step[3]), .D(step[5]), .Y(
        un1_data_send42_1_0_i));
    SLE \SCCB_CLK_cnt[1]  (.D(SCCB_CLK_cnt_s[1]), .CLK(xclk_c), .EN(
        VCC), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        SCCB_CLK_cnt[1]));
    CFG2 #( .INIT(4'h9) )  SCCB_CLK_RNO (.A(SCCB_CLK_cnt_lcry), .B(
        SCCB_CLK_0), .Y(N_8_i));
    ARI1 #( .INIT(20'h4AA00) )  \step_cry[6]  (.A(VCC), .B(step[6]), 
        .C(GND), .D(GND), .FCI(step_cry[5]), .S(step_s[6]), .Y(
        step_cry_Y[6]), .FCO(step_cry[6]));
    ARI1 #( .INIT(20'h4AA00) )  \step_cry[4]  (.A(VCC), .B(step[4]), 
        .C(GND), .D(GND), .FCI(step_cry[3]), .S(step_s[4]), .Y(
        step_cry_Y[4]), .FCO(step_cry[4]));
    CFG3 #( .INIT(8'hB8) )  SIO_C (.A(sccb_clk_step_Z), .B(idle_Z), .C(
        SCCB_CLK_Z), .Y(sio_c_c));
    CFG3 #( .INIT(8'hFE) )  un1_data_send42_1_1_0_1 (.A(N_21), .B(N_24)
        , .C(N_14), .Y(un1_data_send42_1_1_0_1_Z));
    ARI1 #( .INIT(20'h4AA00) )  step_s_20 (.A(VCC), .B(step[0]), .C(
        GND), .D(GND), .FCI(VCC), .S(step_s_20_S), .Y(step_s_20_Y), 
        .FCO(step_s_20_FCO));
    CFG1 #( .INIT(2'h1) )  \step_RNO[0]  (.A(step[0]), .Y(step_s[0]));
    ARI1 #( .INIT(20'h48800) )  \SCCB_CLK_cnt_cry[4]  (.A(VCC), .B(
        SCCB_CLK_cnt[4]), .C(SCCB_CLK_cnt_lcry), .D(GND), .FCI(
        SCCB_CLK_cnt_cry[3]), .S(SCCB_CLK_cnt_s[4]), .Y(
        SCCB_CLK_cnt_cry_Y[4]), .FCO(SCCB_CLK_cnt_cry[4]));
    SLE \step[5]  (.D(step_s[5]), .CLK(SCCB_CLK_Z), .EN(VCC), .ALn(VCC)
        , .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(step[5]));
    ARI1 #( .INIT(20'h48800) )  \SCCB_CLK_cnt_cry[6]  (.A(VCC), .B(
        SCCB_CLK_cnt[6]), .C(SCCB_CLK_cnt_lcry), .D(GND), .FCI(
        SCCB_CLK_cnt_cry[5]), .S(SCCB_CLK_cnt_s[6]), .Y(
        SCCB_CLK_cnt_cry_Y[6]), .FCO(SCCB_CLK_cnt_cry[6]));
    SLE \step[3]  (.D(step_s[3]), .CLK(SCCB_CLK_Z), .EN(VCC), .ALn(VCC)
        , .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(step[3]));
    
endmodule


module sccb_design(
       xclk,
       sio_c,
       sio_d
    );
input  xclk;
output sio_c;
output sio_d;

    wire VCC, GND, data_send, xclk_c, sio_c_c, \SCCB_CTRL_0.idle_i , 
        xclk_ibuf_Z;
    
    CLKINT xclk_ibuf_RNIN1HC (.A(xclk_ibuf_Z), .Y(xclk_c));
    OUTBUF #( .IOSTD("") )  sio_c_obuf (.D(sio_c_c), .PAD(sio_c));
    INBUF #( .IOSTD("") )  xclk_ibuf (.PAD(xclk), .Y(xclk_ibuf_Z));
    VCC VCC_Z (.Y(VCC));
    SCCB_CTRL SCCB_CTRL_0 (.sio_c_c(sio_c_c), .xclk_c(xclk_c), 
        .data_send_1z(data_send), .idle_i(\SCCB_CTRL_0.idle_i ));
    TRIBUFF #( .IOSTD("") )  sio_d_obuft (.D(data_send), .E(
        \SCCB_CTRL_0.idle_i ), .PAD(sio_d));
    GND GND_Z (.Y(GND));
    
endmodule
