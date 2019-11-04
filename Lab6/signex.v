module signextender(in,out);

	input [15:0]in;
	output [31:0]out;
	reg [31:0]out;

	always @ (in)
		begin

			if(in[15]==1)
			begin
				out[15:0]=in[15:0];
				out[31:16]=16'b1111111111111111;	
			end
			else 
			begin
				out[15:0]=in[15:0];
				out[31:16]=16'b0000000000000000;
			end
		end

endmodule

/*module tb_signex;

	reg [15:0]in;
	wire [31:0]out;

	signextender sex(in,out);

	initial
	begin
		#0 in=16'b1001000100100000;
		#5 $display("\nInput: %b | Output: %b",in,out);
		#5 in=16'b0001100100101000;
		#5 $display("\nInput: %b | Output: %b\n",in,out);
		#5 $finish; 
	end

	initial
		begin
			$dumpfile("signex.vcd");
			$dumpvars;
		end


endmodule*/