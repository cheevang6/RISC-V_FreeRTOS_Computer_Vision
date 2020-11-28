// SCCB_APB.v
module SCC_APB(PADDR, PCLK,PENABLE,PRESETN,PSEL,PWDATA,PWRITE,INT,PRDATA);
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
    
    wire   [0:0] INT_0; // camera does not use interrupt
    wire   [0:0] SIO_C;
    wire   [0:0] SIO_D_0;
    wire   [0:0] SIO_D;
    wire   [0:0] SIO_D_0;
    wire   [7:0] APBslave_PRDATA_net_0;
    wire   [0:0] INT_0_net_0; // camera does not use interrupt
    wire   [0:0] SIO_C_0_net_0;
    wire   [0:0] SIO_D_0_net_0;
    
    SCCB_CTRL (
        .addr_in(PADDR),
        .XCLK(PCLK),
        .
    );
endmodue
