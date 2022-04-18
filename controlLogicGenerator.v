module controlLogicGenerator(
 input [6:0] opcode,
 input [2:0] funct3,
 input [6:0] funct7,
 output branch,
 output memRead,
 output [2:0] aluOp,
 output memWrite,
 output aluSrc,
 output regWrite);
 
always @(*) begin
	case (opcode)
		7'b0010011: //addi, slli
		7'b0110011: //sub, or, and, add, MUL

end
endmodule

ADD, SUB, AND, OR, mul

ADDI, SLLI SW, LW, ,