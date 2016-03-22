`timescale 1ns / 1ps

module Aliniere_mantise(exp_mantise , aliniere_mantise);
input [56:0]exp_mantise;
output reg[49:0]aliniere_mantise;
reg [23:0] mantisa1;
reg [23:0] mantisa2;
reg sel1 , sel2;

always@(exp_mantise)
	begin
		sel1 = 1'b0;
		sel2 = 1'b0;
		mantisa1 = {1,exp_mantise[46:24]};
		mantisa2 = {1,exp_mantise[22:0]};
		if(exp_mantise[56] == 1'b0 && exp_mantise[55:48] > 0)
			begin
				mantisa1 = mantisa1 >> exp_mantise[55:48];
				sel1 = 1'b1;
			end
		if(exp_mantise[56] == 1'b1 && exp_mantise[55:48] > 0)
			begin
				mantisa2 = mantisa2 >> exp_mantise[55:48];
				sel2 = 1'b1;
			end
		aliniere_mantise = {exp_mantise[47],mantisa1[22:0],sel1,exp_mantise[23],mantisa2[22:0],sel2};
	end
	
endmodule
