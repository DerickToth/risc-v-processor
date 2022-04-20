module instructionMemory(input [7:0] pc, output reg [31:0] instruction);
	reg [31:0] instructionFile [255:0];
	always @(*) instruction = instructionFile[pc];
endmodule