`include "../add_sub.v"

module tb_;

reg [7:0] in1,in2;
reg add_or_sub;
wire [7:0] out;

ADD_SUB uut(
    .in1(in1),
    .in2(in2),
    .add_or_sub(add_or_sub),
    .out(out)
);

// localparam CLK_PERIOD = 2;
// always #(CLK_PERIOD/2) clk=~clk;

// initial begin
//     $dumpfile("tb_.vcd");
//     $dumpvars(0, tb_);
// end

initial begin
    in1 = 8'b00010001;
    in2 = 8'b00000001;
    add_or_sub = 0;
    #2
    $display("%b",out);
    in1 = 8'b00110111;
    in2 = 8'b10000001;
    add_or_sub = 0;
    #2
    $display("%b",out);
    in1 = 8'b11110101;
    in2 = 8'b11100010;
    add_or_sub = 1;
    #2
    $display("%b",out);
    in1 = 8'b11111111;
    in2 = 8'b01011010;
    add_or_sub = 1;
    #2
    $display("%b",out);
end

endmodule