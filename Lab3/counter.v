module jkflipflop(j,k,q,clk);

	input j,k,clk;
	output q;
	reg q;

	always @ (posedge clk)

		begin

			q<=(j&~q)|(~k&q);
				
		end

endmodule

module counter4b(clk,q);

	input clk;
	output q;
	wire [3:0]c;	

	jkflipflop jf1(1'b1,1'b1,c[0],clk);

	jkflipflop jf2(c[0],c[0],c[1],clk);

	jkflipflop jf3((c[1]&c[0]),(c[1]&c[0]),c[2],clk);

	jkflipflop jf4((c[2]&(c[1]&c[0])),(c[2]&(c[1]&c[0])),c[3],clk);

	assign q=c[3];

endmodule

module tb_counter4b;

	reg clk;
	wire q;

	counter4b c1b(clk,q);
	
	initial 
	begin
	c1b.jf1.q=1'b0;
	c1b.jf2.q=1'b0;
	c1b.jf3.q=1'b0;
	c1b.jf4.q=1'b0;
	end

	always @(posedge clk) 
		begin
			$monitor("clk=%b, q=%b\n",clk,q);
		end

	initial begin
		clk=0;
		forever 
		begin
		 #5 clk=~clk;
		end
	end

	initial 
		begin
			#200 $finish;
		end

	initial
		begin
			$dumpfile("counter.vcd");
			$dumpvars;
		end

endmodule