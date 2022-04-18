module alu(
	input [31:0] operand1,
	input [31:0] operand2,
	input [2:0]  aluOp,
	output reg       aluZero,
	output reg [7:0] aluResult
);

  parameter ADD = 3'b000;
  parameter SUB = 3'b001;
  parameter AND = 3'b010;
  parameter OR  = 3'b011;
  parameter MUL = 3'b100;
  parameter SLL = 3'b101;

  always @ (*) begin
    case (aluOp)
      ADD: aluResult = operand1 + operand2;
      SUB: aluResult = operand1 - operand2;
      AND: aluResult = operand1 & operand2;
      OR:  aluResult = operand1 | operand2;
      MUL: aluResult = operand1 * operand2;
      SLL: aluResult = operand1 << operand2;
    endcase
    aluZero = aluResult == 0;
  end

endmodule
