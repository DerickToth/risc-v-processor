module instructionMemory(input [7:0] pc, output reg [31:0] instruction);
	reg [31:0] instructionFile [255:0];
	
		
	integer j = 0;
	initial begin
		for (j = 0; j < 256; j = j + 1) begin
			case(j)
				0:       instructionFile[j] = 32'h3e800293;
				1:       instructionFile[j] = 32'h00512023;
				2:       instructionFile[j] = 32'hffffffff;
				default: instructionFile[j] = 0;
			endcase
		end
	end
	
	always @(*) instruction = instructionFile[pc];
endmodule

/*
Files stored here lmao xd rawr uwu.

3e800293 // addi t0, x0, 1000
00512023 // sw t0, 0(sp)
ffffffff // halt
*/