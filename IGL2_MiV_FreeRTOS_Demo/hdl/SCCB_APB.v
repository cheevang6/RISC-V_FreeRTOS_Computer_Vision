// SCCB_APB.v
module SCC_APB()
    input [8:0]     PADDR;
    input           PCLK; //
    input           PENABLE;
    input           PRESETN; //
    input           PSEL;
    input [7:0]     PWDATA;
    input           PWRITE;
    output [0:0]    INT;
    output [7:0]    PRDATA;

    wire [8:0]      PADDR;
    wire            PCLK; //
    wire            PENABLE;
    wire            PRESETN; //
    wire            PSEL;
    wire [7:0]      PWDATA;
    wire            PWRITE;
    wire [0:0]      INT;
    wire [7:0]      PRDATA;
    
    wire [7:0]      APBslave_PRDATA;
    
    
    wire   [0:0] INT_0;
    wire   [0:0] SCLI;
    wire   [0:0] SCLO_0;
    wire   [0:0] SDAI;
    wire   [0:0] SDAO_0;
    wire   [7:0] APBslave_PRDATA_net_0;
    wire   [0:0] INT_0_net_0;
    wire   [0:0] SCLO_0_net_0;
    wire   [0:0] SDAO_0_net_0;
endmodue