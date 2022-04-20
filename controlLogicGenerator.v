module controlLogicGenerator(
  input [6:0] opcode,
  input [2:0] funct3,
  input [6:0] funct7,
  output reg      branch,
  output reg      memRead,
  output reg		memtoReg,
  output reg [2:0] aluOp,
  output reg      memWrite,
  output reg      aluSrc,
  output reg      regWrite
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
					0: aluOp = ADD;  // addi
					3'b001: aluOp = (funct7 == 0) ? SLL : NOP; //slli
				endcase
			end
			7'b0110011: begin //sub, or, and, add, MUL
				branch 	= 0;
				memRead 	= 0;
				memWrite = 0;
				memtoReg = 0;
				aluSrc 	= 0;
				regWrite = 1'b1;
				case ({funct7,funct3})
					10'b0000000000: aluOp = ADD;	//add
					10'b0100000000: aluOp = SUB;	//sub
					10'b0000000110: aluOp = OR;	// or
					10'b0000000111: aluOp = AND;	// and
					10'b0000001000: aluOp = MUL;	// mul
				endcase
			end
			7'b0000011: begin //lw
				branch 	= 0;
				memRead 	= 1'b1;
				memWrite = 0;
				memtoReg = 1'b1;
				aluSrc 	= 1'b1;
				regWrite = 1'b1;
				case (funct3)
					3'b010: aluOp = ADD;
				endcase
			end
			7'b0100011: begin //sw
				branch 	= 0;
				memRead 	= 0;
				memWrite = 1'b1;
				memtoReg = 1'b1;
				aluSrc 	= 0;
				regWrite = 0;
				case (funct3)
					3'b010: aluOp = ADD;
				endcase
			end
		endcase
	end

endmodule