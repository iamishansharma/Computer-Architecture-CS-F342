/*module dff_sync_clear(d,clk,q,clearb);

	input d,clk,clearb;
	output q;
	reg q;

	always @ (posedge clock)
	begin
		if(clearb) q<=1'b0;
		else q<=d;
	end

endmodule*/

module shiftreg(EN, in, CLK, Q,f);

	parameter n=4; 
	input EN;
	input in;
	input CLK;
	output [n-1:0] Q; 
	reg [n-1:0] Q;
	output f;
	reg f;

	initial
	Q=4'b0000;

	always @ (posedge CLK) 
		begin
			if (EN) 
				Q={in,Q[n-1:1]};
				f=Q[3];
		end

endmodule

/*module shiftregtest;

	parameter n=4; 
	reg EN,in,CLK; 
	wire [n-1:0] Q; //reg [n-1:0] Q;
	wire f;

	shiftreg shreg(EN,in,CLK,Q,f);

	initial 
		begin 
			CLK=0; 
		end

	always
		#2 CLK=~CLK;

	initial
		begin
		$monitor(,$time," EN=%b, in=%b, Q=%b\n",EN,in,Q); 
			#0 in=0;EN=1;
			#4 in=1;EN=1;
			#4 in=1;EN=1;
			#4 in=0;EN=1;
			#5 $finish;
		end

	initial
		begin
			$dumpfile("shiftreg.vcd");
			$dumpvars;
		end

endmodule*/

