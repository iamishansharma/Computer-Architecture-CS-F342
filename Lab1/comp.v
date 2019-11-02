module compare4bit(a,b,eq,more,less);

	input [3:0]a;
	input [3:0]b;
	output eq,more,less;
	wire [3:0]na;
	wire [3:0]nb;
	wire [3:0]x;

	wire w1,w2,w3,w4,w5,w6,w7,w8;

	wire a1,a2,a3,a4,a5,a6;

	not n1(na[0],a[0]);
	not n2(na[1],a[1]);
	not n3(na[2],a[2]);
	not n4(na[3],a[3]);

	not n5(nb[0],b[0]);
	not n6(nb[1],b[1]);
	not n7(nb[2],b[2]);
	not n8(nb[3],b[3]);

	and a1(w1,b[3],na[3]);
	and a2(w2,nb[3],a[3]);
	nor o1(x[3],w1,w2);

	and a3(w3,b[2],na[2]);
	and a4(w4,nb[2],a[2]);
	nor o2(x[2],w3,w4);

	and a5(w5,b[1],na[1]);
	and a6(w6,nb[1],a[1]);
	nor o3(x[1],w5,w6);

	and a7(w7,b[0],na[0]);
	and a8(w8,nb[0],a[0]);
	nor o4(x[0],w7,w8);

	and ax1(a1,x[3],w4);
	and ax2(a2,x[3],w3);
	and ax3(a3,x[3],x[2],w6);
	and ax4(a4,x[3],x[2],w5);
	and ax5(a5,x[3],x[2],x[1],w8);
	and ax6(a6,x[3],x[2],x[1],w7);
	and ax7(eq,x[3],x[2],x[1],x[0]);

	or lessor(less,w2,a1,a3,a5);

	or moreor(more,w1,a2,a4,a6);

endmodule

module tb_compare4bit;

	reg [3:0]a;
	reg [3:0]b;
	wire eq,more,less;

	compare4bit c4b(a,b,eq,more,less);

	initial
		begin
			$monitor(,$time," a=%4b, b=%4b ",a,b, eq, more, less);

			#0 a=4'b0001;b=4'b0001;
			#4 a=4'b0101;b=4'b0100;
			#4 a=4'b1000;b=4'b1111;

			$finish;
		end

	initial
		begin
			$dumpfile("comp.vcd");
			$dumpvars;
		end

endmodule