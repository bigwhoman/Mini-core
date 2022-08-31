module IF(
    input ld_inst_halt,
    input [19:0] instruction,
    input freeze,
    input clk,
    
    output reg [19:0] instruction_out
);


always @(posedge clk) begin
      instruction_out = instruction;
end




endmodule