`timescale 1ns/1ns

module A(
    input [4:0] DL1,      // Dirección de lectura 1
    input [4:0] DL2,      // Dirección de lectura 2
    input [4:0] DE,       // Dirección de escritura
    input [31:0] DATO,    // Dato a escribir
    input WE,             // Señal de escritura (1 para escribir)
    output reg [31:0] Q1, // Salida de la lectura 1
    output reg [31:0] Q2  // Salida de la lectura 2
);

reg [31:0] MEM [0:31];  // Memoria de 32 registros de 32 bits

/*initial
begin
	$readmemh("datos.txt", MEM);
	#10;
end*/
    
// Inicializar la memoria
initial begin
    integer i;
    for (i = 0; i < 32; i = i + 1)
        MEM[i] = 32'h0;  // Inicializar todos los registros en 0
end

// Escritura en la memoria (secuencial)
always @* begin
    if (WE) begin
        MEM[DE] = DATO;  // Solo escribir cuando WE es 1
    end
end

// Lectura de la memoria (combinacional)
always @* begin
    Q1 = MEM[DL1];  // Leer la dirección DL1
    Q2 = MEM[DL2];  // Leer la dirección DL2
end

endmodule
