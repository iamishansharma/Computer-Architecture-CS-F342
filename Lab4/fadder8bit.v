`include "fadderbydecoder.v"

module fadder8bit(a,b,cin,sum,cout);

	input [7:0]a;
	input [7:0]b;
	input cin;
	output [7:0]sum;
	output cout;

	wire a0,a1,a2,a3,a4,a5,a6;

	fadderbydecoder fbd0(a[0],b[0],cin,sum[0],a0);
	fadderbydecoder fbd1(a[1],b[1],a0,sum[1],a1);
	fadderbydecoder fbd2(a[2],b[2],a1,sum[2],a2);
	fadderbydecoder fbd3(a[3],b[3],a2,sum[3],a3);
	fadderbydecoder fbd4(a[4],b[4],a3,sum[4],a4);
	fadderbydecoder fbd5(a[5],b[5],a4,sum[5],a5);
	fadderbydecoder fbd6(a[6],b[6],a5,sum[6],a6);
	fadderbydecoder fbd7(a[7],b[7],a6,sum[7],cout);

endmodule

/*module tb_fadder8bit;

	reg [7:0]a;
	reg [7:0]b;
	reg cin;
	wire [7:0]sum;
	wire cout;

	fadder8bit f8b(a,b,cin,sum,cout);

	initial
		begin
			$monitor(,$time," a=%b, b=%b, cin=%b, sum=%b, cout=%b",a,b,cin,sum,cout);

			#0 a=8'b00001011;b=8'b01101000;cin=1'b0;
			#2 a=8'b10011011;b=8'b01011000;cin=1'b1;

			$finish;
		end

	initial
		begin
			$dumpfile("fadder8bit.vcd");
			$dumpvars;
		end

endmodule*/
