`include "../mul.v"

module tb_;

reg [7:0] in1,in2;
wire [15:0] out;

MUL uut(
    .in1(in1),
    .in2(in2),
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
    #2
    $display(" %d + %di",out[15:8],out[7:0]);
    in1 = 8'b00110111;
    in2 = 8'b10000001;
    #2
    $display(" %d + %di",out[15:8],out[7:0]);
    in1 = 8'b11110101;
    in2 = 8'b11100010;
    #2
    $display(" %d + %di",out[15:8],out[7:0]);
    in1 = 8'b11111111;
    in2 = 8'b01011010;
    #2
    $display(" %d + %di",out[15:8],out[7:0]);
end

endmodule