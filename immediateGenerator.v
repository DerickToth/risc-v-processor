module immediateGenerator(
  input      [31:0] instruction,
  output reg [31:0] immediate
);

  parameter JAL_OPCODE       = 7'b1101111;
  parameter JALR_OPCODE      = 7'b1100111;
  parameter BNE_BEQ_OPCODE   = 7'b1100011;
  parameter ADDI_SLLI_OPCODE = 7'b0010011;
  parameter SW_OPCODE        = 7'b0100011;
  parameter LW_OPCODE        = 7'b0000011;

  wire [6:0] opcode = instruction[6:0];

  always @ (*) begin
    case (opcode)
      JAL_OPCODE:       immediate = {{20{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:21], 1'b0}; // untested
      JALR_OPCODE:      immediate = {{20{instruction[31]}}, instruction[31:20]};                                            // untested
		BNE_BEQ_OPCODE:   immediate = {{20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], 1'b0};   // untested
      ADDI_SLLI_OPCODE: immediate = {{20{instruction[31]}}, instruction[31:20]};
      SW_OPCODE:        immediate = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
      default:          immediate = {{20{instruction[31]}}, instruction[31:20]};
    endcase
  end

endmodule