module tb_;
reg clk;
reg rst;
wire halted;
 
CPU cpu(
    .rst (rst),
    .clk (clk),
    .halted(halted)
);

localparam CLK_PERIOD = 2;
always #(CLK_PERIOD/2) clk=~clk;

initial begin
    rst = 0;
    clk = 1;
    #1
    rst = 1;
    @(posedge halted)
    $finish();
end

endmodule