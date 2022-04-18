module immediateGenerator(
  input      [31:0] instruction,
  output reg [31:0] immediate
);

  parameter ADDI_SLLI_OPCODE = 7'b0010011;
  parameter SW_OPCODE        = 7'b0000011;
  parameter LW_OPCODE        = 7'b0000011;

  wire [6:0] opcode = instruction[6:0];

  always @ (*) begin
    $display("%b", opcode);
    case (opcode)
      ADDI_SLLI_OPCODE: immediate = {{20{instruction[31]}}, instruction[31:20]};
      SW_OPCODE:        immediate = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};
      LW_OPCODE:        immediate = {{20{instruction[31]}}, instruction[31:20]};
    endcase
  end

endmodule