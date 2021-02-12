// reseting.v
`timescale 10ns/1ns

module reseting (
    output reg resetn
);

initial begin
    resetn = 1;
    #500_00_000; resetn = 0;
end

endmodule