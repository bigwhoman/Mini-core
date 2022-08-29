module CPU (
 input clk,rst,inst_mem_read_write,
 input [19:0] input_inst,
 input [7:0] memory_data_in,
 input [5:0] mem_write_adr_imediate,
 output reg halted
);


// freeze the pipelines
wire freeze;


// -------------------------  instruction fetch and pipeline --------------------------------------

reg [4:0] read_address;
reg [4:0] write_address;

wire inst_memory_enable;
wire [19:0] inst_out_data;
wire [19:0] inst_if_out;

inst_mem instrucion_memory(
//inputs
.read_writenot(inst_mem_read_write),
.read_address(read_address),
.write_address(write_address),
.clk(clk),
.rst(rst),
.enable(inst_memory_enable),
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

// [7 : 0] out_data1
// [7 : 0] out_data2
wire read_writenot_data_mem;
wire data_mem_enable;
wire [7:0] mem_data_out_1,mem_data_out_2;

data_mem data_memory(
//inputs
    .clk(clk),
    .rst(rst),
    .enable(data_mem_enable),
    .read_writenot(read_writenot_data_mem),
    .in_data(alu_ex_out),
    .read_address1(inst_if_out[17:12]),
    .read_address2(inst_if_out[11:6]),
    .write_address(write_adr_ex_out),


//outputs
    .out_data1(mem_data_out_1),
    .out_data2(mem_data_out_2)

);

wire halted_ld_out;
wire [5:0] write_adr_mem_ld_out;
wire [1:0] alu_inst_ld_out;
wire [7:0] data_out_1_ld,data_out_2_ld;

LD load_pipeline(
//inputs
.ld_inst_halt(inst_mem_read_write),
.halted(halted_cu_out),
.write_adr(inst_if_out[5:0]),
.alu_inst(inst_if_out[19:18]),
.mem_data_1(mem_data_out_1),
.mem_data_2(mem_data_out_2),
.freeze(freeze),
.clk(clk),

//outputs
.halted_out(halted_ld_out),
.write_adr_out(write_adr_mem_ld_out),
.alu_inst_out(alu_inst_ld_out),
.data_out_1(data_out_1_ld),
.data_out_2(data_out_2_ld)
);

// ---------------------------- execute and pipeline ---------------------------------------------------

wire [7:0] add_sub_out;
wire [7:0] mul_out;
// [7:0] out

ADD_SUB adder_subtracter(
// inputs 
    .in1(data_out_1_ld),
    .in2(data_out_2_ld),
    .add_or_sub(alu_inst_ld_out),

//outputs
    .out(add_sub_out)
);

MUL multiplier(
// inputs 
    .in1(data_out_1_ld),
    .in2(data_out_2_ld),

//outputs
    .out(mul_out)

);

// multiplexer  --- > if alu instruction is 2 its mul if 1 or 0 its add/sub and if 3 its halted 

wire [7:0] alu_out = alu_inst_ld_out == 2 ? mul_out : add_sub_out;

wire [7:0] alu_ex_out;
wire [5:0] write_adr_ex_out;

EX execute_pipeline(
// inputs
.ld_inst_halt(inst_mem_read_write),
.halted(halted_ld_out),
.alu_output(alu_out),
.write_addr(write_adr_mem_ld_out),
.data_rw(data_mem_rw),
.freeze(freeze),
.clk(clk),

// outputs
.halted_out(halted),
.data_rw_out(read_writenot_data_mem),
.alu_output_out(alu_ex_out),
.write_addr_out(write_adr_ex_out)
);


// ----------------------------- controll unit ---------------------------------------------------------

wire halted_cu_out;
wire data_mem_rw;


CU controll_unit(
//inputs
.op(inst_if_out[19:18]),

//outputs
.halted(halted_cu_out),
.data_mem_rw(data_mem_rw)
);

// --------------------------- reset, halt and instruction fetch(pointer) for the CPU ----------------------------------------------

always @(posedge clk,negedge rst) begin
  if(rst == 0) begin
    halted = 0;
    read_address = 0;
    write_address = 0;
  end else begin
    if(inst_mem_read_write) begin
      read_address = read_address + 1;
    end else begin
      write_address = write_address + 1;
    end
  end
end



endmodule











// TODO : review the system and pipelining --- controll unit and pipeline module design -- mem data fill inputs