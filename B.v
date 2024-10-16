`timescale 1ns/1ns

module B(
	input [4:0]DIRECCION,
	input [31:0]DATO,
	input WE,
	output reg Q
);

reg [31:0] MEM [0:32];

initial
begin
	$readmemh("datos2.txt", MEM);
	#10;
end

always @*
	begin
		Q = MEM[DIRECCION];
	if(WE)
		begin
			MEM[DIRECCION] = DATO;
		end
	else
		Q = MEM[DIRECCION];
	end
endmodule
