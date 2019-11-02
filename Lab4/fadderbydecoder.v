`include "decoder3x8.v"

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

/*module tb_fadderbydecoder;

	reg x,y,z;
	wire s,c;

	fadderbydecoder fbd1(x,y,z,s,c);

	initial
		begin
			$monitor(,$time," x=%b , y=%b, cin=%b, sum=%b, cout=%b",x,y,z,s,c);

			#0 x=1'b0;y=1'b0;z=1'b0;
			#2 x=1'b0;y=1'b0;z=1'b1;
			#2 x=1'b0;y=1'b1;z=1'b0;
			#2 x=1'b0;y=1'b1;z=1'b1;
			#2 x=1'b1;y=1'b0;z=1'b0;
			#2 x=1'b1;y=1'b0;z=1'b1;
			#2 x=1'b1;y=1'b1;z=1'b0;
			#2 x=1'b1;y=1'b1;z=1'b1;

			$finish;
		end

	initial
		begin
			$dumpfile("fadderbydecoder.vcd");
			$dumpvars;
		end

endmodule*/