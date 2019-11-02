module bit3data_32to2to1mux(out,op,in1,in2,in3);

	input [31:0]in1,in2,in3;
	output [31:0]out;
	input [1:0]op;
  	
  	wire [31:0]inter;

	bit32_2to1mux b32ao(inter,op[0],in1,in2);
	bit32_2to1mux b32faao(out,op[1],inter,in3);
	
endmodule