module LD(
//inputs
input ld_inst_halt,
input halted,
input [5:0] write_adr,
input [1:0] alu_inst,
input [5:0] mem_data_1,
input [5:0] mem_data_2,
input freeze,
input clk,
input data_mem_write,

//outputs
output reg halted_out,
output reg [5:0] write_adr_out,
output reg [1:0] alu_inst_out,
output reg [5:0] data_out_1,
output reg [5:0] data_out_2,
output reg data_mem_write_out
);

always @(posedge clk) begin
    if(!ld_inst_halt && !freeze) begin
      write_adr_out = write_adr;
      alu_inst_out = alu_inst;
      data_out_1 = mem_data_1;
      data_out_2 = mem_data_2;
      halted_out = halted;
      data_mem_write_out = data_mem_write;
    end
end


endmodule