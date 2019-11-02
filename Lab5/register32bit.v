`include "dff.v"

module reg_32bit(q,d,clk,reset);

	input [31:0]d;
	input clk,reset;
	output [31:0]q;

	genvar i;

	generate for(i=0; i<=31; i=i+1)

			begin: dffloop

			dff_sync_clear dff1(d[i],reset,clk,q[i]);
				
			end
		
	endgenerate

endmodule

/*module tb32reg;

	reg [31:0] d;
	reg clk,reset;
	wire [31:0] q;

	reg_32bit R(q,d,clk,reset);

	always @(clk)

		#5 clk<=~clk;

		initial
			begin
				clk=1'b1;
				reset=1'b0;//reset the register 
				#20 reset=1'b1;
				#20 d=32'hAFAFAFAF; 
				#200 $finish;
			end

	initial
	begin
		$dumpfile("register32bit.vcd");
		$dumpvars;
	end
endmodule*/