`timescale 1ns/1ns

module A(
	input [31:0]DATOES,
	input [4:0]DL1,
	input [4:0]DL2,
	input [4:0]DIRESC,
	input WE,
	output reg [31:0]Q1,
	output reg [31:0]Q2
);

	reg [31:0] MEM [0:31];

	initial
	begin
		$readmemh("datos.txt", MEM);
	end
	always @*
	begin
		Q1 = MEM[DL1];
		Q2 = MEM[DL2];
		if(WE)
		begin
			MEM[DIRESC] = DATOES;
		end
	end
endmodule
