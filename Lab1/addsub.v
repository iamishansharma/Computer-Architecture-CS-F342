//4 bit Full Adder Subtractor

`include "fadder1b.v"

module AddSub4b(a,b,s,coutfinal,sum,v);

	input [3:0]a;
	input [3:0]b;
	input s;
	output [3:0]sum;
	output coutfinal;
	output v;
	wire cout1,cout2,cout3;
	wire b0,b1,b2,b3;

	xor x0(b0,b[0],s);
	xor x1(b1,b[1],s);
	xor x2(b2,b[2],s);
	xor x3(b3,b[3],s);

	fadder1b f1b1(a[0],b0,sum[0],cout1,s);
	fadder1b f1b2(a[1],b1,sum[1],cout2,cout1);
	fadder1b f1b3(a[2],b2,sum[2],cout3,cout2);
	fadder1b f1b4(a[3],b3,sum[3],coutfinal,cout3);

	xor x4(v,coutfinal,cout3);

endmodule

module tb_AddSub4b;

	reg [3:0]a;
	reg [3:0]b;
	reg s;
	wire [3:0]sum;
	output coutfinal;
	wire v;

	AddSub4b as4b(a,b,s,coutfinal,sum,v);

	initial
		begin
			$monitor(,$time," a=%4b, b=%4b, s=%b, sum=%4b, cout=%b, v=%b",a,b,s,sum,coutfinal,v);

			#0 a=4'b1011;b=4'b1000;s=1'b0;
			#2 a=4'b1011;b=4'b0100;s=1'b1;

			$finish;
		end

	initial
		begin
			$dumpfile("addsub.vcd");
			$dumpvars;
		end

endmodule