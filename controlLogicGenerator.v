module controlLogicGenerator(
  input [6:0] opcode,
  input [2:0] funct3,
  input [6:0] funct7,
  output       branch,
  output       memRead,
  output 		memtoReg,
  output [2:0] aluOp,
  output       memWrite,
  output       aluSrc,
  output       regWrite
);
	
  //Must be in sync with alu opcode parameters
	parameter ADD = 3'b000;
	parameter SUB = 3'b001;
	parameter AND = 3'b010;
	parameter OR  = 3'b011;
	parameter MUL = 3'b100;
	parameter SLL = 3'b101;
	parameter NOP = 3'b111;
  
	always @(*) begin
		case (opcode)
			7'b0010011: begin //addi, slli
				branch 	= 0;
				memRead 	= 0;
				memWrite = 0;
				memtoReg = 0;
				aluSrc 	= 1'b1;
				regWrite = 1'b1;
				case (funct3)
					0: opcode = ADD;  // addi
					3'b001: funct7 == 0 ? opcode = SLL : NOP; //slli
				endcase
			end
			7'b0110011: //sub, or, and, add, MUL
				branch 	= 0;
				memRead 	= 0;
				memWrite = 0;
				memtoReg = 0;
				aluSrc 	= 0;
				regWrite = 1'b1;
				case ({funct7,funct3})
					8'b0000000000: opcode = ADD	//add
					8'b0100000000: opcode = SUB	//sub
					8'b0000000110: opcode = OR		// or
					8'b0000000111: opcode = AND	// and
					8'b0000001000: opcode = MUL	// mul
				endcase
			7'b0000011: //lw
				branch 	= 0;
				memRead 	= 1'b1;
				memWrite = 0;
				memtoReg = 1'b1;
				aluSrc 	= 1'b1;
				regWrite = 1'b1;
				case (funct3):
					3'b010: opcode = ADD
				endcase
			7'b0100011: //sw
				branch 	= 0;
				memRead 	= 0;
				memWrite = 1'b1;
				memtoReg = 1'b1;
				aluSrc 	= 0;
				regWrite = 0;
				case (funct3):
					3'b010: opcode = ADD
				endcase
			default: //nop case
		endcase
	end

endmodule