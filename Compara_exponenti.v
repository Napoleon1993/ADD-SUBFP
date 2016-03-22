`timescale 1ns / 1ps

module Compara_exponenti(date,out , exp);
input [15:0] date;
output reg[8:0] out;
output reg[15:0] exp;
always @(date)
	begin
		if(date[15:8] > date[7:0])
			out = {1'b1,date[15:8]-date[7:0]};
		else
			out = {1'b0,date[7:0]-date[15:8]};
		exp = date;
	end
endmodule
