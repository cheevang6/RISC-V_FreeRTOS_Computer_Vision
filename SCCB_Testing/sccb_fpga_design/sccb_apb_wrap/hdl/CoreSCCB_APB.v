// CoreSCCB_APB.v

module CoreSCCB_APB (
	input PCLK,
    input PRESETN,
    input PSEL,
    input PENABLE,
    input PWRITE,
	output PSLVERR,
    output PREADY,
    input [7:0] PADDR,
    input [7:0] PWDATA,
    output [7:0] PRDATA,
    output sioc,
    inout siod,
    output cam_pwdn,
    output cam_rstn,
    output xclk
);

// APB registers
parameter   IDADDR_RW_REG   = 8'h00;
// If I wanted separate registers for ID addres and RW bit...
//parameter   IDADDR_REG   = 8'h00;
//parameter   READWRITE_REG   = 8'h04;
parameter   SUBADDR_REG     = 8'h04;
parameter   WDATA_REG       = 8'h08;
parameter   RDATA_REG       = 8'h0C;
parameter   START_REG       = 8'h10;
parameter	DONE_REG		= 8'h14;
parameter   IDLE            = 8'h18;
/* Not sure about these registers yet
parameter   ACK_ID          = 8'h1C;
parameter   ACK_SUB         = 8'h20;
parameter   ACK_WR          = 8'h24;
// or just make one ACK register for all three
parameter   ACK =           = 8'h28;
*/

// variables for CoreSCCB
reg			start;
reg  [7:0]  data_in, id_addr, sub_addr;
wire		done;
wire [7:0]	data_out;
wire        sccb_clk;
reg         rw;

clock_divider #(.APB_CLK_FREQ(50_000_000),.XCLK_FREQ(10_000_000),.SCCB_CLK_FREQ(100_000)) sccb_clk_0(
	.clk(PCLK),
	.resetn(PRESETN),
	.sccb_clk(sccb_clk),
	.mid_pulse(mid_pulse),
    .xclk(xclk)
);

CoreSCCB #(.XCLK_FREQ(10_000_000)) coresccb_0 (
	.xclk(PCLK),
	.resetn(PRESETN),
	.cam_pwdn(cam_pwdn), // grounded
    .cam_rstn(cam_rstn),
	.start(start),
	.rw(rw),
	.id_addr(id_addr),
	.sub_addr(sub_addr),
	.data_in(data_in),
	.data_out(data_out),
	.sioc(sioc),
    .siod(siod),
	.done(done),
	.mid_pulse(mid_pulse),
    .sccb_clk(sccb_clk)
);

assign PREADY = 1'b1;
assign PSLVERR = 1'b0;

// APB Read Registers
assign PRDATA = (PADDR[7:0] == IDADDR_RW_REG) ? id_addr :
                (PADDR[7:0] == SUBADDR_REG)? sub_addr :
                (PADDR[7:0] == WDATA_REG)  ? data_in :
                (PADDR[7:0] == RDATA_REG)  ? data_out :
                (PADDR[7:0] == DONE_REG)   ? done : 8'hff; // I'm using 0xff for testing
// in drivers, it will have to poll the DONE_REG to check if transaction is completed

// APB Write Registers
// To stop data transfer, PADDR = 24'bff (since OV7670 does not have this register)
always @(posedge PCLK or negedge PRESETN) begin
    if(!PRESETN) begin
		start <= 1'b0;
		id_addr <= 8'h00;
		sub_addr <= 8'h00;
		data_in <= 8'h00;
    end else if(PWRITE && PENABLE && PSEL) begin
		if(mid_pulse && (PADDR[7:0] != 24'hff)) begin
			case(PADDR[7:0])
                IDADDR_RW_REG : begin
                        id_addr <= PWDATA[7:0];
                        rw  <= PWDATA[0];
                    end
                SUBADDR_REG : begin
                        sub_addr <= PWDATA[7:0];
                    end
                WDATA_REG : begin
                        data_in <= PWDATA[7:0];
                    end
                START_REG : begin
                        start <= PWDATA[0];
                    end
                IDLE : begin
                        start <= 0;
                    end
                default : begin
                    end
            endcase
		end else begin
            id_addr <= 8'hff;
            sub_addr <= 8'hff;
            data_in <= 8'hff;
            start <= 0;
        end
    end
end

endmodule

