module IF(
    //inputs
    input ld_inst_halt,
    input [19:0] instruction,
    input freeze,
    input clk,
    
    //outputs
    output reg [19:0] instruction_out
    
);


always @(posedge clk) begin
    if(!ld_inst_halt && !freeze) begin
      instruction_out = instruction;
    end
end




endmodule