// ADD2_APB.v
module ADD2_APB(
	PRESETN, PCLK, PSEL,  PENABLE, PWRITE,
	PSLVERR, PREADY, PADDR, PWDATA, PRDATA,
);

input PCLK, PRESETN, PSEL, PENABLE, PWRITE;
input [7:0] PADDR, PWDATA;
output [7:0] PRDATA;
output PREADY, PSLVERR;

reg [7:0] a, b;
wire [7:0] x;

ADD2 a0 (
    .clk(PCLK), .rstn(PRESETN),
    .x(x), .a(a), .b(b)
);

assign PREADY = 1'b1;
assign PSLVERR = 1'b0;
assign PRDATA = (PADDR[7:0] == 8'h00)? a :
                (PADDR[7:0] == 8'h04)? b :
                (PADDR[7:0] == 8'h08)? x : 8'hFF;

always @(posedge PCLK or negedge PRESETN) begin
    if(!PRESETN) begin
        a <= 8'h00;
        b <= 8'h00;
    end else if(PWRITE && PENABLE && PSEL) begin
        if(PADDR[7:0] == 8'h00)
            a <= PWDATA;
        else if(PADDR[7:0] == 8'h04)
            b <= PWDATA;
        else begin
            a <= 8'h01;
            b <= 8'h10;
        end
    end
end
endmodule