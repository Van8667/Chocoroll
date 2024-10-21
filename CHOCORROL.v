`timescale 1ns/1ns

module Chocorrol(
    input [19:0] INSTRUCCION,
    output [31:0] RESULTADO
);

    wire[31:0] C1, C2, C3;
	
	A I1(
		.DL1(INSTRUCCION[17:13]),
		.DL2(INSTRUCCION[9:5]),
		.WE(INSTRUCCION[19]),
		.Q1(C1),
		.Q2(C2)
	);

	ALU O1(
		.OPERADOR1(C1),
		.OPERADOR2(C2),
		.SEL(INSTRUCCION[12:10]),
		.RESULTADO(C3)
	);
	
	B I2(
		.DIRECCION(INSTRUCCION[4:0]),
		.DATOS(C3),
		.WE(INSTRUCCION[18]),
		.DATOSQ(RESULTADO)
	);

endmodule
