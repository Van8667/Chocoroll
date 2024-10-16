`timescale 1ns/1ns

module Chocorrol(
    input [19:0] INSTRUCCION,
    output [31:0] RESULTADO
);

    wire[4:0] OP1, OP2, MB;
    wire[2:0] ALUC;
    wire[1:0] MC;
    wire WE_A, WE_B;
    wire [31:0] C1_A, C2_A, C3_ALU, Q_B;

    assign MC = INSTRUCCION[19:18];
    assign OP1 = INSTRUCCION[17:13];
    assign ALUC = INSTRUCCION[12:10];
    assign OP2 = INSTRUCCION[9:5];
    assign MB = INSTRUCCION[4:0];

    assign WE_A = (MC == 2'b01) ? 1'b1 : 1'b0;
    assign WE_B = (MC == 2'b10) ? 1'b1 : 1'b0;

    A mod_A(
        .DL1(OP1),
        .DL2(OP2),
        .DE(OP1),
        .DATO(C3_ALU),
        .WE(WE_A),
        .Q1(C1_A),
        .Q2(C2_A)
    );

    ALU mod_ALU(
        .OPERADOR1(C1_A),
        .OPERADOR2(C2_A),
        .SEL(ALUC),
        .RESULTADO(C3_ALU)
    );

    B mod_B(
        .DIRECCION(MB),
        .DATO(C3_ALU),
        .WE(WE_B),
        .Q(Q_B)
    );

    assign RESULTADO = Q_B;

endmodule
