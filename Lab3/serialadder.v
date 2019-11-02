`include "shiftreg.v"
`include "fadder1b.v"
`include "dff.v"

module serialadder4b(clk,a,b,sum,cin,cout,sc);

	input clk;
	input a;
	input b;
	inout sum;
	inout cin;
	inout cout;
	input sc;

	wire c1;

	wire x;
	wire y;

	wire [3:0]sa;
	wire [3:0]sb;

	and a1(c1,sc,clk);

	shiftreg sA(1'b1,a,clk,sa,x);

	shiftreg sB(1'b1,b,clk,sb,y);

	fadder1b f1(x,y,sum,cout,cin);

	dff_sync_clear dff2(cout,1'b1,w1,cin);

	dff_sync_clear dff1(cout,1'b0,w1,cin);

endmodule

module tb_serialadder4b;

	reg clk;
	reg a;
	reg b;
	wire sum;
	wire cout;
	wire cin;
	reg sc;
	integer i;

	serialadder4b sa1(clk,a,b,sum,cin,cout,sc);
	
	reg [3:0]A;
	reg [3:0]B;

	input [3:0]sumfinal;

	initial
		begin
			clk = 0;
			assign A=4'b0111;
			assign B=4'b0100;

			for(i=0; i<=3; i=i+1)
			begin
				a=A[i];
				b=B[i];
				#2 clk = 1;
				#2 clk = 0;
			end
		end

	initial
		begin
			$dumpfile("serialadder.vcd");
			$dumpvars;
		end

endmodule