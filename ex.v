module EX(
    // inputs
    input ld_inst_halt,
    input halted,
    input [7:0] alu_output,
    input [5:0] write_addr,
    input freeze,
    input clk,
    input data_rw,

    // outputs
    output reg halted_out,
    output reg data_rw_out,
    output reg [7:0] alu_output_out,
    output reg [5:0] write_addr_out
);


always @(posedge clk) begin
  if(!freeze && !ld_inst_halt) begin
    halted_out = halted;
    data_rw_out = data_rw;
    alu_output_out = alu_output;
    write_addr_out = write_addr;
  end
end






endmodule