module signx(neg,x);

//this module is used to get the sign of an input 4-digit number

	input [3:0]x;
	output neg;
	reg neg;

	always @ (x)

		if (x[3] == 1)

			begin 
				neg =1; 
			end 

		else neg=0;

endmodule

module comp(a,b,signA,signB,more,eq,less);

	input [3:0]a;
	input [3:0]b;
	output signA,signB,more,eq,less;
	reg more,eq,less;

	signx sna(signA,a);
	signx snb(signB,b);

	always @ (a or b or signA or signB)

		if(signA==1 && signB==0)
		begin
			less=1;
			eq=0;
			more=0;
		end

		else if(signA==0 && signB==1)
		begin
			more=1;
			eq=0;
			less=0;
		end

		else if(a > b)
		begin
			more=1;
			less=0;
			eq=0;
		end

		else if(a == b)
		begin
			more=0;
			less=0;
			eq=1;
		end

		else 
		begin
			more=0;
			less=1;
			eq=0;
		end

endmodule

module tb_comp;

	reg [3:0]a;
	reg [3:0]b;
	wire signA,signB,more,eq,less;

	comp c1(a,b,signA,signB,more,eq,less);

	initial
		begin
			$monitor(,$time," A=%b | B=%b || AgtB=%b | AeqB=%b | AltB=%b",a,b,more,eq,less);

			#0 a=4'b1001;b=4'b0001;
			#2 a=4'b0001;b=4'b1001;
			#2 a=4'b1001;b=4'b1001;
			#2 a=4'b0011;b=4'b0011;

			$finish;
		end

	initial
		begin
			$dumpfile("compbehav.vcd");
			$dumpvars;
		end
endmodule