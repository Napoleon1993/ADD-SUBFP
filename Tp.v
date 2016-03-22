`timescale 1ns / 1ps
module Tp(clk , clear , load , mantise , exponent , op ,mantisaF , ExpF , semnF );
input clk , clear , load ;
input [47:0] mantise ;
input [15:0] exponent;
input op;

output reg [22:0]mantisaF;
output reg [7:0]ExpF;
output reg semnF;

wire [15:0] R1;
wire [47:0] R2;
wire [8:0] Valoare1,Valoare2;
wire [7:0] ExponentMaxim;
wire [49:0] AlinMant;
wire [15:0] Exp;
wire [56:0]Conc;
wire [56:0] R3;
wire [15:0] R4;
wire [49:0] R5;
wire [7:0] R6 , R7 , ExponentAjustat;
wire [25:0] R8;
wire [25:0]AdunScad;
wire [23:0]MantisaN;
wire [23:0]R9;
wire [7:0]R10;


//Segment 1
Registru #(16) Reg1(R1,exponent,clear,load,clk);
Registru #(48) Reg2(R2,mantise,clear,load,clk);
Compara_exponenti CE(R1,Valoare1,Exp);
Concatenare CT(R2,Valoare1,Conc);

//Segment2
Registru #(57) Reg3(R3,Conc,clear,load,clk);
Registru #(16) Reg4(R4,Exp,clear,load,clk);
Alege_exponent AE(R4,ExponentMaxim);
Aliniere_mantise AM(R3,AlinMant);

//Segment3
Registru #(50) Reg5(R5,AlinMant,clear,load,clk);
Registru #(8) Reg6(R6,ExponentMaxim,clear,load,clk);
Adunare_Scadere_Mantise AS(R5,op,AdunScad);

//Segment4
Registru #(26) Reg8(R8,AdunScad,clear,load,clk);
Registru #(8) Reg7(R7,R6,clear,load,clk);
Normalizare NM(R8,MantisaN,Valoare2);
Ajustare_exponent AJE(R7,Valoare2,ExponentAjustat);

//Segment5
Registru #(24) Reg9(R9,MantisaN,clear,load,clk);
Registru #(8) Reg10(R10,ExponentAjustat,clear,load,clk);

always @(R9 or R10)
	begin
		semnF = R9[23];
		mantisaF = R9[22:0];
		ExpF = R10;
	end
endmodule
