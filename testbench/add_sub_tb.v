`include "../add_sub.v"

module tb_;

reg signed [7:0] in1,in2;
reg add_or_sub;
wire [7:0] out;

wire signed [3:0] r,co ;
wire signed [3:0] a,b,c,d ;

ADD_SUB uut(
    .in1(in1),
    .in2(in2),
    .add_or_sub(add_or_sub),
    .out(out)
);

assign r = out[7:4];
assign co = out[3:0];
assign a = in1[7:4];
assign b = in1[3:0];
assign c = in2[7:4];
assign d = in2[3:0];

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
    $display("in1 = %d + %di, in2 = %d + %di, output =  %d + %di",a,b,c,d,r,co);
    in1 = 8'b00110111;
    in2 = 8'b10000001;
    add_or_sub = 0;
    #2
    $display("in1 = %d + %di, in2 = %d + %di, output =  %d + %di",a,b,c,d,r,co);
    in1 = 8'b11110101;
    in2 = 8'b11100010;
    add_or_sub = 1;
    #2
    $display("in1 = %d + %di, in2 = %d + %di, output =  %d + %di",a,b,c,d,r,co);
    in1 = 8'b11111111;
    in2 = 8'b01011010;
    add_or_sub = 1;
    #2
    $display("in1 = %d + %di, in2 = %d + %di, output =  %d + %di",a,b,c,d,r,co);
end

endmodule