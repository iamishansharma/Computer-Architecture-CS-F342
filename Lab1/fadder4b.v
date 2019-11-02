//4 Bit Full Adder;

`include "fadder1b.v"

module fadder4b(a,b,cin,sum,coutfinal);

	input [3:0]a;
	input [3:0]b;
	input cin;
	output [3:0]sum;
	output coutfinal;
	wire cout1,cout2,cout3;

	fadder1b f1b1(a[0],b[0],sum[0],cout1,cin);
	fadder1b f1b2(a[1],b[1],sum[1],cout2,cout1);
	fadder1b f1b3(a[2],b[2],sum[2],cout3,cout2);
	fadder1b f1b4(a[3],b[3],sum[3],coutfinal,cout3);

endmodule

module tb_fadder4b;

	reg [3:0]a;
	reg [3:0]b;
	reg cin;
	wire [3:0]sum;
	output coutfinal;

	fadder4b f4b(a,b,cin,sum,coutfinal);

	initial
		begin
			$monitor(,$time," a=%4b, b=%4b, cin=%b, sum=%4b, cout=%b",a,b,cin,sum,coutfinal);

			#0 a=4'b1011;b=4'b1000;cin=1'b0;
			#2 a=4'b1011;b=4'b1000;cin=1'b1;

			$finish;
		end

	initial
		begin
			$dumpfile("fadder4b.vcd");
			$dumpvars;
		end

endmodule
