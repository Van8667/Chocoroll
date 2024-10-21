`timescale 1ns/1ns

module tb_CHOCORROL;
    // Señal de entrada
    reg [19:0] INSTRUCCION;
    
    // Señal de salida
    wire [31:0] SAL;

    // Instanciación del módulo CHOCORROL
    CHOCORROL uut (
        .INSTRUCCION(INSTRUCCION),
        .SAL(SAL)
    );

    initial begin
        // Esperar un tiempo para asegurar la inicialización de memoria
        #100;

        // Test 1: Sumar datos en las posiciones 0 (6F) y 1 (7E7) y almacenar en la dirección 3
        INSTRUCCION = 20'b01_00100_010_00000_00011; // Ajustar según tu lógica
        #100; // Esperar a que se procese
        $display("Resultado de la suma: %h", SAL); // Imprimir el resultado

        // Test 2: Leer el resultado almacenado en la dirección 3
        INSTRUCCION = 20'b00000000000000000011; // Instrucción para leer de la dirección 3
        #100; // Esperar a que se procese
        $display("Lectura desde dirección 3: %h", SAL); // Imprimir el resultado

        // Finalizar simulación
        #100;
        $stop;
    end

    // Monitorear cambios en SAL
    initial begin
        $monitor("Tiempo: %0t | INSTRUCCION: %b | SAL: %h", $time, INSTRUCCION, SAL);
    end
endmodule
