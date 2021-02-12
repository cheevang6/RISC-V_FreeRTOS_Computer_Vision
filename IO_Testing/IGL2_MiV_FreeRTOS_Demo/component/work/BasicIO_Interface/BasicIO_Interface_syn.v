`timescale 1 ns/100 ps
// Version: 


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
    ) ;
/* synthesis syn_black_box

syn_tsu0 = " FTDI_UART0_TXD->PCLK = 0"
syn_tsu1 = " PADDR_in[0]->PCLK = 4.275"
syn_tsu2 = " PADDR_in[10]->PCLK = 4.357"
syn_tsu3 = " PADDR_in[11]->PCLK = 4.26"
syn_tsu4 = " PADDR_in[1]->PCLK = 4.157"
syn_tsu5 = " PADDR_in[2]->PCLK = 4.176"
syn_tsu6 = " PADDR_in[3]->PCLK = 4.149"
syn_tsu7 = " PADDR_in[4]->PCLK = 1.943"
syn_tsu8 = " PADDR_in[5]->PCLK = 1.692"
syn_tsu9 = " PADDR_in[6]->PCLK = 2.901"
syn_tsu10 = " PADDR_in[7]->PCLK = 2.849"
syn_tsu11 = " PADDR_in[8]->PCLK = 3.245"
syn_tsu12 = " PADDR_in[9]->PCLK = 4.475"
syn_tsu13 = " PENABLE_in->PCLK = 2.016"
syn_tsu14 = " PRESETN->PCLK = 0"
syn_tsu15 = " PSEL_in->PCLK = 4.208"
syn_tsu16 = " PWDATA_in[0]->PCLK = 0"
syn_tsu17 = " PWDATA_in[1]->PCLK = 0"
syn_tsu18 = " PWDATA_in[2]->PCLK = 0"
syn_tsu19 = " PWDATA_in[3]->PCLK = 0"
syn_tsu20 = " PWDATA_in[4]->PCLK = 0"
syn_tsu21 = " PWDATA_in[5]->PCLK = 0"
syn_tsu22 = " PWDATA_in[6]->PCLK = 0"
syn_tsu23 = " PWDATA_in[7]->PCLK = 0"
syn_tsu24 = " PWRITE_in->PCLK = 2.078"
syn_tsu25 = " USER_BUTTON1->PCLK = 0"
syn_tsu26 = " USER_BUTTON2->PCLK = 0"
syn_tpd0 = " PADDR_in[0]->PRDATA_in[0] = 8.198"
syn_tpd1 = " PADDR_in[0]->PRDATA_in[1] = 8.198"
syn_tpd2 = " PADDR_in[0]->PRDATA_in[2] = 5.939"
syn_tpd3 = " PADDR_in[0]->PRDATA_in[3] = 5.939"
syn_tpd4 = " PADDR_in[0]->PRDATA_in[4] = 5.939"
syn_tpd5 = " PADDR_in[0]->PRDATA_in[5] = 5.939"
syn_tpd6 = " PADDR_in[10]->PRDATA_in[0] = 4.541"
syn_tpd7 = " PADDR_in[10]->PRDATA_in[1] = 4.541"
syn_tpd8 = " PADDR_in[10]->PRDATA_in[2] = 5.503"
syn_tpd9 = " PADDR_in[10]->PRDATA_in[3] = 5.503"
syn_tpd10 = " PADDR_in[10]->PRDATA_in[4] = 5.503"
syn_tpd11 = " PADDR_in[10]->PRDATA_in[5] = 5.503"
syn_tpd12 = " PADDR_in[10]->PRDATA_in[6] = 4.488"
syn_tpd13 = " PADDR_in[10]->PRDATA_in[7] = 4.488"
syn_tpd14 = " PADDR_in[11]->PRDATA_in[0] = 4.444"
syn_tpd15 = " PADDR_in[11]->PRDATA_in[1] = 4.444"
syn_tpd16 = " PADDR_in[11]->PRDATA_in[2] = 5.406"
syn_tpd17 = " PADDR_in[11]->PRDATA_in[3] = 5.406"
syn_tpd18 = " PADDR_in[11]->PRDATA_in[4] = 5.406"
syn_tpd19 = " PADDR_in[11]->PRDATA_in[5] = 5.406"
syn_tpd20 = " PADDR_in[11]->PRDATA_in[6] = 4.391"
syn_tpd21 = " PADDR_in[11]->PRDATA_in[7] = 4.391"
syn_tpd22 = " PADDR_in[1]->PRDATA_in[0] = 8.080"
syn_tpd23 = " PADDR_in[1]->PRDATA_in[1] = 8.080"
syn_tpd24 = " PADDR_in[1]->PRDATA_in[2] = 5.821"
syn_tpd25 = " PADDR_in[1]->PRDATA_in[3] = 5.821"
syn_tpd26 = " PADDR_in[1]->PRDATA_in[4] = 5.821"
syn_tpd27 = " PADDR_in[1]->PRDATA_in[5] = 5.821"
syn_tpd28 = " PADDR_in[2]->PRDATA_in[0] = 8.108"
syn_tpd29 = " PADDR_in[2]->PRDATA_in[1] = 8.108"
syn_tpd30 = " PADDR_in[2]->PRDATA_in[2] = 5.840"
syn_tpd31 = " PADDR_in[2]->PRDATA_in[3] = 5.840"
syn_tpd32 = " PADDR_in[2]->PRDATA_in[4] = 5.840"
syn_tpd33 = " PADDR_in[2]->PRDATA_in[5] = 5.840"
syn_tpd34 = " PADDR_in[3]->PRDATA_in[0] = 8.075"
syn_tpd35 = " PADDR_in[3]->PRDATA_in[1] = 8.075"
syn_tpd36 = " PADDR_in[3]->PRDATA_in[2] = 5.813"
syn_tpd37 = " PADDR_in[3]->PRDATA_in[3] = 5.813"
syn_tpd38 = " PADDR_in[3]->PRDATA_in[4] = 5.813"
syn_tpd39 = " PADDR_in[3]->PRDATA_in[5] = 5.813"
syn_tpd40 = " PADDR_in[4]->PRDATA_in[0] = 5.792"
syn_tpd41 = " PADDR_in[4]->PRDATA_in[1] = 5.792"
syn_tpd42 = " PADDR_in[4]->PRDATA_in[2] = 3.506"
syn_tpd43 = " PADDR_in[4]->PRDATA_in[3] = 3.506"
syn_tpd44 = " PADDR_in[4]->PRDATA_in[4] = 3.506"
syn_tpd45 = " PADDR_in[4]->PRDATA_in[5] = 3.506"
syn_tpd46 = " PADDR_in[5]->PRDATA_in[0] = 5.613"
syn_tpd47 = " PADDR_in[5]->PRDATA_in[1] = 5.613"
syn_tpd48 = " PADDR_in[5]->PRDATA_in[2] = 3.354"
syn_tpd49 = " PADDR_in[5]->PRDATA_in[3] = 3.354"
syn_tpd50 = " PADDR_in[5]->PRDATA_in[4] = 3.354"
syn_tpd51 = " PADDR_in[5]->PRDATA_in[5] = 3.354"
syn_tpd52 = " PADDR_in[6]->PRDATA_in[0] = 6.842"
syn_tpd53 = " PADDR_in[6]->PRDATA_in[1] = 6.842"
syn_tpd54 = " PADDR_in[6]->PRDATA_in[2] = 4.565"
syn_tpd55 = " PADDR_in[6]->PRDATA_in[3] = 4.565"
syn_tpd56 = " PADDR_in[6]->PRDATA_in[4] = 4.565"
syn_tpd57 = " PADDR_in[6]->PRDATA_in[5] = 4.565"
syn_tpd58 = " PADDR_in[7]->PRDATA_in[0] = 6.772"
syn_tpd59 = " PADDR_in[7]->PRDATA_in[1] = 6.772"
syn_tpd60 = " PADDR_in[7]->PRDATA_in[2] = 4.513"
syn_tpd61 = " PADDR_in[7]->PRDATA_in[3] = 4.513"
syn_tpd62 = " PADDR_in[7]->PRDATA_in[4] = 4.513"
syn_tpd63 = " PADDR_in[7]->PRDATA_in[5] = 4.513"
syn_tpd64 = " PADDR_in[8]->PRDATA_in[0] = 3.429"
syn_tpd65 = " PADDR_in[8]->PRDATA_in[1] = 3.429"
syn_tpd66 = " PADDR_in[8]->PRDATA_in[2] = 4.391"
syn_tpd67 = " PADDR_in[8]->PRDATA_in[3] = 4.391"
syn_tpd68 = " PADDR_in[8]->PRDATA_in[4] = 4.391"
syn_tpd69 = " PADDR_in[8]->PRDATA_in[5] = 4.391"
syn_tpd70 = " PADDR_in[8]->PRDATA_in[6] = 3.376"
syn_tpd71 = " PADDR_in[8]->PRDATA_in[7] = 3.376"
syn_tpd72 = " PADDR_in[9]->PRDATA_in[0] = 4.659"
syn_tpd73 = " PADDR_in[9]->PRDATA_in[1] = 4.659"
syn_tpd74 = " PADDR_in[9]->PRDATA_in[2] = 5.621"
syn_tpd75 = " PADDR_in[9]->PRDATA_in[3] = 5.621"
syn_tpd76 = " PADDR_in[9]->PRDATA_in[4] = 5.621"
syn_tpd77 = " PADDR_in[9]->PRDATA_in[5] = 5.621"
syn_tpd78 = " PADDR_in[9]->PRDATA_in[6] = 4.606"
syn_tpd79 = " PADDR_in[9]->PRDATA_in[7] = 4.606"
syn_tco80 = " PCLK->FTDI_UART0_RXD = 4.166"
syn_tco81 = " PCLK->LED1_GREEN = 4.174"
syn_tco82 = " PCLK->LED1_RED = 4.174"
syn_tco83 = " PCLK->LED2_GREEN = 4.174"
syn_tco84 = " PCLK->LED2_RED = 4.174"
syn_tco85 = " PCLK->PRDATA_in[0] = 7.470"
syn_tco86 = " PCLK->PRDATA_in[1] = 7.382"
syn_tco87 = " PCLK->PRDATA_in[2] = 6.196"
syn_tco88 = " PCLK->PRDATA_in[3] = 6.196"
syn_tco89 = " PCLK->PRDATA_in[4] = 6.196"
syn_tco90 = " PCLK->PRDATA_in[5] = 6.196"
syn_tco91 = " PCLK->PRDATA_in[6] = 5.325"
syn_tco92 = " PCLK->PRDATA_in[7] = 5.325"
syn_tco93 = " PCLK->USER_PB1_IRQ = 4.182"
syn_tco94 = " PCLK->USER_PB2_IRQ = 4.182"
syn_tpd95 = " PSEL_in->PRDATA_in[0] = 4.392"
syn_tpd96 = " PSEL_in->PRDATA_in[1] = 4.392"
syn_tpd97 = " PSEL_in->PRDATA_in[2] = 5.354"
syn_tpd98 = " PSEL_in->PRDATA_in[3] = 5.354"
syn_tpd99 = " PSEL_in->PRDATA_in[4] = 5.354"
syn_tpd100 = " PSEL_in->PRDATA_in[5] = 5.354"
syn_tpd101 = " PSEL_in->PRDATA_in[6] = 4.339"
syn_tpd102 = " PSEL_in->PRDATA_in[7] = 4.339"
*/
/* synthesis black_box_pad_pin ="" */
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

endmodule
