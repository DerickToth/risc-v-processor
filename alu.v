module alu(
	input [31:0] operand1,
	input [31:0] operand2,
	input [2:0]  aluOp,
	output reg        aluZero = 0,
	output reg [31:0] aluResult
);

	parameter ADD = 3'b000;
	parameter SUB = 3'b001;
	parameter AND = 3'b010;
	parameter OR  = 3'b011;
	parameter MUL = 3'b100;
	parameter SLL = 3'b101;
	parameter BNE = 3'b110;
	parameter BEQ = 3'b111;
	
	always @ (*) begin
		case (aluOp)
			ADD: aluResult = operand1 + operand2;
			// SUB: aluResult = operand1 - operand2;
			AND: aluResult = operand1 & operand2;
			OR:  aluResult = operand1 | operand2;
			MUL: aluResult = operand1 * operand2;
			SLL: aluResult = operand1 << operand2;
			// BNE: aluResult = operand1 - operand2;
			// BEQ: aluResult = operand1 - operand2;
			default: aluResult = operand1 - operand2;
		endcase
		aluZero = (aluOp == BNE) ^ (aluResult == 32'd0);
	end

endmodule
