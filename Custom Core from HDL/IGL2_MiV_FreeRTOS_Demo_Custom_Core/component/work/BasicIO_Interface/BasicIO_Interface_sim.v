`timescale 1 ns/100 ps
// Version: v12.1 12.600.0.14


module PB_Debouncer_0(
       USER_BUTTON1,
       PB_Debouncer_0_PBout,
       PCLK,
       PRESETN
    );
input  USER_BUTTON1;
output PB_Debouncer_0_PBout;
input  PCLK;
input  PRESETN;

    wire [31:0] count;
    wire [31:0] count_4;
    wire [7:0] PB_Status;
    wire [0:0] State;
    wire VCC, GND, un2_count_cry_15_S_0, un2_count_cry_4_S_0, 
        un2_count_cry_6_S_0, un2_count_cry_8_S_0, un2_count_cry_9_S_0, 
        un2_count_cry_14_S_0, DPB_Z, PB_Status_0_sqmuxa_Z, 
        un15_pb_status_0, SPB_Z, un6_count_i, un2_count_cry_0_Z, 
        un2_count_cry_0_S_0, un2_count_cry_0_Y_0, un2_count_cry_1_Z, 
        un2_count_cry_1_S_0, un2_count_cry_1_Y_0, un2_count_cry_2_Z, 
        un2_count_cry_2_S_0, un2_count_cry_2_Y_0, un2_count_cry_3_Z, 
        un2_count_cry_3_S_0, un2_count_cry_3_Y_0, un2_count_cry_4_Z, 
        un2_count_cry_4_Y_0, un2_count_cry_5_Z, un2_count_cry_5_S_0, 
        un2_count_cry_5_Y_0, un2_count_cry_6_Z, un2_count_cry_6_Y_0, 
        un2_count_cry_7_Z, un2_count_cry_7_S_0, un2_count_cry_7_Y_0, 
        un2_count_cry_8_Z, un2_count_cry_8_Y_0, un2_count_cry_9_Z, 
        un2_count_cry_9_Y_0, un2_count_cry_10_Z, un2_count_cry_10_S_0, 
        un2_count_cry_10_Y_0, un2_count_cry_11_Z, un2_count_cry_11_S_0, 
        un2_count_cry_11_Y_0, un2_count_cry_12_Z, un2_count_cry_12_S_0, 
        un2_count_cry_12_Y_0, un2_count_cry_13_Z, un2_count_cry_13_S_0, 
        un2_count_cry_13_Y_0, un2_count_cry_14_Z, un2_count_cry_14_Y_0, 
        un2_count_cry_15_Z, un2_count_cry_15_Y_0, un2_count_cry_16_Z, 
        un2_count_cry_16_S_0, un2_count_cry_16_Y_0, un2_count_cry_17_Z, 
        un2_count_cry_17_S_0, un2_count_cry_17_Y_0, un2_count_cry_18_Z, 
        un2_count_cry_18_S_0, un2_count_cry_18_Y_0, un2_count_cry_19_Z, 
        un2_count_cry_19_S_0, un2_count_cry_19_Y_0, un2_count_cry_20_Z, 
        un2_count_cry_20_S_0, un2_count_cry_20_Y_0, un2_count_cry_21_Z, 
        un2_count_cry_21_S_0, un2_count_cry_21_Y_0, un2_count_cry_22_Z, 
        un2_count_cry_22_S_0, un2_count_cry_22_Y_0, un2_count_cry_23_Z, 
        un2_count_cry_23_S_0, un2_count_cry_23_Y_0, un2_count_cry_24_Z, 
        un2_count_cry_24_S_0, un2_count_cry_24_Y_0, un2_count_cry_25_Z, 
        un2_count_cry_25_S_0, un2_count_cry_25_Y_0, un2_count_cry_26_Z, 
        un2_count_cry_26_S_0, un2_count_cry_26_Y_0, un2_count_cry_27_Z, 
        un2_count_cry_27_S_0, un2_count_cry_27_Y_0, un2_count_cry_28_Z, 
        un2_count_cry_28_S_0, un2_count_cry_28_Y_0, un2_count_cry_29_Z, 
        un2_count_cry_29_S_0, un2_count_cry_29_Y_0, 
        un2_count_s_31_FCO_0, un2_count_s_31_S_0, un2_count_s_31_Y_0, 
        un2_count_cry_30_Z, un2_count_cry_30_S_0, un2_count_cry_30_Y_0, 
        un15_pb_status_1_0_Z, un15_pb_status_1_Z, un6_count_13_Z, 
        un6_count_23_Z, un6_count_21_Z, un6_count_20_Z, un6_count_19_Z, 
        un6_count_18_Z, un6_count_17_Z, un6_count_16_Z, un6_count_27_Z, 
        un6_count_28_Z;
    
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_10 (.A(VCC), .B(
        count[10]), .C(GND), .D(GND), .FCI(un2_count_cry_9_Z), .S(
        un2_count_cry_10_S_0), .Y(un2_count_cry_10_Y_0), .FCO(
        un2_count_cry_10_Z));
    CFG2 #( .INIT(4'h8) )  \count_4[12]  (.A(un2_count_cry_12_S_0), .B(
        State[0]), .Y(count_4[12]));
    SLE \count[5]  (.D(count_4[5]), .CLK(PCLK), .EN(VCC), .ALn(PRESETN)
        , .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(count[5]));
    CFG2 #( .INIT(4'h8) )  \count_4[20]  (.A(un2_count_cry_20_S_0), .B(
        State[0]), .Y(count_4[20]));
    CFG2 #( .INIT(4'h8) )  \count_4[27]  (.A(un2_count_cry_27_S_0), .B(
        State[0]), .Y(count_4[27]));
    SLE \count[1]  (.D(count_4[1]), .CLK(PCLK), .EN(VCC), .ALn(PRESETN)
        , .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(count[1]));
    CFG2 #( .INIT(4'h8) )  \count_4[2]  (.A(un2_count_cry_2_S_0), .B(
        State[0]), .Y(count_4[2]));
    SLE \count[27]  (.D(count_4[27]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[27]));
    CFG2 #( .INIT(4'h8) )  \count_4[1]  (.A(un2_count_cry_1_S_0), .B(
        State[0]), .Y(count_4[1]));
    SLE \count[10]  (.D(count_4[10]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[10]));
    SLE \count[0]  (.D(count_4[0]), .CLK(PCLK), .EN(VCC), .ALn(PRESETN)
        , .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(count[0]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_9 (.A(VCC), .B(count[9]), 
        .C(GND), .D(GND), .FCI(un2_count_cry_8_Z), .S(
        un2_count_cry_9_S_0), .Y(un2_count_cry_9_Y_0), .FCO(
        un2_count_cry_9_Z));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_21 (.A(VCC), .B(
        count[21]), .C(GND), .D(GND), .FCI(un2_count_cry_20_Z), .S(
        un2_count_cry_21_S_0), .Y(un2_count_cry_21_Y_0), .FCO(
        un2_count_cry_21_Z));
    SLE \count[14]  (.D(un2_count_cry_14_S_0), .CLK(PCLK), .EN(VCC), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[14]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_19 (.A(VCC), .B(
        count[19]), .C(GND), .D(GND), .FCI(un2_count_cry_18_Z), .S(
        un2_count_cry_19_S_0), .Y(un2_count_cry_19_Y_0), .FCO(
        un2_count_cry_19_Z));
    CFG2 #( .INIT(4'h8) )  \count_4[16]  (.A(un2_count_cry_16_S_0), .B(
        State[0]), .Y(count_4[16]));
    SLE \count[22]  (.D(count_4[22]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[22]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_20 (.A(VCC), .B(
        count[20]), .C(GND), .D(GND), .FCI(un2_count_cry_19_Z), .S(
        un2_count_cry_20_S_0), .Y(un2_count_cry_20_Y_0), .FCO(
        un2_count_cry_20_Z));
    CFG2 #( .INIT(4'h8) )  \count_4[22]  (.A(un2_count_cry_22_S_0), .B(
        State[0]), .Y(count_4[22]));
    CFG2 #( .INIT(4'h8) )  \count_4[25]  (.A(un2_count_cry_25_S_0), .B(
        State[0]), .Y(count_4[25]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_18 (.A(VCC), .B(
        count[18]), .C(GND), .D(GND), .FCI(un2_count_cry_17_Z), .S(
        un2_count_cry_18_S_0), .Y(un2_count_cry_18_Y_0), .FCO(
        un2_count_cry_18_Z));
    SLE PBout (.D(PB_Status[7]), .CLK(PCLK), .EN(un15_pb_status_0), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        PB_Debouncer_0_PBout));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_1 (.A(VCC), .B(count[1]), 
        .C(GND), .D(GND), .FCI(un2_count_cry_0_Z), .S(
        un2_count_cry_1_S_0), .Y(un2_count_cry_1_Y_0), .FCO(
        un2_count_cry_1_Z));
    SLE SPB (.D(USER_BUTTON1), .CLK(PCLK), .EN(PRESETN), .ALn(VCC), 
        .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(SPB_Z));
    CFG2 #( .INIT(4'h8) )  \count_4[26]  (.A(un2_count_cry_26_S_0), .B(
        State[0]), .Y(count_4[26]));
    SLE \count[20]  (.D(count_4[20]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[20]));
    CFG4 #( .INIT(16'h0001) )  un6_count_18 (.A(un2_count_cry_8_S_0), 
        .B(un2_count_cry_9_S_0), .C(un2_count_cry_10_S_0), .D(
        un2_count_cry_11_S_0), .Y(un6_count_18_Z));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_29 (.A(VCC), .B(
        count[29]), .C(GND), .D(GND), .FCI(un2_count_cry_28_Z), .S(
        un2_count_cry_29_S_0), .Y(un2_count_cry_29_Y_0), .FCO(
        un2_count_cry_29_Z));
    SLE \count[24]  (.D(count_4[24]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[24]));
    SLE \PB_Status[5]  (.D(PB_Status[4]), .CLK(PCLK), .EN(
        PB_Status_0_sqmuxa_Z), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(PB_Status[5]));
    CFG2 #( .INIT(4'h8) )  \count_4[5]  (.A(un2_count_cry_5_S_0), .B(
        State[0]), .Y(count_4[5]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_30 (.A(VCC), .B(
        count[30]), .C(GND), .D(GND), .FCI(un2_count_cry_29_Z), .S(
        un2_count_cry_30_S_0), .Y(un2_count_cry_30_Y_0), .FCO(
        un2_count_cry_30_Z));
    SLE \count[8]  (.D(un2_count_cry_8_S_0), .CLK(PCLK), .EN(VCC), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[8]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_5 (.A(VCC), .B(count[5]), 
        .C(GND), .D(GND), .FCI(un2_count_cry_4_Z), .S(
        un2_count_cry_5_S_0), .Y(un2_count_cry_5_Y_0), .FCO(
        un2_count_cry_5_Z));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_28 (.A(VCC), .B(
        count[28]), .C(GND), .D(GND), .FCI(un2_count_cry_27_Z), .S(
        un2_count_cry_28_S_0), .Y(un2_count_cry_28_Y_0), .FCO(
        un2_count_cry_28_Z));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_2 (.A(VCC), .B(count[2]), 
        .C(GND), .D(GND), .FCI(un2_count_cry_1_Z), .S(
        un2_count_cry_2_S_0), .Y(un2_count_cry_2_Y_0), .FCO(
        un2_count_cry_2_Z));
    SLE \PB_Status[0]  (.D(DPB_Z), .CLK(PCLK), .EN(
        PB_Status_0_sqmuxa_Z), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(PB_Status[0]));
    CFG2 #( .INIT(4'h8) )  \count_4[18]  (.A(un2_count_cry_18_S_0), .B(
        State[0]), .Y(count_4[18]));
    SLE \count[19]  (.D(count_4[19]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[19]));
    CFG4 #( .INIT(16'h0010) )  un6_count_16 (.A(un2_count_cry_2_S_0), 
        .B(un2_count_cry_3_S_0), .C(count[0]), .D(un2_count_cry_1_S_0), 
        .Y(un6_count_16_Z));
    SLE \count[15]  (.D(un2_count_cry_15_S_0), .CLK(PCLK), .EN(VCC), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[15]));
    SLE \count[11]  (.D(count_4[11]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[11]));
    SLE DPB (.D(SPB_Z), .CLK(PCLK), .EN(PRESETN), .ALn(VCC), .ADn(VCC), 
        .SLn(VCC), .SD(GND), .LAT(GND), .Q(DPB_Z));
    CFG2 #( .INIT(4'h8) )  \count_4[31]  (.A(un2_count_s_31_S_0), .B(
        State[0]), .Y(count_4[31]));
    CFG2 #( .INIT(4'h8) )  \count_4[28]  (.A(un2_count_cry_28_S_0), .B(
        State[0]), .Y(count_4[28]));
    SLE \count[13]  (.D(count_4[13]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[13]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_6 (.A(VCC), .B(count[6]), 
        .C(GND), .D(GND), .FCI(un2_count_cry_5_Z), .S(
        un2_count_cry_6_S_0), .Y(un2_count_cry_6_Y_0), .FCO(
        un2_count_cry_6_Z));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_3 (.A(VCC), .B(count[3]), 
        .C(GND), .D(GND), .FCI(un2_count_cry_2_Z), .S(
        un2_count_cry_3_S_0), .Y(un2_count_cry_3_Y_0), .FCO(
        un2_count_cry_3_Z));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_14 (.A(VCC), .B(
        count[14]), .C(GND), .D(GND), .FCI(un2_count_cry_13_Z), .S(
        un2_count_cry_14_S_0), .Y(un2_count_cry_14_Y_0), .FCO(
        un2_count_cry_14_Z));
    SLE \count[29]  (.D(count_4[29]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[29]));
    CFG2 #( .INIT(4'h8) )  \count_4[11]  (.A(un2_count_cry_11_S_0), .B(
        State[0]), .Y(count_4[11]));
    SLE \count[2]  (.D(count_4[2]), .CLK(PCLK), .EN(VCC), .ALn(PRESETN)
        , .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(count[2]));
    CFG4 #( .INIT(16'h8000) )  un6_count_28 (.A(un6_count_16_Z), .B(
        un6_count_17_Z), .C(un6_count_18_Z), .D(un6_count_19_Z), .Y(
        un6_count_28_Z));
    ARI1 #( .INIT(20'h45500) )  un2_count_s_31 (.A(VCC), .B(count[31]), 
        .C(GND), .D(GND), .FCI(un2_count_cry_30_Z), .S(
        un2_count_s_31_S_0), .Y(un2_count_s_31_Y_0), .FCO(
        un2_count_s_31_FCO_0));
    SLE \count[25]  (.D(count_4[25]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[25]));
    CFG4 #( .INIT(16'h0001) )  un6_count_17 (.A(un2_count_cry_4_S_0), 
        .B(un2_count_cry_5_S_0), .C(un2_count_cry_6_S_0), .D(
        un2_count_cry_7_S_0), .Y(un6_count_17_Z));
    SLE \State[0]  (.D(un6_count_i), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        State[0]));
    CFG2 #( .INIT(4'h8) )  \count_4[13]  (.A(un2_count_cry_13_S_0), .B(
        State[0]), .Y(count_4[13]));
    SLE \count[30]  (.D(count_4[30]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[30]));
    SLE \count[21]  (.D(count_4[21]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[21]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_13 (.A(VCC), .B(
        count[13]), .C(GND), .D(GND), .FCI(un2_count_cry_12_Z), .S(
        un2_count_cry_13_S_0), .Y(un2_count_cry_13_Y_0), .FCO(
        un2_count_cry_13_Z));
    CFG2 #( .INIT(4'h8) )  \count_4[24]  (.A(un2_count_cry_24_S_0), .B(
        State[0]), .Y(count_4[24]));
    SLE \count[9]  (.D(un2_count_cry_9_S_0), .CLK(PCLK), .EN(VCC), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[9]));
    SLE \count[16]  (.D(count_4[16]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[16]));
    SLE \count[23]  (.D(count_4[23]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[23]));
    CFG4 #( .INIT(16'h0001) )  un6_count_20 (.A(un2_count_cry_16_S_0), 
        .B(un2_count_cry_17_S_0), .C(un2_count_cry_18_S_0), .D(
        un2_count_cry_19_S_0), .Y(un6_count_20_Z));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_24 (.A(VCC), .B(
        count[24]), .C(GND), .D(GND), .FCI(un2_count_cry_23_Z), .S(
        un2_count_cry_24_S_0), .Y(un2_count_cry_24_Y_0), .FCO(
        un2_count_cry_24_Z));
    CFG2 #( .INIT(4'h8) )  \count_4[7]  (.A(un2_count_cry_7_S_0), .B(
        State[0]), .Y(count_4[7]));
    CFG2 #( .INIT(4'h8) )  \count_4[21]  (.A(un2_count_cry_21_S_0), .B(
        State[0]), .Y(count_4[21]));
    SLE \PB_Status[1]  (.D(PB_Status[0]), .CLK(PCLK), .EN(
        PB_Status_0_sqmuxa_Z), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(PB_Status[1]));
    CFG2 #( .INIT(4'h8) )  \count_4[23]  (.A(un2_count_cry_23_S_0), .B(
        State[0]), .Y(count_4[23]));
    SLE \PB_Status[6]  (.D(PB_Status[5]), .CLK(PCLK), .EN(
        PB_Status_0_sqmuxa_Z), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(PB_Status[6]));
    CFG2 #( .INIT(4'h2) )  \count_4[0]  (.A(State[0]), .B(count[0]), 
        .Y(count_4[0]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_23 (.A(VCC), .B(
        count[23]), .C(GND), .D(GND), .FCI(un2_count_cry_22_Z), .S(
        un2_count_cry_23_S_0), .Y(un2_count_cry_23_Y_0), .FCO(
        un2_count_cry_23_Z));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_0 (.A(VCC), .B(count[0]), 
        .C(GND), .D(GND), .FCI(GND), .S(un2_count_cry_0_S_0), .Y(
        un2_count_cry_0_Y_0), .FCO(un2_count_cry_0_Z));
    CFG2 #( .INIT(4'h1) )  un6_count_13 (.A(un2_count_cry_27_S_0), .B(
        un2_count_cry_26_S_0), .Y(un6_count_13_Z));
    SLE \count[6]  (.D(un2_count_cry_6_S_0), .CLK(PCLK), .EN(VCC), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[6]));
    CFG4 #( .INIT(16'h0001) )  un6_count_21 (.A(un2_count_cry_20_S_0), 
        .B(un2_count_cry_21_S_0), .C(un2_count_cry_22_S_0), .D(
        un2_count_cry_23_S_0), .Y(un6_count_21_Z));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_4 (.A(VCC), .B(count[4]), 
        .C(GND), .D(GND), .FCI(un2_count_cry_3_Z), .S(
        un2_count_cry_4_S_0), .Y(un2_count_cry_4_Y_0), .FCO(
        un2_count_cry_4_Z));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_12 (.A(VCC), .B(
        count[12]), .C(GND), .D(GND), .FCI(un2_count_cry_11_Z), .S(
        un2_count_cry_12_S_0), .Y(un2_count_cry_12_Y_0), .FCO(
        un2_count_cry_12_Z));
    SLE \count[26]  (.D(count_4[26]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[26]));
    SLE \count[3]  (.D(count_4[3]), .CLK(PCLK), .EN(VCC), .ALn(PRESETN)
        , .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(count[3]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_16 (.A(VCC), .B(
        count[16]), .C(GND), .D(GND), .FCI(un2_count_cry_15_Z), .S(
        un2_count_cry_16_S_0), .Y(un2_count_cry_16_Y_0), .FCO(
        un2_count_cry_16_Z));
    GND GND_Z (.Y(GND));
    CFG2 #( .INIT(4'h8) )  \count_4[19]  (.A(un2_count_cry_19_S_0), .B(
        State[0]), .Y(count_4[19]));
    VCC VCC_Z (.Y(VCC));
    CFG4 #( .INIT(16'h1000) )  un6_count_27 (.A(un2_count_cry_25_S_0), 
        .B(un2_count_cry_24_S_0), .C(un6_count_23_Z), .D(
        un6_count_13_Z), .Y(un6_count_27_Z));
    CFG4 #( .INIT(16'h0001) )  un6_count_19 (.A(un2_count_cry_12_S_0), 
        .B(un2_count_cry_13_S_0), .C(un2_count_cry_14_S_0), .D(
        un2_count_cry_15_S_0), .Y(un6_count_19_Z));
    CFG2 #( .INIT(4'h4) )  PB_Status_0_sqmuxa (.A(State[0]), .B(
        PRESETN), .Y(PB_Status_0_sqmuxa_Z));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_17 (.A(VCC), .B(
        count[17]), .C(GND), .D(GND), .FCI(un2_count_cry_16_Z), .S(
        un2_count_cry_17_S_0), .Y(un2_count_cry_17_Y_0), .FCO(
        un2_count_cry_17_Z));
    CFG4 #( .INIT(16'h1008) )  un15_pb_status (.A(PB_Status[7]), .B(
        PB_Status[3]), .C(un15_pb_status_1_0_Z), .D(un15_pb_status_1_Z)
        , .Y(un15_pb_status_0));
    SLE \PB_Status[4]  (.D(PB_Status[3]), .CLK(PCLK), .EN(
        PB_Status_0_sqmuxa_Z), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(PB_Status[4]));
    SLE \count[31]  (.D(count_4[31]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[31]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_22 (.A(VCC), .B(
        count[22]), .C(GND), .D(GND), .FCI(un2_count_cry_21_Z), .S(
        un2_count_cry_22_S_0), .Y(un2_count_cry_22_Y_0), .FCO(
        un2_count_cry_22_Z));
    CFG2 #( .INIT(4'h8) )  \count_4[3]  (.A(un2_count_cry_3_S_0), .B(
        State[0]), .Y(count_4[3]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_15 (.A(VCC), .B(
        count[15]), .C(GND), .D(GND), .FCI(un2_count_cry_14_Z), .S(
        un2_count_cry_15_S_0), .Y(un2_count_cry_15_Y_0), .FCO(
        un2_count_cry_15_Z));
    CFG2 #( .INIT(4'h8) )  \count_4[29]  (.A(un2_count_cry_29_S_0), .B(
        State[0]), .Y(count_4[29]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_26 (.A(VCC), .B(
        count[26]), .C(GND), .D(GND), .FCI(un2_count_cry_25_Z), .S(
        un2_count_cry_26_S_0), .Y(un2_count_cry_26_Y_0), .FCO(
        un2_count_cry_26_Z));
    SLE \count[18]  (.D(count_4[18]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[18]));
    CFG4 #( .INIT(16'h7FFF) )  \State_RNO[0]  (.A(un6_count_21_Z), .B(
        un6_count_20_Z), .C(un6_count_27_Z), .D(un6_count_28_Z), .Y(
        un6_count_i));
    CFG2 #( .INIT(4'h8) )  \count_4[30]  (.A(un2_count_cry_30_S_0), .B(
        State[0]), .Y(count_4[30]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_27 (.A(VCC), .B(
        count[27]), .C(GND), .D(GND), .FCI(un2_count_cry_26_Z), .S(
        un2_count_cry_27_S_0), .Y(un2_count_cry_27_Y_0), .FCO(
        un2_count_cry_27_Z));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_7 (.A(VCC), .B(count[7]), 
        .C(GND), .D(GND), .FCI(un2_count_cry_6_Z), .S(
        un2_count_cry_7_S_0), .Y(un2_count_cry_7_Y_0), .FCO(
        un2_count_cry_7_Z));
    SLE \PB_Status[7]  (.D(PB_Status[6]), .CLK(PCLK), .EN(
        PB_Status_0_sqmuxa_Z), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(PB_Status[7]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_25 (.A(VCC), .B(
        count[25]), .C(GND), .D(GND), .FCI(un2_count_cry_24_Z), .S(
        un2_count_cry_25_S_0), .Y(un2_count_cry_25_Y_0), .FCO(
        un2_count_cry_25_Z));
    CFG4 #( .INIT(16'h4CCD) )  un15_pb_status_1 (.A(PB_Status[0]), .B(
        PB_Status[3]), .C(PB_Status[2]), .D(PB_Status[1]), .Y(
        un15_pb_status_1_Z));
    CFG4 #( .INIT(16'h0001) )  un6_count_23 (.A(un2_count_cry_28_S_0), 
        .B(un2_count_cry_29_S_0), .C(un2_count_cry_30_S_0), .D(
        un2_count_s_31_S_0), .Y(un6_count_23_Z));
    SLE \PB_Status[2]  (.D(PB_Status[1]), .CLK(PCLK), .EN(
        PB_Status_0_sqmuxa_Z), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(PB_Status[2]));
    SLE \count[17]  (.D(count_4[17]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[17]));
    CFG2 #( .INIT(4'h8) )  \count_4[10]  (.A(un2_count_cry_10_S_0), .B(
        State[0]), .Y(count_4[10]));
    CFG2 #( .INIT(4'h8) )  \count_4[17]  (.A(un2_count_cry_17_S_0), .B(
        State[0]), .Y(count_4[17]));
    SLE \count[4]  (.D(un2_count_cry_4_S_0), .CLK(PCLK), .EN(VCC), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[4]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_8 (.A(VCC), .B(count[8]), 
        .C(GND), .D(GND), .FCI(un2_count_cry_7_Z), .S(
        un2_count_cry_8_S_0), .Y(un2_count_cry_8_Y_0), .FCO(
        un2_count_cry_8_Z));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_11 (.A(VCC), .B(
        count[11]), .C(GND), .D(GND), .FCI(un2_count_cry_10_Z), .S(
        un2_count_cry_11_S_0), .Y(un2_count_cry_11_Y_0), .FCO(
        un2_count_cry_11_Z));
    SLE \count[12]  (.D(count_4[12]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[12]));
    SLE \count[7]  (.D(count_4[7]), .CLK(PCLK), .EN(VCC), .ALn(PRESETN)
        , .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(count[7]));
    SLE \PB_Status[3]  (.D(PB_Status[2]), .CLK(PCLK), .EN(
        PB_Status_0_sqmuxa_Z), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(PB_Status[3]));
    CFG4 #( .INIT(16'h4CCD) )  un15_pb_status_1_0 (.A(PB_Status[4]), 
        .B(PB_Status[7]), .C(PB_Status[6]), .D(PB_Status[5]), .Y(
        un15_pb_status_1_0_Z));
    SLE \count[28]  (.D(count_4[28]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[28]));
    
endmodule


module UART_Term_UART_Term_0_Clock_gen_0s_0s(
       CUARTO1OI,
       CUARTl0OI,
       CUARTll_1z,
       CUARTIl,
       PCLK,
       PRESETN,
       CUARTl0_1z
    );
input  [7:3] CUARTO1OI;
input  [7:0] CUARTl0OI;
output CUARTll_1z;
output CUARTIl;
input  PCLK;
input  PRESETN;
output CUARTl0_1z;

    wire [3:0] CUARTO1;
    wire [3:0] CUARTO1_3;
    wire [12:0] CUARTO0;
    wire [12:0] CUARTO0_s;
    wire [11:0] CUARTO0_cry;
    wire [0:0] CUARTO0_RNI8F8F2_Y;
    wire [1:1] CUARTO0_RNI4B714_Y;
    wire [2:2] CUARTO0_RNI296J5_Y;
    wire [3:3] CUARTO0_RNI29557_Y;
    wire [4:4] CUARTO0_RNI4B4N8_Y;
    wire [5:5] CUARTO0_RNI8F39A_Y;
    wire [6:6] CUARTO0_RNIEL2RB_Y;
    wire [7:7] CUARTO0_RNIMT1DD_Y;
    wire [8:8] CUARTO0_RNIVOINE_Y;
    wire [9:9] CUARTO0_RNIAM32G_Y;
    wire [10:10] CUARTO0_RNIUIR6H_Y;
    wire [12:12] CUARTO0_RNO_FCO;
    wire [12:12] CUARTO0_RNO_Y;
    wire [11:11] CUARTO0_RNIKHJBI_Y;
    wire VCC, CUARTl05, GND, CUARTO08_1_RNIEL9T_Y, CUARTO0_cry_cy, 
        CUARTO08_1_RNIEL9T_S, CUARTO08_1, CUARTO08_7, CUARTO08_8, CO0;
    
    SLE \genblk1.CUARTO0[9]  (.D(CUARTO0_s[9]), .CLK(PCLK), .EN(VCC), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO0[9]));
    CFG2 #( .INIT(4'h8) )  \CUARTlOI.CUARTO1_3_1.CO0  (.A(CUARTIl), .B(
        CUARTO1[0]), .Y(CO0));
    ARI1 #( .INIT(20'h64700) )  \genblk1.CUARTO0_RNI29557[3]  (.A(VCC), 
        .B(CUARTl0OI[3]), .C(CUARTO08_1_RNIEL9T_Y), .D(CUARTO0[3]), 
        .FCI(CUARTO0_cry[2]), .S(CUARTO0_s[3]), .Y(
        CUARTO0_RNI29557_Y[3]), .FCO(CUARTO0_cry[3]));
    ARI1 #( .INIT(20'h64700) )  \genblk1.CUARTO0_RNI4B714[1]  (.A(VCC), 
        .B(CUARTl0OI[1]), .C(CUARTO08_1_RNIEL9T_Y), .D(CUARTO0[1]), 
        .FCI(CUARTO0_cry[0]), .S(CUARTO0_s[1]), .Y(
        CUARTO0_RNI4B714_Y[1]), .FCO(CUARTO0_cry[1]));
    SLE \genblk1.CUARTO0[6]  (.D(CUARTO0_s[6]), .CLK(PCLK), .EN(VCC), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO0[6]));
    SLE \genblk1.CUARTI0  (.D(CUARTO08_1_RNIEL9T_Y), .CLK(PCLK), .EN(
        VCC), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), 
        .Q(CUARTIl));
    SLE \CUARTO1[1]  (.D(CUARTO1_3[1]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO1[1]));
    SLE \genblk1.CUARTO0[12]  (.D(CUARTO0_s[12]), .CLK(PCLK), .EN(VCC), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO0[12]));
    ARI1 #( .INIT(20'h64700) )  \genblk1.CUARTO0_RNIMT1DD[7]  (.A(VCC), 
        .B(CUARTl0OI[7]), .C(CUARTO08_1_RNIEL9T_Y), .D(CUARTO0[7]), 
        .FCI(CUARTO0_cry[6]), .S(CUARTO0_s[7]), .Y(
        CUARTO0_RNIMT1DD_Y[7]), .FCO(CUARTO0_cry[7]));
    SLE \genblk1.CUARTO0[1]  (.D(CUARTO0_s[1]), .CLK(PCLK), .EN(VCC), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO0[1]));
    CFG2 #( .INIT(4'h6) )  \CUARTlOI.CUARTO1_3_1.SUM[1]  (.A(CO0), .B(
        CUARTO1[1]), .Y(CUARTO1_3[1]));
    SLE \genblk1.CUARTO0[10]  (.D(CUARTO0_s[10]), .CLK(PCLK), .EN(VCC), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO0[10]));
    CFG4 #( .INIT(16'h8000) )  \CUARTlOI.CUARTl05  (.A(CUARTO1[2]), .B(
        CUARTO1[3]), .C(CUARTO1[1]), .D(CUARTO1[0]), .Y(CUARTl05));
    SLE \CUARTO1[3]  (.D(CUARTO1_3[3]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO1[3]));
    ARI1 #( .INIT(20'h64700) )  \genblk1.CUARTO0_RNIAM32G[9]  (.A(VCC), 
        .B(CUARTO1OI[4]), .C(CUARTO08_1_RNIEL9T_Y), .D(CUARTO0[9]), 
        .FCI(CUARTO0_cry[8]), .S(CUARTO0_s[9]), .Y(
        CUARTO0_RNIAM32G_Y[9]), .FCO(CUARTO0_cry[9]));
    SLE \genblk1.CUARTO0[7]  (.D(CUARTO0_s[7]), .CLK(PCLK), .EN(VCC), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO0[7]));
    CFG4 #( .INIT(16'h0001) )  \genblk1.CUARTIOI.CUARTO08_7  (.A(
        CUARTO0[5]), .B(CUARTO0[4]), .C(CUARTO0[3]), .D(CUARTO0[2]), 
        .Y(CUARTO08_7));
    SLE \genblk1.CUARTO0[2]  (.D(CUARTO0_s[2]), .CLK(PCLK), .EN(VCC), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO0[2]));
    CFG4 #( .INIT(16'h0001) )  \genblk1.CUARTIOI.CUARTO08_8  (.A(
        CUARTO0[9]), .B(CUARTO0[8]), .C(CUARTO0[7]), .D(CUARTO0[6]), 
        .Y(CUARTO08_8));
    ARI1 #( .INIT(20'h64700) )  \genblk1.CUARTO0_RNI4B4N8[4]  (.A(VCC), 
        .B(CUARTl0OI[4]), .C(CUARTO08_1_RNIEL9T_Y), .D(CUARTO0[4]), 
        .FCI(CUARTO0_cry[3]), .S(CUARTO0_s[4]), .Y(
        CUARTO0_RNI4B4N8_Y[4]), .FCO(CUARTO0_cry[4]));
    ARI1 #( .INIT(20'h64700) )  \genblk1.CUARTO0_RNI8F8F2[0]  (.A(VCC), 
        .B(CUARTl0OI[0]), .C(CUARTO08_1_RNIEL9T_Y), .D(CUARTO0[0]), 
        .FCI(CUARTO0_cry_cy), .S(CUARTO0_s[0]), .Y(
        CUARTO0_RNI8F8F2_Y[0]), .FCO(CUARTO0_cry[0]));
    CFG3 #( .INIT(8'h78) )  \CUARTlOI.CUARTO1_3_1.SUM[2]  (.A(
        CUARTO1[1]), .B(CO0), .C(CUARTO1[2]), .Y(CUARTO1_3[2]));
    ARI1 #( .INIT(20'h64700) )  \genblk1.CUARTO0_RNIUIR6H[10]  (.A(VCC)
        , .B(CUARTO1OI[5]), .C(CUARTO08_1_RNIEL9T_Y), .D(CUARTO0[10]), 
        .FCI(CUARTO0_cry[9]), .S(CUARTO0_s[10]), .Y(
        CUARTO0_RNIUIR6H_Y[10]), .FCO(CUARTO0_cry[10]));
    ARI1 #( .INIT(20'h64700) )  \genblk1.CUARTO0_RNIVOINE[8]  (.A(VCC), 
        .B(CUARTO1OI[3]), .C(CUARTO08_1_RNIEL9T_Y), .D(CUARTO0[8]), 
        .FCI(CUARTO0_cry[7]), .S(CUARTO0_s[8]), .Y(
        CUARTO0_RNIVOINE_Y[8]), .FCO(CUARTO0_cry[8]));
    SLE \genblk1.CUARTO0[11]  (.D(CUARTO0_s[11]), .CLK(PCLK), .EN(VCC), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO0[11]));
    SLE \CUARTO1[2]  (.D(CUARTO1_3[2]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO1[2]));
    ARI1 #( .INIT(20'h40080) )  \genblk1.CUARTIOI.CUARTO08_1_RNIEL9T  
        (.A(CUARTO0[12]), .B(CUARTO08_1), .C(CUARTO08_7), .D(
        CUARTO08_8), .FCI(VCC), .S(CUARTO08_1_RNIEL9T_S), .Y(
        CUARTO08_1_RNIEL9T_Y), .FCO(CUARTO0_cry_cy));
    ARI1 #( .INIT(20'h44700) )  \genblk1.CUARTO0_RNO[12]  (.A(VCC), .B(
        CUARTO1OI[7]), .C(CUARTO08_1_RNIEL9T_Y), .D(CUARTO0[12]), .FCI(
        CUARTO0_cry[11]), .S(CUARTO0_s[12]), .Y(CUARTO0_RNO_Y[12]), 
        .FCO(CUARTO0_RNO_FCO[12]));
    ARI1 #( .INIT(20'h64700) )  \genblk1.CUARTO0_RNIKHJBI[11]  (.A(VCC)
        , .B(CUARTO1OI[6]), .C(CUARTO08_1_RNIEL9T_Y), .D(CUARTO0[11]), 
        .FCI(CUARTO0_cry[10]), .S(CUARTO0_s[11]), .Y(
        CUARTO0_RNIKHJBI_Y[11]), .FCO(CUARTO0_cry[11]));
    SLE \genblk1.CUARTO0[8]  (.D(CUARTO0_s[8]), .CLK(PCLK), .EN(VCC), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO0[8]));
    SLE \genblk1.CUARTO0[4]  (.D(CUARTO0_s[4]), .CLK(PCLK), .EN(VCC), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO0[4]));
    SLE \genblk1.CUARTO0[5]  (.D(CUARTO0_s[5]), .CLK(PCLK), .EN(VCC), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO0[5]));
    SLE CUARTl0 (.D(CUARTl05), .CLK(PCLK), .EN(CUARTIl), .ALn(PRESETN), 
        .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(CUARTl0_1z));
    GND GND_Z (.Y(GND));
    VCC VCC_Z (.Y(VCC));
    SLE \genblk1.CUARTO0[0]  (.D(CUARTO0_s[0]), .CLK(PCLK), .EN(VCC), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO0[0]));
    CFG2 #( .INIT(4'h6) )  \CUARTlOI.CUARTO1_3_1.SUM[0]  (.A(CUARTIl), 
        .B(CUARTO1[0]), .Y(CUARTO1_3[0]));
    ARI1 #( .INIT(20'h64700) )  \genblk1.CUARTO0_RNI8F39A[5]  (.A(VCC), 
        .B(CUARTl0OI[5]), .C(CUARTO08_1_RNIEL9T_Y), .D(CUARTO0[5]), 
        .FCI(CUARTO0_cry[4]), .S(CUARTO0_s[5]), .Y(
        CUARTO0_RNI8F39A_Y[5]), .FCO(CUARTO0_cry[5]));
    ARI1 #( .INIT(20'h64700) )  \genblk1.CUARTO0_RNIEL2RB[6]  (.A(VCC), 
        .B(CUARTl0OI[6]), .C(CUARTO08_1_RNIEL9T_Y), .D(CUARTO0[6]), 
        .FCI(CUARTO0_cry[5]), .S(CUARTO0_s[6]), .Y(
        CUARTO0_RNIEL2RB_Y[6]), .FCO(CUARTO0_cry[6]));
    CFG2 #( .INIT(4'h8) )  CUARTll (.A(CUARTIl), .B(CUARTl0_1z), .Y(
        CUARTll_1z));
    SLE \genblk1.CUARTO0[3]  (.D(CUARTO0_s[3]), .CLK(PCLK), .EN(VCC), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO0[3]));
    SLE \CUARTO1[0]  (.D(CUARTO1_3[0]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO1[0]));
    CFG4 #( .INIT(16'h0001) )  \genblk1.CUARTIOI.CUARTO08_1  (.A(
        CUARTO0[11]), .B(CUARTO0[10]), .C(CUARTO0[1]), .D(CUARTO0[0]), 
        .Y(CUARTO08_1));
    ARI1 #( .INIT(20'h64700) )  \genblk1.CUARTO0_RNI296J5[2]  (.A(VCC), 
        .B(CUARTl0OI[2]), .C(CUARTO08_1_RNIEL9T_Y), .D(CUARTO0[2]), 
        .FCI(CUARTO0_cry[1]), .S(CUARTO0_s[2]), .Y(
        CUARTO0_RNI296J5_Y[2]), .FCO(CUARTO0_cry[2]));
    CFG4 #( .INIT(16'h78F0) )  \CUARTlOI.CUARTO1_3_1.SUM[3]  (.A(
        CUARTO1[1]), .B(CO0), .C(CUARTO1[3]), .D(CUARTO1[2]), .Y(
        CUARTO1_3[3]));
    
endmodule


module UART_Term_UART_Term_0_Tx_async_0s_0s_0s_1s_2s_3s_4s_5s_6s(
       CUARTO1OI,
       CUARTO1I,
       CUARTO1I5,
       CUARTIl,
       CUARTl0,
       CUARTO1I5_i,
       TXRDY,
       FTDI_UART0_RXD,
       CUARTll,
       PCLK,
       PRESETN
    );
input  [2:0] CUARTO1OI;
input  [7:0] CUARTO1I;
input  CUARTO1I5;
input  CUARTIl;
input  CUARTl0;
input  CUARTO1I5_i;
output TXRDY;
output FTDI_UART0_RXD;
input  CUARTll;
input  PCLK;
input  PRESETN;

    wire [7:0] CUARTIl0l;
    wire [3:0] CUARTll0l;
    wire [0:0] CUARTll0l_3;
    wire [5:0] CUARTlI0l;
    wire [5:0] CUARTlI0l_ns;
    wire VCC, N_101_i, GND, N_91_i, N_93_i, N_95_i, CUARTO00l_Z, 
        CUARTO00l_5, un1_CUARTO00l_1_sqmuxa_0_Z, CUARTll1_4_iv_i, 
        N_113_i, CUARTOl0l_1_sqmuxa_i_Z, N_82_i, 
        CUARTll1_2_u_2_1_wmux_3_FCO, CUARTll1_2_u_2_1_wmux_3_S, 
        CUARTll1_2, CUARTll1_2_u_2_1_0_y1, CUARTll1_2_u_2_1_0_y3, 
        CUARTll1_2_u_2_1_co1_0, CUARTll1_2_u_2_1_wmux_2_S, 
        CUARTll1_2_u_2_1_y0_0, CUARTll1_2_u_2_1_co0_0, 
        CUARTll1_2_u_2_1_wmux_1_S, CUARTll1_2_u_2_1_0_co1, 
        CUARTll1_2_u_2_1_wmux_0_S, CUARTll1_2_u_2_1_0_y0, 
        CUARTll1_2_u_2_1_0_co0, CUARTll1_2_u_2_1_0_wmux_S, N_143, 
        N_97_i, N_98, CUARTll1_3_i_m, N_141, N_123, N_29, N_28, N_27, 
        N_26, N_25, N_24;
    
    CFG2 #( .INIT(4'hE) )  un1_CUARTO00l_1_sqmuxa_0 (.A(N_143), .B(
        CUARTlI0l[5]), .Y(un1_CUARTO00l_1_sqmuxa_0_Z));
    ARI1 #( .INIT(20'h0FA44) )  \CUARTl10l.CUARTll1_2_u_2_1_0_wmux  (
        .A(CUARTll0l[0]), .B(CUARTll0l[1]), .C(CUARTIl0l[0]), .D(
        CUARTIl0l[1]), .FCI(VCC), .S(CUARTll1_2_u_2_1_0_wmux_S), .Y(
        CUARTll1_2_u_2_1_0_y0), .FCO(CUARTll1_2_u_2_1_0_co0));
    CFG4 #( .INIT(16'hA0EC) )  \CUARTlI0l_ns[4]  (.A(N_143), .B(
        CUARTlI0l[4]), .C(N_141), .D(CUARTll), .Y(CUARTlI0l_ns[4]));
    SLE \CUARTIl0l[0]  (.D(CUARTO1I[0]), .CLK(PCLK), .EN(N_101_i), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTIl0l[0]));
    SLE \CUARTll0l[1]  (.D(N_91_i), .CLK(PCLK), .EN(CUARTll), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTll0l[1]));
    SLE \CUARTll0l[2]  (.D(N_93_i), .CLK(PCLK), .EN(CUARTll), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTll0l[2]));
    CFG4 #( .INIT(16'h0031) )  \CUARTl10l.CUARTll1_4_iv_i  (.A(
        CUARTlI0l[3]), .B(CUARTlI0l[2]), .C(CUARTll1_2), .D(
        CUARTll1_3_i_m), .Y(CUARTll1_4_iv_i));
    ARI1 #( .INIT(20'h0F588) )  \CUARTl10l.CUARTll1_2_u_2_1_wmux_0  (
        .A(CUARTll1_2_u_2_1_0_y0), .B(CUARTll0l[1]), .C(CUARTIl0l[2]), 
        .D(CUARTIl0l[3]), .FCI(CUARTll1_2_u_2_1_0_co0), .S(
        CUARTll1_2_u_2_1_wmux_0_S), .Y(CUARTll1_2_u_2_1_0_y1), .FCO(
        CUARTll1_2_u_2_1_0_co1));
    CFG2 #( .INIT(4'h6) )  \CUARTlI0l_ns_i_x2[3]  (.A(CUARTO1OI[0]), 
        .B(CUARTll0l[0]), .Y(N_97_i));
    SLE \CUARTIl0l[6]  (.D(CUARTO1I[6]), .CLK(PCLK), .EN(N_101_i), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTIl0l[6]));
    CFG2 #( .INIT(4'h2) )  \CUARTlI0l_ns_a3[1]  (.A(CUARTlI0l[0]), .B(
        TXRDY), .Y(CUARTlI0l_ns[1]));
    CFG4 #( .INIT(16'hF888) )  \CUARTlI0l_ns[0]  (.A(CUARTlI0l[5]), .B(
        CUARTll), .C(TXRDY), .D(CUARTlI0l[0]), .Y(CUARTlI0l_ns[0]));
    SLE \CUARTIl0l[4]  (.D(CUARTO1I[4]), .CLK(PCLK), .EN(N_101_i), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTIl0l[4]));
    SLE \CUARTIl0l[5]  (.D(CUARTO1I[5]), .CLK(PCLK), .EN(N_101_i), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTIl0l[5]));
    CFG4 #( .INIT(16'hFCFA) )  \CUARTlI0l_ns[5]  (.A(CUARTlI0l[5]), .B(
        CUARTlI0l[4]), .C(N_123), .D(CUARTll), .Y(CUARTlI0l_ns[5]));
    CFG3 #( .INIT(8'h06) )  \CUARTOO1l.CUARTO00l_5  (.A(CUARTll1_2), 
        .B(CUARTO00l_Z), .C(CUARTlI0l[5]), .Y(CUARTO00l_5));
    SLE \CUARTlI0l[5]  (.D(CUARTlI0l_ns[5]), .CLK(PCLK), .EN(VCC), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTlI0l[5]));
    SLE \CUARTll0l[3]  (.D(N_95_i), .CLK(PCLK), .EN(CUARTll), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTll0l[3]));
    SLE CUARTOl0l (.D(CUARTO1I5_i), .CLK(PCLK), .EN(
        CUARTOl0l_1_sqmuxa_i_Z), .ALn(PRESETN), .ADn(GND), .SLn(VCC), 
        .SD(GND), .LAT(GND), .Q(TXRDY));
    CFG3 #( .INIT(8'h48) )  \CUARTll0l_RNO[1]  (.A(CUARTll0l[1]), .B(
        CUARTlI0l[3]), .C(CUARTll0l[0]), .Y(N_91_i));
    CFG3 #( .INIT(8'hF8) )  CUARTOl0l_1_sqmuxa_i (.A(CUARTlI0l[2]), .B(
        CUARTll), .C(CUARTO1I5), .Y(CUARTOl0l_1_sqmuxa_i_Z));
    CFG4 #( .INIT(16'h0200) )  \CUARTlI0l_ns_i_a2[3]  (.A(CUARTll0l[1])
        , .B(N_97_i), .C(CUARTll0l[3]), .D(CUARTll0l[2]), .Y(N_141));
    SLE CUARTll1 (.D(CUARTll1_4_iv_i), .CLK(PCLK), .EN(N_113_i), .ALn(
        PRESETN), .ADn(GND), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        FTDI_UART0_RXD));
    CFG2 #( .INIT(4'h7) )  \CUARTI10l.CUARTll0l_3_i_o2[1]  (.A(
        CUARTll0l[1]), .B(CUARTll0l[0]), .Y(N_98));
    CFG3 #( .INIT(8'hFE) )  CUARTll1_RNO (.A(CUARTlI0l[0]), .B(CUARTll)
        , .C(CUARTlI0l[1]), .Y(N_113_i));
    ARI1 #( .INIT(20'h0FA44) )  \CUARTl10l.CUARTll1_2_u_2_1_wmux_1  (
        .A(CUARTll0l[0]), .B(CUARTll0l[1]), .C(CUARTIl0l[4]), .D(
        CUARTIl0l[5]), .FCI(CUARTll1_2_u_2_1_0_co1), .S(
        CUARTll1_2_u_2_1_wmux_1_S), .Y(CUARTll1_2_u_2_1_y0_0), .FCO(
        CUARTll1_2_u_2_1_co0_0));
    SLE \CUARTIl0l[1]  (.D(CUARTO1I[1]), .CLK(PCLK), .EN(N_101_i), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTIl0l[1]));
    SLE \CUARTlI0l[2]  (.D(CUARTlI0l_ns[2]), .CLK(PCLK), .EN(VCC), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTlI0l[2]));
    CFG3 #( .INIT(8'hAE) )  \CUARTlI0l_ns[2]  (.A(CUARTlI0l[1]), .B(
        CUARTlI0l[2]), .C(CUARTll), .Y(CUARTlI0l_ns[2]));
    CFG3 #( .INIT(8'h82) )  \CUARTl10l.CUARTll1_4_iv_i_RNO  (.A(
        CUARTlI0l[4]), .B(CUARTO1OI[2]), .C(CUARTO00l_Z), .Y(
        CUARTll1_3_i_m));
    SLE \CUARTIl0l[2]  (.D(CUARTO1I[2]), .CLK(PCLK), .EN(N_101_i), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTIl0l[2]));
    SLE CUARTO00l (.D(CUARTO00l_5), .CLK(PCLK), .EN(
        un1_CUARTO00l_1_sqmuxa_0_Z), .ALn(PRESETN), .ADn(VCC), .SLn(
        VCC), .SD(GND), .LAT(GND), .Q(CUARTO00l_Z));
    CFG3 #( .INIT(8'h82) )  \CUARTll0l_RNO[2]  (.A(CUARTlI0l[3]), .B(
        N_98), .C(CUARTll0l[2]), .Y(N_93_i));
    SLE \CUARTll0l[0]  (.D(CUARTll0l_3[0]), .CLK(PCLK), .EN(CUARTll), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTll0l[0]));
    CFG4 #( .INIT(16'h2000) )  \CUARTlI0l_ns_a3[5]  (.A(CUARTlI0l[3]), 
        .B(CUARTO1OI[1]), .C(CUARTll), .D(N_141), .Y(N_123));
    CFG4 #( .INIT(16'hCEAA) )  \CUARTlI0l_RNO[3]  (.A(CUARTlI0l[3]), 
        .B(CUARTlI0l[2]), .C(N_141), .D(CUARTll), .Y(N_82_i));
    ARI1 #( .INIT(20'h0EC2C) )  \CUARTl10l.CUARTll1_2_u_2_1_wmux_3  (
        .A(CUARTll1_2_u_2_1_0_y3), .B(CUARTll1_2_u_2_1_0_y1), .C(
        CUARTll0l[2]), .D(VCC), .FCI(CUARTll1_2_u_2_1_co1_0), .S(
        CUARTll1_2_u_2_1_wmux_3_S), .Y(CUARTll1_2), .FCO(
        CUARTll1_2_u_2_1_wmux_3_FCO));
    GND GND_Z (.Y(GND));
    SLE \CUARTlI0l[4]  (.D(CUARTlI0l_ns[4]), .CLK(PCLK), .EN(VCC), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTlI0l[4]));
    VCC VCC_Z (.Y(VCC));
    CFG2 #( .INIT(4'h2) )  \CUARTI10l.CUARTll0l_3_a3[0]  (.A(
        CUARTlI0l[3]), .B(CUARTll0l[0]), .Y(CUARTll0l_3[0]));
    SLE \CUARTIl0l[3]  (.D(CUARTO1I[3]), .CLK(PCLK), .EN(N_101_i), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTIl0l[3]));
    ARI1 #( .INIT(20'h0F588) )  \CUARTl10l.CUARTll1_2_u_2_1_wmux_2  (
        .A(CUARTll1_2_u_2_1_y0_0), .B(CUARTll0l[1]), .C(CUARTIl0l[6]), 
        .D(CUARTIl0l[7]), .FCI(CUARTll1_2_u_2_1_co0_0), .S(
        CUARTll1_2_u_2_1_wmux_2_S), .Y(CUARTll1_2_u_2_1_0_y3), .FCO(
        CUARTll1_2_u_2_1_co1_0));
    SLE \CUARTlI0l[1]  (.D(CUARTlI0l_ns[1]), .CLK(PCLK), .EN(VCC), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTlI0l[1]));
    SLE \CUARTlI0l[3]  (.D(N_82_i), .CLK(PCLK), .EN(VCC), .ALn(PRESETN)
        , .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(CUARTlI0l[3]));
    SLE \CUARTlI0l[0]  (.D(CUARTlI0l_ns[0]), .CLK(PCLK), .EN(VCC), 
        .ALn(PRESETN), .ADn(GND), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTlI0l[0]));
    CFG2 #( .INIT(4'h8) )  \CUARTlI0l_RNITQ8J[2]  (.A(CUARTll), .B(
        CUARTlI0l[2]), .Y(N_101_i));
    CFG4 #( .INIT(16'h8000) )  un1_CUARTO00l_1_sqmuxa_0_a2 (.A(
        CUARTlI0l[3]), .B(CUARTl0), .C(CUARTIl), .D(CUARTO1OI[1]), .Y(
        N_143));
    CFG4 #( .INIT(16'h82A0) )  \CUARTll0l_RNO[3]  (.A(CUARTlI0l[3]), 
        .B(N_98), .C(CUARTll0l[3]), .D(CUARTll0l[2]), .Y(N_95_i));
    SLE \CUARTIl0l[7]  (.D(CUARTO1I[7]), .CLK(PCLK), .EN(N_101_i), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTIl0l[7]));
    
endmodule


module UART_Term_UART_Term_0_Rx_async_0s_0s_0s_1s_2s_3s(
       CUARTO1OI,
       CUARTOIII,
       OVERFLOW,
       FRAMING_ERR,
       CUARTI00_1z,
       PARITY_ERR,
       CUARTllI,
       FTDI_UART0_TXD,
       CUARTIl,
       PCLK,
       PRESETN,
       CUARTOOl
    );
input  [2:0] CUARTO1OI;
output [7:0] CUARTOIII;
output OVERFLOW;
output FRAMING_ERR;
output CUARTI00_1z;
output PARITY_ERR;
output CUARTllI;
input  FTDI_UART0_TXD;
input  CUARTIl;
input  PCLK;
input  PRESETN;
input  CUARTOOl;

    wire [2:0] CUARTI1Il;
    wire [3:0] CUARTl0Il;
    wire [3:0] CUARTl0Il_4;
    wire [3:0] CUARTIlIl;
    wire [8:0] CUARTO0Il;
    wire [7:7] CUARTlOl_2;
    wire [8:0] CUARTO0Il_11;
    wire [3:0] CUARTIOll;
    wire [1:0] CUARTll0;
    wire [1:1] CUARTll0ce;
    wire [0:0] CUARTll0_ns;
    wire [7:7] CUARTO0Il_9_u_1_1;
    wire [7:7] CUARTO0Il_9;
    wire [2:2] CUARTll0_d;
    wire [0:0] CUARTIlIl_3_i_a2_0_1;
    wire CUARTOOl_i, GND, VCC, N_86_i, N_88_i, N_90_i, 
        CUARTlOl_1_sqmuxa_Z, un1_CUARTI1Il7_1_0_Z, N_84_i, 
        CUARTI0I_1_sqmuxa_i, CUARTll0_0_sqmuxa, i9_mux_0, 
        CUARTO1Il_1_sqmuxa_i_Z, CUARTI11_12, CUARTI11_1_sqmuxa_i_Z, 
        CUARTI0Il_Z, CUARTI0Il_4, CUARTOOll_Z, CUARTOOll_0_sqmuxa, 
        CUARTl1Il_Z, CUARTl1Il_4, CUARTI00_1_sqmuxa, 
        CUARTI01_0_sqmuxa_Z, un1_CUARTI0111_i, CUARTO11_1_sqmuxa_i_Z, 
        N_204_i, CUARTI0I_1_sqmuxa_Z, CUARTll0_s0_0_a2_Z, N_27_mux, 
        CUARTI115, CUARTI0I23, i1_mux, CUARTI0I10, m5_1_2, CUARTI0I_8, 
        CUARTI0I5, m18_1_1, CUARTll019, m18_1, CUARTOOll_0_sqmuxa_2, 
        N_30_mux, CUARTI0I5_0, N_115_1, CUARTll0_14_d, 
        CUARTI0I_0_sqmuxa_Z, CUARTll019_NE_1, CUARTI1115, 
        CUARTl0Il_0_sqmuxa_0_a2_Z, un1_CUARTI1131_1_Z, N_108, N_97_i, 
        N_123, CUARTI0Il4, CUARTI0Il_2, un1_CUARTI11_0_sqmuxa_1_i, 
        un1_CUARTI11_0_sqmuxa_i, N_93, N_211, CO1, N_12, N_11, N_10, 
        N_9, N_2, N_1;
    
    CFG4 #( .INIT(16'h5410) )  un1_CUARTI11_0_sqmuxa_1 (.A(
        CUARTO1OI[2]), .B(CUARTO1OI[0]), .C(CUARTI115), .D(CUARTI1115), 
        .Y(un1_CUARTI11_0_sqmuxa_1_i));
    CFG3 #( .INIT(8'hD8) )  \CUARTll0_ns_1_0_.m20  (.A(CUARTll0[1]), 
        .B(N_30_mux), .C(CUARTll019), .Y(i9_mux_0));
    SLE \CUARTI1Il[0]  (.D(CUARTI1Il[1]), .CLK(PCLK), .EN(CUARTIl), 
        .ALn(PRESETN), .ADn(GND), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTI1Il[0]));
    CFG2 #( .INIT(4'h8) )  \CUARTll0ce[1]  (.A(CUARTIl), .B(
        CUARTll0[0]), .Y(CUARTll0ce[1]));
    CFG2 #( .INIT(4'h8) )  CUARTl0Il_0_sqmuxa_0_a2 (.A(
        CUARTll0_s0_0_a2_Z), .B(CUARTIl), .Y(CUARTl0Il_0_sqmuxa_0_a2_Z)
        );
    SLE CUARTl1Il (.D(CUARTl1Il_4), .CLK(PCLK), .EN(CUARTIl), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTl1Il_Z));
    CFG4 #( .INIT(16'hF0FE) )  CUARTI11_1_sqmuxa_i (.A(
        un1_CUARTI11_0_sqmuxa_1_i), .B(un1_CUARTI11_0_sqmuxa_i), .C(
        CUARTOOl), .D(un1_CUARTI1131_1_Z), .Y(CUARTI11_1_sqmuxa_i_Z));
    CFG2 #( .INIT(4'h8) )  \CUARTO1ll.CUARTI0I5_0_0  (.A(CUARTl0Il[0]), 
        .B(CUARTl0Il[3]), .Y(CUARTI0I5_0));
    CFG4 #( .INIT(16'hBC8C) )  \CUARTll0_ns_1_0_.m18_2  (.A(N_30_mux), 
        .B(m18_1), .C(CUARTll0[1]), .D(N_27_mux), .Y(CUARTll0_ns[0]));
    SLE \CUARTIlIl[1]  (.D(N_86_i), .CLK(PCLK), .EN(CUARTIl), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTIlIl[1]));
    CFG4 #( .INIT(16'h1230) )  \CUARTIlIl_RNO[2]  (.A(CUARTIlIl[0]), 
        .B(N_93), .C(CUARTIlIl[2]), .D(CUARTIlIl[1]), .Y(N_88_i));
    CFG3 #( .INIT(8'h27) )  \CUARTO1ll.CUARTI0I_8.m5_1_2  (.A(
        CUARTO1OI[0]), .B(CUARTI0I5), .C(CUARTI0I23), .Y(m5_1_2));
    SLE CUARTI01 (.D(CUARTI01_0_sqmuxa_Z), .CLK(PCLK), .EN(
        un1_CUARTI0111_i), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(FRAMING_ERR));
    CFG3 #( .INIT(8'hDC) )  CUARTO1Il_1_sqmuxa_i (.A(CUARTI0I_8), .B(
        CUARTOOl), .C(CUARTIl), .Y(CUARTO1Il_1_sqmuxa_i_Z));
    SLE \CUARTIlIl[2]  (.D(N_88_i), .CLK(PCLK), .EN(CUARTIl), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTIlIl[2]));
    SLE \CUARTlOl[4]  (.D(CUARTO0Il[4]), .CLK(PCLK), .EN(
        CUARTlOl_1_sqmuxa_Z), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(CUARTOIII[4]));
    CFG2 #( .INIT(4'hE) )  CUARTI0I_1_sqmuxa_i_0 (.A(CUARTO1OI[0]), .B(
        CUARTO1OI[1]), .Y(CUARTI0I_1_sqmuxa_i));
    CFG4 #( .INIT(16'hEF00) )  \CUARTll0_ns_1_0_.m16  (.A(CUARTIlIl[0])
        , .B(CUARTIlIl[3]), .C(N_115_1), .D(i1_mux), .Y(N_30_mux));
    CFG3 #( .INIT(8'h20) )  \CUARTO1ll.CUARTI0I23  (.A(CUARTll0[0]), 
        .B(CUARTll0[1]), .C(CUARTI115), .Y(CUARTI0I23));
    CFG3 #( .INIT(8'h53) )  \CUARTO0ll.CUARTO0Il_9_u_1_1[7]  (.A(
        CUARTO0Il[8]), .B(CUARTO0Il[7]), .C(CUARTO1OI[0]), .Y(
        CUARTO0Il_9_u_1_1[7]));
    CFG4 #( .INIT(16'h060C) )  \CUARTO0ll.CUARTl0Il_4[0]  (.A(CUARTIl), 
        .B(CUARTl0Il[0]), .C(CUARTl0Il_0_sqmuxa_0_a2_Z), .D(N_27_mux), 
        .Y(CUARTl0Il_4[0]));
    CFG4 #( .INIT(16'h8000) )  \CUARTll0_ns_1_0_.m8  (.A(CUARTIlIl[2]), 
        .B(CUARTIlIl[3]), .C(CUARTIlIl[1]), .D(CUARTIlIl[0]), .Y(
        N_27_mux));
    CFG4 #( .INIT(16'h7BDE) )  \CUARTllll.CUARTll019_NE_1  (.A(
        CUARTIOll[3]), .B(CUARTIOll[0]), .C(CUARTl0Il[3]), .D(
        CUARTl0Il[0]), .Y(CUARTll019_NE_1));
    SLE \CUARTlOl[5]  (.D(CUARTO0Il[5]), .CLK(PCLK), .EN(
        CUARTlOl_1_sqmuxa_Z), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(CUARTOIII[5]));
    SLE \CUARTlOl[0]  (.D(CUARTO0Il[0]), .CLK(PCLK), .EN(
        CUARTlOl_1_sqmuxa_Z), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(CUARTOIII[0]));
    CFG3 #( .INIT(8'hF8) )  CUARTI01_RNO (.A(CUARTOOll_Z), .B(CUARTIl), 
        .C(CUARTOOl), .Y(un1_CUARTI0111_i));
    CFG2 #( .INIT(4'h1) )  CUARTll0_s0_0_a2 (.A(CUARTll0[1]), .B(
        CUARTll0[0]), .Y(CUARTll0_s0_0_a2_Z));
    CFG2 #( .INIT(4'h4) )  \CUARTO0ll.CUARTO0Il_11[2]  (.A(
        CUARTll0_s0_0_a2_Z), .B(CUARTO0Il[3]), .Y(CUARTO0Il_11[2]));
    CFG2 #( .INIT(4'h2) )  CUARTll0_s2_0_a2 (.A(CUARTll0[1]), .B(
        CUARTll0[0]), .Y(CUARTll0_d[2]));
    CFG2 #( .INIT(4'h4) )  CUARTll0_s1_0_a2 (.A(CUARTll0[1]), .B(
        CUARTll0[0]), .Y(CUARTll0_14_d));
    CFG2 #( .INIT(4'h8) )  CUARTI0I_0_sqmuxa (.A(CUARTO1OI[0]), .B(
        CUARTO1OI[1]), .Y(CUARTI0I_0_sqmuxa_Z));
    SLE \CUARTO0Il[4]  (.D(CUARTO0Il_11[4]), .CLK(PCLK), .EN(
        un1_CUARTI1Il7_1_0_Z), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), 
        .SD(GND), .LAT(GND), .Q(CUARTO0Il[4]));
    CFG3 #( .INIT(8'hE0) )  un1_CUARTI1Il7_1_0 (.A(CUARTll0_s0_0_a2_Z), 
        .B(N_27_mux), .C(CUARTIl), .Y(un1_CUARTI1Il7_1_0_Z));
    SLE \CUARTIlIl[3]  (.D(N_90_i), .CLK(PCLK), .EN(CUARTIl), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTIlIl[3]));
    CFG4 #( .INIT(16'h8000) )  CUARTOOll_0_sqmuxa_0_a2 (.A(
        CUARTOOll_0_sqmuxa_2), .B(i1_mux), .C(CUARTll0_d[2]), .D(
        N_115_1), .Y(CUARTOOll_0_sqmuxa));
    SLE CUARTO1Il (.D(CUARTOOl_i), .CLK(PCLK), .EN(
        CUARTO1Il_1_sqmuxa_i_Z), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), 
        .SD(GND), .LAT(GND), .Q(CUARTllI));
    CFG2 #( .INIT(4'h4) )  \CUARTO0ll.CUARTO0Il_11[1]  (.A(
        CUARTll0_s0_0_a2_Z), .B(CUARTO0Il[2]), .Y(CUARTO0Il_11[1]));
    SLE \CUARTO0Il[0]  (.D(CUARTO0Il_11[0]), .CLK(PCLK), .EN(
        un1_CUARTI1Il7_1_0_Z), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), 
        .SD(GND), .LAT(GND), .Q(CUARTO0Il[0]));
    CFG4 #( .INIT(16'h9555) )  \CUARTlIll.CUARTIlIl_3_i_x2[3]  (.A(
        CUARTIlIl[3]), .B(CUARTIlIl[2]), .C(CUARTIlIl[1]), .D(
        CUARTIlIl[0]), .Y(N_97_i));
    CFG4 #( .INIT(16'h78F0) )  \un1_CUARTl0Il_1.SUM[1]  (.A(CUARTIl), 
        .B(N_27_mux), .C(CUARTl0Il[1]), .D(CUARTl0Il[0]), .Y(N_211));
    CFG3 #( .INIT(8'h01) )  \CUARTIlIl_RNO[0]  (.A(N_93), .B(
        CUARTIlIl[0]), .C(N_108), .Y(N_84_i));
    CFG2 #( .INIT(4'h8) )  CUARTI01_0_sqmuxa (.A(CUARTIl), .B(
        CUARTOOll_Z), .Y(CUARTI01_0_sqmuxa_Z));
    CFG4 #( .INIT(16'h0800) )  CUARTlOl_1_sqmuxa (.A(CUARTll0_14_d), 
        .B(CUARTll019), .C(CUARTllI), .D(CUARTIl), .Y(
        CUARTlOl_1_sqmuxa_Z));
    CFG4 #( .INIT(16'h0081) )  \CUARTllll.CUARTll019_NE_i  (.A(
        CUARTIOll[1]), .B(CUARTl0Il[2]), .C(CUARTl0Il[1]), .D(
        CUARTll019_NE_1), .Y(CUARTll019));
    CFG3 #( .INIT(8'h80) )  \CUARTllll.CUARTl1Il_4  (.A(CUARTll019), 
        .B(CUARTllI), .C(CUARTll0_14_d), .Y(CUARTl1Il_4));
    CFG3 #( .INIT(8'h17) )  \CUARTll0_ns_1_0_.m12  (.A(CUARTI1Il[1]), 
        .B(CUARTI1Il[0]), .C(CUARTI1Il[2]), .Y(i1_mux));
    CFG2 #( .INIT(4'h8) )  CUARTll0_0_sqmuxa_0_a2 (.A(N_123), .B(
        CUARTIlIl[3]), .Y(CUARTll0_0_sqmuxa));
    CFG2 #( .INIT(4'h8) )  \CUARTI0ll.CUARTI0Il4  (.A(N_27_mux), .B(
        CUARTO1OI[1]), .Y(CUARTI0Il4));
    SLE \CUARTO0Il[2]  (.D(CUARTO0Il_11[2]), .CLK(PCLK), .EN(
        un1_CUARTI1Il7_1_0_Z), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), 
        .SD(GND), .LAT(GND), .Q(CUARTO0Il[2]));
    SLE \CUARTlOl[1]  (.D(CUARTO0Il[1]), .CLK(PCLK), .EN(
        CUARTlOl_1_sqmuxa_Z), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(CUARTOIII[1]));
    SLE \CUARTll0[1]  (.D(i9_mux_0), .CLK(PCLK), .EN(CUARTll0ce[1]), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTll0[1]));
    CFG3 #( .INIT(8'h40) )  \CUARTlIll.CUARTIlIl_3_i_a2_0_1[0]  (.A(
        CUARTIlIl[3]), .B(CUARTll0[1]), .C(CUARTll0[0]), .Y(
        CUARTIlIl_3_i_a2_0_1[0]));
    SLE \CUARTIOll[0]  (.D(N_204_i), .CLK(PCLK), .EN(CUARTll0_0_sqmuxa)
        , .ALn(PRESETN), .ADn(GND), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTIOll[0]));
    CFG2 #( .INIT(4'h4) )  CUARTOOll_0_sqmuxa_0_a2_2 (.A(CUARTIlIl[0]), 
        .B(CUARTIlIl[3]), .Y(CUARTOOll_0_sqmuxa_2));
    CFG4 #( .INIT(16'h0040) )  \CUARTlIll.CUARTIlIl_3_i_a2[0]  (.A(
        CUARTIlIl[1]), .B(CUARTll0_s0_0_a2_Z), .C(CUARTIlIl[3]), .D(
        CUARTIlIl[2]), .Y(N_108));
    CFG4 #( .INIT(16'h0301) )  \CUARTIlIl_RNO[3]  (.A(
        CUARTll0_s0_0_a2_Z), .B(N_123), .C(N_97_i), .D(i1_mux), .Y(
        N_90_i));
    CFG4 #( .INIT(16'h4000) )  \CUARTl0ll.CUARTI115  (.A(CUARTl0Il[3]), 
        .B(CUARTl0Il[2]), .C(CUARTl0Il[1]), .D(CUARTl0Il[0]), .Y(
        CUARTI115));
    CFG1 #( .INIT(2'h1) )  CUARTOOl_i_0 (.A(CUARTOOl), .Y(CUARTOOl_i));
    CFG4 #( .INIT(16'hA820) )  un1_CUARTI11_0_sqmuxa (.A(CUARTO1OI[2]), 
        .B(CUARTO1OI[0]), .C(CUARTI115), .D(CUARTI1115), .Y(
        un1_CUARTI11_0_sqmuxa_i));
    CFG3 #( .INIT(8'h7F) )  un1_CUARTI1131_1 (.A(CUARTIl), .B(N_27_mux)
        , .C(CUARTO1OI[1]), .Y(un1_CUARTI1131_1_Z));
    SLE CUARTOOll (.D(CUARTOOll_0_sqmuxa), .CLK(PCLK), .EN(CUARTIl), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTOOll_Z));
    SLE \CUARTIOll[1]  (.D(CUARTI0I_1_sqmuxa_Z), .CLK(PCLK), .EN(
        CUARTll0_0_sqmuxa), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(CUARTIOll[1]));
    SLE \CUARTl0Il[0]  (.D(CUARTl0Il_4[0]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTl0Il[0]));
    SLE CUARTI11 (.D(CUARTI11_12), .CLK(PCLK), .EN(
        CUARTI11_1_sqmuxa_i_Z), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), 
        .SD(GND), .LAT(GND), .Q(PARITY_ERR));
    CFG4 #( .INIT(16'h00B8) )  \CUARTI0ll.CUARTI0Il_4_u  (.A(
        CUARTI0Il_2), .B(CUARTI0Il4), .C(CUARTI0Il_Z), .D(
        CUARTll0_d[2]), .Y(CUARTI0Il_4));
    SLE \CUARTll0[0]  (.D(CUARTll0_ns[0]), .CLK(PCLK), .EN(CUARTIl), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTll0[0]));
    CFG4 #( .INIT(16'h5140) )  \CUARTl0ll.CUARTI11_12_iv  (.A(CUARTOOl)
        , .B(CUARTI0Il_2), .C(un1_CUARTI11_0_sqmuxa_1_i), .D(
        un1_CUARTI11_0_sqmuxa_i), .Y(CUARTI11_12));
    SLE \CUARTO0Il[1]  (.D(CUARTO0Il_11[1]), .CLK(PCLK), .EN(
        un1_CUARTI1Il7_1_0_Z), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), 
        .SD(GND), .LAT(GND), .Q(CUARTO0Il[1]));
    SLE \CUARTO0Il[3]  (.D(CUARTO0Il_11[3]), .CLK(PCLK), .EN(
        un1_CUARTI1Il7_1_0_Z), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), 
        .SD(GND), .LAT(GND), .Q(CUARTO0Il[3]));
    CFG4 #( .INIT(16'h069F) )  \CUARTO0ll.CUARTO0Il_9_u[7]  (.A(
        CUARTO1OI[0]), .B(CUARTO1OI[1]), .C(i1_mux), .D(
        CUARTO0Il_9_u_1_1[7]), .Y(CUARTO0Il_9[7]));
    SLE \CUARTl0Il[2]  (.D(CUARTl0Il_4[2]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTl0Il[2]));
    CFG2 #( .INIT(4'h8) )  CUARTI00_1_sqmuxa_0_a2 (.A(N_27_mux), .B(
        CUARTll0_d[2]), .Y(CUARTI00_1_sqmuxa));
    GND GND_Z (.Y(GND));
    VCC VCC_Z (.Y(VCC));
    CFG2 #( .INIT(4'h9) )  \CUARTIOll_RNO[0]  (.A(CUARTO1OI[0]), .B(
        CUARTO1OI[1]), .Y(N_204_i));
    CFG2 #( .INIT(4'h4) )  \CUARTO0ll.CUARTO0Il_11[5]  (.A(
        CUARTll0_s0_0_a2_Z), .B(CUARTO0Il[6]), .Y(CUARTO0Il_11[5]));
    SLE \CUARTIlIl[0]  (.D(N_84_i), .CLK(PCLK), .EN(CUARTIl), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTIlIl[0]));
    CFG2 #( .INIT(4'h1) )  CUARTI0I_1_sqmuxa (.A(CUARTO1OI[0]), .B(
        CUARTO1OI[1]), .Y(CUARTI0I_1_sqmuxa_Z));
    SLE CUARTI00 (.D(CUARTI00_1_sqmuxa), .CLK(PCLK), .EN(CUARTIl), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTI00_1z));
    CFG2 #( .INIT(4'h4) )  \CUARTO0ll.CUARTO0Il_11[4]  (.A(
        CUARTll0_s0_0_a2_Z), .B(CUARTO0Il[5]), .Y(CUARTO0Il_11[4]));
    CFG2 #( .INIT(4'h8) )  \CUARTllll.CUARTlOl_2[7]  (.A(CUARTO1OI[0]), 
        .B(CUARTO0Il[7]), .Y(CUARTlOl_2[7]));
    SLE CUARTO11 (.D(CUARTOOl_i), .CLK(PCLK), .EN(
        CUARTO11_1_sqmuxa_i_Z), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), 
        .SD(GND), .LAT(GND), .Q(OVERFLOW));
    CFG4 #( .INIT(16'h0008) )  \CUARTO1ll.CUARTI0I5  (.A(CUARTI0I5_0), 
        .B(CUARTll0_14_d), .C(CUARTl0Il[2]), .D(CUARTl0Il[1]), .Y(
        CUARTI0I5));
    CFG2 #( .INIT(4'h8) )  \CUARTO1ll.CUARTI0I10  (.A(CUARTI1115), .B(
        CUARTll0_14_d), .Y(CUARTI0I10));
    CFG2 #( .INIT(4'h4) )  \CUARTO0ll.CUARTO0Il_11[3]  (.A(
        CUARTll0_s0_0_a2_Z), .B(CUARTO0Il[4]), .Y(CUARTO0Il_11[3]));
    CFG2 #( .INIT(4'h4) )  \CUARTO0ll.CUARTl0Il_4[1]  (.A(
        CUARTl0Il_0_sqmuxa_0_a2_Z), .B(N_211), .Y(CUARTl0Il_4[1]));
    CFG2 #( .INIT(4'h8) )  \CUARTll0_ns_1_0_.m16_e_0  (.A(CUARTIlIl[1])
        , .B(CUARTIlIl[2]), .Y(N_115_1));
    CFG4 #( .INIT(16'h1032) )  \CUARTO0ll.CUARTO0Il_11[6]  (.A(
        CUARTI0I_1_sqmuxa_Z), .B(CUARTll0_s0_0_a2_Z), .C(CUARTO0Il[7]), 
        .D(i1_mux), .Y(CUARTO0Il_11[6]));
    CFG4 #( .INIT(16'h040E) )  \CUARTO0ll.CUARTO0Il_11[8]  (.A(
        CUARTI0I_0_sqmuxa_Z), .B(CUARTO0Il[8]), .C(CUARTll0_s0_0_a2_Z), 
        .D(i1_mux), .Y(CUARTO0Il_11[8]));
    CFG2 #( .INIT(4'h9) )  \CUARTI0ll.CUARTI0Il_2  (.A(i1_mux), .B(
        CUARTI0Il_Z), .Y(CUARTI0Il_2));
    SLE \CUARTlOl[3]  (.D(CUARTO0Il[3]), .CLK(PCLK), .EN(
        CUARTlOl_1_sqmuxa_Z), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(CUARTOIII[3]));
    SLE \CUARTl0Il[1]  (.D(CUARTl0Il_4[1]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTl0Il[1]));
    SLE \CUARTO0Il[8]  (.D(CUARTO0Il_11[8]), .CLK(PCLK), .EN(
        un1_CUARTI1Il7_1_0_Z), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), 
        .SD(GND), .LAT(GND), .Q(CUARTO0Il[8]));
    SLE \CUARTO0Il[7]  (.D(CUARTO0Il_11[7]), .CLK(PCLK), .EN(
        un1_CUARTI1Il7_1_0_Z), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), 
        .SD(GND), .LAT(GND), .Q(CUARTO0Il[7]));
    SLE \CUARTl0Il[3]  (.D(CUARTl0Il_4[3]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTl0Il[3]));
    SLE \CUARTlOl[6]  (.D(CUARTO0Il[6]), .CLK(PCLK), .EN(
        CUARTlOl_1_sqmuxa_Z), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(CUARTOIII[6]));
    SLE \CUARTI1Il[2]  (.D(FTDI_UART0_TXD), .CLK(PCLK), .EN(CUARTIl), 
        .ALn(PRESETN), .ADn(GND), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTI1Il[2]));
    CFG3 #( .INIT(8'h04) )  \CUARTll0_ns_1_0_.m18_1_1  (.A(
        CUARTIlIl[1]), .B(CUARTOOll_0_sqmuxa_2), .C(CUARTIlIl[2]), .Y(
        m18_1_1));
    SLE \CUARTlOl[2]  (.D(CUARTO0Il[2]), .CLK(PCLK), .EN(
        CUARTlOl_1_sqmuxa_Z), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(CUARTOIII[2]));
    SLE \CUARTIOll[3]  (.D(CUARTI0I_1_sqmuxa_i), .CLK(PCLK), .EN(
        CUARTll0_0_sqmuxa), .ALn(PRESETN), .ADn(GND), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(CUARTIOll[3]));
    SLE \CUARTI1Il[1]  (.D(CUARTI1Il[2]), .CLK(PCLK), .EN(CUARTIl), 
        .ALn(PRESETN), .ADn(GND), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTI1Il[1]));
    CFG3 #( .INIT(8'hF8) )  CUARTO11_1_sqmuxa_i (.A(CUARTl1Il_Z), .B(
        CUARTIl), .C(CUARTOOl), .Y(CUARTO11_1_sqmuxa_i_Z));
    CFG4 #( .INIT(16'h8000) )  \un1_CUARTl0Il_1.CO1  (.A(CUARTIl), .B(
        N_27_mux), .C(CUARTl0Il[1]), .D(CUARTl0Il[0]), .Y(CO1));
    CFG4 #( .INIT(16'h006A) )  \CUARTO0ll.CUARTl0Il_4[3]  (.A(
        CUARTl0Il[3]), .B(CUARTl0Il[2]), .C(CO1), .D(
        CUARTl0Il_0_sqmuxa_0_a2_Z), .Y(CUARTl0Il_4[3]));
    SLE \CUARTlOl[7]  (.D(CUARTlOl_2[7]), .CLK(PCLK), .EN(
        CUARTlOl_1_sqmuxa_Z), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(CUARTOIII[7]));
    SLE \CUARTO0Il[5]  (.D(CUARTO0Il_11[5]), .CLK(PCLK), .EN(
        un1_CUARTI1Il7_1_0_Z), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), 
        .SD(GND), .LAT(GND), .Q(CUARTO0Il[5]));
    CFG4 #( .INIT(16'h98BA) )  \CUARTll0_ns_1_0_.m18_1  (.A(
        CUARTll0[0]), .B(CUARTll0[1]), .C(m18_1_1), .D(CUARTll019), .Y(
        m18_1));
    CFG4 #( .INIT(16'h0004) )  \CUARTlIll.CUARTIlIl_3_i_a2_0[3]  (.A(
        CUARTIlIl[0]), .B(CUARTll0_s0_0_a2_Z), .C(CUARTIlIl[2]), .D(
        CUARTIlIl[1]), .Y(N_123));
    CFG3 #( .INIT(8'h12) )  \CUARTIlIl_RNO[1]  (.A(CUARTIlIl[0]), .B(
        N_93), .C(CUARTIlIl[1]), .Y(N_86_i));
    CFG2 #( .INIT(4'h4) )  \CUARTO0ll.CUARTO0Il_11[7]  (.A(
        CUARTll0_s0_0_a2_Z), .B(CUARTO0Il_9[7]), .Y(CUARTO0Il_11[7]));
    SLE \CUARTO0Il[6]  (.D(CUARTO0Il_11[6]), .CLK(PCLK), .EN(
        un1_CUARTI1Il7_1_0_Z), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), 
        .SD(GND), .LAT(GND), .Q(CUARTO0Il[6]));
    CFG4 #( .INIT(16'hDC50) )  \CUARTlIll.CUARTIlIl_3_i_o2[0]  (.A(
        i1_mux), .B(CUARTIlIl_3_i_a2_0_1[0]), .C(CUARTll0_s0_0_a2_Z), 
        .D(N_115_1), .Y(N_93));
    SLE CUARTI0Il (.D(CUARTI0Il_4), .CLK(PCLK), .EN(CUARTIl), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTI0Il_Z));
    CFG3 #( .INIT(8'h14) )  \CUARTO0ll.CUARTl0Il_4[2]  (.A(
        CUARTl0Il_0_sqmuxa_0_a2_Z), .B(CUARTl0Il[2]), .C(CO1), .Y(
        CUARTl0Il_4[2]));
    CFG4 #( .INIT(16'h0002) )  \CUARTl0ll.CUARTI1115  (.A(CUARTl0Il[3])
        , .B(CUARTl0Il[2]), .C(CUARTl0Il[1]), .D(CUARTl0Il[0]), .Y(
        CUARTI1115));
    CFG4 #( .INIT(16'hC55C) )  \CUARTO1ll.CUARTI0I_8.m5  (.A(
        CUARTI0I10), .B(m5_1_2), .C(CUARTO1OI[1]), .D(CUARTO1OI[0]), 
        .Y(CUARTI0I_8));
    CFG2 #( .INIT(4'h4) )  \CUARTO0ll.CUARTO0Il_11[0]  (.A(
        CUARTll0_s0_0_a2_Z), .B(CUARTO0Il[1]), .Y(CUARTO0Il_11[0]));
    
endmodule


module UART_Term_UART_Term_0_COREUART_0s_0s_0s_24s_0s_0s(
       CUARTOIII,
       CUARTO1OI,
       CUARTl0OI,
       PWDATA_in,
       CUARTOOl,
       FTDI_UART0_TXD,
       PARITY_ERR,
       FRAMING_ERR,
       OVERFLOW,
       FTDI_UART0_RXD,
       TXRDY,
       CUARTO1I5_i,
       RXRDY,
       CUARTO1I5,
       PCLK,
       PRESETN
    );
output [7:0] CUARTOIII;
input  [7:0] CUARTO1OI;
input  [7:0] CUARTl0OI;
input  [7:0] PWDATA_in;
input  CUARTOOl;
input  FTDI_UART0_TXD;
output PARITY_ERR;
output FRAMING_ERR;
output OVERFLOW;
output FTDI_UART0_RXD;
output TXRDY;
input  CUARTO1I5_i;
output RXRDY;
input  CUARTO1I5;
input  PCLK;
input  PRESETN;

    wire [7:0] CUARTO1I;
    wire VCC, GND, CUARTllI, RXRDY4, CUARTI00, CUARTll, CUARTIl, 
        CUARTl0;
    
    SLE \genblk1.RXRDY  (.D(CUARTllI), .CLK(PCLK), .EN(RXRDY4), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(RXRDY));
    GND GND_Z (.Y(GND));
    SLE \CUARTO1I[3]  (.D(PWDATA_in[3]), .CLK(PCLK), .EN(CUARTO1I5), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO1I[3]));
    UART_Term_UART_Term_0_Clock_gen_0s_0s CUARTOO1 (.CUARTO1OI({
        CUARTO1OI[7], CUARTO1OI[6], CUARTO1OI[5], CUARTO1OI[4], 
        CUARTO1OI[3]}), .CUARTl0OI({CUARTl0OI[7], CUARTl0OI[6], 
        CUARTl0OI[5], CUARTl0OI[4], CUARTl0OI[3], CUARTl0OI[2], 
        CUARTl0OI[1], CUARTl0OI[0]}), .CUARTll_1z(CUARTll), .CUARTIl(
        CUARTIl), .PCLK(PCLK), .PRESETN(PRESETN), .CUARTl0_1z(CUARTl0));
    CFG2 #( .INIT(4'hD) )  \genblk1.RXRDY4  (.A(CUARTllI), .B(CUARTI00)
        , .Y(RXRDY4));
    SLE \CUARTO1I[0]  (.D(PWDATA_in[0]), .CLK(PCLK), .EN(CUARTO1I5), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO1I[0]));
    UART_Term_UART_Term_0_Tx_async_0s_0s_0s_1s_2s_3s_4s_5s_6s CUARTIO1 
        (.CUARTO1OI({CUARTO1OI[2], CUARTO1OI[1], CUARTO1OI[0]}), 
        .CUARTO1I({CUARTO1I[7], CUARTO1I[6], CUARTO1I[5], CUARTO1I[4], 
        CUARTO1I[3], CUARTO1I[2], CUARTO1I[1], CUARTO1I[0]}), 
        .CUARTO1I5(CUARTO1I5), .CUARTIl(CUARTIl), .CUARTl0(CUARTl0), 
        .CUARTO1I5_i(CUARTO1I5_i), .TXRDY(TXRDY), .FTDI_UART0_RXD(
        FTDI_UART0_RXD), .CUARTll(CUARTll), .PCLK(PCLK), .PRESETN(
        PRESETN));
    SLE \CUARTO1I[5]  (.D(PWDATA_in[5]), .CLK(PCLK), .EN(CUARTO1I5), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO1I[5]));
    VCC VCC_Z (.Y(VCC));
    SLE \CUARTO1I[6]  (.D(PWDATA_in[6]), .CLK(PCLK), .EN(CUARTO1I5), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO1I[6]));
    SLE \CUARTO1I[4]  (.D(PWDATA_in[4]), .CLK(PCLK), .EN(CUARTO1I5), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO1I[4]));
    UART_Term_UART_Term_0_Rx_async_0s_0s_0s_1s_2s_3s CUARTO01 (
        .CUARTO1OI({CUARTO1OI[2], CUARTO1OI[1], CUARTO1OI[0]}), 
        .CUARTOIII({CUARTOIII[7], CUARTOIII[6], CUARTOIII[5], 
        CUARTOIII[4], CUARTOIII[3], CUARTOIII[2], CUARTOIII[1], 
        CUARTOIII[0]}), .OVERFLOW(OVERFLOW), .FRAMING_ERR(FRAMING_ERR), 
        .CUARTI00_1z(CUARTI00), .PARITY_ERR(PARITY_ERR), .CUARTllI(
        CUARTllI), .FTDI_UART0_TXD(FTDI_UART0_TXD), .CUARTIl(CUARTIl), 
        .PCLK(PCLK), .PRESETN(PRESETN), .CUARTOOl(CUARTOOl));
    SLE \CUARTO1I[7]  (.D(PWDATA_in[7]), .CLK(PCLK), .EN(CUARTO1I5), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO1I[7]));
    SLE \CUARTO1I[2]  (.D(PWDATA_in[2]), .CLK(PCLK), .EN(CUARTO1I5), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO1I[2]));
    SLE \CUARTO1I[1]  (.D(PWDATA_in[1]), .CLK(PCLK), .EN(CUARTO1I5), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO1I[1]));
    
endmodule


module UART_Term_UART_Term_0_CoreUARTapb_Z3_layer0(
       CUARTOIII,
       PADDR_in,
       CUARTO1OI,
       APB3_Bus_0_APBmslave0_PRDATA,
       CUARTl0OI,
       PWDATA_in,
       CUARTO1I5,
       RXRDY,
       CUARTO1I5_i,
       TXRDY,
       FTDI_UART0_RXD,
       OVERFLOW,
       FRAMING_ERR,
       FTDI_UART0_TXD,
       CUARTOOl,
       PENABLE_in,
       PWRITE_in,
       APB3_Bus_0_APBmslave0_PSELx,
       N_82_i,
       CUARTl0OI4,
       CUARTO1OI4,
       N_52_0_i,
       N_55_0_i,
       N_58_0_i,
       N_63_i,
       N_79_i,
       N_73_i,
       PCLK,
       PRESETN
    );
output [7:0] CUARTOIII;
input  [4:2] PADDR_in;
output [7:0] CUARTO1OI;
output [7:0] APB3_Bus_0_APBmslave0_PRDATA;
output [7:0] CUARTl0OI;
input  [7:0] PWDATA_in;
input  CUARTO1I5;
output RXRDY;
input  CUARTO1I5_i;
output TXRDY;
output FTDI_UART0_RXD;
output OVERFLOW;
output FRAMING_ERR;
input  FTDI_UART0_TXD;
input  CUARTOOl;
input  PENABLE_in;
input  PWRITE_in;
input  APB3_Bus_0_APBmslave0_PSELx;
input  N_82_i;
input  CUARTl0OI4;
input  CUARTO1OI4;
input  N_52_0_i;
input  N_55_0_i;
input  N_58_0_i;
input  N_63_i;
input  N_79_i;
input  N_73_i;
input  PCLK;
input  PRESETN;

    wire [2:2] CUARTl1OI;
    wire [2:2] CUARTO1OI_Z;
    wire [2:2] CUARTl0OI_Z;
    wire [2:2] CUARTl1OI_5_1_1;
    wire [2:2] CUARTl1OI_5_1;
    wire [2:2] CUARTOIII_Z;
    wire VCC, un1_CUARTl1OI23_i, GND, PARITY_ERR, un1_CUARTl1OI23_0_Z;
    
    GND GND_Z (.Y(GND));
    SLE \CUARTO1OI_Z[6]  (.D(PWDATA_in[6]), .CLK(PCLK), .EN(CUARTO1OI4)
        , .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO1OI[6]));
    SLE \CUARTO1OI_Z[1]  (.D(PWDATA_in[1]), .CLK(PCLK), .EN(CUARTO1OI4)
        , .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO1OI[1]));
    SLE \CUARTOOII[6]  (.D(N_55_0_i), .CLK(PCLK), .EN(
        un1_CUARTl1OI23_i), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(APB3_Bus_0_APBmslave0_PRDATA[6]));
    SLE \CUARTO1OI_Z[5]  (.D(PWDATA_in[5]), .CLK(PCLK), .EN(CUARTO1OI4)
        , .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO1OI[5]));
    CFG4 #( .INIT(16'h1011) )  un1_CUARTl1OI23_0_RNITGC21 (.A(
        PWRITE_in), .B(un1_CUARTl1OI23_0_Z), .C(PARITY_ERR), .D(
        PENABLE_in), .Y(un1_CUARTl1OI23_i));
    SLE \CUARTOOII[5]  (.D(N_58_0_i), .CLK(PCLK), .EN(
        un1_CUARTl1OI23_i), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(APB3_Bus_0_APBmslave0_PRDATA[5]));
    SLE \CUARTO1OI_Z[0]  (.D(PWDATA_in[0]), .CLK(PCLK), .EN(CUARTO1OI4)
        , .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO1OI[0]));
    SLE \CUARTl0OI_Z[6]  (.D(PWDATA_in[6]), .CLK(PCLK), .EN(CUARTl0OI4)
        , .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTl0OI[6]));
    VCC VCC_Z (.Y(VCC));
    CFG4 #( .INIT(16'hF588) )  \CUARTl1OI_5_2[2]  (.A(PADDR_in[3]), .B(
        CUARTl0OI_Z[2]), .C(CUARTO1OI_Z[2]), .D(CUARTl1OI_5_1[2]), .Y(
        CUARTl1OI[2]));
    SLE \CUARTO1OI_Z[3]  (.D(PWDATA_in[3]), .CLK(PCLK), .EN(CUARTO1OI4)
        , .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO1OI[3]));
    SLE \CUARTOOII[1]  (.D(N_73_i), .CLK(PCLK), .EN(un1_CUARTl1OI23_i), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        APB3_Bus_0_APBmslave0_PRDATA[1]));
    SLE \CUARTOOII[3]  (.D(N_79_i), .CLK(PCLK), .EN(un1_CUARTl1OI23_i), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        APB3_Bus_0_APBmslave0_PRDATA[3]));
    CFG4 #( .INIT(16'hFC02) )  \CUARTl1OI_5_1[2]  (.A(PARITY_ERR), .B(
        CUARTl1OI_5_1_1[2]), .C(PADDR_in[3]), .D(PADDR_in[2]), .Y(
        CUARTl1OI_5_1[2]));
    SLE \CUARTl0OI_Z[7]  (.D(PWDATA_in[7]), .CLK(PCLK), .EN(CUARTl0OI4)
        , .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTl0OI[7]));
    SLE \CUARTl0OI_Z[1]  (.D(PWDATA_in[1]), .CLK(PCLK), .EN(CUARTl0OI4)
        , .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTl0OI[1]));
    CFG3 #( .INIT(8'h51) )  \CUARTl1OI_5_1_1[2]  (.A(PADDR_in[4]), .B(
        PADDR_in[2]), .C(CUARTOIII_Z[2]), .Y(CUARTl1OI_5_1_1[2]));
    SLE \CUARTl0OI_Z[0]  (.D(PWDATA_in[0]), .CLK(PCLK), .EN(CUARTl0OI4)
        , .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTl0OI[0]));
    SLE \CUARTOOII[0]  (.D(N_82_i), .CLK(PCLK), .EN(un1_CUARTl1OI23_i), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        APB3_Bus_0_APBmslave0_PRDATA[0]));
    CFG3 #( .INIT(8'h8F) )  un1_CUARTl1OI23_0 (.A(PADDR_in[4]), .B(
        PADDR_in[3]), .C(APB3_Bus_0_APBmslave0_PSELx), .Y(
        un1_CUARTl1OI23_0_Z));
    SLE \CUARTOOII[2]  (.D(CUARTl1OI[2]), .CLK(PCLK), .EN(
        un1_CUARTl1OI23_i), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(APB3_Bus_0_APBmslave0_PRDATA[2]));
    SLE \CUARTl0OI_Z[5]  (.D(PWDATA_in[5]), .CLK(PCLK), .EN(CUARTl0OI4)
        , .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTl0OI[5]));
    SLE \CUARTO1OI_Z[7]  (.D(PWDATA_in[7]), .CLK(PCLK), .EN(CUARTO1OI4)
        , .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO1OI[7]));
    SLE \CUARTl0OI_Z[2]  (.D(PWDATA_in[2]), .CLK(PCLK), .EN(CUARTl0OI4)
        , .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTl0OI_Z[2]));
    SLE \CUARTOOII[4]  (.D(N_63_i), .CLK(PCLK), .EN(un1_CUARTl1OI23_i), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        APB3_Bus_0_APBmslave0_PRDATA[4]));
    SLE \CUARTO1OI_Z[2]  (.D(PWDATA_in[2]), .CLK(PCLK), .EN(CUARTO1OI4)
        , .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO1OI_Z[2]));
    UART_Term_UART_Term_0_COREUART_0s_0s_0s_24s_0s_0s CUARTlOlI (
        .CUARTOIII({CUARTOIII[7], CUARTOIII[6], CUARTOIII[5], 
        CUARTOIII[4], CUARTOIII[3], CUARTOIII_Z[2], CUARTOIII[1], 
        CUARTOIII[0]}), .CUARTO1OI({CUARTO1OI[7], CUARTO1OI[6], 
        CUARTO1OI[5], CUARTO1OI[4], CUARTO1OI[3], CUARTO1OI_Z[2], 
        CUARTO1OI[1], CUARTO1OI[0]}), .CUARTl0OI({CUARTl0OI[7], 
        CUARTl0OI[6], CUARTl0OI[5], CUARTl0OI[4], CUARTl0OI[3], 
        CUARTl0OI_Z[2], CUARTl0OI[1], CUARTl0OI[0]}), .PWDATA_in({
        PWDATA_in[7], PWDATA_in[6], PWDATA_in[5], PWDATA_in[4], 
        PWDATA_in[3], PWDATA_in[2], PWDATA_in[1], PWDATA_in[0]}), 
        .CUARTOOl(CUARTOOl), .FTDI_UART0_TXD(FTDI_UART0_TXD), 
        .PARITY_ERR(PARITY_ERR), .FRAMING_ERR(FRAMING_ERR), .OVERFLOW(
        OVERFLOW), .FTDI_UART0_RXD(FTDI_UART0_RXD), .TXRDY(TXRDY), 
        .CUARTO1I5_i(CUARTO1I5_i), .RXRDY(RXRDY), .CUARTO1I5(CUARTO1I5)
        , .PCLK(PCLK), .PRESETN(PRESETN));
    SLE \CUARTl0OI_Z[4]  (.D(PWDATA_in[4]), .CLK(PCLK), .EN(CUARTl0OI4)
        , .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTl0OI[4]));
    SLE \CUARTOOII[7]  (.D(N_52_0_i), .CLK(PCLK), .EN(
        un1_CUARTl1OI23_i), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(APB3_Bus_0_APBmslave0_PRDATA[7]));
    SLE \CUARTl0OI_Z[3]  (.D(PWDATA_in[3]), .CLK(PCLK), .EN(CUARTl0OI4)
        , .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTl0OI[3]));
    SLE \CUARTO1OI_Z[4]  (.D(PWDATA_in[4]), .CLK(PCLK), .EN(CUARTO1OI4)
        , .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        CUARTO1OI[4]));
    
endmodule


module UART_Term(
       PWDATA_in,
       CUARTl0OI,
       APB3_Bus_0_APBmslave0_PRDATA,
       CUARTO1OI,
       PADDR_in,
       CUARTOIII,
       PRESETN,
       PCLK,
       N_73_i,
       N_79_i,
       N_63_i,
       N_58_0_i,
       N_55_0_i,
       N_52_0_i,
       CUARTO1OI4,
       CUARTl0OI4,
       N_82_i,
       APB3_Bus_0_APBmslave0_PSELx,
       PWRITE_in,
       PENABLE_in,
       CUARTOOl,
       FTDI_UART0_TXD,
       FRAMING_ERR,
       OVERFLOW,
       FTDI_UART0_RXD,
       TXRDY,
       CUARTO1I5_i,
       RXRDY,
       CUARTO1I5
    );
input  [7:0] PWDATA_in;
output [7:0] CUARTl0OI;
output [7:0] APB3_Bus_0_APBmslave0_PRDATA;
output [7:0] CUARTO1OI;
input  [4:2] PADDR_in;
output [7:0] CUARTOIII;
input  PRESETN;
input  PCLK;
input  N_73_i;
input  N_79_i;
input  N_63_i;
input  N_58_0_i;
input  N_55_0_i;
input  N_52_0_i;
input  CUARTO1OI4;
input  CUARTl0OI4;
input  N_82_i;
input  APB3_Bus_0_APBmslave0_PSELx;
input  PWRITE_in;
input  PENABLE_in;
input  CUARTOOl;
input  FTDI_UART0_TXD;
output FRAMING_ERR;
output OVERFLOW;
output FTDI_UART0_RXD;
output TXRDY;
input  CUARTO1I5_i;
output RXRDY;
input  CUARTO1I5;

    wire N_314, N_315, N_316, GND, VCC;
    
    UART_Term_UART_Term_0_CoreUARTapb_Z3_layer0 UART_Term_0 (
        .CUARTOIII({CUARTOIII[7], CUARTOIII[6], CUARTOIII[5], 
        CUARTOIII[4], CUARTOIII[3], N_314, CUARTOIII[1], CUARTOIII[0]})
        , .PADDR_in({PADDR_in[4], PADDR_in[3], PADDR_in[2]}), 
        .CUARTO1OI({CUARTO1OI[7], CUARTO1OI[6], CUARTO1OI[5], 
        CUARTO1OI[4], CUARTO1OI[3], N_315, CUARTO1OI[1], CUARTO1OI[0]})
        , .APB3_Bus_0_APBmslave0_PRDATA({
        APB3_Bus_0_APBmslave0_PRDATA[7], 
        APB3_Bus_0_APBmslave0_PRDATA[6], 
        APB3_Bus_0_APBmslave0_PRDATA[5], 
        APB3_Bus_0_APBmslave0_PRDATA[4], 
        APB3_Bus_0_APBmslave0_PRDATA[3], 
        APB3_Bus_0_APBmslave0_PRDATA[2], 
        APB3_Bus_0_APBmslave0_PRDATA[1], 
        APB3_Bus_0_APBmslave0_PRDATA[0]}), .CUARTl0OI({CUARTl0OI[7], 
        CUARTl0OI[6], CUARTl0OI[5], CUARTl0OI[4], CUARTl0OI[3], N_316, 
        CUARTl0OI[1], CUARTl0OI[0]}), .PWDATA_in({PWDATA_in[7], 
        PWDATA_in[6], PWDATA_in[5], PWDATA_in[4], PWDATA_in[3], 
        PWDATA_in[2], PWDATA_in[1], PWDATA_in[0]}), .CUARTO1I5(
        CUARTO1I5), .RXRDY(RXRDY), .CUARTO1I5_i(CUARTO1I5_i), .TXRDY(
        TXRDY), .FTDI_UART0_RXD(FTDI_UART0_RXD), .OVERFLOW(OVERFLOW), 
        .FRAMING_ERR(FRAMING_ERR), .FTDI_UART0_TXD(FTDI_UART0_TXD), 
        .CUARTOOl(CUARTOOl), .PENABLE_in(PENABLE_in), .PWRITE_in(
        PWRITE_in), .APB3_Bus_0_APBmslave0_PSELx(
        APB3_Bus_0_APBmslave0_PSELx), .N_82_i(N_82_i), .CUARTl0OI4(
        CUARTl0OI4), .CUARTO1OI4(CUARTO1OI4), .N_52_0_i(N_52_0_i), 
        .N_55_0_i(N_55_0_i), .N_58_0_i(N_58_0_i), .N_63_i(N_63_i), 
        .N_79_i(N_79_i), .N_73_i(N_73_i), .PCLK(PCLK), .PRESETN(
        PRESETN));
    VCC VCC_Z (.Y(VCC));
    GND GND_Z (.Y(GND));
    
endmodule


module PB_Debouncer(
       USER_BUTTON2,
       PB_Debouncer_1_PBout,
       PCLK,
       PRESETN
    );
input  USER_BUTTON2;
output PB_Debouncer_1_PBout;
input  PCLK;
input  PRESETN;

    wire [31:0] count;
    wire [31:0] count_4;
    wire [7:0] PB_Status;
    wire [0:0] State;
    wire VCC, GND, un2_count_cry_15_S, un2_count_cry_4_S, 
        un2_count_cry_6_S, un2_count_cry_8_S, un2_count_cry_9_S, 
        un2_count_cry_14_S, DPB_Z, PB_Status_0_sqmuxa_Z, 
        un15_pb_status_Z, SPB_Z, un6_count_i, un2_count_cry_0_Z, 
        un2_count_cry_0_S, un2_count_cry_0_Y, un2_count_cry_1_Z, 
        un2_count_cry_1_S, un2_count_cry_1_Y, un2_count_cry_2_Z, 
        un2_count_cry_2_S, un2_count_cry_2_Y, un2_count_cry_3_Z, 
        un2_count_cry_3_S, un2_count_cry_3_Y, un2_count_cry_4_Z, 
        un2_count_cry_4_Y, un2_count_cry_5_Z, un2_count_cry_5_S, 
        un2_count_cry_5_Y, un2_count_cry_6_Z, un2_count_cry_6_Y, 
        un2_count_cry_7_Z, un2_count_cry_7_S, un2_count_cry_7_Y, 
        un2_count_cry_8_Z, un2_count_cry_8_Y, un2_count_cry_9_Z, 
        un2_count_cry_9_Y, un2_count_cry_10_Z, un2_count_cry_10_S, 
        un2_count_cry_10_Y, un2_count_cry_11_Z, un2_count_cry_11_S, 
        un2_count_cry_11_Y, un2_count_cry_12_Z, un2_count_cry_12_S, 
        un2_count_cry_12_Y, un2_count_cry_13_Z, un2_count_cry_13_S, 
        un2_count_cry_13_Y, un2_count_cry_14_Z, un2_count_cry_14_Y, 
        un2_count_cry_15_Z, un2_count_cry_15_Y, un2_count_cry_16_Z, 
        un2_count_cry_16_S, un2_count_cry_16_Y, un2_count_cry_17_Z, 
        un2_count_cry_17_S, un2_count_cry_17_Y, un2_count_cry_18_Z, 
        un2_count_cry_18_S, un2_count_cry_18_Y, un2_count_cry_19_Z, 
        un2_count_cry_19_S, un2_count_cry_19_Y, un2_count_cry_20_Z, 
        un2_count_cry_20_S, un2_count_cry_20_Y, un2_count_cry_21_Z, 
        un2_count_cry_21_S, un2_count_cry_21_Y, un2_count_cry_22_Z, 
        un2_count_cry_22_S, un2_count_cry_22_Y, un2_count_cry_23_Z, 
        un2_count_cry_23_S, un2_count_cry_23_Y, un2_count_cry_24_Z, 
        un2_count_cry_24_S, un2_count_cry_24_Y, un2_count_cry_25_Z, 
        un2_count_cry_25_S, un2_count_cry_25_Y, un2_count_cry_26_Z, 
        un2_count_cry_26_S, un2_count_cry_26_Y, un2_count_cry_27_Z, 
        un2_count_cry_27_S, un2_count_cry_27_Y, un2_count_cry_28_Z, 
        un2_count_cry_28_S, un2_count_cry_28_Y, un2_count_cry_29_Z, 
        un2_count_cry_29_S, un2_count_cry_29_Y, un2_count_s_31_FCO, 
        un2_count_s_31_S, un2_count_s_31_Y, un2_count_cry_30_Z, 
        un2_count_cry_30_S, un2_count_cry_30_Y, un15_pb_status_1_0_Z, 
        un15_pb_status_1_Z, un6_count_13_Z, un6_count_23_Z, 
        un6_count_21_Z, un6_count_20_Z, un6_count_19_Z, un6_count_18_Z, 
        un6_count_17_Z, un6_count_16_Z, un6_count_27_Z, un6_count_28_Z;
    
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_10 (.A(VCC), .B(
        count[10]), .C(GND), .D(GND), .FCI(un2_count_cry_9_Z), .S(
        un2_count_cry_10_S), .Y(un2_count_cry_10_Y), .FCO(
        un2_count_cry_10_Z));
    CFG2 #( .INIT(4'h8) )  \count_4[12]  (.A(un2_count_cry_12_S), .B(
        State[0]), .Y(count_4[12]));
    SLE \count[5]  (.D(count_4[5]), .CLK(PCLK), .EN(VCC), .ALn(PRESETN)
        , .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(count[5]));
    CFG2 #( .INIT(4'h8) )  \count_4[20]  (.A(un2_count_cry_20_S), .B(
        State[0]), .Y(count_4[20]));
    CFG2 #( .INIT(4'h8) )  \count_4[27]  (.A(un2_count_cry_27_S), .B(
        State[0]), .Y(count_4[27]));
    SLE \count[1]  (.D(count_4[1]), .CLK(PCLK), .EN(VCC), .ALn(PRESETN)
        , .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(count[1]));
    CFG2 #( .INIT(4'h8) )  \count_4[2]  (.A(un2_count_cry_2_S), .B(
        State[0]), .Y(count_4[2]));
    SLE \count[27]  (.D(count_4[27]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[27]));
    CFG2 #( .INIT(4'h8) )  \count_4[1]  (.A(un2_count_cry_1_S), .B(
        State[0]), .Y(count_4[1]));
    SLE \count[10]  (.D(count_4[10]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[10]));
    SLE \count[0]  (.D(count_4[0]), .CLK(PCLK), .EN(VCC), .ALn(PRESETN)
        , .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(count[0]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_9 (.A(VCC), .B(count[9]), 
        .C(GND), .D(GND), .FCI(un2_count_cry_8_Z), .S(
        un2_count_cry_9_S), .Y(un2_count_cry_9_Y), .FCO(
        un2_count_cry_9_Z));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_21 (.A(VCC), .B(
        count[21]), .C(GND), .D(GND), .FCI(un2_count_cry_20_Z), .S(
        un2_count_cry_21_S), .Y(un2_count_cry_21_Y), .FCO(
        un2_count_cry_21_Z));
    SLE \count[14]  (.D(un2_count_cry_14_S), .CLK(PCLK), .EN(VCC), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[14]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_19 (.A(VCC), .B(
        count[19]), .C(GND), .D(GND), .FCI(un2_count_cry_18_Z), .S(
        un2_count_cry_19_S), .Y(un2_count_cry_19_Y), .FCO(
        un2_count_cry_19_Z));
    CFG2 #( .INIT(4'h8) )  \count_4[16]  (.A(un2_count_cry_16_S), .B(
        State[0]), .Y(count_4[16]));
    SLE \count[22]  (.D(count_4[22]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[22]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_20 (.A(VCC), .B(
        count[20]), .C(GND), .D(GND), .FCI(un2_count_cry_19_Z), .S(
        un2_count_cry_20_S), .Y(un2_count_cry_20_Y), .FCO(
        un2_count_cry_20_Z));
    CFG2 #( .INIT(4'h8) )  \count_4[22]  (.A(un2_count_cry_22_S), .B(
        State[0]), .Y(count_4[22]));
    CFG2 #( .INIT(4'h8) )  \count_4[25]  (.A(un2_count_cry_25_S), .B(
        State[0]), .Y(count_4[25]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_18 (.A(VCC), .B(
        count[18]), .C(GND), .D(GND), .FCI(un2_count_cry_17_Z), .S(
        un2_count_cry_18_S), .Y(un2_count_cry_18_Y), .FCO(
        un2_count_cry_18_Z));
    SLE PBout (.D(PB_Status[7]), .CLK(PCLK), .EN(un15_pb_status_Z), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        PB_Debouncer_1_PBout));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_1 (.A(VCC), .B(count[1]), 
        .C(GND), .D(GND), .FCI(un2_count_cry_0_Z), .S(
        un2_count_cry_1_S), .Y(un2_count_cry_1_Y), .FCO(
        un2_count_cry_1_Z));
    SLE SPB (.D(USER_BUTTON2), .CLK(PCLK), .EN(PRESETN), .ALn(VCC), 
        .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(SPB_Z));
    CFG2 #( .INIT(4'h8) )  \count_4[26]  (.A(un2_count_cry_26_S), .B(
        State[0]), .Y(count_4[26]));
    SLE \count[20]  (.D(count_4[20]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[20]));
    CFG4 #( .INIT(16'h0001) )  un6_count_18 (.A(un2_count_cry_8_S), .B(
        un2_count_cry_9_S), .C(un2_count_cry_10_S), .D(
        un2_count_cry_11_S), .Y(un6_count_18_Z));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_29 (.A(VCC), .B(
        count[29]), .C(GND), .D(GND), .FCI(un2_count_cry_28_Z), .S(
        un2_count_cry_29_S), .Y(un2_count_cry_29_Y), .FCO(
        un2_count_cry_29_Z));
    SLE \count[24]  (.D(count_4[24]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[24]));
    SLE \PB_Status[5]  (.D(PB_Status[4]), .CLK(PCLK), .EN(
        PB_Status_0_sqmuxa_Z), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(PB_Status[5]));
    CFG2 #( .INIT(4'h8) )  \count_4[5]  (.A(un2_count_cry_5_S), .B(
        State[0]), .Y(count_4[5]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_30 (.A(VCC), .B(
        count[30]), .C(GND), .D(GND), .FCI(un2_count_cry_29_Z), .S(
        un2_count_cry_30_S), .Y(un2_count_cry_30_Y), .FCO(
        un2_count_cry_30_Z));
    SLE \count[8]  (.D(un2_count_cry_8_S), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[8]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_5 (.A(VCC), .B(count[5]), 
        .C(GND), .D(GND), .FCI(un2_count_cry_4_Z), .S(
        un2_count_cry_5_S), .Y(un2_count_cry_5_Y), .FCO(
        un2_count_cry_5_Z));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_28 (.A(VCC), .B(
        count[28]), .C(GND), .D(GND), .FCI(un2_count_cry_27_Z), .S(
        un2_count_cry_28_S), .Y(un2_count_cry_28_Y), .FCO(
        un2_count_cry_28_Z));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_2 (.A(VCC), .B(count[2]), 
        .C(GND), .D(GND), .FCI(un2_count_cry_1_Z), .S(
        un2_count_cry_2_S), .Y(un2_count_cry_2_Y), .FCO(
        un2_count_cry_2_Z));
    SLE \PB_Status[0]  (.D(DPB_Z), .CLK(PCLK), .EN(
        PB_Status_0_sqmuxa_Z), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(PB_Status[0]));
    CFG2 #( .INIT(4'h8) )  \count_4[18]  (.A(un2_count_cry_18_S), .B(
        State[0]), .Y(count_4[18]));
    SLE \count[19]  (.D(count_4[19]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[19]));
    CFG4 #( .INIT(16'h0010) )  un6_count_16 (.A(un2_count_cry_2_S), .B(
        un2_count_cry_3_S), .C(count[0]), .D(un2_count_cry_1_S), .Y(
        un6_count_16_Z));
    SLE \count[15]  (.D(un2_count_cry_15_S), .CLK(PCLK), .EN(VCC), 
        .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[15]));
    SLE \count[11]  (.D(count_4[11]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[11]));
    SLE DPB (.D(SPB_Z), .CLK(PCLK), .EN(PRESETN), .ALn(VCC), .ADn(VCC), 
        .SLn(VCC), .SD(GND), .LAT(GND), .Q(DPB_Z));
    CFG2 #( .INIT(4'h8) )  \count_4[31]  (.A(un2_count_s_31_S), .B(
        State[0]), .Y(count_4[31]));
    CFG2 #( .INIT(4'h8) )  \count_4[28]  (.A(un2_count_cry_28_S), .B(
        State[0]), .Y(count_4[28]));
    SLE \count[13]  (.D(count_4[13]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[13]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_6 (.A(VCC), .B(count[6]), 
        .C(GND), .D(GND), .FCI(un2_count_cry_5_Z), .S(
        un2_count_cry_6_S), .Y(un2_count_cry_6_Y), .FCO(
        un2_count_cry_6_Z));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_3 (.A(VCC), .B(count[3]), 
        .C(GND), .D(GND), .FCI(un2_count_cry_2_Z), .S(
        un2_count_cry_3_S), .Y(un2_count_cry_3_Y), .FCO(
        un2_count_cry_3_Z));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_14 (.A(VCC), .B(
        count[14]), .C(GND), .D(GND), .FCI(un2_count_cry_13_Z), .S(
        un2_count_cry_14_S), .Y(un2_count_cry_14_Y), .FCO(
        un2_count_cry_14_Z));
    SLE \count[29]  (.D(count_4[29]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[29]));
    CFG2 #( .INIT(4'h8) )  \count_4[11]  (.A(un2_count_cry_11_S), .B(
        State[0]), .Y(count_4[11]));
    SLE \count[2]  (.D(count_4[2]), .CLK(PCLK), .EN(VCC), .ALn(PRESETN)
        , .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(count[2]));
    CFG4 #( .INIT(16'h8000) )  un6_count_28 (.A(un6_count_16_Z), .B(
        un6_count_17_Z), .C(un6_count_18_Z), .D(un6_count_19_Z), .Y(
        un6_count_28_Z));
    ARI1 #( .INIT(20'h45500) )  un2_count_s_31 (.A(VCC), .B(count[31]), 
        .C(GND), .D(GND), .FCI(un2_count_cry_30_Z), .S(
        un2_count_s_31_S), .Y(un2_count_s_31_Y), .FCO(
        un2_count_s_31_FCO));
    SLE \count[25]  (.D(count_4[25]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[25]));
    CFG4 #( .INIT(16'h0001) )  un6_count_17 (.A(un2_count_cry_4_S), .B(
        un2_count_cry_5_S), .C(un2_count_cry_6_S), .D(
        un2_count_cry_7_S), .Y(un6_count_17_Z));
    SLE \State[0]  (.D(un6_count_i), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        State[0]));
    CFG2 #( .INIT(4'h8) )  \count_4[13]  (.A(un2_count_cry_13_S), .B(
        State[0]), .Y(count_4[13]));
    SLE \count[30]  (.D(count_4[30]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[30]));
    SLE \count[21]  (.D(count_4[21]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[21]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_13 (.A(VCC), .B(
        count[13]), .C(GND), .D(GND), .FCI(un2_count_cry_12_Z), .S(
        un2_count_cry_13_S), .Y(un2_count_cry_13_Y), .FCO(
        un2_count_cry_13_Z));
    CFG2 #( .INIT(4'h8) )  \count_4[24]  (.A(un2_count_cry_24_S), .B(
        State[0]), .Y(count_4[24]));
    SLE \count[9]  (.D(un2_count_cry_9_S), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[9]));
    SLE \count[16]  (.D(count_4[16]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[16]));
    SLE \count[23]  (.D(count_4[23]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[23]));
    CFG4 #( .INIT(16'h0001) )  un6_count_20 (.A(un2_count_cry_16_S), 
        .B(un2_count_cry_17_S), .C(un2_count_cry_18_S), .D(
        un2_count_cry_19_S), .Y(un6_count_20_Z));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_24 (.A(VCC), .B(
        count[24]), .C(GND), .D(GND), .FCI(un2_count_cry_23_Z), .S(
        un2_count_cry_24_S), .Y(un2_count_cry_24_Y), .FCO(
        un2_count_cry_24_Z));
    CFG2 #( .INIT(4'h8) )  \count_4[7]  (.A(un2_count_cry_7_S), .B(
        State[0]), .Y(count_4[7]));
    CFG2 #( .INIT(4'h8) )  \count_4[21]  (.A(un2_count_cry_21_S), .B(
        State[0]), .Y(count_4[21]));
    SLE \PB_Status[1]  (.D(PB_Status[0]), .CLK(PCLK), .EN(
        PB_Status_0_sqmuxa_Z), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(PB_Status[1]));
    CFG2 #( .INIT(4'h8) )  \count_4[23]  (.A(un2_count_cry_23_S), .B(
        State[0]), .Y(count_4[23]));
    SLE \PB_Status[6]  (.D(PB_Status[5]), .CLK(PCLK), .EN(
        PB_Status_0_sqmuxa_Z), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(PB_Status[6]));
    CFG2 #( .INIT(4'h2) )  \count_4[0]  (.A(State[0]), .B(count[0]), 
        .Y(count_4[0]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_23 (.A(VCC), .B(
        count[23]), .C(GND), .D(GND), .FCI(un2_count_cry_22_Z), .S(
        un2_count_cry_23_S), .Y(un2_count_cry_23_Y), .FCO(
        un2_count_cry_23_Z));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_0 (.A(VCC), .B(count[0]), 
        .C(GND), .D(GND), .FCI(GND), .S(un2_count_cry_0_S), .Y(
        un2_count_cry_0_Y), .FCO(un2_count_cry_0_Z));
    CFG2 #( .INIT(4'h1) )  un6_count_13 (.A(un2_count_cry_27_S), .B(
        un2_count_cry_26_S), .Y(un6_count_13_Z));
    SLE \count[6]  (.D(un2_count_cry_6_S), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[6]));
    CFG4 #( .INIT(16'h0001) )  un6_count_21 (.A(un2_count_cry_20_S), 
        .B(un2_count_cry_21_S), .C(un2_count_cry_22_S), .D(
        un2_count_cry_23_S), .Y(un6_count_21_Z));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_4 (.A(VCC), .B(count[4]), 
        .C(GND), .D(GND), .FCI(un2_count_cry_3_Z), .S(
        un2_count_cry_4_S), .Y(un2_count_cry_4_Y), .FCO(
        un2_count_cry_4_Z));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_12 (.A(VCC), .B(
        count[12]), .C(GND), .D(GND), .FCI(un2_count_cry_11_Z), .S(
        un2_count_cry_12_S), .Y(un2_count_cry_12_Y), .FCO(
        un2_count_cry_12_Z));
    SLE \count[26]  (.D(count_4[26]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[26]));
    SLE \count[3]  (.D(count_4[3]), .CLK(PCLK), .EN(VCC), .ALn(PRESETN)
        , .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(count[3]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_16 (.A(VCC), .B(
        count[16]), .C(GND), .D(GND), .FCI(un2_count_cry_15_Z), .S(
        un2_count_cry_16_S), .Y(un2_count_cry_16_Y), .FCO(
        un2_count_cry_16_Z));
    GND GND_Z (.Y(GND));
    CFG2 #( .INIT(4'h8) )  \count_4[19]  (.A(un2_count_cry_19_S), .B(
        State[0]), .Y(count_4[19]));
    VCC VCC_Z (.Y(VCC));
    CFG4 #( .INIT(16'h1000) )  un6_count_27 (.A(un2_count_cry_25_S), 
        .B(un2_count_cry_24_S), .C(un6_count_23_Z), .D(un6_count_13_Z), 
        .Y(un6_count_27_Z));
    CFG4 #( .INIT(16'h0001) )  un6_count_19 (.A(un2_count_cry_12_S), 
        .B(un2_count_cry_13_S), .C(un2_count_cry_14_S), .D(
        un2_count_cry_15_S), .Y(un6_count_19_Z));
    CFG2 #( .INIT(4'h4) )  PB_Status_0_sqmuxa (.A(State[0]), .B(
        PRESETN), .Y(PB_Status_0_sqmuxa_Z));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_17 (.A(VCC), .B(
        count[17]), .C(GND), .D(GND), .FCI(un2_count_cry_16_Z), .S(
        un2_count_cry_17_S), .Y(un2_count_cry_17_Y), .FCO(
        un2_count_cry_17_Z));
    CFG4 #( .INIT(16'h1008) )  un15_pb_status (.A(PB_Status[7]), .B(
        PB_Status[3]), .C(un15_pb_status_1_0_Z), .D(un15_pb_status_1_Z)
        , .Y(un15_pb_status_Z));
    SLE \PB_Status[4]  (.D(PB_Status[3]), .CLK(PCLK), .EN(
        PB_Status_0_sqmuxa_Z), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(PB_Status[4]));
    SLE \count[31]  (.D(count_4[31]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[31]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_22 (.A(VCC), .B(
        count[22]), .C(GND), .D(GND), .FCI(un2_count_cry_21_Z), .S(
        un2_count_cry_22_S), .Y(un2_count_cry_22_Y), .FCO(
        un2_count_cry_22_Z));
    CFG2 #( .INIT(4'h8) )  \count_4[3]  (.A(un2_count_cry_3_S), .B(
        State[0]), .Y(count_4[3]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_15 (.A(VCC), .B(
        count[15]), .C(GND), .D(GND), .FCI(un2_count_cry_14_Z), .S(
        un2_count_cry_15_S), .Y(un2_count_cry_15_Y), .FCO(
        un2_count_cry_15_Z));
    CFG2 #( .INIT(4'h8) )  \count_4[29]  (.A(un2_count_cry_29_S), .B(
        State[0]), .Y(count_4[29]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_26 (.A(VCC), .B(
        count[26]), .C(GND), .D(GND), .FCI(un2_count_cry_25_Z), .S(
        un2_count_cry_26_S), .Y(un2_count_cry_26_Y), .FCO(
        un2_count_cry_26_Z));
    SLE \count[18]  (.D(count_4[18]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[18]));
    CFG4 #( .INIT(16'h7FFF) )  \State_RNO[0]  (.A(un6_count_21_Z), .B(
        un6_count_20_Z), .C(un6_count_27_Z), .D(un6_count_28_Z), .Y(
        un6_count_i));
    CFG2 #( .INIT(4'h8) )  \count_4[30]  (.A(un2_count_cry_30_S), .B(
        State[0]), .Y(count_4[30]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_27 (.A(VCC), .B(
        count[27]), .C(GND), .D(GND), .FCI(un2_count_cry_26_Z), .S(
        un2_count_cry_27_S), .Y(un2_count_cry_27_Y), .FCO(
        un2_count_cry_27_Z));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_7 (.A(VCC), .B(count[7]), 
        .C(GND), .D(GND), .FCI(un2_count_cry_6_Z), .S(
        un2_count_cry_7_S), .Y(un2_count_cry_7_Y), .FCO(
        un2_count_cry_7_Z));
    SLE \PB_Status[7]  (.D(PB_Status[6]), .CLK(PCLK), .EN(
        PB_Status_0_sqmuxa_Z), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(PB_Status[7]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_25 (.A(VCC), .B(
        count[25]), .C(GND), .D(GND), .FCI(un2_count_cry_24_Z), .S(
        un2_count_cry_25_S), .Y(un2_count_cry_25_Y), .FCO(
        un2_count_cry_25_Z));
    CFG4 #( .INIT(16'h4CCD) )  un15_pb_status_1 (.A(PB_Status[0]), .B(
        PB_Status[3]), .C(PB_Status[2]), .D(PB_Status[1]), .Y(
        un15_pb_status_1_Z));
    CFG4 #( .INIT(16'h0001) )  un6_count_23 (.A(un2_count_cry_28_S), 
        .B(un2_count_cry_29_S), .C(un2_count_cry_30_S), .D(
        un2_count_s_31_S), .Y(un6_count_23_Z));
    SLE \PB_Status[2]  (.D(PB_Status[1]), .CLK(PCLK), .EN(
        PB_Status_0_sqmuxa_Z), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(PB_Status[2]));
    SLE \count[17]  (.D(count_4[17]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[17]));
    CFG2 #( .INIT(4'h8) )  \count_4[10]  (.A(un2_count_cry_10_S), .B(
        State[0]), .Y(count_4[10]));
    CFG2 #( .INIT(4'h8) )  \count_4[17]  (.A(un2_count_cry_17_S), .B(
        State[0]), .Y(count_4[17]));
    SLE \count[4]  (.D(un2_count_cry_4_S), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[4]));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_8 (.A(VCC), .B(count[8]), 
        .C(GND), .D(GND), .FCI(un2_count_cry_7_Z), .S(
        un2_count_cry_8_S), .Y(un2_count_cry_8_Y), .FCO(
        un2_count_cry_8_Z));
    ARI1 #( .INIT(20'h65500) )  un2_count_cry_11 (.A(VCC), .B(
        count[11]), .C(GND), .D(GND), .FCI(un2_count_cry_10_Z), .S(
        un2_count_cry_11_S), .Y(un2_count_cry_11_Y), .FCO(
        un2_count_cry_11_Z));
    SLE \count[12]  (.D(count_4[12]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[12]));
    SLE \count[7]  (.D(count_4[7]), .CLK(PCLK), .EN(VCC), .ALn(PRESETN)
        , .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(count[7]));
    SLE \PB_Status[3]  (.D(PB_Status[2]), .CLK(PCLK), .EN(
        PB_Status_0_sqmuxa_Z), .ALn(VCC), .ADn(VCC), .SLn(VCC), .SD(
        GND), .LAT(GND), .Q(PB_Status[3]));
    CFG4 #( .INIT(16'h4CCD) )  un15_pb_status_1_0 (.A(PB_Status[4]), 
        .B(PB_Status[7]), .C(PB_Status[6]), .D(PB_Status[5]), .Y(
        un15_pb_status_1_0_Z));
    SLE \count[28]  (.D(count_4[28]), .CLK(PCLK), .EN(VCC), .ALn(
        PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), .Q(
        count[28]));
    
endmodule


module GPIO_Basic_GPIO_Basic_0_CoreGPIO_Z2_layer0(
       APB3_Bus_0_APBmslave0_PRDATA,
       PADDR_in,
       PADDR_in_i_0,
       CUARTOIII,
       CUARTO1OI,
       CUARTl0OI,
       PWDATA_in,
       INT_net_0,
       N_49_0_i,
       N_42_0_i,
       N_73_i_1z,
       N_79_i_1z,
       N_63_i_1z,
       N_82_i_1z,
       CUARTO1OI4,
       CUARTOOl,
       CUARTl0OI4,
       CUARTO1I5,
       N_35_0_i,
       N_32_0_i,
       N_29_0_i,
       N_26_0_i,
       TXRDY,
       RXRDY,
       FRAMING_ERR,
       OVERFLOW,
       APB3_Bus_0_APBmslave1_PSELx,
       PWRITE_in,
       APB3_Bus_0_APBmslave0_PSELx,
       CUARTO1I5_i,
       PENABLE_in,
       N_52_0_i_1z,
       N_55_0_i_1z,
       N_58_0_i_1z,
       PB_Debouncer_1_PBout,
       PB_Debouncer_0_PBout,
       LED1_GREEN,
       LED1_RED,
       LED2_GREEN,
       LED2_RED,
       PCLK,
       PRESETN
    );
input  [5:0] APB3_Bus_0_APBmslave0_PRDATA;
input  [6:0] PADDR_in;
input  PADDR_in_i_0;
input  [7:0] CUARTOIII;
input  [7:0] CUARTO1OI;
input  [7:0] CUARTl0OI;
input  [5:0] PWDATA_in;
output [1:0] INT_net_0;
output N_49_0_i;
output N_42_0_i;
output N_73_i_1z;
output N_79_i_1z;
output N_63_i_1z;
output N_82_i_1z;
output CUARTO1OI4;
output CUARTOOl;
output CUARTl0OI4;
output CUARTO1I5;
output N_35_0_i;
output N_32_0_i;
output N_29_0_i;
output N_26_0_i;
input  TXRDY;
input  RXRDY;
input  FRAMING_ERR;
input  OVERFLOW;
input  APB3_Bus_0_APBmslave1_PSELx;
input  PWRITE_in;
input  APB3_Bus_0_APBmslave0_PSELx;
output CUARTO1I5_i;
input  PENABLE_in;
output N_52_0_i_1z;
output N_55_0_i_1z;
output N_58_0_i_1z;
input  PB_Debouncer_1_PBout;
input  PB_Debouncer_0_PBout;
output LED1_GREEN;
output LED1_RED;
output LED2_GREEN;
output LED2_RED;
input  PCLK;
input  PRESETN;

    wire [1:0] GPOUT_reg;
    wire [1:0] gpin3;
    wire [1:0] gpin2;
    wire [1:0] INTR_reg;
    wire [1:0] gpin1;
    wire VCC, N_139_mux_i, N_154_mux_i, GND, N_140_mux_i, N_155_mux_i, 
        GPOUT_reg_0_sqmuxa, N_157_mux_i, N_156_mux_i, N_58_0_i_1_1_Z, 
        N_55_0_i_1_1_Z, N_52_0_i_1_1_Z, m40_1_1, un12_PRDATA_o, N_41_0, 
        un5_PRDATA_o, GPOUT_reg36, m47_1_1, N_48_0, m7_2_Z, N_33_0, 
        N_30_0, N_27_0, N_23_0, N_126, N_123, N_129, N_132, m16_e_3_Z, 
        N_154, N_78, N_61, N_71, N_81, N_135_mux, N_138_mux;
    
    SLE \xhdl1.GEN_BITS[4].APB_32.GPOUT_reg[4]  (.D(PWDATA_in[4]), 
        .CLK(PCLK), .EN(GPOUT_reg_0_sqmuxa), .ALn(PRESETN), .ADn(VCC), 
        .SLn(VCC), .SD(GND), .LAT(GND), .Q(LED2_GREEN));
    CFG4 #( .INIT(16'h1C0C) )  N_52_0_i_1_1 (.A(PADDR_in[4]), .B(
        PADDR_in[3]), .C(PADDR_in[2]), .D(CUARTOIII[7]), .Y(
        N_52_0_i_1_1_Z));
    SLE \xhdl1.GEN_BITS[1].APB_32.INTR_reg[1]  (.D(N_156_mux_i), .CLK(
        PCLK), .EN(VCC), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), 
        .LAT(GND), .Q(INTR_reg[1]));
    CFG3 #( .INIT(8'h5C) )  \xhdl1.GEN_BITS[1].gpin3_RNIPFFH8[1]  (.A(
        gpin3[1]), .B(m40_1_1), .C(un12_PRDATA_o), .Y(N_41_0));
    CFG3 #( .INIT(8'h20) )  m16_e (.A(PADDR_in_i_0), .B(PADDR_in[6]), 
        .C(m16_e_3_Z), .Y(N_135_mux));
    CFG4 #( .INIT(16'h30BA) )  
        \xhdl1.GEN_BITS[0].APB_32.edge_neg_RNO[0]  (.A(gpin3[0]), .B(
        PWDATA_in[0]), .C(INT_net_0[0]), .D(gpin2[0]), .Y(N_140_mux_i));
    CFG4 #( .INIT(16'h30BA) )  
        \xhdl1.GEN_BITS[1].APB_32.edge_neg_RNO[1]  (.A(gpin3[1]), .B(
        PWDATA_in[1]), .C(INT_net_0[1]), .D(gpin2[1]), .Y(N_139_mux_i));
    CFG3 #( .INIT(8'h1B) )  m128 (.A(PADDR_in[2]), .B(CUARTl0OI[1]), 
        .C(CUARTO1OI[1]), .Y(N_129));
    CFG4 #( .INIT(16'hC0AA) )  
        \xhdl1.GEN_BITS[5].APB_32.GPOUT_reg_RNIHP0G6[5]  (.A(N_23_0), 
        .B(LED2_RED), .C(GPOUT_reg36), .D(APB3_Bus_0_APBmslave1_PSELx), 
        .Y(N_26_0_i));
    CFG3 #( .INIT(8'h80) )  m13 (.A(PADDR_in[3]), .B(PWRITE_in), .C(
        N_138_mux), .Y(CUARTO1OI4));
    CFG4 #( .INIT(16'hDDA0) )  N_58_0_i (.A(PADDR_in[3]), .B(
        CUARTl0OI[5]), .C(CUARTO1OI[5]), .D(N_58_0_i_1_1_Z), .Y(
        N_58_0_i_1z));
    CFG3 #( .INIT(8'h74) )  N_79_i (.A(N_126), .B(PADDR_in[3]), .C(
        N_78), .Y(N_79_i_1z));
    CFG3 #( .INIT(8'h1B) )  m131 (.A(PADDR_in[2]), .B(CUARTl0OI[0]), 
        .C(CUARTO1OI[0]), .Y(N_132));
    CFG3 #( .INIT(8'h74) )  N_63_i (.A(N_123), .B(PADDR_in[3]), .C(
        N_61), .Y(N_63_i_1z));
    CFG4 #( .INIT(16'h0001) )  m16_e_3 (.A(PADDR_in[3]), .B(
        PADDR_in[2]), .C(PADDR_in[1]), .D(PADDR_in[0]), .Y(m16_e_3_Z));
    SLE \xhdl1.GEN_BITS[0].APB_32.GPOUT_reg[0]  (.D(PWDATA_in[0]), 
        .CLK(PCLK), .EN(GPOUT_reg_0_sqmuxa), .ALn(PRESETN), .ADn(VCC), 
        .SLn(VCC), .SD(GND), .LAT(GND), .Q(GPOUT_reg[0]));
    CFG4 #( .INIT(16'hC0AA) )  
        \xhdl1.GEN_BITS[4].APB_32.GPOUT_reg_RNIE2EN6[4]  (.A(N_27_0), 
        .B(LED2_GREEN), .C(GPOUT_reg36), .D(
        APB3_Bus_0_APBmslave1_PSELx), .Y(N_29_0_i));
    CFG3 #( .INIT(8'h10) )  m21 (.A(PADDR_in[5]), .B(PADDR_in[4]), .C(
        N_135_mux), .Y(un5_PRDATA_o));
    CFG3 #( .INIT(8'h5C) )  \xhdl1.GEN_BITS[0].gpin3_RNIJPG59[0]  (.A(
        gpin3[0]), .B(m47_1_1), .C(un12_PRDATA_o), .Y(N_48_0));
    CFG2 #( .INIT(4'h8) )  m22 (.A(APB3_Bus_0_APBmslave0_PRDATA[5]), 
        .B(APB3_Bus_0_APBmslave0_PSELx), .Y(N_23_0));
    SLE \xhdl1.GEN_BITS[3].APB_32.GPOUT_reg[3]  (.D(PWDATA_in[3]), 
        .CLK(PCLK), .EN(GPOUT_reg_0_sqmuxa), .ALn(PRESETN), .ADn(VCC), 
        .SLn(VCC), .SD(GND), .LAT(GND), .Q(LED1_RED));
    CFG3 #( .INIT(8'h40) )  m7_2 (.A(PADDR_in[2]), .B(PWRITE_in), .C(
        APB3_Bus_0_APBmslave0_PSELx), .Y(m7_2_Z));
    CFG4 #( .INIT(16'h1C0C) )  N_55_0_i_1_1 (.A(PADDR_in[4]), .B(
        PADDR_in[3]), .C(PADDR_in[2]), .D(CUARTOIII[6]), .Y(
        N_55_0_i_1_1_Z));
    CFG4 #( .INIT(16'h4000) )  m8 (.A(PADDR_in[4]), .B(PADDR_in[3]), 
        .C(PENABLE_in), .D(m7_2_Z), .Y(CUARTl0OI4));
    CFG4 #( .INIT(16'hDDA0) )  N_55_0_i (.A(PADDR_in[3]), .B(
        CUARTl0OI[6]), .C(CUARTO1OI[6]), .D(N_55_0_i_1_1_Z), .Y(
        N_55_0_i_1z));
    CFG4 #( .INIT(16'h535F) )  
        \xhdl1.GEN_BITS[1].APB_32.GPOUT_reg_RNI000J5[1]  (.A(
        INTR_reg[1]), .B(GPOUT_reg[1]), .C(un5_PRDATA_o), .D(
        GPOUT_reg36), .Y(m40_1_1));
    SLE \xhdl1.GEN_BITS[1].gpin3[1]  (.D(gpin2[1]), .CLK(PCLK), .EN(
        VCC), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), 
        .Q(gpin3[1]));
    SLE \xhdl1.GEN_BITS[5].APB_32.GPOUT_reg[5]  (.D(PWDATA_in[5]), 
        .CLK(PCLK), .EN(GPOUT_reg_0_sqmuxa), .ALn(PRESETN), .ADn(VCC), 
        .SLn(VCC), .SD(GND), .LAT(GND), .Q(LED2_RED));
    CFG3 #( .INIT(8'h74) )  N_82_i (.A(N_132), .B(PADDR_in[3]), .C(
        N_81), .Y(N_82_i_1z));
    CFG4 #( .INIT(16'h2777) )  
        \xhdl1.GEN_BITS[0].APB_32.GPOUT_reg_RNISKE06[0]  (.A(
        un5_PRDATA_o), .B(INTR_reg[0]), .C(GPOUT_reg[0]), .D(
        GPOUT_reg36), .Y(m47_1_1));
    SLE \xhdl1.GEN_BITS[1].APB_32.GPOUT_reg[1]  (.D(PWDATA_in[1]), 
        .CLK(PCLK), .EN(GPOUT_reg_0_sqmuxa), .ALn(PRESETN), .ADn(VCC), 
        .SLn(VCC), .SD(GND), .LAT(GND), .Q(GPOUT_reg[1]));
    CFG3 #( .INIT(8'h40) )  m18 (.A(PADDR_in[5]), .B(PADDR_in[4]), .C(
        N_135_mux), .Y(un12_PRDATA_o));
    SLE \xhdl1.GEN_BITS[1].APB_32.edge_neg[1]  (.D(N_139_mux_i), .CLK(
        PCLK), .EN(N_154_mux_i), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), 
        .SD(GND), .LAT(GND), .Q(INT_net_0[1]));
    CFG4 #( .INIT(16'h1000) )  m80 (.A(PADDR_in[4]), .B(PADDR_in[3]), 
        .C(PENABLE_in), .D(m7_2_Z), .Y(CUARTO1I5));
    CFG2 #( .INIT(4'h8) )  m26 (.A(APB3_Bus_0_APBmslave0_PRDATA[4]), 
        .B(APB3_Bus_0_APBmslave0_PSELx), .Y(N_27_0));
    CFG4 #( .INIT(16'h7444) )  \xhdl1.GEN_BITS[0].gpin3_RNIEJ2PC[0]  (
        .A(N_48_0), .B(APB3_Bus_0_APBmslave1_PSELx), .C(
        APB3_Bus_0_APBmslave0_PSELx), .D(
        APB3_Bus_0_APBmslave0_PRDATA[0]), .Y(N_49_0_i));
    CFG4 #( .INIT(16'hC0AA) )  
        \xhdl1.GEN_BITS[2].APB_32.GPOUT_reg_RNI8K8M6[2]  (.A(N_33_0), 
        .B(LED1_GREEN), .C(GPOUT_reg36), .D(
        APB3_Bus_0_APBmslave1_PSELx), .Y(N_35_0_i));
    SLE \xhdl1.GEN_BITS[0].gpin1[0]  (.D(PB_Debouncer_0_PBout), .CLK(
        PCLK), .EN(VCC), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), 
        .LAT(GND), .Q(gpin1[0]));
    CFG3 #( .INIT(8'h20) )  m20 (.A(PADDR_in[5]), .B(PADDR_in[4]), .C(
        N_135_mux), .Y(GPOUT_reg36));
    CFG3 #( .INIT(8'hAE) )  
        \xhdl1.GEN_BITS[1].APB_32.edge_neg_RNO_0[1]  (.A(N_154), .B(
        gpin3[1]), .C(gpin2[1]), .Y(N_154_mux_i));
    CFG3 #( .INIT(8'h74) )  N_73_i (.A(N_129), .B(PADDR_in[3]), .C(
        N_71), .Y(N_73_i_1z));
    CFG4 #( .INIT(16'hDDA0) )  N_52_0_i (.A(PADDR_in[3]), .B(
        CUARTl0OI[7]), .C(CUARTO1OI[7]), .D(N_52_0_i_1_1_Z), .Y(
        N_52_0_i_1z));
    CFG4 #( .INIT(16'h1C0C) )  N_58_0_i_1_1 (.A(PADDR_in[4]), .B(
        PADDR_in[3]), .C(PADDR_in[2]), .D(CUARTOIII[5]), .Y(
        N_58_0_i_1_1_Z));
    CFG3 #( .INIT(8'h1B) )  m125 (.A(PADDR_in[2]), .B(CUARTl0OI[3]), 
        .C(CUARTO1OI[3]), .Y(N_126));
    CFG4 #( .INIT(16'h8000) )  m97 (.A(PWRITE_in), .B(PENABLE_in), .C(
        GPOUT_reg36), .D(APB3_Bus_0_APBmslave1_PSELx), .Y(
        GPOUT_reg_0_sqmuxa));
    CFG2 #( .INIT(4'h8) )  m29 (.A(APB3_Bus_0_APBmslave0_PRDATA[3]), 
        .B(APB3_Bus_0_APBmslave0_PSELx), .Y(N_30_0));
    CFG3 #( .INIT(8'hAE) )  
        \xhdl1.GEN_BITS[0].APB_32.edge_neg_RNO_0[0]  (.A(N_154), .B(
        gpin3[0]), .C(gpin2[0]), .Y(N_155_mux_i));
    SLE \xhdl1.GEN_BITS[0].gpin2[0]  (.D(gpin1[0]), .CLK(PCLK), .EN(
        VCC), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), 
        .Q(gpin2[0]));
    GND GND_Z (.Y(GND));
    VCC VCC_Z (.Y(VCC));
    CFG4 #( .INIT(16'hEFFF) )  m80_i (.A(PADDR_in[4]), .B(PADDR_in[3]), 
        .C(PENABLE_in), .D(m7_2_Z), .Y(CUARTO1I5_i));
    CFG4 #( .INIT(16'h6420) )  m65 (.A(PADDR_in[4]), .B(PADDR_in[2]), 
        .C(OVERFLOW), .D(CUARTOIII[3]), .Y(N_78));
    CFG4 #( .INIT(16'h6420) )  m60 (.A(PADDR_in[4]), .B(PADDR_in[2]), 
        .C(FRAMING_ERR), .D(CUARTOIII[4]), .Y(N_61));
    CFG4 #( .INIT(16'h7250) )  
        \xhdl1.GEN_BITS[1].APB_32.INTR_reg_RNO[1]  (.A(N_154), .B(
        PWDATA_in[1]), .C(INT_net_0[1]), .D(INTR_reg[1]), .Y(
        N_156_mux_i));
    CFG2 #( .INIT(4'h8) )  m32 (.A(APB3_Bus_0_APBmslave0_PRDATA[2]), 
        .B(APB3_Bus_0_APBmslave0_PSELx), .Y(N_33_0));
    SLE \xhdl1.GEN_BITS[1].gpin1[1]  (.D(PB_Debouncer_1_PBout), .CLK(
        PCLK), .EN(VCC), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), 
        .LAT(GND), .Q(gpin1[1]));
    SLE \xhdl1.GEN_BITS[0].APB_32.INTR_reg[0]  (.D(N_157_mux_i), .CLK(
        PCLK), .EN(VCC), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), 
        .LAT(GND), .Q(INTR_reg[0]));
    CFG4 #( .INIT(16'h0AC0) )  m75 (.A(CUARTOIII[0]), .B(TXRDY), .C(
        PADDR_in[4]), .D(PADDR_in[2]), .Y(N_81));
    CFG4 #( .INIT(16'h8000) )  m103_e (.A(PWRITE_in), .B(PENABLE_in), 
        .C(un5_PRDATA_o), .D(APB3_Bus_0_APBmslave1_PSELx), .Y(N_154));
    CFG4 #( .INIT(16'h0CA0) )  m70 (.A(RXRDY), .B(CUARTOIII[1]), .C(
        PADDR_in[4]), .D(PADDR_in[2]), .Y(N_71));
    CFG4 #( .INIT(16'h4000) )  m11 (.A(PADDR_in[4]), .B(PADDR_in[2]), 
        .C(PENABLE_in), .D(APB3_Bus_0_APBmslave0_PSELx), .Y(N_138_mux));
    SLE \xhdl1.GEN_BITS[2].APB_32.GPOUT_reg[2]  (.D(PWDATA_in[2]), 
        .CLK(PCLK), .EN(GPOUT_reg_0_sqmuxa), .ALn(PRESETN), .ADn(VCC), 
        .SLn(VCC), .SD(GND), .LAT(GND), .Q(LED1_GREEN));
    SLE \xhdl1.GEN_BITS[0].APB_32.edge_neg[0]  (.D(N_140_mux_i), .CLK(
        PCLK), .EN(N_155_mux_i), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), 
        .SD(GND), .LAT(GND), .Q(INT_net_0[0]));
    SLE \xhdl1.GEN_BITS[1].gpin2[1]  (.D(gpin1[1]), .CLK(PCLK), .EN(
        VCC), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), 
        .Q(gpin2[1]));
    SLE \xhdl1.GEN_BITS[0].gpin3[0]  (.D(gpin2[0]), .CLK(PCLK), .EN(
        VCC), .ALn(PRESETN), .ADn(VCC), .SLn(VCC), .SD(GND), .LAT(GND), 
        .Q(gpin3[0]));
    CFG4 #( .INIT(16'h7444) )  \xhdl1.GEN_BITS[1].gpin3_RNILA15C[1]  (
        .A(N_41_0), .B(APB3_Bus_0_APBmslave1_PSELx), .C(
        APB3_Bus_0_APBmslave0_PSELx), .D(
        APB3_Bus_0_APBmslave0_PRDATA[1]), .Y(N_42_0_i));
    CFG4 #( .INIT(16'hC0AA) )  
        \xhdl1.GEN_BITS[3].APB_32.GPOUT_reg_RNIBBRE6[3]  (.A(N_30_0), 
        .B(LED1_RED), .C(GPOUT_reg36), .D(APB3_Bus_0_APBmslave1_PSELx), 
        .Y(N_32_0_i));
    CFG4 #( .INIT(16'h7250) )  
        \xhdl1.GEN_BITS[0].APB_32.INTR_reg_RNO[0]  (.A(N_154), .B(
        PWDATA_in[0]), .C(INT_net_0[0]), .D(INTR_reg[0]), .Y(
        N_157_mux_i));
    CFG3 #( .INIT(8'h1B) )  m122 (.A(PADDR_in[2]), .B(CUARTl0OI[4]), 
        .C(CUARTO1OI[4]), .Y(N_123));
    CFG3 #( .INIT(8'h10) )  m79 (.A(PADDR_in[3]), .B(PWRITE_in), .C(
        N_138_mux), .Y(CUARTOOl));
    
endmodule


module GPIO_Basic(
       INT_net_0,
       PWDATA_in,
       CUARTl0OI,
       CUARTO1OI,
       CUARTOIII,
       PADDR_in_i_0,
       PADDR_in,
       APB3_Bus_0_APBmslave0_PRDATA,
       PRESETN,
       PCLK,
       LED2_RED,
       LED2_GREEN,
       LED1_RED,
       LED1_GREEN,
       PB_Debouncer_0_PBout,
       PB_Debouncer_1_PBout,
       N_58_0_i,
       N_55_0_i,
       N_52_0_i,
       PENABLE_in,
       CUARTO1I5_i,
       APB3_Bus_0_APBmslave0_PSELx,
       PWRITE_in,
       APB3_Bus_0_APBmslave1_PSELx,
       OVERFLOW,
       FRAMING_ERR,
       RXRDY,
       TXRDY,
       N_26_0_i,
       N_29_0_i,
       N_32_0_i,
       N_35_0_i,
       CUARTO1I5,
       CUARTl0OI4,
       CUARTOOl,
       CUARTO1OI4,
       N_82_i,
       N_63_i,
       N_79_i,
       N_73_i,
       N_42_0_i,
       N_49_0_i
    );
output [1:0] INT_net_0;
input  [5:0] PWDATA_in;
input  [7:0] CUARTl0OI;
input  [7:0] CUARTO1OI;
input  [7:0] CUARTOIII;
input  PADDR_in_i_0;
input  [6:0] PADDR_in;
input  [5:0] APB3_Bus_0_APBmslave0_PRDATA;
input  PRESETN;
input  PCLK;
output LED2_RED;
output LED2_GREEN;
output LED1_RED;
output LED1_GREEN;
input  PB_Debouncer_0_PBout;
input  PB_Debouncer_1_PBout;
output N_58_0_i;
output N_55_0_i;
output N_52_0_i;
input  PENABLE_in;
output CUARTO1I5_i;
input  APB3_Bus_0_APBmslave0_PSELx;
input  PWRITE_in;
input  APB3_Bus_0_APBmslave1_PSELx;
input  OVERFLOW;
input  FRAMING_ERR;
input  RXRDY;
input  TXRDY;
output N_26_0_i;
output N_29_0_i;
output N_32_0_i;
output N_35_0_i;
output CUARTO1I5;
output CUARTl0OI4;
output CUARTOOl;
output CUARTO1OI4;
output N_82_i;
output N_63_i;
output N_79_i;
output N_73_i;
output N_42_0_i;
output N_49_0_i;

    wire N_308, N_309, N_310, GND, VCC;
    
    VCC VCC_Z (.Y(VCC));
    GPIO_Basic_GPIO_Basic_0_CoreGPIO_Z2_layer0 GPIO_Basic_0 (
        .APB3_Bus_0_APBmslave0_PRDATA({APB3_Bus_0_APBmslave0_PRDATA[5], 
        APB3_Bus_0_APBmslave0_PRDATA[4], 
        APB3_Bus_0_APBmslave0_PRDATA[3], 
        APB3_Bus_0_APBmslave0_PRDATA[2], 
        APB3_Bus_0_APBmslave0_PRDATA[1], 
        APB3_Bus_0_APBmslave0_PRDATA[0]}), .PADDR_in({PADDR_in[6], 
        PADDR_in[5], PADDR_in[4], PADDR_in[3], PADDR_in[2], 
        PADDR_in[1], PADDR_in[0]}), .PADDR_in_i_0(PADDR_in_i_0), 
        .CUARTOIII({CUARTOIII[7], CUARTOIII[6], CUARTOIII[5], 
        CUARTOIII[4], CUARTOIII[3], N_308, CUARTOIII[1], CUARTOIII[0]})
        , .CUARTO1OI({CUARTO1OI[7], CUARTO1OI[6], CUARTO1OI[5], 
        CUARTO1OI[4], CUARTO1OI[3], N_309, CUARTO1OI[1], CUARTO1OI[0]})
        , .CUARTl0OI({CUARTl0OI[7], CUARTl0OI[6], CUARTl0OI[5], 
        CUARTl0OI[4], CUARTl0OI[3], N_310, CUARTl0OI[1], CUARTl0OI[0]})
        , .PWDATA_in({PWDATA_in[5], PWDATA_in[4], PWDATA_in[3], 
        PWDATA_in[2], PWDATA_in[1], PWDATA_in[0]}), .INT_net_0({
        INT_net_0[1], INT_net_0[0]}), .N_49_0_i(N_49_0_i), .N_42_0_i(
        N_42_0_i), .N_73_i_1z(N_73_i), .N_79_i_1z(N_79_i), .N_63_i_1z(
        N_63_i), .N_82_i_1z(N_82_i), .CUARTO1OI4(CUARTO1OI4), 
        .CUARTOOl(CUARTOOl), .CUARTl0OI4(CUARTl0OI4), .CUARTO1I5(
        CUARTO1I5), .N_35_0_i(N_35_0_i), .N_32_0_i(N_32_0_i), 
        .N_29_0_i(N_29_0_i), .N_26_0_i(N_26_0_i), .TXRDY(TXRDY), 
        .RXRDY(RXRDY), .FRAMING_ERR(FRAMING_ERR), .OVERFLOW(OVERFLOW), 
        .APB3_Bus_0_APBmslave1_PSELx(APB3_Bus_0_APBmslave1_PSELx), 
        .PWRITE_in(PWRITE_in), .APB3_Bus_0_APBmslave0_PSELx(
        APB3_Bus_0_APBmslave0_PSELx), .CUARTO1I5_i(CUARTO1I5_i), 
        .PENABLE_in(PENABLE_in), .N_52_0_i_1z(N_52_0_i), .N_55_0_i_1z(
        N_55_0_i), .N_58_0_i_1z(N_58_0_i), .PB_Debouncer_1_PBout(
        PB_Debouncer_1_PBout), .PB_Debouncer_0_PBout(
        PB_Debouncer_0_PBout), .LED1_GREEN(LED1_GREEN), .LED1_RED(
        LED1_RED), .LED2_GREEN(LED2_GREEN), .LED2_RED(LED2_RED), .PCLK(
        PCLK), .PRESETN(PRESETN));
    GND GND_Z (.Y(GND));
    
endmodule


module CAPB3II(
       PRDATA_in,
       APB3_Bus_0_APBmslave0_PRDATA,
       APB3_Bus_0_APBmslave0_PSELx,
       APB3_Bus_0_APBmslave1_PSELx
    );
output [7:6] PRDATA_in;
input  [7:6] APB3_Bus_0_APBmslave0_PRDATA;
input  APB3_Bus_0_APBmslave0_PSELx;
input  APB3_Bus_0_APBmslave1_PSELx;

    wire GND, VCC;
    
    CFG3 #( .INIT(8'h40) )  \PRDATA[7]  (.A(
        APB3_Bus_0_APBmslave1_PSELx), .B(APB3_Bus_0_APBmslave0_PSELx), 
        .C(APB3_Bus_0_APBmslave0_PRDATA[7]), .Y(PRDATA_in[7]));
    VCC VCC_Z (.Y(VCC));
    CFG3 #( .INIT(8'h40) )  \PRDATA[6]  (.A(
        APB3_Bus_0_APBmslave1_PSELx), .B(APB3_Bus_0_APBmslave0_PSELx), 
        .C(APB3_Bus_0_APBmslave0_PRDATA[6]), .Y(PRDATA_in[6]));
    GND GND_Z (.Y(GND));
    
endmodule


module CoreAPB3_Z1_layer0(
       APB3_Bus_0_APBmslave0_PRDATA,
       PRDATA_in,
       PADDR_in,
       APB3_Bus_0_APBmslave1_PSELx,
       APB3_Bus_0_APBmslave0_PSELx,
       PSEL_in
    );
input  [7:6] APB3_Bus_0_APBmslave0_PRDATA;
output [7:6] PRDATA_in;
input  [11:8] PADDR_in;
output APB3_Bus_0_APBmslave1_PSELx;
output APB3_Bus_0_APBmslave0_PSELx;
input  PSEL_in;

    wire N_9_mux, GND, VCC;
    
    CFG4 #( .INIT(16'h0002) )  m3_e (.A(PSEL_in), .B(PADDR_in[11]), .C(
        PADDR_in[10]), .D(PADDR_in[9]), .Y(N_9_mux));
    VCC VCC_Z (.Y(VCC));
    CFG2 #( .INIT(4'h8) )  m5 (.A(N_9_mux), .B(PADDR_in[8]), .Y(
        APB3_Bus_0_APBmslave1_PSELx));
    CFG2 #( .INIT(4'h2) )  m4 (.A(N_9_mux), .B(PADDR_in[8]), .Y(
        APB3_Bus_0_APBmslave0_PSELx));
    GND GND_Z (.Y(GND));
    CAPB3II CAPB3IIII (.PRDATA_in({PRDATA_in[7], PRDATA_in[6]}), 
        .APB3_Bus_0_APBmslave0_PRDATA({APB3_Bus_0_APBmslave0_PRDATA[7], 
        APB3_Bus_0_APBmslave0_PRDATA[6]}), 
        .APB3_Bus_0_APBmslave0_PSELx(APB3_Bus_0_APBmslave0_PSELx), 
        .APB3_Bus_0_APBmslave1_PSELx(APB3_Bus_0_APBmslave1_PSELx));
    
endmodule


module APB3_Bus(
       PADDR_in,
       PRDATA_in,
       APB3_Bus_0_APBmslave0_PRDATA,
       PSEL_in,
       APB3_Bus_0_APBmslave0_PSELx,
       APB3_Bus_0_APBmslave1_PSELx
    );
input  [11:8] PADDR_in;
output [7:6] PRDATA_in;
input  [7:6] APB3_Bus_0_APBmslave0_PRDATA;
input  PSEL_in;
output APB3_Bus_0_APBmslave0_PSELx;
output APB3_Bus_0_APBmslave1_PSELx;

    wire GND, VCC;
    
    VCC VCC_Z (.Y(VCC));
    GND GND_Z (.Y(GND));
    CoreAPB3_Z1_layer0 APB3_Bus_0 (.APB3_Bus_0_APBmslave0_PRDATA({
        APB3_Bus_0_APBmslave0_PRDATA[7], 
        APB3_Bus_0_APBmslave0_PRDATA[6]}), .PRDATA_in({PRDATA_in[7], 
        PRDATA_in[6]}), .PADDR_in({PADDR_in[11], PADDR_in[10], 
        PADDR_in[9], PADDR_in[8]}), .APB3_Bus_0_APBmslave1_PSELx(
        APB3_Bus_0_APBmslave1_PSELx), .APB3_Bus_0_APBmslave0_PSELx(
        APB3_Bus_0_APBmslave0_PSELx), .PSEL_in(PSEL_in));
    
endmodule


module BasicIO_Interface(
       FTDI_UART0_TXD,
       PADDR_in,
       PCLK,
       PENABLE_in,
       PRESETN,
       PSEL_in,
       PWDATA_in,
       PWRITE_in,
       USER_BUTTON1,
       USER_BUTTON2,
       FTDI_UART0_RXD,
       LED1_GREEN,
       LED1_RED,
       LED2_GREEN,
       LED2_RED,
       PRDATA_in,
       PREADY_in,
       PSLVERR_in,
       USER_PB1_IRQ,
       USER_PB2_IRQ
    );
input  FTDI_UART0_TXD;
input  [31:0] PADDR_in;
input  PCLK;
input  PENABLE_in;
input  PRESETN;
input  PSEL_in;
input  [31:0] PWDATA_in;
input  PWRITE_in;
input  USER_BUTTON1;
input  USER_BUTTON2;
output FTDI_UART0_RXD;
output LED1_GREEN;
output LED1_RED;
output LED2_GREEN;
output LED2_RED;
output [31:0] PRDATA_in;
output PREADY_in;
output PSLVERR_in;
output USER_PB1_IRQ;
output USER_PB2_IRQ;

    wire [7:0] APB3_Bus_0_APBmslave0_PRDATA;
    wire [7:0] \UART_Term_0.UART_Term_0.CUARTl0OI ;
    wire [7:0] \UART_Term_0.UART_Term_0.CUARTO1OI ;
    wire [7:0] \UART_Term_0.UART_Term_0.CUARTOIII ;
    wire NN_1, NN_2, GND, PB_Debouncer_0_PBout, PB_Debouncer_1_PBout, 
        APB3_Bus_0_APBmslave1_PSELx, APB3_Bus_0_APBmslave0_PSELx, 
        \UART_Term_0.UART_Term_0.TXRDY , 
        \UART_Term_0.UART_Term_0.RXRDY , 
        \UART_Term_0.UART_Term_0.FRAMING_ERR , 
        \UART_Term_0.UART_Term_0.OVERFLOW , 
        \UART_Term_0.UART_Term_0.CUARTl1II.CUARTl0OI4 , 
        \UART_Term_0.UART_Term_0.CUARTOOlI.CUARTO1OI4 , 
        \UART_Term_0.UART_Term_0.CUARTlOlI.CUARTO01.CUARTOOl , 
        \UART_Term_0.UART_Term_0.CUARTlOlI.CUARTl10.CUARTO1I5 , N_82_i, 
        N_52_0_i, N_55_0_i, N_58_0_i, N_63_i, N_79_i, N_73_i, 
        \UART_Term_0.UART_Term_0.CUARTlOlI.CUARTl10.CUARTO1I5_i , 
        N_311, N_312, N_313, N_317, N_318, N_319;
    assign PRDATA_in[31] = GND;
    assign PRDATA_in[30] = GND;
    assign PRDATA_in[29] = GND;
    assign PRDATA_in[28] = GND;
    assign PRDATA_in[27] = GND;
    assign PRDATA_in[26] = GND;
    assign PRDATA_in[25] = GND;
    assign PRDATA_in[24] = GND;
    assign PRDATA_in[23] = GND;
    assign PRDATA_in[22] = GND;
    assign PRDATA_in[21] = GND;
    assign PRDATA_in[20] = GND;
    assign PRDATA_in[19] = GND;
    assign PRDATA_in[18] = GND;
    assign PRDATA_in[17] = GND;
    assign PRDATA_in[16] = GND;
    assign PRDATA_in[15] = GND;
    assign PRDATA_in[14] = GND;
    assign PRDATA_in[13] = GND;
    assign PRDATA_in[12] = GND;
    assign PRDATA_in[11] = GND;
    assign PRDATA_in[10] = GND;
    assign PRDATA_in[9] = GND;
    assign PRDATA_in[8] = GND;
    assign PSLVERR_in = GND;
    
    PB_Debouncer_0 PB_Debouncer_0 (.USER_BUTTON1(USER_BUTTON1), 
        .PB_Debouncer_0_PBout(PB_Debouncer_0_PBout), .PCLK(NN_1), 
        .PRESETN(NN_2));
    UART_Term UART_Term_0 (.PWDATA_in({PWDATA_in[7], PWDATA_in[6], 
        PWDATA_in[5], PWDATA_in[4], PWDATA_in[3], PWDATA_in[2], 
        PWDATA_in[1], PWDATA_in[0]}), .CUARTl0OI({
        \UART_Term_0.UART_Term_0.CUARTl0OI [7], 
        \UART_Term_0.UART_Term_0.CUARTl0OI [6], 
        \UART_Term_0.UART_Term_0.CUARTl0OI [5], 
        \UART_Term_0.UART_Term_0.CUARTl0OI [4], 
        \UART_Term_0.UART_Term_0.CUARTl0OI [3], N_317, 
        \UART_Term_0.UART_Term_0.CUARTl0OI [1], 
        \UART_Term_0.UART_Term_0.CUARTl0OI [0]}), 
        .APB3_Bus_0_APBmslave0_PRDATA({APB3_Bus_0_APBmslave0_PRDATA[7], 
        APB3_Bus_0_APBmslave0_PRDATA[6], 
        APB3_Bus_0_APBmslave0_PRDATA[5], 
        APB3_Bus_0_APBmslave0_PRDATA[4], 
        APB3_Bus_0_APBmslave0_PRDATA[3], 
        APB3_Bus_0_APBmslave0_PRDATA[2], 
        APB3_Bus_0_APBmslave0_PRDATA[1], 
        APB3_Bus_0_APBmslave0_PRDATA[0]}), .CUARTO1OI({
        \UART_Term_0.UART_Term_0.CUARTO1OI [7], 
        \UART_Term_0.UART_Term_0.CUARTO1OI [6], 
        \UART_Term_0.UART_Term_0.CUARTO1OI [5], 
        \UART_Term_0.UART_Term_0.CUARTO1OI [4], 
        \UART_Term_0.UART_Term_0.CUARTO1OI [3], N_318, 
        \UART_Term_0.UART_Term_0.CUARTO1OI [1], 
        \UART_Term_0.UART_Term_0.CUARTO1OI [0]}), .PADDR_in({
        PADDR_in[4], PADDR_in[3], PADDR_in[2]}), .CUARTOIII({
        \UART_Term_0.UART_Term_0.CUARTOIII [7], 
        \UART_Term_0.UART_Term_0.CUARTOIII [6], 
        \UART_Term_0.UART_Term_0.CUARTOIII [5], 
        \UART_Term_0.UART_Term_0.CUARTOIII [4], 
        \UART_Term_0.UART_Term_0.CUARTOIII [3], N_319, 
        \UART_Term_0.UART_Term_0.CUARTOIII [1], 
        \UART_Term_0.UART_Term_0.CUARTOIII [0]}), .PRESETN(NN_2), 
        .PCLK(NN_1), .N_73_i(N_73_i), .N_79_i(N_79_i), .N_63_i(N_63_i), 
        .N_58_0_i(N_58_0_i), .N_55_0_i(N_55_0_i), .N_52_0_i(N_52_0_i), 
        .CUARTO1OI4(\UART_Term_0.UART_Term_0.CUARTOOlI.CUARTO1OI4 ), 
        .CUARTl0OI4(\UART_Term_0.UART_Term_0.CUARTl1II.CUARTl0OI4 ), 
        .N_82_i(N_82_i), .APB3_Bus_0_APBmslave0_PSELx(
        APB3_Bus_0_APBmslave0_PSELx), .PWRITE_in(PWRITE_in), 
        .PENABLE_in(PENABLE_in), .CUARTOOl(
        \UART_Term_0.UART_Term_0.CUARTlOlI.CUARTO01.CUARTOOl ), 
        .FTDI_UART0_TXD(FTDI_UART0_TXD), .FRAMING_ERR(
        \UART_Term_0.UART_Term_0.FRAMING_ERR ), .OVERFLOW(
        \UART_Term_0.UART_Term_0.OVERFLOW ), .FTDI_UART0_RXD(
        FTDI_UART0_RXD), .TXRDY(\UART_Term_0.UART_Term_0.TXRDY ), 
        .CUARTO1I5_i(
        \UART_Term_0.UART_Term_0.CUARTlOlI.CUARTl10.CUARTO1I5_i ), 
        .RXRDY(\UART_Term_0.UART_Term_0.RXRDY ), .CUARTO1I5(
        \UART_Term_0.UART_Term_0.CUARTlOlI.CUARTl10.CUARTO1I5 ));
    PB_Debouncer PB_Debouncer_1 (.USER_BUTTON2(USER_BUTTON2), 
        .PB_Debouncer_1_PBout(PB_Debouncer_1_PBout), .PCLK(NN_1), 
        .PRESETN(NN_2));
    VCC VCC_Z (.Y(PREADY_in));
    CLKINT PCLK_RNIAB1A (.A(PCLK), .Y(NN_1));
    CLKINT PRESETN_RNI1MJ2 (.A(PRESETN), .Y(NN_2));
    GPIO_Basic GPIO_Basic_0 (.INT_net_0({USER_PB2_IRQ, USER_PB1_IRQ}), 
        .PWDATA_in({PWDATA_in[5], PWDATA_in[4], PWDATA_in[3], 
        PWDATA_in[2], PWDATA_in[1], PWDATA_in[0]}), .CUARTl0OI({
        \UART_Term_0.UART_Term_0.CUARTl0OI [7], 
        \UART_Term_0.UART_Term_0.CUARTl0OI [6], 
        \UART_Term_0.UART_Term_0.CUARTl0OI [5], 
        \UART_Term_0.UART_Term_0.CUARTl0OI [4], 
        \UART_Term_0.UART_Term_0.CUARTl0OI [3], N_311, 
        \UART_Term_0.UART_Term_0.CUARTl0OI [1], 
        \UART_Term_0.UART_Term_0.CUARTl0OI [0]}), .CUARTO1OI({
        \UART_Term_0.UART_Term_0.CUARTO1OI [7], 
        \UART_Term_0.UART_Term_0.CUARTO1OI [6], 
        \UART_Term_0.UART_Term_0.CUARTO1OI [5], 
        \UART_Term_0.UART_Term_0.CUARTO1OI [4], 
        \UART_Term_0.UART_Term_0.CUARTO1OI [3], N_312, 
        \UART_Term_0.UART_Term_0.CUARTO1OI [1], 
        \UART_Term_0.UART_Term_0.CUARTO1OI [0]}), .CUARTOIII({
        \UART_Term_0.UART_Term_0.CUARTOIII [7], 
        \UART_Term_0.UART_Term_0.CUARTOIII [6], 
        \UART_Term_0.UART_Term_0.CUARTOIII [5], 
        \UART_Term_0.UART_Term_0.CUARTOIII [4], 
        \UART_Term_0.UART_Term_0.CUARTOIII [3], N_313, 
        \UART_Term_0.UART_Term_0.CUARTOIII [1], 
        \UART_Term_0.UART_Term_0.CUARTOIII [0]}), .PADDR_in_i_0(
        PADDR_in[7]), .PADDR_in({PADDR_in[6], PADDR_in[5], PADDR_in[4], 
        PADDR_in[3], PADDR_in[2], PADDR_in[1], PADDR_in[0]}), 
        .APB3_Bus_0_APBmslave0_PRDATA({APB3_Bus_0_APBmslave0_PRDATA[5], 
        APB3_Bus_0_APBmslave0_PRDATA[4], 
        APB3_Bus_0_APBmslave0_PRDATA[3], 
        APB3_Bus_0_APBmslave0_PRDATA[2], 
        APB3_Bus_0_APBmslave0_PRDATA[1], 
        APB3_Bus_0_APBmslave0_PRDATA[0]}), .PRESETN(NN_2), .PCLK(NN_1), 
        .LED2_RED(LED2_RED), .LED2_GREEN(LED2_GREEN), .LED1_RED(
        LED1_RED), .LED1_GREEN(LED1_GREEN), .PB_Debouncer_0_PBout(
        PB_Debouncer_0_PBout), .PB_Debouncer_1_PBout(
        PB_Debouncer_1_PBout), .N_58_0_i(N_58_0_i), .N_55_0_i(N_55_0_i)
        , .N_52_0_i(N_52_0_i), .PENABLE_in(PENABLE_in), .CUARTO1I5_i(
        \UART_Term_0.UART_Term_0.CUARTlOlI.CUARTl10.CUARTO1I5_i ), 
        .APB3_Bus_0_APBmslave0_PSELx(APB3_Bus_0_APBmslave0_PSELx), 
        .PWRITE_in(PWRITE_in), .APB3_Bus_0_APBmslave1_PSELx(
        APB3_Bus_0_APBmslave1_PSELx), .OVERFLOW(
        \UART_Term_0.UART_Term_0.OVERFLOW ), .FRAMING_ERR(
        \UART_Term_0.UART_Term_0.FRAMING_ERR ), .RXRDY(
        \UART_Term_0.UART_Term_0.RXRDY ), .TXRDY(
        \UART_Term_0.UART_Term_0.TXRDY ), .N_26_0_i(PRDATA_in[5]), 
        .N_29_0_i(PRDATA_in[4]), .N_32_0_i(PRDATA_in[3]), .N_35_0_i(
        PRDATA_in[2]), .CUARTO1I5(
        \UART_Term_0.UART_Term_0.CUARTlOlI.CUARTl10.CUARTO1I5 ), 
        .CUARTl0OI4(\UART_Term_0.UART_Term_0.CUARTl1II.CUARTl0OI4 ), 
        .CUARTOOl(
        \UART_Term_0.UART_Term_0.CUARTlOlI.CUARTO01.CUARTOOl ), 
        .CUARTO1OI4(\UART_Term_0.UART_Term_0.CUARTOOlI.CUARTO1OI4 ), 
        .N_82_i(N_82_i), .N_63_i(N_63_i), .N_79_i(N_79_i), .N_73_i(
        N_73_i), .N_42_0_i(PRDATA_in[1]), .N_49_0_i(PRDATA_in[0]));
    GND GND_Z (.Y(GND));
    APB3_Bus APB3_Bus_0 (.PADDR_in({PADDR_in[11], PADDR_in[10], 
        PADDR_in[9], PADDR_in[8]}), .PRDATA_in({PRDATA_in[7], 
        PRDATA_in[6]}), .APB3_Bus_0_APBmslave0_PRDATA({
        APB3_Bus_0_APBmslave0_PRDATA[7], 
        APB3_Bus_0_APBmslave0_PRDATA[6]}), .PSEL_in(PSEL_in), 
        .APB3_Bus_0_APBmslave0_PSELx(APB3_Bus_0_APBmslave0_PSELx), 
        .APB3_Bus_0_APBmslave1_PSELx(APB3_Bus_0_APBmslave1_PSELx));
    
endmodule
