module decoder3x8(in,out);

	input [2:0]in;
	output [7:0]out;

	assign out[0]=((!in[2])&(!in[1])&(!in[0]));
	assign out[1]=((!in[2])&(!in[1])&(in[0]));
	assign out[2]=((!in[2])&(in[1])&(!in[0]));
	assign out[3]=((!in[2])&(in[1])&(in[0]));
	assign out[4]=((in[2])&(!in[1])&(!in[0]));
	assign out[5]=((in[2])&(!in[1])&(in[0]));
	assign out[6]=((in[2])&(in[1])&(!in[0]));
	assign out[7]=((in[2])&(in[1])&(in[0]));

endmodule

module fadderbydecoder(x,y,z,s,c);

	input x,y,z;
	output s,c;
	wire [2:0]w;
	wire [7:0]o;

	assign w[0]=z;
	assign w[1]=y;
	assign w[2]=x;

	decoder3x8 dc1(w,o);

	assign s=o[1]|o[2]|o[4]|o[7];
	assign c=o[3]|o[5]|o[6]|o[7];

endmodule

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

module fadder32bit(a,b,s,in,out);

	input [31:0] a, b;
	input in;
	output [31:0]s;
	output out;
	wire [3:0]c;

	fadder8bit f1(a[7:0],b[7:0],in,s[7:0],c[0]);
	
	genvar j;
	generate for (j=8; j<=24;j=j+8)

	begin: fadd8_loop

	fadder8bit f1(a[(j+7):j], b[(j+7):j],c[(j-8)/8],s[(j+7):j],c[((j-8)/8)+1]);

	end

	endgenerate

endmodule