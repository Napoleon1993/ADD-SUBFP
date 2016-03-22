`timescale 1ns / 1ps

module Registru(out , date , clear , load , clk);
parameter lungime = 16;
input clear;
input clk;
input load;
input [lungime-1:0]date;
output reg [lungime-1:0]out;

always @(posedge clk)
	begin
		if(~clear)
			out <= 0;
		else if(load)
			out <= date;
	end
endmodule
