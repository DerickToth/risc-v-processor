module registerFile(
	input [5:0] readRegister1,
	input [5:0] readRegister2,
	input [5:0] writeRegister,
	input [31:0] writeData,
	input regWrite,
	input writeClock,
	output reg [31:0] readData1,
	output reg [31:0] readData2);
  
  
	reg [31:0] regFile [31:0];
	
	always @(*) readData1 = regFile[readRegister1];
	always @(*) readData2 = regFile[readRegister2];
	
	always @(writeClock) begin
		if (regWrite == 1'b1) regFile[writeRegister] = writeData;
	end
	
endmodule