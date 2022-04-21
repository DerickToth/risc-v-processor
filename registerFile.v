module registerFile(
	input [5:0] readRegister1,
	input [5:0] readRegister2,
	input [5:0] writeRegister,
	input [31:0] writeData,
	input regWrite,
	input writeClock,
	output reg [31:0] readData1,
	output reg [31:0] readData2);
  
	reg [1023:0] regFile;

  initial regFile[95:64] = 32'h000000f0; // Highest stack pointer
	
	always @(*) readData1 = regFile[readRegister1*32 +: 32];
	always @(*) readData2 = regFile[readRegister2*32 +: 32];
	
	always @(writeClock) begin
		if (regWrite == 1'b1) regFile[writeRegister*32 +: 32] = writeData;
	end
	
endmodule