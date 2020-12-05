// SCCB_APB.v
module SCC_APB(PADDR,PCLK,PENABLE,PRESETN,PSEL,PWDATA,PWRITE,INT,PRDATA,SIO_C,SIO_D);
    input [8:0]     PADDR;
    input           PCLK; //
    input           PENABLE;
    input           PRESETN; //
    input           PSEL;
    input [7:0]     PWDATA;
    input           PWRITE;
    input           SIO_C;
    output [0:0]    INT;
    output [7:0]    PRDATA;
    inout           SIO_D;

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
    
    SCCB_CTRL SCCB_CTRL_0(
        .addr_in(PADDR),
        .XCLK(PCLK),
        .RW_REQ(PWRTIE),
        .data_in(PWDATA),
        .data_out(PRDATA),
        .addr_id(),
        .SIO_D(),
        .SIO_C()
    );
    
    assign APBslave_PRDATA
endmodue
