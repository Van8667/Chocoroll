`timescale 1ns/1ns

module B(
	input [4:0]DIRECCION,
	input [31:0]DATOS,
	input WE,
	output reg [31:0]DATOSQ
);

	reg [31:0] MEM [0:32];

	initial begin
		$readmemh("datos2.txt", MEM);
	end

	always @* 
		begin
			if (WE) 
			begin
				MEM[DIRECCION] = DATOS;
			end
		else
		begin
			DATOSQ = MEM[DIRECCION];
		end
	end
		
endmodule
