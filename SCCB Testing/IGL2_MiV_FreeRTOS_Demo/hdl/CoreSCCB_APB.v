// CoreSCCB_APB.v

module CoreSCCB_APB (
	PCLK,
    PRESETN,
    PSEL,
    PENABLE,
    PWRITE,
	PSLVERR,
    PREADY,
    PADDR,
    PWDATA,
    PRDATA,
    SIO_D,
    SIO_C
);

input           PCLK, PRESETN, PSEL, PENABLE, PWRITE;
input   [23:0]   PADDR, PWDATA;
output  [23:0]  PRDATA;
output          PREADY, PSLVERR;
output          SIO_C;
inout           SIO_D;

// APB registers
parameter   START       = 8'h00;
parameter   IPADDR      = 8'h01;
parameter   SUBADDR     = 8'h02;
parameter   WDATA       = 8'h03;
parameter   RDATA       = 8'h04;
parameter   DONE        = 8'h05;
//parameter   READWRITE   = 8'h06;

reg     [7:0]   start, rw;
reg     [7:0]   data_in, ip_addr, sub_addr;
wire            data_out;

CoreSCCB coresccb_c0(
    .XCLK(PCLK),            // Master clock to camera
    .RST_N(PRESETN),        // Reset 
    .PWDN(1'b1),            // Power down (camera)
    .start(start),
    .RW(rw),                // Read/Write request
    .data_in(data_in),      // Data write to register
    .ip_addr(ip_addr),      // Device ID + RW signal
    .sub_addr(sub_addr),    // Register address
    .data_out(data_out),    // Data read from register
    // VSYNC, HREF, PCLK,   // used when retrieving pixels
    .done(done),            // basically, this is ACK
    .SIO_D(SIO_D),          // SCCB data
    .SIO_C(SIO_C)           // SCCB clock
);

assign PREADY = 1'b1;
assign PSLVERR = 1'b0;

// APB Read Registers
assign PRDATA = (PADDR[7:0] == START)  ? start :
                (PADDR[7:0] == IPADDR) ? ip_addr :
                (PADDR[7:0] == SUBADDR)? sub_addr :
                (PADDR[7:0] == WDATA)  ? data_in :
                (PADDR[7:0] == RDATA)  ? data_out :
                (PADDR[7:0] == DONE)   ? done : 8'hff; // I'm using 0xff for testing

// APB Write Registers
always @(posedge PCLK or negedge PRESETN) begin
    if(!PRESETN) begin
    
    end else if(PWRITE && PENABLE && PSEL) begin
        ip_addr  <= pwdata[23:16];
        rw       <= pwdata[16];
        sub_addr <= pwdata[15:8];
        wdata    <= pwdata[7:0];
    end
end


