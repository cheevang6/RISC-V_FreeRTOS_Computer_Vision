`timescale 1 ns/100 ps
// Version: v12.3 12.800.0.16


module SCCB_CTRL(
       sio_c_c,
       data_send_1z,
       xclk_c,
       idle_i
    );
output sio_c_c;
output data_send_1z;
input  xclk_c;
output idle_i;

    wire [7:0] step;
    wire [0:0] step_i_0;
    wire [5:1] step_3;
    wire [7:0] SCCB_CLK_CNT;
    wire [7:0] SCCB_CLK_CNT_s;
    wire [6:0] SCCB_CLK_CNT_cry;
    wire [6:0] SCCB_CLK_CNT_cry_Y;
    wire [7:7] SCCB_CLK_CNT_s_FCO;
    wire [7:7] SCCB_CLK_CNT_s_Y;
    wire SCCB_CLK_Z, SCCB_CLK_0, idle_Z, VCC, GND, un4_step_cry_2_S, 
        un4_step_cry_3_S, un4_step_cry_6_S, un4_step_s_7_S, 
        data_send_26, SCCB_MID_PULSE_Z, sccb_clk_step_Z, 
        sccb_clk_step_2_iv_i_Z, idle_2, N_8_i, N_16_i, 
        SCCB_CLK_CNT_s_10_FCO, SCCB_CLK_CNT_s_10_S, 
        SCCB_CLK_CNT_s_10_Y, SCCB_CLK_CNT_lcry, un4_step_s_1_11_FCO, 
        un4_step_s_1_11_S, un4_step_s_1_11_Y, un4_step_cry_1_Z, 
        un4_step_cry_1_S, un4_step_cry_1_Y, un4_step_cry_2_Z, 
        un4_step_cry_2_Y, un4_step_cry_3_Z, un4_step_cry_3_Y, 
        un4_step_cry_4_Z, un4_step_cry_4_S, un4_step_cry_4_Y, 
        un4_step_cry_5_Z, un4_step_cry_5_S, un4_step_cry_5_Y, 
        un4_step_s_7_FCO, un4_step_s_7_Y, un4_step_cry_6_Z, 
        un4_step_cry_6_Y, data_send80, un1_data_send82_0, un1_step_3_i, 
        un1_data_send42_1_i, N_26, N_53, N_52, N_48, 
        data_send60_0_a2_2_Z, SCCB_CLK_CNT12lto7_i_a2_3_Z, 
        SCCB_MID_PULSE4_i_a2_4_Z, SCCB_MID_PULSE4_i_a2_3_Z, 
        data_send_26_0_iv_0_a2_1_2_Z, N_19, N_56, N_50, data_send82, 
        data_send40, data_send_26_0_iv_0_a2_3_2_Z, 
        data_send_26_0_iv_0_a2_0_0_Z, un1_data_send82_2_0_0_Z, 
        data_send_26_0_iv_0_0_1_Z, data_send_26_0_iv_0_1_0_Z, N_26_0;
    
    CFG3 #( .INIT(8'h54) )  sccb_clk_step_2_iv_i (.A(un1_step_3_i), .B(
        un1_data_send42_1_i), .C(sccb_clk_step_Z), .Y(
        sccb_clk_step_2_iv_i_Z));
    SLE \SCCB_CLK_CNT[6]  (.D(SCCB_CLK_CNT_s[6]), .CLK(xclk_c), .EN(
        VCC), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        SCCB_CLK_CNT[6]));
    SLE \SCCB_CLK_CNT[2]  (.D(SCCB_CLK_CNT_s[2]), .CLK(xclk_c), .EN(
        VCC), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        SCCB_CLK_CNT[2]));
    CFG4 #( .INIT(16'h2000) )  data_send82_0_a2 (.A(step[1]), .B(
        step[0]), .C(N_52), .D(N_50), .Y(data_send82));
    CFG1 #( .INIT(2'h1) )  idle_RNIAA0D (.A(idle_Z), .Y(idle_i));
    SLE data_send (.D(data_send_26), .CLK(SCCB_CLK_Z), .EN(
        SCCB_MID_PULSE_Z), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(GND), 
        .LAT(GND), .Q(data_send_1z));
    SLE \SCCB_CLK_CNT[0]  (.D(SCCB_CLK_CNT_s[0]), .CLK(xclk_c), .EN(
        VCC), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        SCCB_CLK_CNT[0]));
    ARI1 #( .INIT(20'h48800) )  \SCCB_CLK_CNT_cry[1]  (.A(VCC), .B(
        SCCB_CLK_CNT[1]), .C(SCCB_CLK_CNT_lcry), .D(GND), .FCI(
        SCCB_CLK_CNT_cry[0]), .S(SCCB_CLK_CNT_s[1]), .Y(
        SCCB_CLK_CNT_cry_Y[1]), .FCO(SCCB_CLK_CNT_cry[1]));
    ARI1 #( .INIT(20'h4AA00) )  un4_step_cry_6 (.A(VCC), .B(step[6]), 
        .C(GND), .D(GND), .FCI(un4_step_cry_5_Z), .S(un4_step_cry_6_S), 
        .Y(un4_step_cry_6_Y), .FCO(un4_step_cry_6_Z));
    SLE \step[7]  (.D(un4_step_s_7_S), .CLK(xclk_c), .EN(VCC), .ALn(
        VCC), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(step[7]));
    SLE \step[0]  (.D(step_i_0[0]), .CLK(xclk_c), .EN(VCC), .ALn(VCC), 
        .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(step[0]));
    SLE \SCCB_CLK_CNT[5]  (.D(SCCB_CLK_CNT_s[5]), .CLK(xclk_c), .EN(
        VCC), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        SCCB_CLK_CNT[5]));
    ARI1 #( .INIT(20'h48800) )  \SCCB_CLK_CNT_cry[2]  (.A(VCC), .B(
        SCCB_CLK_CNT[2]), .C(SCCB_CLK_CNT_lcry), .D(GND), .FCI(
        SCCB_CLK_CNT_cry[1]), .S(SCCB_CLK_CNT_s[2]), .Y(
        SCCB_CLK_CNT_cry_Y[2]), .FCO(SCCB_CLK_CNT_cry[2]));
    ARI1 #( .INIT(20'h4AA00) )  un4_step_cry_3 (.A(VCC), .B(step[3]), 
        .C(GND), .D(GND), .FCI(un4_step_cry_2_Z), .S(un4_step_cry_3_S), 
        .Y(un4_step_cry_3_Y), .FCO(un4_step_cry_3_Z));
    CFG4 #( .INIT(16'h0001) )  SCCB_MID_PULSE4_i_a2_3 (.A(
        SCCB_CLK_CNT[4]), .B(SCCB_CLK_CNT[3]), .C(SCCB_CLK_CNT[0]), .D(
        SCCB_CLK_CNT[5]), .Y(SCCB_MID_PULSE4_i_a2_3_Z));
    SLE \SCCB_CLK_CNT[3]  (.D(SCCB_CLK_CNT_s[3]), .CLK(xclk_c), .EN(
        VCC), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        SCCB_CLK_CNT[3]));
    ARI1 #( .INIT(20'h4AA00) )  un4_step_cry_5 (.A(VCC), .B(step[5]), 
        .C(GND), .D(GND), .FCI(un4_step_cry_4_Z), .S(un4_step_cry_5_S), 
        .Y(un4_step_cry_5_Y), .FCO(un4_step_cry_5_Z));
    CFG2 #( .INIT(4'h8) )  data_send82_0_a3_0 (.A(step[3]), .B(step[5])
        , .Y(N_52));
    SLE \step[2]  (.D(un4_step_cry_2_S), .CLK(xclk_c), .EN(VCC), .ALn(
        VCC), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(step[2]));
    CFG4 #( .INIT(16'h1000) )  data_send40_0_a2 (.A(step[1]), .B(
        step[0]), .C(N_53), .D(N_50), .Y(data_send40));
    ARI1 #( .INIT(20'h48800) )  \SCCB_CLK_CNT_s[7]  (.A(VCC), .B(
        SCCB_CLK_CNT[7]), .C(SCCB_CLK_CNT_lcry), .D(GND), .FCI(
        SCCB_CLK_CNT_cry[6]), .S(SCCB_CLK_CNT_s[7]), .Y(
        SCCB_CLK_CNT_s_Y[7]), .FCO(SCCB_CLK_CNT_s_FCO[7]));
    SLE \SCCB_CLK_CNT[4]  (.D(SCCB_CLK_CNT_s[4]), .CLK(xclk_c), .EN(
        VCC), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        SCCB_CLK_CNT[4]));
    SLE \step[6]  (.D(un4_step_cry_6_S), .CLK(xclk_c), .EN(VCC), .ALn(
        VCC), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(step[6]));
    CFG2 #( .INIT(4'hB) )  un1_data_send42_1_0_o2 (.A(data_send80), .B(
        un1_data_send82_0), .Y(N_26));
    CFG3 #( .INIT(8'h13) )  SCCB_MID_PULSE_RNO (.A(
        SCCB_MID_PULSE4_i_a2_3_Z), .B(SCCB_CLK_Z), .C(
        SCCB_MID_PULSE4_i_a2_4_Z), .Y(N_16_i));
    ARI1 #( .INIT(20'h48800) )  \SCCB_CLK_CNT_cry[0]  (.A(VCC), .B(
        SCCB_CLK_CNT[0]), .C(SCCB_CLK_CNT_lcry), .D(GND), .FCI(
        SCCB_CLK_CNT_s_10_FCO), .S(SCCB_CLK_CNT_s[0]), .Y(
        SCCB_CLK_CNT_cry_Y[0]), .FCO(SCCB_CLK_CNT_cry[0]));
    CLKINT SCCB_CLK_inferred_clock_RNIPQ8 (.A(SCCB_CLK_0), .Y(
        SCCB_CLK_Z));
    SLE \step[4]  (.D(step_3[4]), .CLK(xclk_c), .EN(VCC), .ALn(VCC), 
        .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(step[4]));
    CFG4 #( .INIT(16'hEAAA) )  \step_3[5]  (.A(un4_step_cry_5_S), .B(
        N_48), .C(data_send60_0_a2_2_Z), .D(N_53), .Y(step_3[5]));
    CFG4 #( .INIT(16'h0001) )  SCCB_MID_PULSE4_i_a2_4 (.A(
        SCCB_CLK_CNT[7]), .B(SCCB_CLK_CNT[6]), .C(SCCB_CLK_CNT[2]), .D(
        SCCB_CLK_CNT[1]), .Y(SCCB_MID_PULSE4_i_a2_4_Z));
    SLE SCCB_CLK (.D(N_8_i), .CLK(xclk_c), .EN(VCC), .ALn(VCC), .ADn(
        VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(SCCB_CLK_0));
    CFG4 #( .INIT(16'hCC80) )  data_send_26_0_iv_0_0_1 (.A(N_56), .B(
        data_send_1z), .C(step[5]), .D(data_send_26_0_iv_0_a2_1_2_Z), 
        .Y(data_send_26_0_iv_0_0_1_Z));
    SLE sccb_clk_step (.D(sccb_clk_step_2_iv_i_Z), .CLK(SCCB_CLK_Z), 
        .EN(SCCB_MID_PULSE_Z), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(sccb_clk_step_Z));
    CFG4 #( .INIT(16'hFFFE) )  un1_data_send82_2_0 (.A(
        un1_data_send82_2_0_0_Z), .B(data_send82), .C(data_send80), .D(
        N_56), .Y(un1_data_send82_0));
    CFG3 #( .INIT(8'hB8) )  SIO_C_i_m2 (.A(sccb_clk_step_Z), .B(idle_Z)
        , .C(SCCB_CLK_Z), .Y(sio_c_c));
    SLE \SCCB_CLK_CNT[7]  (.D(SCCB_CLK_CNT_s[7]), .CLK(xclk_c), .EN(
        VCC), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        SCCB_CLK_CNT[7]));
    CFG4 #( .INIT(16'h8880) )  SCCB_CLK_CNT12lto7_i_a2_3 (.A(
        SCCB_CLK_CNT[6]), .B(SCCB_CLK_CNT[5]), .C(SCCB_CLK_CNT[2]), .D(
        SCCB_CLK_CNT[1]), .Y(SCCB_CLK_CNT12lto7_i_a2_3_Z));
    SLE \step[1]  (.D(step_3[1]), .CLK(xclk_c), .EN(VCC), .ALn(VCC), 
        .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(step[1]));
    CFG4 #( .INIT(16'hCCC8) )  data_send_26_0_iv_0_1_0 (.A(N_26), .B(
        data_send_1z), .C(data_send_26_0_iv_0_a2_3_2_Z), .D(
        data_send82), .Y(data_send_26_0_iv_0_1_0_Z));
    CFG4 #( .INIT(16'hFFF8) )  data_send_26_0_iv_0_0 (.A(step[0]), .B(
        data_send_26_0_iv_0_a2_0_0_Z), .C(data_send_26_0_iv_0_1_0_Z), 
        .D(data_send_26_0_iv_0_0_1_Z), .Y(data_send_26));
    CFG4 #( .INIT(16'h7FFF) )  SCCB_CLK_CNT12lto7_i_a2 (.A(
        SCCB_CLK_CNT[7]), .B(SCCB_CLK_CNT[4]), .C(SCCB_CLK_CNT[3]), .D(
        SCCB_CLK_CNT12lto7_i_a2_3_Z), .Y(SCCB_CLK_CNT_lcry));
    SLE idle (.D(idle_2), .CLK(SCCB_CLK_Z), .EN(SCCB_MID_PULSE_Z), 
        .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        idle_Z));
    ARI1 #( .INIT(20'h48800) )  \SCCB_CLK_CNT_cry[3]  (.A(VCC), .B(
        SCCB_CLK_CNT[3]), .C(SCCB_CLK_CNT_lcry), .D(GND), .FCI(
        SCCB_CLK_CNT_cry[2]), .S(SCCB_CLK_CNT_s[3]), .Y(
        SCCB_CLK_CNT_cry_Y[3]), .FCO(SCCB_CLK_CNT_cry[3]));
    ARI1 #( .INIT(20'h48800) )  \SCCB_CLK_CNT_cry[5]  (.A(VCC), .B(
        SCCB_CLK_CNT[5]), .C(SCCB_CLK_CNT_lcry), .D(GND), .FCI(
        SCCB_CLK_CNT_cry[4]), .S(SCCB_CLK_CNT_s[5]), .Y(
        SCCB_CLK_CNT_cry_Y[5]), .FCO(SCCB_CLK_CNT_cry[5]));
    ARI1 #( .INIT(20'h4AA00) )  un4_step_s_7 (.A(VCC), .B(step[7]), .C(
        GND), .D(GND), .FCI(un4_step_cry_6_Z), .S(un4_step_s_7_S), .Y(
        un4_step_s_7_Y), .FCO(un4_step_s_7_FCO));
    ARI1 #( .INIT(20'h4AA00) )  un4_step_cry_4 (.A(VCC), .B(step[4]), 
        .C(GND), .D(GND), .FCI(un4_step_cry_3_Z), .S(un4_step_cry_4_S), 
        .Y(un4_step_cry_4_Y), .FCO(un4_step_cry_4_Z));
    CFG3 #( .INIT(8'h81) )  un1_data_send42_1_0_o2_0 (.A(step[5]), .B(
        step[2]), .C(step[0]), .Y(N_19));
    CFG4 #( .INIT(16'h0400) )  data_send_26_0_iv_0_a2_3_2 (.A(step[3]), 
        .B(step[1]), .C(step[0]), .D(N_50), .Y(
        data_send_26_0_iv_0_a2_3_2_Z));
    CFG3 #( .INIT(8'hFB) )  un1_data_send42_1_0_0 (.A(data_send80), .B(
        un1_data_send82_0), .C(un1_step_3_i), .Y(un1_data_send42_1_i));
    GND GND_Z (.Y(GND));
    VCC VCC_Z (.Y(VCC));
    CFG4 #( .INIT(16'h5400) )  data_send_26_0_iv_0_a2_0_0 (.A(step[1]), 
        .B(N_53), .C(N_52), .D(N_50), .Y(data_send_26_0_iv_0_a2_0_0_Z));
    CFG4 #( .INIT(16'hEAAA) )  \step_3[1]  (.A(un4_step_cry_1_S), .B(
        N_48), .C(data_send60_0_a2_2_Z), .D(N_53), .Y(step_3[1]));
    CFG3 #( .INIT(8'h10) )  data_send82_0_a3 (.A(step[4]), .B(step[2]), 
        .C(N_48), .Y(N_50));
    CFG4 #( .INIT(16'h1000) )  data_send80_0_a2 (.A(step[1]), .B(
        step[0]), .C(N_52), .D(N_50), .Y(data_send80));
    SLE \SCCB_CLK_CNT[1]  (.D(SCCB_CLK_CNT_s[1]), .CLK(xclk_c), .EN(
        VCC), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        SCCB_CLK_CNT[1]));
    ARI1 #( .INIT(20'h4AA00) )  un4_step_cry_2 (.A(VCC), .B(step[2]), 
        .C(GND), .D(GND), .FCI(un4_step_cry_1_Z), .S(un4_step_cry_2_S), 
        .Y(un4_step_cry_2_Y), .FCO(un4_step_cry_2_Z));
    CFG2 #( .INIT(4'h9) )  SCCB_CLK_RNO (.A(SCCB_CLK_CNT_lcry), .B(
        SCCB_CLK_0), .Y(N_8_i));
    ARI1 #( .INIT(20'h4AA00) )  un4_step_s_1_11 (.A(VCC), .B(step[0]), 
        .C(GND), .D(GND), .FCI(VCC), .S(un4_step_s_1_11_S), .Y(
        un4_step_s_1_11_Y), .FCO(un4_step_s_1_11_FCO));
    CFG4 #( .INIT(16'h2AAA) )  \step_3[4]  (.A(un4_step_cry_4_S), .B(
        N_48), .C(data_send60_0_a2_2_Z), .D(N_53), .Y(step_3[4]));
    CFG4 #( .INIT(16'h7530) )  un1_data_send82_2_0_0 (.A(step[5]), .B(
        step[1]), .C(N_50), .D(N_48), .Y(un1_data_send82_2_0_0_Z));
    CFG1 #( .INIT(2'h1) )  \step_RNO[0]  (.A(step[0]), .Y(step_i_0[0]));
    ARI1 #( .INIT(20'h48800) )  \SCCB_CLK_CNT_cry[4]  (.A(VCC), .B(
        SCCB_CLK_CNT[4]), .C(SCCB_CLK_CNT_lcry), .D(GND), .FCI(
        SCCB_CLK_CNT_cry[3]), .S(SCCB_CLK_CNT_s[4]), .Y(
        SCCB_CLK_CNT_cry_Y[4]), .FCO(SCCB_CLK_CNT_cry[4]));
    SLE \step[5]  (.D(step_3[5]), .CLK(xclk_c), .EN(VCC), .ALn(VCC), 
        .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(step[5]));
    CFG3 #( .INIT(8'h10) )  un1_data_send82_2_0_a2_1 (.A(step[4]), .B(
        step[3]), .C(N_48), .Y(N_56));
    CFG4 #( .INIT(16'h8000) )  data_send_26_0_iv_0_a2_1_2 (.A(step[4]), 
        .B(step[3]), .C(step[2]), .D(step[1]), .Y(
        data_send_26_0_iv_0_a2_1_2_Z));
    ARI1 #( .INIT(20'h48800) )  \SCCB_CLK_CNT_cry[6]  (.A(VCC), .B(
        SCCB_CLK_CNT[6]), .C(SCCB_CLK_CNT_lcry), .D(GND), .FCI(
        SCCB_CLK_CNT_cry[5]), .S(SCCB_CLK_CNT_s[6]), .Y(
        SCCB_CLK_CNT_cry_Y[6]), .FCO(SCCB_CLK_CNT_cry[6]));
    CFG2 #( .INIT(4'h1) )  un1_data_send82_2_0_a3 (.A(step[6]), .B(
        step[7]), .Y(N_48));
    CFG4 #( .INIT(16'h00FB) )  idle_2_f0 (.A(data_send82), .B(
        un1_data_send82_0), .C(idle_Z), .D(data_send40), .Y(idle_2));
    CFG3 #( .INIT(8'h80) )  un1_data_send42_1_0_a2 (.A(step[1]), .B(
        N_56), .C(N_19), .Y(un1_step_3_i));
    SLE SCCB_MID_PULSE (.D(N_16_i), .CLK(xclk_c), .EN(VCC), .ALn(VCC), 
        .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(SCCB_MID_PULSE_Z)
        );
    CFG2 #( .INIT(4'h1) )  data_send60_0_a3 (.A(step[3]), .B(step[5]), 
        .Y(N_53));
    ARI1 #( .INIT(20'h4AA00) )  SCCB_CLK_CNT_s_10 (.A(VCC), .B(
        SCCB_CLK_CNT_lcry), .C(GND), .D(GND), .FCI(VCC), .S(
        SCCB_CLK_CNT_s_10_S), .Y(SCCB_CLK_CNT_s_10_Y), .FCO(
        SCCB_CLK_CNT_s_10_FCO));
    CFG4 #( .INIT(16'h0008) )  data_send60_0_a2_2 (.A(step[2]), .B(
        step[4]), .C(step[1]), .D(step[0]), .Y(data_send60_0_a2_2_Z));
    ARI1 #( .INIT(20'h4AA00) )  un4_step_cry_1 (.A(VCC), .B(step[1]), 
        .C(GND), .D(GND), .FCI(un4_step_s_1_11_FCO), .S(
        un4_step_cry_1_S), .Y(un4_step_cry_1_Y), .FCO(un4_step_cry_1_Z)
        );
    SLE \step[3]  (.D(un4_step_cry_3_S), .CLK(xclk_c), .EN(VCC), .ALn(
        VCC), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(step[3]));
    
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
    SCCB_CTRL SCCB_CTRL_0 (.sio_c_c(sio_c_c), .data_send_1z(data_send), 
        .xclk_c(xclk_c), .idle_i(\SCCB_CTRL_0.idle_i ));
    TRIBUFF #( .IOSTD("") )  sio_d_obuft (.D(data_send), .E(
        \SCCB_CTRL_0.idle_i ), .PAD(sio_d));
    GND GND_Z (.Y(GND));
    
endmodule
