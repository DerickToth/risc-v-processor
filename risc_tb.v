module risc_tb();

	reg clk_1;
	reg clk_2;
	
	wire [31:0] aluIn1, aluIn2, immVal, regOut1 ,regOut2, aluOut, memOut, regWriteBack, currInstruction;
	wire aluZero, branch, memRead, memToReg, memWrite, aluSrc, regWrite;
	
	wire [6:0] opcode;
   wire [2:0] funct3;
   wire [6:0] funct7;
	wire [5:0] readReg1, readReg2, writeReg;
	
	wire [2:0] aluOp;
	
	reg [3:0] currPC = 0;
	
	wire [7:0] testAddr;
	wire [31:0] mdmdmdm;
	
	assign testAddr = 8'hf0;
	assign mdmdmdm = 32'd1000;

	
	// Basic module instantiation
	alu 			 			 ALU(aluIn1, aluIn2, aluOp, aluZero, aluOut);
	//data_memory  			 DATA(aluOut[7:0], ~clk_2, regOut2, memRead, memWrite, memOut);
	data_memory  			 DATA(aluOut[7:0], ~clk_2, regOut2, memRead, memWrite, memOut);
	controlLogicGenerator LOGGEN(opcode, funct3, funct7, branch, memRead, memToReg, aluOp, memWrite, aluSrc, regWrite);
	immediateGenerator    IMMGEN(currInstruction, immVal);
	registerFile			 REGFILE(readReg1, readReg2, writeReg, regWriteBack, regWrite, ~clk_1, regOut1, regOut2);
	instructionMemory		 INSTRMEM(currPC, currInstruction);

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
		if (opcode != 7'b1111111) begin
			currPC <= currPC + 1;
		end
	end

	initial begin
		clk_1 = 0;
		clk_2 = 0;
	end
	
	always @(*) begin
		#1;
		clk_2 = ~clk_2;
		#1;
		clk_1 = ~clk_1;
	end
	
endmodule