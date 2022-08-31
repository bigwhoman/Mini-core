`include "data_mem.v"
`include "controller.v"
`include "inst_mem.v"
`include "if.v"
`include "ld.v"
`include "ex.v"
`include "mul.v"
`include "add_sub.v"


module CPU (
 input clk,rst,
 output halted
);


reg freeze ;

reg inst_mem_read_write;
wire [19:0] input_inst;
wire [7:0] memory_data_in;
wire [5:0] mem_write_adr_imediate;

// -------------------------  instruction fetch and pipeline --------------------------------------

reg [4:0] read_address;
reg [4:0] write_address;

wire [19:0] inst_out_data;
wire [19:0] inst_if_out;

inst_mem instrucion_memory(
//inputs
.read_writenot(inst_mem_read_write),
.read_address(read_address),
.write_address(write_address),
.clk(clk),
.rst(rst),
.enable(1'b1),
.in_data(input_inst),

//outputs
.out_data(inst_out_data)
);

IF inst_fetch_pipeline(
//inputs
.ld_inst_halt(inst_mem_read_write), // is it only needed in here or its needed in the other pipelines as well??
.instruction(inst_out_data),
.freeze(freeze),
.clk(clk),

//outputs
.instruction_out(inst_if_out)

);

// --------------------------- load data and pipeline ------------------------------------------------

wire read_writenot_data_mem,data_mem_write_out_ex;
wire [7:0] mem_data_out_1,mem_data_out_2;
wire [5:0] write_adr_ex_out;
wire [7:0] alu_ex_out;
data_mem data_memory(
//inputs
    .clk(clk),
    .rst(rst),
    .enable(1'b1),
    .write(data_mem_write_out_ex),
    .in_data(alu_ex_out),
    .read_address1(inst_if_out[17:12]),
    .read_address2(inst_if_out[11:6]),
    .write_address(write_adr_ex_out),


//outputs
    .out_data1(mem_data_out_1),
    .out_data2(mem_data_out_2)

);

wire halted_ld_out,data_mem_write_ld;
wire [5:0] write_adr_mem_ld_out;
wire [1:0] alu_inst_ld_out;
wire [7:0] data_out_1_ld,data_out_2_ld;
wire data_mem_write_out_ld;
wire mul_or_add_ld_out,mul_or_add_ld;
wire halted_cu_out;


ld load_pipeline(
//inputs
.ld_inst_halt(inst_mem_read_write),
.halted(halted_cu_out),
.write_adr(inst_if_out[5:0]),
.alu_inst(inst_if_out[19:18]),
.mem_data_1(mem_data_out_1),
.mem_data_2(mem_data_out_2),
.data_mem_write(data_mem_write_ld),
.freeze(freeze),
.clk(clk),
.mul_or_add_ld(mul_or_add_ld),

//outputs
.halted_out(halted_ld_out),
.write_adr_out(write_adr_mem_ld_out),
.alu_inst_out(alu_inst_ld_out),
.data_out_1(data_out_1_ld),
.data_out_2(data_out_2_ld),
.data_mem_write_out(data_mem_write_out_ld),
.mul_or_add_ld_out(mul_or_add_ld_out)

);



// ----------------------------- controll unit ---------------------------------------------------------

wire is_done;

CU controll_unit(
//inputs
.op(inst_if_out[19:18]),
.is_done(is_done),
.clk(clk),
//outputs
.halted(halted_cu_out),
.data_mem_write(data_mem_write_ld),
.mul_or_add(mul_or_add_ld)
);

// ---------------------------- execute and pipeline ---------------------------------------------------

wire is_done_mul, is_done_add;
wire [7:0] add_sub_out;
wire [7:0] mul_out;

ADD_SUB adder_subtracter(
// inputs 
    .in1(data_out_1_ld),
    .in2(data_out_2_ld),
    .add_or_sub(alu_inst_ld_out),
    .clk(clk),
    .rst(rst),
//outputs
    .out(add_sub_out),
    .is_done(is_done_add)
);

MUL multiplier(
// inputs 
    .in1(data_out_1_ld),
    .in2(data_out_2_ld),
    .clk(clk),
    .rst(rst),

//outputs
    .out(mul_out),
    .is_done(is_done_mul)

);


wire [7:0] alu_out = alu_inst_ld_out == 2 ? mul_out : add_sub_out;

wire data_mem_rw;

EX execute_pipeline(
// inputs
.ld_inst_halt(inst_mem_read_write),
.halted(halted_ld_out),
.alu_output(alu_out),
.write_addr(write_adr_mem_ld_out),
.data_rw(data_mem_rw),
.freeze(freeze),
.clk(clk),
.data_mem_write_ex(data_mem_write_out_ld),

// outputs
.halted_out(halted),
.data_rw_out(read_writenot_data_mem),
.alu_output_out(alu_ex_out),
.write_addr_out(write_adr_ex_out),
.data_mem_write_out_ex(data_mem_write_out_ex)
);


// --------------------------- reset, halt and instruction fetch(pointer) for the CPU ----------------------------------------------

always @(negedge rst) begin
    read_address = 0;
    write_address = 0;
    inst_mem_read_write = 1;
end



endmodule
