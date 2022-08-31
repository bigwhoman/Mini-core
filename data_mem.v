module data_mem(
    input clk,
    input rst,
    input enable,
    input write,
    input [7 : 0] in_data,
    input [5 : 0] read_address1,
    input [5 : 0] read_address2,
    input [5 : 0] write_address,

    output reg [7 : 0] out_data1,
    output reg [7 : 0] out_data2

);

reg [7 : 0] storage [63 : 0];
integer i;

always @(posedge clk,negedge rst) begin
	  if( rst == 0 ) begin
	  for(i = 0 ; i < 64 ; i = i + 1) begin
        storage[i] = 0;
    end

    storage [0] = 8'b0011_0001; // 3 + 1i
    storage [1] = 8'b0010_0011; // 2 + 3i
    //addition in 2
    //00_000000_000001_000010

    storage [3] = 8'b1001_0011; // -7 + 3i
    storage [4] = 8'b0110_0001; // 6 + 1i
    //addition
    //00_000011_000100_000101

    storage [6] = 8'b1110_1011; // -2 + -5i
    storage [7] = 8'b1101_1111; // -3 + -1i
    //addition
    //00_0000110_000111_001000

    storage [9] = 8'b0011_0001; // 3 + 1i
    storage [10] = 8'b0010_011; // 2 + 3i
    //subtraction
    //01_0001001_001010_001011

    storage [12] = 8'b1011_1110; // -5 + -2i
    storage [13] = 8'b0010_0011; // 2 + 3i
    //subtraction
    //01_0001100_001101_001110

    
    storage [15] = 8'b0010_0010; // 2 + 2i
    storage [16] = 8'b0010_0001; // 2 + 1i
    //multiplication
    //10_0001111_010000_010001

    
    
    storage [18] = 8'b1101_0010; // -3 + 2i
    storage [19] = 8'b1110_0001; // -2 + 1i
    //multiplication
    //10_010010_010011_010100
	  end else begin
        
        // $display("r1 : %b, r2 : %b",read_address1,read_address2);
        out_data1 = storage[read_address1];
        out_data2 = storage[read_address2];
        
        if(write) begin
            storage[write_address] = in_data;
        end
    end
end

endmodule