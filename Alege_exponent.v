`timescale 1ns / 1ps

module Alege_exponent(data,out);
input [15:0]data;
output reg[7:0] out;

always @(data)
	begin
		if(data[15:8] > data[7:0])
			out = data[15:8];
		else
			out = data[7:0];
	end

endmodule
