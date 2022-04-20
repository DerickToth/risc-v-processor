module risc_processor(input clk50);
	
	wire clk_1;
	wire clk_2;
	
	wire [31:0] aluIn1, aluIn2, immVal, regOut1 ,regOut2, aluOut, memOut, regWriteBack, currInstruction;
	wire aluZero, branch, memRead, memToReg, memWrite, aluSrc, regWrite;
	
	wire [6:0] opcode;
   wire [2:0] funct3;
   wire [6:0] funct7;
	wire [5:0] readReg1, readReg2, writeReg;
	
	wire [2:0] aluOp;
	
	reg [3:0] currPC = 0;

	
	// Basic module instantiation
	alu 			 			 ALU(aluIn1, aluIn2, aluOp,
	                          aluZero, aluOut);
	data_memory  			 DATA(aluOut[7:0], ~clk_2, regOut2, memRead, memWrite,
	                           memOut);
	pll 			 			 PLL(clk50, 0, clk_1, clk_2);
	controlLogicGenerator LOGGEN(opcode, funct3, funct7,
										  branch, memRead, memToReg, opCode, memWrite, aluSrc, regWrite);
	immediateGenerator    IMMGEN(currInstruction,
	                             immVal);
	registerFile			 REGFILE(readReg1, readReg2, writeReg, regWriteBack, regWrite, ~clk_1,
	                              regOut1, regOut2);
	instructionMemory		 INSTRMEM(currPC,
	                               currInstruction);

	// Continuous Assigns
	assign regOut1 = aluIn1;
	assign opcode  = currInstruction[6:0];
	assign funct3  = currInstruction[14:12];
	assign funct7  = currInstruction[31:25];
	assign readReg1 = currInstruction[19:15];
	assign readReg2 = currInstruction[24:20];
	assign writeReg = currInstruction[11:7];
	assign aluIn2 = aluSrc ? immVal : regOut2;
	assign regWriteBack = memToReg ? memOut : aluOut;

	always @(negedge clk_1) begin
		if opcode != 7'b1111111 begin
			currPC <= currPC + 1;
		end
	end
	
endmodule