// ADD2.v
module ADD2(
    clk,
    rstn,
    x, a, b
);
input clk, rstn;
input   [7:0] a, b;
output reg [7:0] x;
    
always @(posedge clk or negedge rstn) begin
    if(~rstn)
        x <= 8'h00;
    else
        x <= a + b;
end
endmodule