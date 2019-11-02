`include "fadder8bit.v"
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