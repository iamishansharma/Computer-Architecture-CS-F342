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

/*module tb_decoder;

	reg [2:0]in;
	wire [7:0]out;

	decoder3x8 d1(in,out);

	initial
		begin

			$monitor(,$time," input=%b | output=%b ",in,out);

			#0 in=3'b000;
			#3 in=3'b001;
			#3 in=3'b010;
			#3 in=3'b011;
			#3 in=3'b100;
			#3 in=3'b101;
			#3 in=3'b110;
			#3 in=3'b111;

			$finish;
		end

	initial
		begin
			$dumpfile("decoder3x8.vcd");
			$dumpvars;
		end

endmodule
*/
