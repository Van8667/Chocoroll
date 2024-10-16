`timescale 1ns/1ns

module tb_Chocorrol;

    reg [19:0]INSTRUCCION;
    wire [31:0] RESULTADO;

    Chocorrol uut(
        .INSTRUCCION(INSTRUCCION),
        .RESULTADO(RESULTADO)
    );

    initial begin
        $display("Comienzo de la simulacion...");

        //Caso 1: Operacion de escritura en el modulo A (MC = 01, ALU suma)
        INSTRUCCION = 20'b01_00001_010_00010_00001;
        #10;
        $display("Resultado: %d, Instruccion: %b", RESULTADO, INSTRUCCION);

        // Caso 2: Operación en ALU (AND) y escritura en módulo B (MC = 10)
        INSTRUCCION = 20'b10_00100_000_00011_00010; // MC=10, OP1=4, ALUC=AND, OP2=3, MB=2
        #10;
        $display("Resultado: %d, Instruccion: %b", RESULTADO, INSTRUCCION);

        // Caso 3: Operación de resta en la ALU y escritura en B (MC = 10)
        INSTRUCCION = 20'b10_00110_110_00101_00011; // MC=10, OP1=6, ALUC=Resta, OP2=5, MB=3
        #10;
        $display("Resultado: %d, Instruccion: %b", RESULTADO, INSTRUCCION);

        // Caso 4: Comparación en la ALU (menor que) y escritura en B (MC = 10)
        INSTRUCCION = 20'b10_00011_111_00100_00100; // MC=10, OP1=3, ALUC=Menor que, OP2=4, MB=4
        #10;
        $display("Resultado: %d, Instruccion: %b", RESULTADO, INSTRUCCION);

        // Caso 5: Operación NOR en la ALU y escritura en B (MC = 10)
        INSTRUCCION = 20'b10_00010_100_00001_00001; // MC=10, OP1=2, ALUC=NOR, OP2=1, MB=1
        #10;
        $display("Resultado: %d, Instruccion: %b", RESULTADO, INSTRUCCION);

        $display("Simulación terminada.");
        $finish; // Finaliza la simulación
    end

endmodule
