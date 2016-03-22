`timescale 1ns / 1ps

module Adunare_Scadere_Mantise(mantise , op , out);
	input [49:0]mantise;
	input op;
	output reg [25:0] out;
	reg [23:0] mantisaA;//in mantisa A 
	reg [23:0] mantisaB;//in mantisa B
	reg semn;//reprezinta xor dintre semn MantisaA si semn MantisaB
	reg cout;//reprezinta carryul
	reg [23:0]SumDif;//reprezinta suma sau diferenta
	reg S;//registrul de semn
	
	
	always@(mantise or op)
		begin
			//presupunem ca initial nu avem cout
			cout = 0;
			//verificam daca mantisaA a fost shiftata la dreapta pentru a vedea daca pe pozitia hiden bitului punem 0 sau 1
			if(mantise[24] == 1'b0)
				mantisaA = {1,mantise[48:26]};
			else 
				mantisaA = {0,mantise[48:26]};
				
			//verificam daca mantisaB a fost shiftata la dreapta pentru a vedea daca pe pozitia hiden bitului punem 0 sau 1
			if(mantise[0] == 1'b0)
				mantisaB = {1,mantise[23:1]};
			else 
				mantisaB = {0,mantise[23:1]};
				
			//vedem daca cele doua mantise au acelasi semn
			semn = mantise[49] ^ mantise[24];
			
			//avem adunare
			if(op == 0)
				begin
					//daca mantisele au acelasi semn facem adunarea mantiselor
					if(semn == 1'b0)
						begin
							{cout,SumDif} = mantisaA + mantisaB;
							S = mantise[49];
						end
					//daca mantisele au semne diferite si prima mantisa este mai mare 
					//facem diferenta dintre mantisaA si mantisaB
					//in S punem semnul mantisei A
					if(semn == 1'b1 && mantisaA >= mantisaB)
						begin
							S = mantise[49];
							{cout,SumDif} = mantisaA + ~mantisaB + 1;
						end
					//daca mantisele au semne diferite si a doua mantisa este mai mare 
					//facem diferenta dintre mantisaB si mantisaA
					//in S punem semnul mantisei B	
					if(semn == 1'b1 && mantisaA < mantisaB)
						begin
							S = mantise[24];
							{cout,SumDif} = mantisaB + ~mantisaA + 1;
						end
				end
				
				//avem scadere
				if(op == 1)
					begin
						//daca mantisele au semne diferite facem adunarea mantiselor
					if(semn == 1'b1)
						begin
							{cout,SumDif} = mantisaA + mantisaB;
							S = mantise[49];
						end
					//daca mantisele au acelasi semn prima mantisa este mai mare 
					//facem diferenta dintre mantisaA si mantisaB
					//in S punem semnul mantisei A
					if(semn == 1'b0 && mantisaA > mantisaB)
						begin
							S = mantise[49];
							{cout,SumDif} = mantisaA + ~mantisaB + 1;
						end
					//daca mantisele au acelasi semn si a doua mantisa este mai mare 
					//facem diferenta dintre mantisaB si mantisaA
					//in S punem semnul mantisei B	
					if(semn == 1'b0 && mantisaA <= mantisaB)
						begin
							S = mantise[24];
							{cout,SumDif} = mantisaB + ~mantisaA + 1;
						end
					end
				
				//daca mantisa rezultata in urma scaderii/adunarii este 0
				if(SumDif == 0)
					out = {1'b1,S,cout,SumDif[22:0]};
				out = {1'b0,S,cout,SumDif[22:0]};
		end
endmodule
