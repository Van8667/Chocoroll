`timescale 1ps/1ps

module ALU(
	input [31:0] OPERADOR1,
	input [31:0] OPERADOR2,
	input [2:0] SEL,
	output reg [31:0] RESULTADO
);

always @*
	begin
	case (SEL)
		3'b000: begin
			RESULTADO = OPERADOR1 & OPERADOR2;
		end
		3'b001: begin
			RESULTADO = OPERADOR1 | OPERADOR2;
		end
		3'b010: begin
			RESULTADO = OPERADOR1 + OPERADOR2;
		end
		3'b110: begin
			RESULTADO = OPERADOR1 - OPERADOR2;
		end
		3'b111: begin
			RESULTADO = (OPERADOR1 < OPERADOR2) ? 32'b1 : 31'b0;
		end
		3'b100: begin
			RESULTADO = ~(OPERADOR1 | OPERADOR2);
		end
		default: begin
			RESULTADO = 32'b0;
		end
	endcase
	end
	
endmodule