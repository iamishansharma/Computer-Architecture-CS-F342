module bit8_2to1mux(out,sel,in1,in2);

	input [7:0]in1,in2;
	output [7:0]out;
	input sel;
  	genvar j; //this is the variable that is be used in the generate //block

	generate for (j=0; j<=7; j=j+1)

		begin: mux_loop //mux_loop is the name of the loop

	  	mux2to1 m1(out[j],sel,in1[j],in2[j]); //mux2to1 is instantiated every time it is called
		end
	
	endgenerate
endmodule