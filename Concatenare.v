`timescale 1ns / 1ps

module Concatenare(mantise,exp,out
    );
input [47:0]mantise;
input [8:0]exp;
output reg[56:0]out;

always @(mantise or exp)
	out = {exp,mantise};
endmodule
