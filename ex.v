module EX(
    input ld_inst_halt,
    input halted,
    input [7:0] alu_output,
    input [5:0] write_addr,
    input freeze,
    input clk,
    input data_rw,
    input data_mem_write_ex,

    output reg halted_out,
    output reg data_rw_out,
    output reg [7:0] alu_output_out,
    output reg [5:0] write_addr_out,
    output reg data_mem_write_out_ex
);


always @(posedge clk) begin
  // if(!freeze && ld_inst_halt) begin
    halted_out = halted;
    data_rw_out = data_rw;
    alu_output_out = alu_output;
    write_addr_out = write_addr;
    data_mem_write_out_ex = data_mem_write_ex;
  // end
end






endmodule