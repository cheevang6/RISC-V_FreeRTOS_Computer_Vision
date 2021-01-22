// ********************************************************************/ 
// Copyright 2013 Microsemi Corporation.  All rights reserved.
 // IP Solutions Group
 //
 // ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN 
 // ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED 
 // IN ADVANCE IN WRITING.  
 //  
 // File:  ramblocks_igloo2.v
 //     
 // Description: Core10100
 //              Pre Build RAM Blocks for the IGLOO2 family  
 //
 //   
 //
 //		  
 // 
 // *********************************************************************/ 


`timescale 1 ns/100 ps
// Version: v11.1 SP2 11.1.2.11


module RAMBLOCK1024X16(
       DATA,
       Q,
       WADDRESS,
       RADDRESS,
       WE,
       RE,
       WCLOCK,
       RCLOCK
    );
input  [15:0] DATA;
output [15:0] Q;
input  [9:0] WADDRESS;
input  [9:0] RADDRESS;
input  WE;
input  RE;
input  WCLOCK;
input  RCLOCK;

    wire VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;
    
    RAM1K18 RAMBLOCK1024X16_R0C0 (.A_DOUT({nc0, Q[15], Q[14], Q[13], 
        Q[12], Q[11], Q[10], Q[9], Q[8], nc1, Q[7], Q[6], Q[5], Q[4], 
        Q[3], Q[2], Q[1], Q[0]}), .B_DOUT({nc2, nc3, nc4, nc5, nc6, 
        nc7, nc8, nc9, nc10, nc11, nc12, nc13, nc14, nc15, nc16, nc17, 
        nc18, nc19}), .BUSY(), .A_CLK(RCLOCK), .A_DOUT_CLK(VCC), 
        .A_ARST_N(VCC), .A_DOUT_EN(VCC), .A_BLK({RE, VCC, VCC}), 
        .A_DOUT_ARST_N(VCC), .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND}), .A_ADDR({RADDRESS[9], RADDRESS[8], 
        RADDRESS[7], RADDRESS[6], RADDRESS[5], RADDRESS[4], 
        RADDRESS[3], RADDRESS[2], RADDRESS[1], RADDRESS[0], GND, GND, 
        GND, GND}), .A_WEN({GND, GND}), .B_CLK(WCLOCK), .B_DOUT_CLK(
        VCC), .B_ARST_N(VCC), .B_DOUT_EN(VCC), .B_BLK({WE, VCC, VCC}), 
        .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(VCC), .B_DIN({GND, 
        DATA[15], DATA[14], DATA[13], DATA[12], DATA[11], DATA[10], 
        DATA[9], DATA[8], GND, DATA[7], DATA[6], DATA[5], DATA[4], 
        DATA[3], DATA[2], DATA[1], DATA[0]}), .B_ADDR({WADDRESS[9], 
        WADDRESS[8], WADDRESS[7], WADDRESS[6], WADDRESS[5], 
        WADDRESS[4], WADDRESS[3], WADDRESS[2], WADDRESS[1], 
        WADDRESS[0], GND, GND, GND, GND}), .B_WEN({VCC, VCC}), .A_EN(
        VCC), .A_DOUT_LAT(VCC), .A_WIDTH({VCC, GND, GND}), .A_WMODE(
        GND), .B_EN(VCC), .B_DOUT_LAT(VCC), .B_WIDTH({VCC, GND, GND}), 
        .B_WMODE(GND), .SII_LOCK(GND));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
`timescale 1 ns/100 ps
// Version: v11.1 SP2 11.1.2.11


module RAMBLOCK1024X32(
       DATA,
       Q,
       WADDRESS,
       RADDRESS,
       WE,
       RE,
       WCLOCK,
       RCLOCK
    );
input  [31:0] DATA;
output [31:0] Q;
input  [9:0] WADDRESS;
input  [9:0] RADDRESS;
input  WE;
input  RE;
input  WCLOCK;
input  RCLOCK;

    wire VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;
    
    RAM1K18 RAMBLOCK1024X32_R0C1 (.A_DOUT({nc0, Q[31], Q[30], Q[29], 
        Q[28], Q[27], Q[26], Q[25], Q[24], nc1, Q[23], Q[22], Q[21], 
        Q[20], Q[19], Q[18], Q[17], Q[16]}), .B_DOUT({nc2, nc3, nc4, 
        nc5, nc6, nc7, nc8, nc9, nc10, nc11, nc12, nc13, nc14, nc15, 
        nc16, nc17, nc18, nc19}), .BUSY(), .A_CLK(RCLOCK), .A_DOUT_CLK(
        VCC), .A_ARST_N(VCC), .A_DOUT_EN(VCC), .A_BLK({RE, VCC, VCC}), 
        .A_DOUT_ARST_N(VCC), .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND}), .A_ADDR({RADDRESS[9], RADDRESS[8], 
        RADDRESS[7], RADDRESS[6], RADDRESS[5], RADDRESS[4], 
        RADDRESS[3], RADDRESS[2], RADDRESS[1], RADDRESS[0], GND, GND, 
        GND, GND}), .A_WEN({GND, GND}), .B_CLK(WCLOCK), .B_DOUT_CLK(
        VCC), .B_ARST_N(VCC), .B_DOUT_EN(VCC), .B_BLK({WE, VCC, VCC}), 
        .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(VCC), .B_DIN({GND, 
        DATA[31], DATA[30], DATA[29], DATA[28], DATA[27], DATA[26], 
        DATA[25], DATA[24], GND, DATA[23], DATA[22], DATA[21], 
        DATA[20], DATA[19], DATA[18], DATA[17], DATA[16]}), .B_ADDR({
        WADDRESS[9], WADDRESS[8], WADDRESS[7], WADDRESS[6], 
        WADDRESS[5], WADDRESS[4], WADDRESS[3], WADDRESS[2], 
        WADDRESS[1], WADDRESS[0], GND, GND, GND, GND}), .B_WEN({VCC, 
        VCC}), .A_EN(VCC), .A_DOUT_LAT(VCC), .A_WIDTH({VCC, GND, GND}), 
        .A_WMODE(GND), .B_EN(VCC), .B_DOUT_LAT(VCC), .B_WIDTH({VCC, 
        GND, GND}), .B_WMODE(GND), .SII_LOCK(GND));
    RAM1K18 RAMBLOCK1024X32_R0C0 (.A_DOUT({nc20, Q[15], Q[14], Q[13], 
        Q[12], Q[11], Q[10], Q[9], Q[8], nc21, Q[7], Q[6], Q[5], Q[4], 
        Q[3], Q[2], Q[1], Q[0]}), .B_DOUT({nc22, nc23, nc24, nc25, 
        nc26, nc27, nc28, nc29, nc30, nc31, nc32, nc33, nc34, nc35, 
        nc36, nc37, nc38, nc39}), .BUSY(), .A_CLK(RCLOCK), .A_DOUT_CLK(
        VCC), .A_ARST_N(VCC), .A_DOUT_EN(VCC), .A_BLK({RE, VCC, VCC}), 
        .A_DOUT_ARST_N(VCC), .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND}), .A_ADDR({RADDRESS[9], RADDRESS[8], 
        RADDRESS[7], RADDRESS[6], RADDRESS[5], RADDRESS[4], 
        RADDRESS[3], RADDRESS[2], RADDRESS[1], RADDRESS[0], GND, GND, 
        GND, GND}), .A_WEN({GND, GND}), .B_CLK(WCLOCK), .B_DOUT_CLK(
        VCC), .B_ARST_N(VCC), .B_DOUT_EN(VCC), .B_BLK({WE, VCC, VCC}), 
        .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(VCC), .B_DIN({GND, 
        DATA[15], DATA[14], DATA[13], DATA[12], DATA[11], DATA[10], 
        DATA[9], DATA[8], GND, DATA[7], DATA[6], DATA[5], DATA[4], 
        DATA[3], DATA[2], DATA[1], DATA[0]}), .B_ADDR({WADDRESS[9], 
        WADDRESS[8], WADDRESS[7], WADDRESS[6], WADDRESS[5], 
        WADDRESS[4], WADDRESS[3], WADDRESS[2], WADDRESS[1], 
        WADDRESS[0], GND, GND, GND, GND}), .B_WEN({VCC, VCC}), .A_EN(
        VCC), .A_DOUT_LAT(VCC), .A_WIDTH({VCC, GND, GND}), .A_WMODE(
        GND), .B_EN(VCC), .B_DOUT_LAT(VCC), .B_WIDTH({VCC, GND, GND}), 
        .B_WMODE(GND), .SII_LOCK(GND));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
`timescale 1 ns/100 ps
// Version: v11.1 SP2 11.1.2.11


module RAMBLOCK1024X8(
       DATA,
       Q,
       WADDRESS,
       RADDRESS,
       WE,
       RE,
       WCLOCK,
       RCLOCK
    );
input  [7:0] DATA;
output [7:0] Q;
input  [9:0] WADDRESS;
input  [9:0] RADDRESS;
input  WE;
input  RE;
input  WCLOCK;
input  RCLOCK;

    wire VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;
    
    RAM1K18 RAMBLOCK1024X8_R0C0 (.A_DOUT({nc0, nc1, nc2, nc3, nc4, nc5, 
        nc6, nc7, nc8, nc9, Q[7], Q[6], Q[5], Q[4], Q[3], Q[2], Q[1], 
        Q[0]}), .B_DOUT({nc10, nc11, nc12, nc13, nc14, nc15, nc16, 
        nc17, nc18, nc19, nc20, nc21, nc22, nc23, nc24, nc25, nc26, 
        nc27}), .BUSY(), .A_CLK(RCLOCK), .A_DOUT_CLK(VCC), .A_ARST_N(
        VCC), .A_DOUT_EN(VCC), .A_BLK({RE, VCC, VCC}), .A_DOUT_ARST_N(
        VCC), .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND}), .A_ADDR({GND, RADDRESS[9], RADDRESS[8], RADDRESS[7], 
        RADDRESS[6], RADDRESS[5], RADDRESS[4], RADDRESS[3], 
        RADDRESS[2], RADDRESS[1], RADDRESS[0], GND, GND, GND}), .A_WEN({
        GND, GND}), .B_CLK(WCLOCK), .B_DOUT_CLK(VCC), .B_ARST_N(VCC), 
        .B_DOUT_EN(VCC), .B_BLK({WE, VCC, VCC}), .B_DOUT_ARST_N(GND), 
        .B_DOUT_SRST_N(VCC), .B_DIN({GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, DATA[7], DATA[6], DATA[5], DATA[4], DATA[3], 
        DATA[2], DATA[1], DATA[0]}), .B_ADDR({GND, WADDRESS[9], 
        WADDRESS[8], WADDRESS[7], WADDRESS[6], WADDRESS[5], 
        WADDRESS[4], WADDRESS[3], WADDRESS[2], WADDRESS[1], 
        WADDRESS[0], GND, GND, GND}), .B_WEN({GND, VCC}), .A_EN(VCC), 
        .A_DOUT_LAT(VCC), .A_WIDTH({GND, VCC, VCC}), .A_WMODE(GND), 
        .B_EN(VCC), .B_DOUT_LAT(VCC), .B_WIDTH({GND, VCC, VCC}), 
        .B_WMODE(GND), .SII_LOCK(GND));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
`timescale 1 ns/100 ps
// Version: v11.1 SP2 11.1.2.11


module RAMBLOCK128X16(
       DATA,
       Q,
       WADDRESS,
       RADDRESS,
       WE,
       RE,
       WCLOCK,
       RCLOCK
    );
input  [15:0] DATA;
output [15:0] Q;
input  [6:0] WADDRESS;
input  [6:0] RADDRESS;
input  WE;
input  RE;
input  WCLOCK;
input  RCLOCK;

    wire VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;
    
    RAM1K18 RAMBLOCK128X16_R0C0 (.A_DOUT({nc0, Q[15], Q[14], Q[13], 
        Q[12], Q[11], Q[10], Q[9], Q[8], nc1, Q[7], Q[6], Q[5], Q[4], 
        Q[3], Q[2], Q[1], Q[0]}), .B_DOUT({nc2, nc3, nc4, nc5, nc6, 
        nc7, nc8, nc9, nc10, nc11, nc12, nc13, nc14, nc15, nc16, nc17, 
        nc18, nc19}), .BUSY(), .A_CLK(RCLOCK), .A_DOUT_CLK(VCC), 
        .A_ARST_N(VCC), .A_DOUT_EN(VCC), .A_BLK({RE, VCC, VCC}), 
        .A_DOUT_ARST_N(VCC), .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND}), .A_ADDR({GND, GND, GND, RADDRESS[6], 
        RADDRESS[5], RADDRESS[4], RADDRESS[3], RADDRESS[2], 
        RADDRESS[1], RADDRESS[0], GND, GND, GND, GND}), .A_WEN({GND, 
        GND}), .B_CLK(WCLOCK), .B_DOUT_CLK(VCC), .B_ARST_N(VCC), 
        .B_DOUT_EN(VCC), .B_BLK({WE, VCC, VCC}), .B_DOUT_ARST_N(GND), 
        .B_DOUT_SRST_N(VCC), .B_DIN({GND, DATA[15], DATA[14], DATA[13], 
        DATA[12], DATA[11], DATA[10], DATA[9], DATA[8], GND, DATA[7], 
        DATA[6], DATA[5], DATA[4], DATA[3], DATA[2], DATA[1], DATA[0]})
        , .B_ADDR({GND, GND, GND, WADDRESS[6], WADDRESS[5], 
        WADDRESS[4], WADDRESS[3], WADDRESS[2], WADDRESS[1], 
        WADDRESS[0], GND, GND, GND, GND}), .B_WEN({VCC, VCC}), .A_EN(
        VCC), .A_DOUT_LAT(VCC), .A_WIDTH({VCC, GND, GND}), .A_WMODE(
        GND), .B_EN(VCC), .B_DOUT_LAT(VCC), .B_WIDTH({VCC, GND, GND}), 
        .B_WMODE(GND), .SII_LOCK(GND));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
`timescale 1 ns/100 ps
// Version: v11.1 SP2 11.1.2.11


module RAMBLOCK128X32(
       DATA,
       Q,
       WADDRESS,
       RADDRESS,
       WE,
       RE,
       WCLOCK,
       RCLOCK
    );
input  [31:0] DATA;
output [31:0] Q;
input  [6:0] WADDRESS;
input  [6:0] RADDRESS;
input  WE;
input  RE;
input  WCLOCK;
input  RCLOCK;

    wire VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;
    
    RAM1K18 RAMBLOCK128X32_R0C0 (.A_DOUT({nc0, Q[31], Q[30], Q[29], 
        Q[28], Q[27], Q[26], Q[25], Q[24], nc1, Q[23], Q[22], Q[21], 
        Q[20], Q[19], Q[18], Q[17], Q[16]}), .B_DOUT({nc2, Q[15], 
        Q[14], Q[13], Q[12], Q[11], Q[10], Q[9], Q[8], nc3, Q[7], Q[6], 
        Q[5], Q[4], Q[3], Q[2], Q[1], Q[0]}), .BUSY(), .A_CLK(RCLOCK), 
        .A_DOUT_CLK(VCC), .A_ARST_N(VCC), .A_DOUT_EN(VCC), .A_BLK({RE, 
        VCC, VCC}), .A_DOUT_ARST_N(VCC), .A_DOUT_SRST_N(VCC), .A_DIN({
        GND, DATA[31], DATA[30], DATA[29], DATA[28], DATA[27], 
        DATA[26], DATA[25], DATA[24], GND, DATA[23], DATA[22], 
        DATA[21], DATA[20], DATA[19], DATA[18], DATA[17], DATA[16]}), 
        .A_ADDR({GND, GND, RADDRESS[6], RADDRESS[5], RADDRESS[4], 
        RADDRESS[3], RADDRESS[2], RADDRESS[1], RADDRESS[0], GND, GND, 
        GND, GND, GND}), .A_WEN({VCC, VCC}), .B_CLK(WCLOCK), 
        .B_DOUT_CLK(VCC), .B_ARST_N(VCC), .B_DOUT_EN(VCC), .B_BLK({WE, 
        VCC, VCC}), .B_DOUT_ARST_N(VCC), .B_DOUT_SRST_N(VCC), .B_DIN({
        GND, DATA[15], DATA[14], DATA[13], DATA[12], DATA[11], 
        DATA[10], DATA[9], DATA[8], GND, DATA[7], DATA[6], DATA[5], 
        DATA[4], DATA[3], DATA[2], DATA[1], DATA[0]}), .B_ADDR({GND, 
        GND, WADDRESS[6], WADDRESS[5], WADDRESS[4], WADDRESS[3], 
        WADDRESS[2], WADDRESS[1], WADDRESS[0], GND, GND, GND, GND, GND})
        , .B_WEN({VCC, VCC}), .A_EN(VCC), .A_DOUT_LAT(VCC), .A_WIDTH({
        VCC, GND, VCC}), .A_WMODE(GND), .B_EN(VCC), .B_DOUT_LAT(VCC), 
        .B_WIDTH({VCC, GND, VCC}), .B_WMODE(GND), .SII_LOCK(GND));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
`timescale 1 ns/100 ps
// Version: v11.1 SP2 11.1.2.11


module RAMBLOCK128X8(
       DATA,
       Q,
       WADDRESS,
       RADDRESS,
       WE,
       RE,
       WCLOCK,
       RCLOCK
    );
input  [7:0] DATA;
output [7:0] Q;
input  [6:0] WADDRESS;
input  [6:0] RADDRESS;
input  WE;
input  RE;
input  WCLOCK;
input  RCLOCK;

    wire VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;
    
    RAM1K18 RAMBLOCK128X8_R0C0 (.A_DOUT({nc0, nc1, nc2, nc3, nc4, nc5, 
        nc6, nc7, nc8, nc9, Q[7], Q[6], Q[5], Q[4], Q[3], Q[2], Q[1], 
        Q[0]}), .B_DOUT({nc10, nc11, nc12, nc13, nc14, nc15, nc16, 
        nc17, nc18, nc19, nc20, nc21, nc22, nc23, nc24, nc25, nc26, 
        nc27}), .BUSY(), .A_CLK(RCLOCK), .A_DOUT_CLK(VCC), .A_ARST_N(
        VCC), .A_DOUT_EN(VCC), .A_BLK({RE, VCC, VCC}), .A_DOUT_ARST_N(
        VCC), .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND}), .A_ADDR({GND, GND, GND, GND, RADDRESS[6], RADDRESS[5], 
        RADDRESS[4], RADDRESS[3], RADDRESS[2], RADDRESS[1], 
        RADDRESS[0], GND, GND, GND}), .A_WEN({GND, GND}), .B_CLK(
        WCLOCK), .B_DOUT_CLK(VCC), .B_ARST_N(VCC), .B_DOUT_EN(VCC), 
        .B_BLK({WE, VCC, VCC}), .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(
        VCC), .B_DIN({GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        DATA[7], DATA[6], DATA[5], DATA[4], DATA[3], DATA[2], DATA[1], 
        DATA[0]}), .B_ADDR({GND, GND, GND, GND, WADDRESS[6], 
        WADDRESS[5], WADDRESS[4], WADDRESS[3], WADDRESS[2], 
        WADDRESS[1], WADDRESS[0], GND, GND, GND}), .B_WEN({GND, VCC}), 
        .A_EN(VCC), .A_DOUT_LAT(VCC), .A_WIDTH({GND, VCC, VCC}), 
        .A_WMODE(GND), .B_EN(VCC), .B_DOUT_LAT(VCC), .B_WIDTH({GND, 
        VCC, VCC}), .B_WMODE(GND), .SII_LOCK(GND));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
`timescale 1 ns/100 ps
// Version: v11.1 SP2 11.1.2.11


module RAMBLOCK2048X16(
       DATA,
       Q,
       WADDRESS,
       RADDRESS,
       WE,
       RE,
       WCLOCK,
       RCLOCK
    );
input  [15:0] DATA;
output [15:0] Q;
input  [10:0] WADDRESS;
input  [10:0] RADDRESS;
input  WE;
input  RE;
input  WCLOCK;
input  RCLOCK;

    wire VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;
    
    RAM1K18 RAMBLOCK2048X16_R0C1 (.A_DOUT({nc0, nc1, nc2, nc3, nc4, 
        nc5, nc6, nc7, nc8, nc9, Q[15], Q[14], Q[13], Q[12], Q[11], 
        Q[10], Q[9], Q[8]}), .B_DOUT({nc10, nc11, nc12, nc13, nc14, 
        nc15, nc16, nc17, nc18, nc19, nc20, nc21, nc22, nc23, nc24, 
        nc25, nc26, nc27}), .BUSY(), .A_CLK(RCLOCK), .A_DOUT_CLK(VCC), 
        .A_ARST_N(VCC), .A_DOUT_EN(VCC), .A_BLK({RE, VCC, VCC}), 
        .A_DOUT_ARST_N(VCC), .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND}), .A_ADDR({RADDRESS[10], RADDRESS[9], 
        RADDRESS[8], RADDRESS[7], RADDRESS[6], RADDRESS[5], 
        RADDRESS[4], RADDRESS[3], RADDRESS[2], RADDRESS[1], 
        RADDRESS[0], GND, GND, GND}), .A_WEN({GND, GND}), .B_CLK(
        WCLOCK), .B_DOUT_CLK(VCC), .B_ARST_N(VCC), .B_DOUT_EN(VCC), 
        .B_BLK({WE, VCC, VCC}), .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(
        VCC), .B_DIN({GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        DATA[15], DATA[14], DATA[13], DATA[12], DATA[11], DATA[10], 
        DATA[9], DATA[8]}), .B_ADDR({WADDRESS[10], WADDRESS[9], 
        WADDRESS[8], WADDRESS[7], WADDRESS[6], WADDRESS[5], 
        WADDRESS[4], WADDRESS[3], WADDRESS[2], WADDRESS[1], 
        WADDRESS[0], GND, GND, GND}), .B_WEN({GND, VCC}), .A_EN(VCC), 
        .A_DOUT_LAT(VCC), .A_WIDTH({GND, VCC, VCC}), .A_WMODE(GND), 
        .B_EN(VCC), .B_DOUT_LAT(VCC), .B_WIDTH({GND, VCC, VCC}), 
        .B_WMODE(GND), .SII_LOCK(GND));
    RAM1K18 RAMBLOCK2048X16_R0C0 (.A_DOUT({nc28, nc29, nc30, nc31, 
        nc32, nc33, nc34, nc35, nc36, nc37, Q[7], Q[6], Q[5], Q[4], 
        Q[3], Q[2], Q[1], Q[0]}), .B_DOUT({nc38, nc39, nc40, nc41, 
        nc42, nc43, nc44, nc45, nc46, nc47, nc48, nc49, nc50, nc51, 
        nc52, nc53, nc54, nc55}), .BUSY(), .A_CLK(RCLOCK), .A_DOUT_CLK(
        VCC), .A_ARST_N(VCC), .A_DOUT_EN(VCC), .A_BLK({RE, VCC, VCC}), 
        .A_DOUT_ARST_N(VCC), .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND}), .A_ADDR({RADDRESS[10], RADDRESS[9], 
        RADDRESS[8], RADDRESS[7], RADDRESS[6], RADDRESS[5], 
        RADDRESS[4], RADDRESS[3], RADDRESS[2], RADDRESS[1], 
        RADDRESS[0], GND, GND, GND}), .A_WEN({GND, GND}), .B_CLK(
        WCLOCK), .B_DOUT_CLK(VCC), .B_ARST_N(VCC), .B_DOUT_EN(VCC), 
        .B_BLK({WE, VCC, VCC}), .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(
        VCC), .B_DIN({GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        DATA[7], DATA[6], DATA[5], DATA[4], DATA[3], DATA[2], DATA[1], 
        DATA[0]}), .B_ADDR({WADDRESS[10], WADDRESS[9], WADDRESS[8], 
        WADDRESS[7], WADDRESS[6], WADDRESS[5], WADDRESS[4], 
        WADDRESS[3], WADDRESS[2], WADDRESS[1], WADDRESS[0], GND, GND, 
        GND}), .B_WEN({GND, VCC}), .A_EN(VCC), .A_DOUT_LAT(VCC), 
        .A_WIDTH({GND, VCC, VCC}), .A_WMODE(GND), .B_EN(VCC), 
        .B_DOUT_LAT(VCC), .B_WIDTH({GND, VCC, VCC}), .B_WMODE(GND), 
        .SII_LOCK(GND));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
`timescale 1 ns/100 ps
// Version: v11.1 SP2 11.1.2.11


module RAMBLOCK2048X32(
       DATA,
       Q,
       WADDRESS,
       RADDRESS,
       WE,
       RE,
       WCLOCK,
       RCLOCK
    );
input  [31:0] DATA;
output [31:0] Q;
input  [10:0] WADDRESS;
input  [10:0] RADDRESS;
input  WE;
input  RE;
input  WCLOCK;
input  RCLOCK;

    wire VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;
    
    RAM1K18 RAMBLOCK2048X32_R0C2 (.A_DOUT({nc0, nc1, nc2, nc3, nc4, 
        nc5, nc6, nc7, nc8, nc9, Q[23], Q[22], Q[21], Q[20], Q[19], 
        Q[18], Q[17], Q[16]}), .B_DOUT({nc10, nc11, nc12, nc13, nc14, 
        nc15, nc16, nc17, nc18, nc19, nc20, nc21, nc22, nc23, nc24, 
        nc25, nc26, nc27}), .BUSY(), .A_CLK(RCLOCK), .A_DOUT_CLK(VCC), 
        .A_ARST_N(VCC), .A_DOUT_EN(VCC), .A_BLK({RE, VCC, VCC}), 
        .A_DOUT_ARST_N(VCC), .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND}), .A_ADDR({RADDRESS[10], RADDRESS[9], 
        RADDRESS[8], RADDRESS[7], RADDRESS[6], RADDRESS[5], 
        RADDRESS[4], RADDRESS[3], RADDRESS[2], RADDRESS[1], 
        RADDRESS[0], GND, GND, GND}), .A_WEN({GND, GND}), .B_CLK(
        WCLOCK), .B_DOUT_CLK(VCC), .B_ARST_N(VCC), .B_DOUT_EN(VCC), 
        .B_BLK({WE, VCC, VCC}), .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(
        VCC), .B_DIN({GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        DATA[23], DATA[22], DATA[21], DATA[20], DATA[19], DATA[18], 
        DATA[17], DATA[16]}), .B_ADDR({WADDRESS[10], WADDRESS[9], 
        WADDRESS[8], WADDRESS[7], WADDRESS[6], WADDRESS[5], 
        WADDRESS[4], WADDRESS[3], WADDRESS[2], WADDRESS[1], 
        WADDRESS[0], GND, GND, GND}), .B_WEN({GND, VCC}), .A_EN(VCC), 
        .A_DOUT_LAT(VCC), .A_WIDTH({GND, VCC, VCC}), .A_WMODE(GND), 
        .B_EN(VCC), .B_DOUT_LAT(VCC), .B_WIDTH({GND, VCC, VCC}), 
        .B_WMODE(GND), .SII_LOCK(GND));
    RAM1K18 RAMBLOCK2048X32_R0C0 (.A_DOUT({nc28, nc29, nc30, nc31, 
        nc32, nc33, nc34, nc35, nc36, nc37, Q[7], Q[6], Q[5], Q[4], 
        Q[3], Q[2], Q[1], Q[0]}), .B_DOUT({nc38, nc39, nc40, nc41, 
        nc42, nc43, nc44, nc45, nc46, nc47, nc48, nc49, nc50, nc51, 
        nc52, nc53, nc54, nc55}), .BUSY(), .A_CLK(RCLOCK), .A_DOUT_CLK(
        VCC), .A_ARST_N(VCC), .A_DOUT_EN(VCC), .A_BLK({RE, VCC, VCC}), 
        .A_DOUT_ARST_N(VCC), .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND}), .A_ADDR({RADDRESS[10], RADDRESS[9], 
        RADDRESS[8], RADDRESS[7], RADDRESS[6], RADDRESS[5], 
        RADDRESS[4], RADDRESS[3], RADDRESS[2], RADDRESS[1], 
        RADDRESS[0], GND, GND, GND}), .A_WEN({GND, GND}), .B_CLK(
        WCLOCK), .B_DOUT_CLK(VCC), .B_ARST_N(VCC), .B_DOUT_EN(VCC), 
        .B_BLK({WE, VCC, VCC}), .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(
        VCC), .B_DIN({GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        DATA[7], DATA[6], DATA[5], DATA[4], DATA[3], DATA[2], DATA[1], 
        DATA[0]}), .B_ADDR({WADDRESS[10], WADDRESS[9], WADDRESS[8], 
        WADDRESS[7], WADDRESS[6], WADDRESS[5], WADDRESS[4], 
        WADDRESS[3], WADDRESS[2], WADDRESS[1], WADDRESS[0], GND, GND, 
        GND}), .B_WEN({GND, VCC}), .A_EN(VCC), .A_DOUT_LAT(VCC), 
        .A_WIDTH({GND, VCC, VCC}), .A_WMODE(GND), .B_EN(VCC), 
        .B_DOUT_LAT(VCC), .B_WIDTH({GND, VCC, VCC}), .B_WMODE(GND), 
        .SII_LOCK(GND));
    RAM1K18 RAMBLOCK2048X32_R0C1 (.A_DOUT({nc56, nc57, nc58, nc59, 
        nc60, nc61, nc62, nc63, nc64, nc65, Q[15], Q[14], Q[13], Q[12], 
        Q[11], Q[10], Q[9], Q[8]}), .B_DOUT({nc66, nc67, nc68, nc69, 
        nc70, nc71, nc72, nc73, nc74, nc75, nc76, nc77, nc78, nc79, 
        nc80, nc81, nc82, nc83}), .BUSY(), .A_CLK(RCLOCK), .A_DOUT_CLK(
        VCC), .A_ARST_N(VCC), .A_DOUT_EN(VCC), .A_BLK({RE, VCC, VCC}), 
        .A_DOUT_ARST_N(VCC), .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND}), .A_ADDR({RADDRESS[10], RADDRESS[9], 
        RADDRESS[8], RADDRESS[7], RADDRESS[6], RADDRESS[5], 
        RADDRESS[4], RADDRESS[3], RADDRESS[2], RADDRESS[1], 
        RADDRESS[0], GND, GND, GND}), .A_WEN({GND, GND}), .B_CLK(
        WCLOCK), .B_DOUT_CLK(VCC), .B_ARST_N(VCC), .B_DOUT_EN(VCC), 
        .B_BLK({WE, VCC, VCC}), .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(
        VCC), .B_DIN({GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        DATA[15], DATA[14], DATA[13], DATA[12], DATA[11], DATA[10], 
        DATA[9], DATA[8]}), .B_ADDR({WADDRESS[10], WADDRESS[9], 
        WADDRESS[8], WADDRESS[7], WADDRESS[6], WADDRESS[5], 
        WADDRESS[4], WADDRESS[3], WADDRESS[2], WADDRESS[1], 
        WADDRESS[0], GND, GND, GND}), .B_WEN({GND, VCC}), .A_EN(VCC), 
        .A_DOUT_LAT(VCC), .A_WIDTH({GND, VCC, VCC}), .A_WMODE(GND), 
        .B_EN(VCC), .B_DOUT_LAT(VCC), .B_WIDTH({GND, VCC, VCC}), 
        .B_WMODE(GND), .SII_LOCK(GND));
    RAM1K18 RAMBLOCK2048X32_R0C3 (.A_DOUT({nc84, nc85, nc86, nc87, 
        nc88, nc89, nc90, nc91, nc92, nc93, Q[31], Q[30], Q[29], Q[28], 
        Q[27], Q[26], Q[25], Q[24]}), .B_DOUT({nc94, nc95, nc96, nc97, 
        nc98, nc99, nc100, nc101, nc102, nc103, nc104, nc105, nc106, 
        nc107, nc108, nc109, nc110, nc111}), .BUSY(), .A_CLK(RCLOCK), 
        .A_DOUT_CLK(VCC), .A_ARST_N(VCC), .A_DOUT_EN(VCC), .A_BLK({RE, 
        VCC, VCC}), .A_DOUT_ARST_N(VCC), .A_DOUT_SRST_N(VCC), .A_DIN({
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND}), .A_ADDR({RADDRESS[10], 
        RADDRESS[9], RADDRESS[8], RADDRESS[7], RADDRESS[6], 
        RADDRESS[5], RADDRESS[4], RADDRESS[3], RADDRESS[2], 
        RADDRESS[1], RADDRESS[0], GND, GND, GND}), .A_WEN({GND, GND}), 
        .B_CLK(WCLOCK), .B_DOUT_CLK(VCC), .B_ARST_N(VCC), .B_DOUT_EN(
        VCC), .B_BLK({WE, VCC, VCC}), .B_DOUT_ARST_N(GND), 
        .B_DOUT_SRST_N(VCC), .B_DIN({GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, DATA[31], DATA[30], DATA[29], DATA[28], 
        DATA[27], DATA[26], DATA[25], DATA[24]}), .B_ADDR({
        WADDRESS[10], WADDRESS[9], WADDRESS[8], WADDRESS[7], 
        WADDRESS[6], WADDRESS[5], WADDRESS[4], WADDRESS[3], 
        WADDRESS[2], WADDRESS[1], WADDRESS[0], GND, GND, GND}), .B_WEN({
        GND, VCC}), .A_EN(VCC), .A_DOUT_LAT(VCC), .A_WIDTH({GND, VCC, 
        VCC}), .A_WMODE(GND), .B_EN(VCC), .B_DOUT_LAT(VCC), .B_WIDTH({
        GND, VCC, VCC}), .B_WMODE(GND), .SII_LOCK(GND));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
`timescale 1 ns/100 ps
// Version: v11.1 SP2 11.1.2.11


module RAMBLOCK2048X8(
       DATA,
       Q,
       WADDRESS,
       RADDRESS,
       WE,
       RE,
       WCLOCK,
       RCLOCK
    );
input  [7:0] DATA;
output [7:0] Q;
input  [10:0] WADDRESS;
input  [10:0] RADDRESS;
input  WE;
input  RE;
input  WCLOCK;
input  RCLOCK;

    wire VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;
    
    RAM1K18 RAMBLOCK2048X8_R0C0 (.A_DOUT({nc0, nc1, nc2, nc3, nc4, nc5, 
        nc6, nc7, nc8, nc9, Q[7], Q[6], Q[5], Q[4], Q[3], Q[2], Q[1], 
        Q[0]}), .B_DOUT({nc10, nc11, nc12, nc13, nc14, nc15, nc16, 
        nc17, nc18, nc19, nc20, nc21, nc22, nc23, nc24, nc25, nc26, 
        nc27}), .BUSY(), .A_CLK(RCLOCK), .A_DOUT_CLK(VCC), .A_ARST_N(
        VCC), .A_DOUT_EN(VCC), .A_BLK({RE, VCC, VCC}), .A_DOUT_ARST_N(
        VCC), .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND}), .A_ADDR({RADDRESS[10], RADDRESS[9], RADDRESS[8], 
        RADDRESS[7], RADDRESS[6], RADDRESS[5], RADDRESS[4], 
        RADDRESS[3], RADDRESS[2], RADDRESS[1], RADDRESS[0], GND, GND, 
        GND}), .A_WEN({GND, GND}), .B_CLK(WCLOCK), .B_DOUT_CLK(VCC), 
        .B_ARST_N(VCC), .B_DOUT_EN(VCC), .B_BLK({WE, VCC, VCC}), 
        .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(VCC), .B_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, DATA[7], DATA[6], 
        DATA[5], DATA[4], DATA[3], DATA[2], DATA[1], DATA[0]}), 
        .B_ADDR({WADDRESS[10], WADDRESS[9], WADDRESS[8], WADDRESS[7], 
        WADDRESS[6], WADDRESS[5], WADDRESS[4], WADDRESS[3], 
        WADDRESS[2], WADDRESS[1], WADDRESS[0], GND, GND, GND}), .B_WEN({
        GND, VCC}), .A_EN(VCC), .A_DOUT_LAT(VCC), .A_WIDTH({GND, VCC, 
        VCC}), .A_WMODE(GND), .B_EN(VCC), .B_DOUT_LAT(VCC), .B_WIDTH({
        GND, VCC, VCC}), .B_WMODE(GND), .SII_LOCK(GND));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
`timescale 1 ns/100 ps
// Version: v11.1 SP2 11.1.2.11


module RAMBLOCK256X16(
       DATA,
       Q,
       WADDRESS,
       RADDRESS,
       WE,
       RE,
       WCLOCK,
       RCLOCK
    );
input  [15:0] DATA;
output [15:0] Q;
input  [7:0] WADDRESS;
input  [7:0] RADDRESS;
input  WE;
input  RE;
input  WCLOCK;
input  RCLOCK;

    wire VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;
    
    RAM1K18 RAMBLOCK256X16_R0C0 (.A_DOUT({nc0, Q[15], Q[14], Q[13], 
        Q[12], Q[11], Q[10], Q[9], Q[8], nc1, Q[7], Q[6], Q[5], Q[4], 
        Q[3], Q[2], Q[1], Q[0]}), .B_DOUT({nc2, nc3, nc4, nc5, nc6, 
        nc7, nc8, nc9, nc10, nc11, nc12, nc13, nc14, nc15, nc16, nc17, 
        nc18, nc19}), .BUSY(), .A_CLK(RCLOCK), .A_DOUT_CLK(VCC), 
        .A_ARST_N(VCC), .A_DOUT_EN(VCC), .A_BLK({RE, VCC, VCC}), 
        .A_DOUT_ARST_N(VCC), .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND}), .A_ADDR({GND, GND, RADDRESS[7], 
        RADDRESS[6], RADDRESS[5], RADDRESS[4], RADDRESS[3], 
        RADDRESS[2], RADDRESS[1], RADDRESS[0], GND, GND, GND, GND}), 
        .A_WEN({GND, GND}), .B_CLK(WCLOCK), .B_DOUT_CLK(VCC), 
        .B_ARST_N(VCC), .B_DOUT_EN(VCC), .B_BLK({WE, VCC, VCC}), 
        .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(VCC), .B_DIN({GND, 
        DATA[15], DATA[14], DATA[13], DATA[12], DATA[11], DATA[10], 
        DATA[9], DATA[8], GND, DATA[7], DATA[6], DATA[5], DATA[4], 
        DATA[3], DATA[2], DATA[1], DATA[0]}), .B_ADDR({GND, GND, 
        WADDRESS[7], WADDRESS[6], WADDRESS[5], WADDRESS[4], 
        WADDRESS[3], WADDRESS[2], WADDRESS[1], WADDRESS[0], GND, GND, 
        GND, GND}), .B_WEN({VCC, VCC}), .A_EN(VCC), .A_DOUT_LAT(VCC), 
        .A_WIDTH({VCC, GND, GND}), .A_WMODE(GND), .B_EN(VCC), 
        .B_DOUT_LAT(VCC), .B_WIDTH({VCC, GND, GND}), .B_WMODE(GND), 
        .SII_LOCK(GND));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
`timescale 1 ns/100 ps
// Version: v11.1 SP2 11.1.2.11


module RAMBLOCK256X32(
       DATA,
       Q,
       WADDRESS,
       RADDRESS,
       WE,
       RE,
       WCLOCK,
       RCLOCK
    );
input  [31:0] DATA;
output [31:0] Q;
input  [7:0] WADDRESS;
input  [7:0] RADDRESS;
input  WE;
input  RE;
input  WCLOCK;
input  RCLOCK;

    wire VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;
    
    RAM1K18 RAMBLOCK256X32_R0C0 (.A_DOUT({nc0, Q[31], Q[30], Q[29], 
        Q[28], Q[27], Q[26], Q[25], Q[24], nc1, Q[23], Q[22], Q[21], 
        Q[20], Q[19], Q[18], Q[17], Q[16]}), .B_DOUT({nc2, Q[15], 
        Q[14], Q[13], Q[12], Q[11], Q[10], Q[9], Q[8], nc3, Q[7], Q[6], 
        Q[5], Q[4], Q[3], Q[2], Q[1], Q[0]}), .BUSY(), .A_CLK(RCLOCK), 
        .A_DOUT_CLK(VCC), .A_ARST_N(VCC), .A_DOUT_EN(VCC), .A_BLK({RE, 
        VCC, VCC}), .A_DOUT_ARST_N(VCC), .A_DOUT_SRST_N(VCC), .A_DIN({
        GND, DATA[31], DATA[30], DATA[29], DATA[28], DATA[27], 
        DATA[26], DATA[25], DATA[24], GND, DATA[23], DATA[22], 
        DATA[21], DATA[20], DATA[19], DATA[18], DATA[17], DATA[16]}), 
        .A_ADDR({GND, RADDRESS[7], RADDRESS[6], RADDRESS[5], 
        RADDRESS[4], RADDRESS[3], RADDRESS[2], RADDRESS[1], 
        RADDRESS[0], GND, GND, GND, GND, GND}), .A_WEN({VCC, VCC}), 
        .B_CLK(WCLOCK), .B_DOUT_CLK(VCC), .B_ARST_N(VCC), .B_DOUT_EN(
        VCC), .B_BLK({WE, VCC, VCC}), .B_DOUT_ARST_N(VCC), 
        .B_DOUT_SRST_N(VCC), .B_DIN({GND, DATA[15], DATA[14], DATA[13], 
        DATA[12], DATA[11], DATA[10], DATA[9], DATA[8], GND, DATA[7], 
        DATA[6], DATA[5], DATA[4], DATA[3], DATA[2], DATA[1], DATA[0]})
        , .B_ADDR({GND, WADDRESS[7], WADDRESS[6], WADDRESS[5], 
        WADDRESS[4], WADDRESS[3], WADDRESS[2], WADDRESS[1], 
        WADDRESS[0], GND, GND, GND, GND, GND}), .B_WEN({VCC, VCC}), 
        .A_EN(VCC), .A_DOUT_LAT(VCC), .A_WIDTH({VCC, GND, VCC}), 
        .A_WMODE(GND), .B_EN(VCC), .B_DOUT_LAT(VCC), .B_WIDTH({VCC, 
        GND, VCC}), .B_WMODE(GND), .SII_LOCK(GND));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
`timescale 1 ns/100 ps
// Version: v11.1 SP2 11.1.2.11


module RAMBLOCK256X8(
       DATA,
       Q,
       WADDRESS,
       RADDRESS,
       WE,
       RE,
       WCLOCK,
       RCLOCK
    );
input  [7:0] DATA;
output [7:0] Q;
input  [7:0] WADDRESS;
input  [7:0] RADDRESS;
input  WE;
input  RE;
input  WCLOCK;
input  RCLOCK;

    wire VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;
    
    RAM1K18 RAMBLOCK256X8_R0C0 (.A_DOUT({nc0, nc1, nc2, nc3, nc4, nc5, 
        nc6, nc7, nc8, nc9, Q[7], Q[6], Q[5], Q[4], Q[3], Q[2], Q[1], 
        Q[0]}), .B_DOUT({nc10, nc11, nc12, nc13, nc14, nc15, nc16, 
        nc17, nc18, nc19, nc20, nc21, nc22, nc23, nc24, nc25, nc26, 
        nc27}), .BUSY(), .A_CLK(RCLOCK), .A_DOUT_CLK(VCC), .A_ARST_N(
        VCC), .A_DOUT_EN(VCC), .A_BLK({RE, VCC, VCC}), .A_DOUT_ARST_N(
        VCC), .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND}), .A_ADDR({GND, GND, GND, RADDRESS[7], RADDRESS[6], 
        RADDRESS[5], RADDRESS[4], RADDRESS[3], RADDRESS[2], 
        RADDRESS[1], RADDRESS[0], GND, GND, GND}), .A_WEN({GND, GND}), 
        .B_CLK(WCLOCK), .B_DOUT_CLK(VCC), .B_ARST_N(VCC), .B_DOUT_EN(
        VCC), .B_BLK({WE, VCC, VCC}), .B_DOUT_ARST_N(GND), 
        .B_DOUT_SRST_N(VCC), .B_DIN({GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, DATA[7], DATA[6], DATA[5], DATA[4], DATA[3], 
        DATA[2], DATA[1], DATA[0]}), .B_ADDR({GND, GND, GND, 
        WADDRESS[7], WADDRESS[6], WADDRESS[5], WADDRESS[4], 
        WADDRESS[3], WADDRESS[2], WADDRESS[1], WADDRESS[0], GND, GND, 
        GND}), .B_WEN({GND, VCC}), .A_EN(VCC), .A_DOUT_LAT(VCC), 
        .A_WIDTH({GND, VCC, VCC}), .A_WMODE(GND), .B_EN(VCC), 
        .B_DOUT_LAT(VCC), .B_WIDTH({GND, VCC, VCC}), .B_WMODE(GND), 
        .SII_LOCK(GND));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
`timescale 1 ns/100 ps
// Version: v11.1 SP2 11.1.2.11


module RAMBLOCK4096X16(
       DATA,
       Q,
       WADDRESS,
       RADDRESS,
       WE,
       RE,
       WCLOCK,
       RCLOCK
    );
input  [15:0] DATA;
output [15:0] Q;
input  [11:0] WADDRESS;
input  [11:0] RADDRESS;
input  WE;
input  RE;
input  WCLOCK;
input  RCLOCK;

    wire VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;
    
    RAM1K18 RAMBLOCK4096X16_R0C2 (.A_DOUT({nc0, nc1, nc2, nc3, nc4, 
        nc5, nc6, nc7, nc8, nc9, nc10, nc11, nc12, nc13, Q[11], Q[10], 
        Q[9], Q[8]}), .B_DOUT({nc14, nc15, nc16, nc17, nc18, nc19, 
        nc20, nc21, nc22, nc23, nc24, nc25, nc26, nc27, nc28, nc29, 
        nc30, nc31}), .BUSY(), .A_CLK(RCLOCK), .A_DOUT_CLK(VCC), 
        .A_ARST_N(VCC), .A_DOUT_EN(VCC), .A_BLK({RE, VCC, VCC}), 
        .A_DOUT_ARST_N(VCC), .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND}), .A_ADDR({RADDRESS[11], RADDRESS[10], 
        RADDRESS[9], RADDRESS[8], RADDRESS[7], RADDRESS[6], 
        RADDRESS[5], RADDRESS[4], RADDRESS[3], RADDRESS[2], 
        RADDRESS[1], RADDRESS[0], GND, GND}), .A_WEN({GND, GND}), 
        .B_CLK(WCLOCK), .B_DOUT_CLK(VCC), .B_ARST_N(VCC), .B_DOUT_EN(
        VCC), .B_BLK({WE, VCC, VCC}), .B_DOUT_ARST_N(GND), 
        .B_DOUT_SRST_N(VCC), .B_DIN({GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, DATA[11], DATA[10], DATA[9], 
        DATA[8]}), .B_ADDR({WADDRESS[11], WADDRESS[10], WADDRESS[9], 
        WADDRESS[8], WADDRESS[7], WADDRESS[6], WADDRESS[5], 
        WADDRESS[4], WADDRESS[3], WADDRESS[2], WADDRESS[1], 
        WADDRESS[0], GND, GND}), .B_WEN({GND, VCC}), .A_EN(VCC), 
        .A_DOUT_LAT(VCC), .A_WIDTH({GND, VCC, GND}), .A_WMODE(GND), 
        .B_EN(VCC), .B_DOUT_LAT(VCC), .B_WIDTH({GND, VCC, GND}), 
        .B_WMODE(GND), .SII_LOCK(GND));
    RAM1K18 RAMBLOCK4096X16_R0C0 (.A_DOUT({nc32, nc33, nc34, nc35, 
        nc36, nc37, nc38, nc39, nc40, nc41, nc42, nc43, nc44, nc45, 
        Q[3], Q[2], Q[1], Q[0]}), .B_DOUT({nc46, nc47, nc48, nc49, 
        nc50, nc51, nc52, nc53, nc54, nc55, nc56, nc57, nc58, nc59, 
        nc60, nc61, nc62, nc63}), .BUSY(), .A_CLK(RCLOCK), .A_DOUT_CLK(
        VCC), .A_ARST_N(VCC), .A_DOUT_EN(VCC), .A_BLK({RE, VCC, VCC}), 
        .A_DOUT_ARST_N(VCC), .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND}), .A_ADDR({RADDRESS[11], RADDRESS[10], 
        RADDRESS[9], RADDRESS[8], RADDRESS[7], RADDRESS[6], 
        RADDRESS[5], RADDRESS[4], RADDRESS[3], RADDRESS[2], 
        RADDRESS[1], RADDRESS[0], GND, GND}), .A_WEN({GND, GND}), 
        .B_CLK(WCLOCK), .B_DOUT_CLK(VCC), .B_ARST_N(VCC), .B_DOUT_EN(
        VCC), .B_BLK({WE, VCC, VCC}), .B_DOUT_ARST_N(GND), 
        .B_DOUT_SRST_N(VCC), .B_DIN({GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, DATA[3], DATA[2], DATA[1], 
        DATA[0]}), .B_ADDR({WADDRESS[11], WADDRESS[10], WADDRESS[9], 
        WADDRESS[8], WADDRESS[7], WADDRESS[6], WADDRESS[5], 
        WADDRESS[4], WADDRESS[3], WADDRESS[2], WADDRESS[1], 
        WADDRESS[0], GND, GND}), .B_WEN({GND, VCC}), .A_EN(VCC), 
        .A_DOUT_LAT(VCC), .A_WIDTH({GND, VCC, GND}), .A_WMODE(GND), 
        .B_EN(VCC), .B_DOUT_LAT(VCC), .B_WIDTH({GND, VCC, GND}), 
        .B_WMODE(GND), .SII_LOCK(GND));
    RAM1K18 RAMBLOCK4096X16_R0C1 (.A_DOUT({nc64, nc65, nc66, nc67, 
        nc68, nc69, nc70, nc71, nc72, nc73, nc74, nc75, nc76, nc77, 
        Q[7], Q[6], Q[5], Q[4]}), .B_DOUT({nc78, nc79, nc80, nc81, 
        nc82, nc83, nc84, nc85, nc86, nc87, nc88, nc89, nc90, nc91, 
        nc92, nc93, nc94, nc95}), .BUSY(), .A_CLK(RCLOCK), .A_DOUT_CLK(
        VCC), .A_ARST_N(VCC), .A_DOUT_EN(VCC), .A_BLK({RE, VCC, VCC}), 
        .A_DOUT_ARST_N(VCC), .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND}), .A_ADDR({RADDRESS[11], RADDRESS[10], 
        RADDRESS[9], RADDRESS[8], RADDRESS[7], RADDRESS[6], 
        RADDRESS[5], RADDRESS[4], RADDRESS[3], RADDRESS[2], 
        RADDRESS[1], RADDRESS[0], GND, GND}), .A_WEN({GND, GND}), 
        .B_CLK(WCLOCK), .B_DOUT_CLK(VCC), .B_ARST_N(VCC), .B_DOUT_EN(
        VCC), .B_BLK({WE, VCC, VCC}), .B_DOUT_ARST_N(GND), 
        .B_DOUT_SRST_N(VCC), .B_DIN({GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, DATA[7], DATA[6], DATA[5], 
        DATA[4]}), .B_ADDR({WADDRESS[11], WADDRESS[10], WADDRESS[9], 
        WADDRESS[8], WADDRESS[7], WADDRESS[6], WADDRESS[5], 
        WADDRESS[4], WADDRESS[3], WADDRESS[2], WADDRESS[1], 
        WADDRESS[0], GND, GND}), .B_WEN({GND, VCC}), .A_EN(VCC), 
        .A_DOUT_LAT(VCC), .A_WIDTH({GND, VCC, GND}), .A_WMODE(GND), 
        .B_EN(VCC), .B_DOUT_LAT(VCC), .B_WIDTH({GND, VCC, GND}), 
        .B_WMODE(GND), .SII_LOCK(GND));
    RAM1K18 RAMBLOCK4096X16_R0C3 (.A_DOUT({nc96, nc97, nc98, nc99, 
        nc100, nc101, nc102, nc103, nc104, nc105, nc106, nc107, nc108, 
        nc109, Q[15], Q[14], Q[13], Q[12]}), .B_DOUT({nc110, nc111, 
        nc112, nc113, nc114, nc115, nc116, nc117, nc118, nc119, nc120, 
        nc121, nc122, nc123, nc124, nc125, nc126, nc127}), .BUSY(), 
        .A_CLK(RCLOCK), .A_DOUT_CLK(VCC), .A_ARST_N(VCC), .A_DOUT_EN(
        VCC), .A_BLK({RE, VCC, VCC}), .A_DOUT_ARST_N(VCC), 
        .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND}), 
        .A_ADDR({RADDRESS[11], RADDRESS[10], RADDRESS[9], RADDRESS[8], 
        RADDRESS[7], RADDRESS[6], RADDRESS[5], RADDRESS[4], 
        RADDRESS[3], RADDRESS[2], RADDRESS[1], RADDRESS[0], GND, GND}), 
        .A_WEN({GND, GND}), .B_CLK(WCLOCK), .B_DOUT_CLK(VCC), 
        .B_ARST_N(VCC), .B_DOUT_EN(VCC), .B_BLK({WE, VCC, VCC}), 
        .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(VCC), .B_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        DATA[15], DATA[14], DATA[13], DATA[12]}), .B_ADDR({
        WADDRESS[11], WADDRESS[10], WADDRESS[9], WADDRESS[8], 
        WADDRESS[7], WADDRESS[6], WADDRESS[5], WADDRESS[4], 
        WADDRESS[3], WADDRESS[2], WADDRESS[1], WADDRESS[0], GND, GND}), 
        .B_WEN({GND, VCC}), .A_EN(VCC), .A_DOUT_LAT(VCC), .A_WIDTH({
        GND, VCC, GND}), .A_WMODE(GND), .B_EN(VCC), .B_DOUT_LAT(VCC), 
        .B_WIDTH({GND, VCC, GND}), .B_WMODE(GND), .SII_LOCK(GND));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
`timescale 1 ns/100 ps
// Version: v11.1 SP2 11.1.2.11


module RAMBLOCK4096X32(
       DATA,
       Q,
       WADDRESS,
       RADDRESS,
       WE,
       RE,
       WCLOCK,
       RCLOCK
    );
input  [31:0] DATA;
output [31:0] Q;
input  [11:0] WADDRESS;
input  [11:0] RADDRESS;
input  WE;
input  RE;
input  WCLOCK;
input  RCLOCK;

    wire VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;
    
    RAM1K18 RAMBLOCK4096X32_R0C1 (.A_DOUT({nc0, nc1, nc2, nc3, nc4, 
        nc5, nc6, nc7, nc8, nc9, nc10, nc11, nc12, nc13, Q[7], Q[6], 
        Q[5], Q[4]}), .B_DOUT({nc14, nc15, nc16, nc17, nc18, nc19, 
        nc20, nc21, nc22, nc23, nc24, nc25, nc26, nc27, nc28, nc29, 
        nc30, nc31}), .BUSY(), .A_CLK(RCLOCK), .A_DOUT_CLK(VCC), 
        .A_ARST_N(VCC), .A_DOUT_EN(VCC), .A_BLK({RE, VCC, VCC}), 
        .A_DOUT_ARST_N(VCC), .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND}), .A_ADDR({RADDRESS[11], RADDRESS[10], 
        RADDRESS[9], RADDRESS[8], RADDRESS[7], RADDRESS[6], 
        RADDRESS[5], RADDRESS[4], RADDRESS[3], RADDRESS[2], 
        RADDRESS[1], RADDRESS[0], GND, GND}), .A_WEN({GND, GND}), 
        .B_CLK(WCLOCK), .B_DOUT_CLK(VCC), .B_ARST_N(VCC), .B_DOUT_EN(
        VCC), .B_BLK({WE, VCC, VCC}), .B_DOUT_ARST_N(GND), 
        .B_DOUT_SRST_N(VCC), .B_DIN({GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, DATA[7], DATA[6], DATA[5], 
        DATA[4]}), .B_ADDR({WADDRESS[11], WADDRESS[10], WADDRESS[9], 
        WADDRESS[8], WADDRESS[7], WADDRESS[6], WADDRESS[5], 
        WADDRESS[4], WADDRESS[3], WADDRESS[2], WADDRESS[1], 
        WADDRESS[0], GND, GND}), .B_WEN({GND, VCC}), .A_EN(VCC), 
        .A_DOUT_LAT(VCC), .A_WIDTH({GND, VCC, GND}), .A_WMODE(GND), 
        .B_EN(VCC), .B_DOUT_LAT(VCC), .B_WIDTH({GND, VCC, GND}), 
        .B_WMODE(GND), .SII_LOCK(GND));
    RAM1K18 RAMBLOCK4096X32_R0C5 (.A_DOUT({nc32, nc33, nc34, nc35, 
        nc36, nc37, nc38, nc39, nc40, nc41, nc42, nc43, nc44, nc45, 
        Q[23], Q[22], Q[21], Q[20]}), .B_DOUT({nc46, nc47, nc48, nc49, 
        nc50, nc51, nc52, nc53, nc54, nc55, nc56, nc57, nc58, nc59, 
        nc60, nc61, nc62, nc63}), .BUSY(), .A_CLK(RCLOCK), .A_DOUT_CLK(
        VCC), .A_ARST_N(VCC), .A_DOUT_EN(VCC), .A_BLK({RE, VCC, VCC}), 
        .A_DOUT_ARST_N(VCC), .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND}), .A_ADDR({RADDRESS[11], RADDRESS[10], 
        RADDRESS[9], RADDRESS[8], RADDRESS[7], RADDRESS[6], 
        RADDRESS[5], RADDRESS[4], RADDRESS[3], RADDRESS[2], 
        RADDRESS[1], RADDRESS[0], GND, GND}), .A_WEN({GND, GND}), 
        .B_CLK(WCLOCK), .B_DOUT_CLK(VCC), .B_ARST_N(VCC), .B_DOUT_EN(
        VCC), .B_BLK({WE, VCC, VCC}), .B_DOUT_ARST_N(GND), 
        .B_DOUT_SRST_N(VCC), .B_DIN({GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, DATA[23], DATA[22], 
        DATA[21], DATA[20]}), .B_ADDR({WADDRESS[11], WADDRESS[10], 
        WADDRESS[9], WADDRESS[8], WADDRESS[7], WADDRESS[6], 
        WADDRESS[5], WADDRESS[4], WADDRESS[3], WADDRESS[2], 
        WADDRESS[1], WADDRESS[0], GND, GND}), .B_WEN({GND, VCC}), 
        .A_EN(VCC), .A_DOUT_LAT(VCC), .A_WIDTH({GND, VCC, GND}), 
        .A_WMODE(GND), .B_EN(VCC), .B_DOUT_LAT(VCC), .B_WIDTH({GND, 
        VCC, GND}), .B_WMODE(GND), .SII_LOCK(GND));
    RAM1K18 RAMBLOCK4096X32_R0C2 (.A_DOUT({nc64, nc65, nc66, nc67, 
        nc68, nc69, nc70, nc71, nc72, nc73, nc74, nc75, nc76, nc77, 
        Q[11], Q[10], Q[9], Q[8]}), .B_DOUT({nc78, nc79, nc80, nc81, 
        nc82, nc83, nc84, nc85, nc86, nc87, nc88, nc89, nc90, nc91, 
        nc92, nc93, nc94, nc95}), .BUSY(), .A_CLK(RCLOCK), .A_DOUT_CLK(
        VCC), .A_ARST_N(VCC), .A_DOUT_EN(VCC), .A_BLK({RE, VCC, VCC}), 
        .A_DOUT_ARST_N(VCC), .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND}), .A_ADDR({RADDRESS[11], RADDRESS[10], 
        RADDRESS[9], RADDRESS[8], RADDRESS[7], RADDRESS[6], 
        RADDRESS[5], RADDRESS[4], RADDRESS[3], RADDRESS[2], 
        RADDRESS[1], RADDRESS[0], GND, GND}), .A_WEN({GND, GND}), 
        .B_CLK(WCLOCK), .B_DOUT_CLK(VCC), .B_ARST_N(VCC), .B_DOUT_EN(
        VCC), .B_BLK({WE, VCC, VCC}), .B_DOUT_ARST_N(GND), 
        .B_DOUT_SRST_N(VCC), .B_DIN({GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, DATA[11], DATA[10], DATA[9], 
        DATA[8]}), .B_ADDR({WADDRESS[11], WADDRESS[10], WADDRESS[9], 
        WADDRESS[8], WADDRESS[7], WADDRESS[6], WADDRESS[5], 
        WADDRESS[4], WADDRESS[3], WADDRESS[2], WADDRESS[1], 
        WADDRESS[0], GND, GND}), .B_WEN({GND, VCC}), .A_EN(VCC), 
        .A_DOUT_LAT(VCC), .A_WIDTH({GND, VCC, GND}), .A_WMODE(GND), 
        .B_EN(VCC), .B_DOUT_LAT(VCC), .B_WIDTH({GND, VCC, GND}), 
        .B_WMODE(GND), .SII_LOCK(GND));
    RAM1K18 RAMBLOCK4096X32_R0C7 (.A_DOUT({nc96, nc97, nc98, nc99, 
        nc100, nc101, nc102, nc103, nc104, nc105, nc106, nc107, nc108, 
        nc109, Q[31], Q[30], Q[29], Q[28]}), .B_DOUT({nc110, nc111, 
        nc112, nc113, nc114, nc115, nc116, nc117, nc118, nc119, nc120, 
        nc121, nc122, nc123, nc124, nc125, nc126, nc127}), .BUSY(), 
        .A_CLK(RCLOCK), .A_DOUT_CLK(VCC), .A_ARST_N(VCC), .A_DOUT_EN(
        VCC), .A_BLK({RE, VCC, VCC}), .A_DOUT_ARST_N(VCC), 
        .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND}), 
        .A_ADDR({RADDRESS[11], RADDRESS[10], RADDRESS[9], RADDRESS[8], 
        RADDRESS[7], RADDRESS[6], RADDRESS[5], RADDRESS[4], 
        RADDRESS[3], RADDRESS[2], RADDRESS[1], RADDRESS[0], GND, GND}), 
        .A_WEN({GND, GND}), .B_CLK(WCLOCK), .B_DOUT_CLK(VCC), 
        .B_ARST_N(VCC), .B_DOUT_EN(VCC), .B_BLK({WE, VCC, VCC}), 
        .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(VCC), .B_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        DATA[31], DATA[30], DATA[29], DATA[28]}), .B_ADDR({
        WADDRESS[11], WADDRESS[10], WADDRESS[9], WADDRESS[8], 
        WADDRESS[7], WADDRESS[6], WADDRESS[5], WADDRESS[4], 
        WADDRESS[3], WADDRESS[2], WADDRESS[1], WADDRESS[0], GND, GND}), 
        .B_WEN({GND, VCC}), .A_EN(VCC), .A_DOUT_LAT(VCC), .A_WIDTH({
        GND, VCC, GND}), .A_WMODE(GND), .B_EN(VCC), .B_DOUT_LAT(VCC), 
        .B_WIDTH({GND, VCC, GND}), .B_WMODE(GND), .SII_LOCK(GND));
    RAM1K18 RAMBLOCK4096X32_R0C6 (.A_DOUT({nc128, nc129, nc130, nc131, 
        nc132, nc133, nc134, nc135, nc136, nc137, nc138, nc139, nc140, 
        nc141, Q[27], Q[26], Q[25], Q[24]}), .B_DOUT({nc142, nc143, 
        nc144, nc145, nc146, nc147, nc148, nc149, nc150, nc151, nc152, 
        nc153, nc154, nc155, nc156, nc157, nc158, nc159}), .BUSY(), 
        .A_CLK(RCLOCK), .A_DOUT_CLK(VCC), .A_ARST_N(VCC), .A_DOUT_EN(
        VCC), .A_BLK({RE, VCC, VCC}), .A_DOUT_ARST_N(VCC), 
        .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND}), 
        .A_ADDR({RADDRESS[11], RADDRESS[10], RADDRESS[9], RADDRESS[8], 
        RADDRESS[7], RADDRESS[6], RADDRESS[5], RADDRESS[4], 
        RADDRESS[3], RADDRESS[2], RADDRESS[1], RADDRESS[0], GND, GND}), 
        .A_WEN({GND, GND}), .B_CLK(WCLOCK), .B_DOUT_CLK(VCC), 
        .B_ARST_N(VCC), .B_DOUT_EN(VCC), .B_BLK({WE, VCC, VCC}), 
        .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(VCC), .B_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        DATA[27], DATA[26], DATA[25], DATA[24]}), .B_ADDR({
        WADDRESS[11], WADDRESS[10], WADDRESS[9], WADDRESS[8], 
        WADDRESS[7], WADDRESS[6], WADDRESS[5], WADDRESS[4], 
        WADDRESS[3], WADDRESS[2], WADDRESS[1], WADDRESS[0], GND, GND}), 
        .B_WEN({GND, VCC}), .A_EN(VCC), .A_DOUT_LAT(VCC), .A_WIDTH({
        GND, VCC, GND}), .A_WMODE(GND), .B_EN(VCC), .B_DOUT_LAT(VCC), 
        .B_WIDTH({GND, VCC, GND}), .B_WMODE(GND), .SII_LOCK(GND));
    RAM1K18 RAMBLOCK4096X32_R0C4 (.A_DOUT({nc160, nc161, nc162, nc163, 
        nc164, nc165, nc166, nc167, nc168, nc169, nc170, nc171, nc172, 
        nc173, Q[19], Q[18], Q[17], Q[16]}), .B_DOUT({nc174, nc175, 
        nc176, nc177, nc178, nc179, nc180, nc181, nc182, nc183, nc184, 
        nc185, nc186, nc187, nc188, nc189, nc190, nc191}), .BUSY(), 
        .A_CLK(RCLOCK), .A_DOUT_CLK(VCC), .A_ARST_N(VCC), .A_DOUT_EN(
        VCC), .A_BLK({RE, VCC, VCC}), .A_DOUT_ARST_N(VCC), 
        .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND}), 
        .A_ADDR({RADDRESS[11], RADDRESS[10], RADDRESS[9], RADDRESS[8], 
        RADDRESS[7], RADDRESS[6], RADDRESS[5], RADDRESS[4], 
        RADDRESS[3], RADDRESS[2], RADDRESS[1], RADDRESS[0], GND, GND}), 
        .A_WEN({GND, GND}), .B_CLK(WCLOCK), .B_DOUT_CLK(VCC), 
        .B_ARST_N(VCC), .B_DOUT_EN(VCC), .B_BLK({WE, VCC, VCC}), 
        .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(VCC), .B_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        DATA[19], DATA[18], DATA[17], DATA[16]}), .B_ADDR({
        WADDRESS[11], WADDRESS[10], WADDRESS[9], WADDRESS[8], 
        WADDRESS[7], WADDRESS[6], WADDRESS[5], WADDRESS[4], 
        WADDRESS[3], WADDRESS[2], WADDRESS[1], WADDRESS[0], GND, GND}), 
        .B_WEN({GND, VCC}), .A_EN(VCC), .A_DOUT_LAT(VCC), .A_WIDTH({
        GND, VCC, GND}), .A_WMODE(GND), .B_EN(VCC), .B_DOUT_LAT(VCC), 
        .B_WIDTH({GND, VCC, GND}), .B_WMODE(GND), .SII_LOCK(GND));
    RAM1K18 RAMBLOCK4096X32_R0C0 (.A_DOUT({nc192, nc193, nc194, nc195, 
        nc196, nc197, nc198, nc199, nc200, nc201, nc202, nc203, nc204, 
        nc205, Q[3], Q[2], Q[1], Q[0]}), .B_DOUT({nc206, nc207, nc208, 
        nc209, nc210, nc211, nc212, nc213, nc214, nc215, nc216, nc217, 
        nc218, nc219, nc220, nc221, nc222, nc223}), .BUSY(), .A_CLK(
        RCLOCK), .A_DOUT_CLK(VCC), .A_ARST_N(VCC), .A_DOUT_EN(VCC), 
        .A_BLK({RE, VCC, VCC}), .A_DOUT_ARST_N(VCC), .A_DOUT_SRST_N(
        VCC), .A_DIN({GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND}), .A_ADDR({
        RADDRESS[11], RADDRESS[10], RADDRESS[9], RADDRESS[8], 
        RADDRESS[7], RADDRESS[6], RADDRESS[5], RADDRESS[4], 
        RADDRESS[3], RADDRESS[2], RADDRESS[1], RADDRESS[0], GND, GND}), 
        .A_WEN({GND, GND}), .B_CLK(WCLOCK), .B_DOUT_CLK(VCC), 
        .B_ARST_N(VCC), .B_DOUT_EN(VCC), .B_BLK({WE, VCC, VCC}), 
        .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(VCC), .B_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        DATA[3], DATA[2], DATA[1], DATA[0]}), .B_ADDR({WADDRESS[11], 
        WADDRESS[10], WADDRESS[9], WADDRESS[8], WADDRESS[7], 
        WADDRESS[6], WADDRESS[5], WADDRESS[4], WADDRESS[3], 
        WADDRESS[2], WADDRESS[1], WADDRESS[0], GND, GND}), .B_WEN({GND, 
        VCC}), .A_EN(VCC), .A_DOUT_LAT(VCC), .A_WIDTH({GND, VCC, GND}), 
        .A_WMODE(GND), .B_EN(VCC), .B_DOUT_LAT(VCC), .B_WIDTH({GND, 
        VCC, GND}), .B_WMODE(GND), .SII_LOCK(GND));
    RAM1K18 RAMBLOCK4096X32_R0C3 (.A_DOUT({nc224, nc225, nc226, nc227, 
        nc228, nc229, nc230, nc231, nc232, nc233, nc234, nc235, nc236, 
        nc237, Q[15], Q[14], Q[13], Q[12]}), .B_DOUT({nc238, nc239, 
        nc240, nc241, nc242, nc243, nc244, nc245, nc246, nc247, nc248, 
        nc249, nc250, nc251, nc252, nc253, nc254, nc255}), .BUSY(), 
        .A_CLK(RCLOCK), .A_DOUT_CLK(VCC), .A_ARST_N(VCC), .A_DOUT_EN(
        VCC), .A_BLK({RE, VCC, VCC}), .A_DOUT_ARST_N(VCC), 
        .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND}), 
        .A_ADDR({RADDRESS[11], RADDRESS[10], RADDRESS[9], RADDRESS[8], 
        RADDRESS[7], RADDRESS[6], RADDRESS[5], RADDRESS[4], 
        RADDRESS[3], RADDRESS[2], RADDRESS[1], RADDRESS[0], GND, GND}), 
        .A_WEN({GND, GND}), .B_CLK(WCLOCK), .B_DOUT_CLK(VCC), 
        .B_ARST_N(VCC), .B_DOUT_EN(VCC), .B_BLK({WE, VCC, VCC}), 
        .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(VCC), .B_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        DATA[15], DATA[14], DATA[13], DATA[12]}), .B_ADDR({
        WADDRESS[11], WADDRESS[10], WADDRESS[9], WADDRESS[8], 
        WADDRESS[7], WADDRESS[6], WADDRESS[5], WADDRESS[4], 
        WADDRESS[3], WADDRESS[2], WADDRESS[1], WADDRESS[0], GND, GND}), 
        .B_WEN({GND, VCC}), .A_EN(VCC), .A_DOUT_LAT(VCC), .A_WIDTH({
        GND, VCC, GND}), .A_WMODE(GND), .B_EN(VCC), .B_DOUT_LAT(VCC), 
        .B_WIDTH({GND, VCC, GND}), .B_WMODE(GND), .SII_LOCK(GND));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
`timescale 1 ns/100 ps
// Version: v11.1 SP2 11.1.2.11


module RAMBLOCK4096X8(
       DATA,
       Q,
       WADDRESS,
       RADDRESS,
       WE,
       RE,
       WCLOCK,
       RCLOCK
    );
input  [7:0] DATA;
output [7:0] Q;
input  [11:0] WADDRESS;
input  [11:0] RADDRESS;
input  WE;
input  RE;
input  WCLOCK;
input  RCLOCK;

    wire VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;
    
    RAM1K18 RAMBLOCK4096X8_R0C0 (.A_DOUT({nc0, nc1, nc2, nc3, nc4, nc5, 
        nc6, nc7, nc8, nc9, nc10, nc11, nc12, nc13, Q[3], Q[2], Q[1], 
        Q[0]}), .B_DOUT({nc14, nc15, nc16, nc17, nc18, nc19, nc20, 
        nc21, nc22, nc23, nc24, nc25, nc26, nc27, nc28, nc29, nc30, 
        nc31}), .BUSY(), .A_CLK(RCLOCK), .A_DOUT_CLK(VCC), .A_ARST_N(
        VCC), .A_DOUT_EN(VCC), .A_BLK({RE, VCC, VCC}), .A_DOUT_ARST_N(
        VCC), .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND}), .A_ADDR({RADDRESS[11], RADDRESS[10], RADDRESS[9], 
        RADDRESS[8], RADDRESS[7], RADDRESS[6], RADDRESS[5], 
        RADDRESS[4], RADDRESS[3], RADDRESS[2], RADDRESS[1], 
        RADDRESS[0], GND, GND}), .A_WEN({GND, GND}), .B_CLK(WCLOCK), 
        .B_DOUT_CLK(VCC), .B_ARST_N(VCC), .B_DOUT_EN(VCC), .B_BLK({WE, 
        VCC, VCC}), .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(VCC), .B_DIN({
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, DATA[3], DATA[2], DATA[1], DATA[0]}), .B_ADDR({
        WADDRESS[11], WADDRESS[10], WADDRESS[9], WADDRESS[8], 
        WADDRESS[7], WADDRESS[6], WADDRESS[5], WADDRESS[4], 
        WADDRESS[3], WADDRESS[2], WADDRESS[1], WADDRESS[0], GND, GND}), 
        .B_WEN({GND, VCC}), .A_EN(VCC), .A_DOUT_LAT(VCC), .A_WIDTH({
        GND, VCC, GND}), .A_WMODE(GND), .B_EN(VCC), .B_DOUT_LAT(VCC), 
        .B_WIDTH({GND, VCC, GND}), .B_WMODE(GND), .SII_LOCK(GND));
    RAM1K18 RAMBLOCK4096X8_R0C1 (.A_DOUT({nc32, nc33, nc34, nc35, nc36, 
        nc37, nc38, nc39, nc40, nc41, nc42, nc43, nc44, nc45, Q[7], 
        Q[6], Q[5], Q[4]}), .B_DOUT({nc46, nc47, nc48, nc49, nc50, 
        nc51, nc52, nc53, nc54, nc55, nc56, nc57, nc58, nc59, nc60, 
        nc61, nc62, nc63}), .BUSY(), .A_CLK(RCLOCK), .A_DOUT_CLK(VCC), 
        .A_ARST_N(VCC), .A_DOUT_EN(VCC), .A_BLK({RE, VCC, VCC}), 
        .A_DOUT_ARST_N(VCC), .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND}), .A_ADDR({RADDRESS[11], RADDRESS[10], 
        RADDRESS[9], RADDRESS[8], RADDRESS[7], RADDRESS[6], 
        RADDRESS[5], RADDRESS[4], RADDRESS[3], RADDRESS[2], 
        RADDRESS[1], RADDRESS[0], GND, GND}), .A_WEN({GND, GND}), 
        .B_CLK(WCLOCK), .B_DOUT_CLK(VCC), .B_ARST_N(VCC), .B_DOUT_EN(
        VCC), .B_BLK({WE, VCC, VCC}), .B_DOUT_ARST_N(GND), 
        .B_DOUT_SRST_N(VCC), .B_DIN({GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, DATA[7], DATA[6], DATA[5], 
        DATA[4]}), .B_ADDR({WADDRESS[11], WADDRESS[10], WADDRESS[9], 
        WADDRESS[8], WADDRESS[7], WADDRESS[6], WADDRESS[5], 
        WADDRESS[4], WADDRESS[3], WADDRESS[2], WADDRESS[1], 
        WADDRESS[0], GND, GND}), .B_WEN({GND, VCC}), .A_EN(VCC), 
        .A_DOUT_LAT(VCC), .A_WIDTH({GND, VCC, GND}), .A_WMODE(GND), 
        .B_EN(VCC), .B_DOUT_LAT(VCC), .B_WIDTH({GND, VCC, GND}), 
        .B_WMODE(GND), .SII_LOCK(GND));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
`timescale 1 ns/100 ps
// Version: v11.1 SP2 11.1.2.11


module RAMBLOCK512X16(
       DATA,
       Q,
       WADDRESS,
       RADDRESS,
       WE,
       RE,
       WCLOCK,
       RCLOCK
    );
input  [15:0] DATA;
output [15:0] Q;
input  [8:0] WADDRESS;
input  [8:0] RADDRESS;
input  WE;
input  RE;
input  WCLOCK;
input  RCLOCK;

    wire VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;
    
    RAM1K18 RAMBLOCK512X16_R0C0 (.A_DOUT({nc0, Q[15], Q[14], Q[13], 
        Q[12], Q[11], Q[10], Q[9], Q[8], nc1, Q[7], Q[6], Q[5], Q[4], 
        Q[3], Q[2], Q[1], Q[0]}), .B_DOUT({nc2, nc3, nc4, nc5, nc6, 
        nc7, nc8, nc9, nc10, nc11, nc12, nc13, nc14, nc15, nc16, nc17, 
        nc18, nc19}), .BUSY(), .A_CLK(RCLOCK), .A_DOUT_CLK(VCC), 
        .A_ARST_N(VCC), .A_DOUT_EN(VCC), .A_BLK({RE, VCC, VCC}), 
        .A_DOUT_ARST_N(VCC), .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND}), .A_ADDR({GND, RADDRESS[8], RADDRESS[7], 
        RADDRESS[6], RADDRESS[5], RADDRESS[4], RADDRESS[3], 
        RADDRESS[2], RADDRESS[1], RADDRESS[0], GND, GND, GND, GND}), 
        .A_WEN({GND, GND}), .B_CLK(WCLOCK), .B_DOUT_CLK(VCC), 
        .B_ARST_N(VCC), .B_DOUT_EN(VCC), .B_BLK({WE, VCC, VCC}), 
        .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(VCC), .B_DIN({GND, 
        DATA[15], DATA[14], DATA[13], DATA[12], DATA[11], DATA[10], 
        DATA[9], DATA[8], GND, DATA[7], DATA[6], DATA[5], DATA[4], 
        DATA[3], DATA[2], DATA[1], DATA[0]}), .B_ADDR({GND, 
        WADDRESS[8], WADDRESS[7], WADDRESS[6], WADDRESS[5], 
        WADDRESS[4], WADDRESS[3], WADDRESS[2], WADDRESS[1], 
        WADDRESS[0], GND, GND, GND, GND}), .B_WEN({VCC, VCC}), .A_EN(
        VCC), .A_DOUT_LAT(VCC), .A_WIDTH({VCC, GND, GND}), .A_WMODE(
        GND), .B_EN(VCC), .B_DOUT_LAT(VCC), .B_WIDTH({VCC, GND, GND}), 
        .B_WMODE(GND), .SII_LOCK(GND));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
`timescale 1 ns/100 ps
// Version: v11.1 SP2 11.1.2.11


module RAMBLOCK512X32(
       DATA,
       Q,
       WADDRESS,
       RADDRESS,
       WE,
       RE,
       WCLOCK,
       RCLOCK
    );
input  [31:0] DATA;
output [31:0] Q;
input  [8:0] WADDRESS;
input  [8:0] RADDRESS;
input  WE;
input  RE;
input  WCLOCK;
input  RCLOCK;

    wire VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;
    
    RAM1K18 RAMBLOCK512X32_R0C0 (.A_DOUT({nc0, Q[31], Q[30], Q[29], 
        Q[28], Q[27], Q[26], Q[25], Q[24], nc1, Q[23], Q[22], Q[21], 
        Q[20], Q[19], Q[18], Q[17], Q[16]}), .B_DOUT({nc2, Q[15], 
        Q[14], Q[13], Q[12], Q[11], Q[10], Q[9], Q[8], nc3, Q[7], Q[6], 
        Q[5], Q[4], Q[3], Q[2], Q[1], Q[0]}), .BUSY(), .A_CLK(RCLOCK), 
        .A_DOUT_CLK(VCC), .A_ARST_N(VCC), .A_DOUT_EN(VCC), .A_BLK({RE, 
        VCC, VCC}), .A_DOUT_ARST_N(VCC), .A_DOUT_SRST_N(VCC), .A_DIN({
        GND, DATA[31], DATA[30], DATA[29], DATA[28], DATA[27], 
        DATA[26], DATA[25], DATA[24], GND, DATA[23], DATA[22], 
        DATA[21], DATA[20], DATA[19], DATA[18], DATA[17], DATA[16]}), 
        .A_ADDR({RADDRESS[8], RADDRESS[7], RADDRESS[6], RADDRESS[5], 
        RADDRESS[4], RADDRESS[3], RADDRESS[2], RADDRESS[1], 
        RADDRESS[0], GND, GND, GND, GND, GND}), .A_WEN({VCC, VCC}), 
        .B_CLK(WCLOCK), .B_DOUT_CLK(VCC), .B_ARST_N(VCC), .B_DOUT_EN(
        VCC), .B_BLK({WE, VCC, VCC}), .B_DOUT_ARST_N(VCC), 
        .B_DOUT_SRST_N(VCC), .B_DIN({GND, DATA[15], DATA[14], DATA[13], 
        DATA[12], DATA[11], DATA[10], DATA[9], DATA[8], GND, DATA[7], 
        DATA[6], DATA[5], DATA[4], DATA[3], DATA[2], DATA[1], DATA[0]})
        , .B_ADDR({WADDRESS[8], WADDRESS[7], WADDRESS[6], WADDRESS[5], 
        WADDRESS[4], WADDRESS[3], WADDRESS[2], WADDRESS[1], 
        WADDRESS[0], GND, GND, GND, GND, GND}), .B_WEN({VCC, VCC}), 
        .A_EN(VCC), .A_DOUT_LAT(VCC), .A_WIDTH({VCC, GND, VCC}), 
        .A_WMODE(GND), .B_EN(VCC), .B_DOUT_LAT(VCC), .B_WIDTH({VCC, 
        GND, VCC}), .B_WMODE(GND), .SII_LOCK(GND));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
`timescale 1 ns/100 ps
// Version: v11.1 SP2 11.1.2.11


module RAMBLOCK512X8(
       DATA,
       Q,
       WADDRESS,
       RADDRESS,
       WE,
       RE,
       WCLOCK,
       RCLOCK
    );
input  [7:0] DATA;
output [7:0] Q;
input  [8:0] WADDRESS;
input  [8:0] RADDRESS;
input  WE;
input  RE;
input  WCLOCK;
input  RCLOCK;

    wire VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;
    
    RAM1K18 RAMBLOCK512X8_R0C0 (.A_DOUT({nc0, nc1, nc2, nc3, nc4, nc5, 
        nc6, nc7, nc8, nc9, Q[7], Q[6], Q[5], Q[4], Q[3], Q[2], Q[1], 
        Q[0]}), .B_DOUT({nc10, nc11, nc12, nc13, nc14, nc15, nc16, 
        nc17, nc18, nc19, nc20, nc21, nc22, nc23, nc24, nc25, nc26, 
        nc27}), .BUSY(), .A_CLK(RCLOCK), .A_DOUT_CLK(VCC), .A_ARST_N(
        VCC), .A_DOUT_EN(VCC), .A_BLK({RE, VCC, VCC}), .A_DOUT_ARST_N(
        VCC), .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND}), .A_ADDR({GND, GND, RADDRESS[8], RADDRESS[7], 
        RADDRESS[6], RADDRESS[5], RADDRESS[4], RADDRESS[3], 
        RADDRESS[2], RADDRESS[1], RADDRESS[0], GND, GND, GND}), .A_WEN({
        GND, GND}), .B_CLK(WCLOCK), .B_DOUT_CLK(VCC), .B_ARST_N(VCC), 
        .B_DOUT_EN(VCC), .B_BLK({WE, VCC, VCC}), .B_DOUT_ARST_N(GND), 
        .B_DOUT_SRST_N(VCC), .B_DIN({GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, DATA[7], DATA[6], DATA[5], DATA[4], DATA[3], 
        DATA[2], DATA[1], DATA[0]}), .B_ADDR({GND, GND, WADDRESS[8], 
        WADDRESS[7], WADDRESS[6], WADDRESS[5], WADDRESS[4], 
        WADDRESS[3], WADDRESS[2], WADDRESS[1], WADDRESS[0], GND, GND, 
        GND}), .B_WEN({GND, VCC}), .A_EN(VCC), .A_DOUT_LAT(VCC), 
        .A_WIDTH({GND, VCC, VCC}), .A_WMODE(GND), .B_EN(VCC), 
        .B_DOUT_LAT(VCC), .B_WIDTH({GND, VCC, VCC}), .B_WMODE(GND), 
        .SII_LOCK(GND));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
`timescale 1 ns/100 ps
// Version: v11.1 SP2 11.1.2.11


module RAMBLOCK64X16(
       DATA,
       Q,
       WADDRESS,
       RADDRESS,
       WE,
       RE,
       WCLOCK,
       RCLOCK
    );
input  [15:0] DATA;
output [15:0] Q;
input  [5:0] WADDRESS;
input  [5:0] RADDRESS;
input  WE;
input  RE;
input  WCLOCK;
input  RCLOCK;

    wire VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;
    
    RAM1K18 RAMBLOCK64X16_R0C0 (.A_DOUT({nc0, Q[15], Q[14], Q[13], 
        Q[12], Q[11], Q[10], Q[9], Q[8], nc1, Q[7], Q[6], Q[5], Q[4], 
        Q[3], Q[2], Q[1], Q[0]}), .B_DOUT({nc2, nc3, nc4, nc5, nc6, 
        nc7, nc8, nc9, nc10, nc11, nc12, nc13, nc14, nc15, nc16, nc17, 
        nc18, nc19}), .BUSY(), .A_CLK(RCLOCK), .A_DOUT_CLK(VCC), 
        .A_ARST_N(VCC), .A_DOUT_EN(VCC), .A_BLK({RE, VCC, VCC}), 
        .A_DOUT_ARST_N(VCC), .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND, GND, GND, GND}), .A_ADDR({GND, GND, GND, GND, RADDRESS[5], 
        RADDRESS[4], RADDRESS[3], RADDRESS[2], RADDRESS[1], 
        RADDRESS[0], GND, GND, GND, GND}), .A_WEN({GND, GND}), .B_CLK(
        WCLOCK), .B_DOUT_CLK(VCC), .B_ARST_N(VCC), .B_DOUT_EN(VCC), 
        .B_BLK({WE, VCC, VCC}), .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(
        VCC), .B_DIN({GND, DATA[15], DATA[14], DATA[13], DATA[12], 
        DATA[11], DATA[10], DATA[9], DATA[8], GND, DATA[7], DATA[6], 
        DATA[5], DATA[4], DATA[3], DATA[2], DATA[1], DATA[0]}), 
        .B_ADDR({GND, GND, GND, GND, WADDRESS[5], WADDRESS[4], 
        WADDRESS[3], WADDRESS[2], WADDRESS[1], WADDRESS[0], GND, GND, 
        GND, GND}), .B_WEN({VCC, VCC}), .A_EN(VCC), .A_DOUT_LAT(VCC), 
        .A_WIDTH({VCC, GND, GND}), .A_WMODE(GND), .B_EN(VCC), 
        .B_DOUT_LAT(VCC), .B_WIDTH({VCC, GND, GND}), .B_WMODE(GND), 
        .SII_LOCK(GND));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
`timescale 1 ns/100 ps
// Version: v11.1 SP2 11.1.2.11


module RAMBLOCK64X32(
       DATA,
       Q,
       WADDRESS,
       RADDRESS,
       WE,
       RE,
       WCLOCK,
       RCLOCK
    );
input  [31:0] DATA;
output [31:0] Q;
input  [5:0] WADDRESS;
input  [5:0] RADDRESS;
input  WE;
input  RE;
input  WCLOCK;
input  RCLOCK;

    wire VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;
    
    RAM1K18 RAMBLOCK64X32_R0C0 (.A_DOUT({nc0, Q[31], Q[30], Q[29], 
        Q[28], Q[27], Q[26], Q[25], Q[24], nc1, Q[23], Q[22], Q[21], 
        Q[20], Q[19], Q[18], Q[17], Q[16]}), .B_DOUT({nc2, Q[15], 
        Q[14], Q[13], Q[12], Q[11], Q[10], Q[9], Q[8], nc3, Q[7], Q[6], 
        Q[5], Q[4], Q[3], Q[2], Q[1], Q[0]}), .BUSY(), .A_CLK(RCLOCK), 
        .A_DOUT_CLK(VCC), .A_ARST_N(VCC), .A_DOUT_EN(VCC), .A_BLK({RE, 
        VCC, VCC}), .A_DOUT_ARST_N(VCC), .A_DOUT_SRST_N(VCC), .A_DIN({
        GND, DATA[31], DATA[30], DATA[29], DATA[28], DATA[27], 
        DATA[26], DATA[25], DATA[24], GND, DATA[23], DATA[22], 
        DATA[21], DATA[20], DATA[19], DATA[18], DATA[17], DATA[16]}), 
        .A_ADDR({GND, GND, GND, RADDRESS[5], RADDRESS[4], RADDRESS[3], 
        RADDRESS[2], RADDRESS[1], RADDRESS[0], GND, GND, GND, GND, GND})
        , .A_WEN({VCC, VCC}), .B_CLK(WCLOCK), .B_DOUT_CLK(VCC), 
        .B_ARST_N(VCC), .B_DOUT_EN(VCC), .B_BLK({WE, VCC, VCC}), 
        .B_DOUT_ARST_N(VCC), .B_DOUT_SRST_N(VCC), .B_DIN({GND, 
        DATA[15], DATA[14], DATA[13], DATA[12], DATA[11], DATA[10], 
        DATA[9], DATA[8], GND, DATA[7], DATA[6], DATA[5], DATA[4], 
        DATA[3], DATA[2], DATA[1], DATA[0]}), .B_ADDR({GND, GND, GND, 
        WADDRESS[5], WADDRESS[4], WADDRESS[3], WADDRESS[2], 
        WADDRESS[1], WADDRESS[0], GND, GND, GND, GND, GND}), .B_WEN({
        VCC, VCC}), .A_EN(VCC), .A_DOUT_LAT(VCC), .A_WIDTH({VCC, GND, 
        VCC}), .A_WMODE(GND), .B_EN(VCC), .B_DOUT_LAT(VCC), .B_WIDTH({
        VCC, GND, VCC}), .B_WMODE(GND), .SII_LOCK(GND));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
`timescale 1 ns/100 ps
// Version: v11.1 SP2 11.1.2.11


module RAMBLOCK64X8(
       DATA,
       Q,
       WADDRESS,
       RADDRESS,
       WE,
       RE,
       WCLOCK,
       RCLOCK
    );
input  [7:0] DATA;
output [7:0] Q;
input  [5:0] WADDRESS;
input  [5:0] RADDRESS;
input  WE;
input  RE;
input  WCLOCK;
input  RCLOCK;

    wire VCC, GND, ADLIB_VCC;
    wire GND_power_net1;
    wire VCC_power_net1;
    assign GND = GND_power_net1;
    assign VCC = VCC_power_net1;
    assign ADLIB_VCC = VCC_power_net1;
    
    RAM1K18 RAMBLOCK64X8_R0C0 (.A_DOUT({nc0, nc1, nc2, nc3, nc4, nc5, 
        nc6, nc7, nc8, nc9, Q[7], Q[6], Q[5], Q[4], Q[3], Q[2], Q[1], 
        Q[0]}), .B_DOUT({nc10, nc11, nc12, nc13, nc14, nc15, nc16, 
        nc17, nc18, nc19, nc20, nc21, nc22, nc23, nc24, nc25, nc26, 
        nc27}), .BUSY(), .A_CLK(RCLOCK), .A_DOUT_CLK(VCC), .A_ARST_N(
        VCC), .A_DOUT_EN(VCC), .A_BLK({RE, VCC, VCC}), .A_DOUT_ARST_N(
        VCC), .A_DOUT_SRST_N(VCC), .A_DIN({GND, GND, GND, GND, GND, 
        GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        GND}), .A_ADDR({GND, GND, GND, GND, GND, RADDRESS[5], 
        RADDRESS[4], RADDRESS[3], RADDRESS[2], RADDRESS[1], 
        RADDRESS[0], GND, GND, GND}), .A_WEN({GND, GND}), .B_CLK(
        WCLOCK), .B_DOUT_CLK(VCC), .B_ARST_N(VCC), .B_DOUT_EN(VCC), 
        .B_BLK({WE, VCC, VCC}), .B_DOUT_ARST_N(GND), .B_DOUT_SRST_N(
        VCC), .B_DIN({GND, GND, GND, GND, GND, GND, GND, GND, GND, GND, 
        DATA[7], DATA[6], DATA[5], DATA[4], DATA[3], DATA[2], DATA[1], 
        DATA[0]}), .B_ADDR({GND, GND, GND, GND, GND, WADDRESS[5], 
        WADDRESS[4], WADDRESS[3], WADDRESS[2], WADDRESS[1], 
        WADDRESS[0], GND, GND, GND}), .B_WEN({GND, VCC}), .A_EN(VCC), 
        .A_DOUT_LAT(VCC), .A_WIDTH({GND, VCC, VCC}), .A_WMODE(GND), 
        .B_EN(VCC), .B_DOUT_LAT(VCC), .B_WIDTH({GND, VCC, VCC}), 
        .B_WMODE(GND), .SII_LOCK(GND));
    GND GND_power_inst1 (.Y(GND_power_net1));
    VCC VCC_power_inst1 (.Y(VCC_power_net1));
    
endmodule
