`timescale 1ns / 1ps

module Normalizare(mantisaI , mantisaN , Valoare2);
input [25:0] mantisaI;
output reg [23:0] mantisaN;
output reg [8:0] Valoare2;
reg [7:0] count;
reg [22:0] mantisa;

always@(mantisaI)
	begin
		//initializam counterul cu 0
		count = 8'b00000000;
		//punem pe msb semnul 
		mantisaN[23] = mantisaI[24];
		//luam o matrice auxiliara pe care o vom normaliza
		mantisa = mantisaI[22:0];
		if(mantisaI[25] == 1'b1)
			begin
				mantisaN = 0;
				Valoare2 = 0;
			end
		if(mantisaI[23] == 1'b1)
			begin
				Valoare2[8] = 1'b0;
				count = 8'b00000001;
				mantisa[22:0] = mantisa[22:0] >> 1;
			end
		else
			begin
				while(mantisa[22] == 1'b0)
					begin
						count = count + 1'b1;
						mantisa[22:0] = mantisa[22:0] << 1;
					end
				Valoare2[8] = 1'b1;
				count = count + 1'b1;
				mantisa[22:0] = mantisa[22:0] << 1;
			end
			//punem in mantisaN mantisa normalizata
			mantisaN[22:0] = mantisa;
			//valoarea cu care trebuie shiftat exponentul
			Valoare2[7:0] = count;
	end
endmodule
