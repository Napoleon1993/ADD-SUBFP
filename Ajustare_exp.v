`timescale 1ns / 1ps


module Ajustare_exp;

	// Inputs
	reg [7:0] exponent;
	reg [8:0] valoare2;

	// Outputs
	wire [7:0] exponentAjustat;

	// Instantiate the Unit Under Test (UUT)
	Ajustare_exponent uut (
		.exponent(exponent), 
		.valoare2(valoare2), 
		.exponentAjustat(exponentAjustat)
	);

	initial begin
		// Initialize Inputs
		exponent = 8'b10000000;
		valoare2 = 9'b000000101;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

