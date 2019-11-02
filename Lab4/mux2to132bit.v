module bit32_2to1mux(out,sel,in1,in2);

	input [31:0]in1,in2;
	output [31:0]out;
	input sel;
  	genvar j; //this is the variable that is be used in the generate //block

	generate for (j=0; j<=24; j=j+8)

		begin: mux32_loop //mux_loop is the name of the loop

	  	bit8_2to1mux bm1(out[(j+7):j],sel,in1[(j+7):j],in2[(j+7):j]); //mux2to1 is instantiated every time it is called
		end
	
	endgenerate	
endmodule