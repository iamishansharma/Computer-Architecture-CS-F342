module mux4to1(select,d,q);

	input [1:0]select;
	input [3:0]d;
	output q;

	wire a1,a2,a3,a4;

	assign a1=d[0]&(!select[1])&(!select[0]);
	assign a2=d[1]&(!select[1])&(select[0]);
	assign a3=d[2]&(select[1])&(!select[0]);
	assign a4=d[3]&(select[1])&(select[0]);

	assign q=a1|a2|a3|a4;

endmodule

module mux16to1(select,d,q);

	input [15:0]d;
	input [3:0]select;
	output q;

	wire [3:0]m;

	mux4to1 m1(select[1:0],d[3:0],m[0]);
	mux4to1 m2(select[1:0],d[7:4],m[1]);
	mux4to1 m3(select[1:0],d[11:8],m[2]);
	mux4to1 m4(select[1:0],d[15:12],m[3]);

	mux4to1 m5(select[3:2],m[3:0],q);

endmodule

module tb_mux16to1;

	reg [15:0]d;
    reg [3:0]select;
    wire q;

    mux16to1 mux1(select,d,q);

	initial
		begin
		$monitor(,$time," d=%b | select=%b | out=%b",d,select,q); 

			   d=16'b0000000000000001; select=4'b0000; 
			#3 d=16'b0000000000000010; select=4'b0001; 
			#3 d=16'b0000000000000100; select=4'b0010; 
			#3 d=16'b0000000000001000; select=4'b0011; 
			#3 d=16'b0000000000010000; select=4'b0100; 
			#3 d=16'b0000000000100000; select=4'b0101; 
			#3 d=16'b0000000001000000; select=4'b0110; 
			#3 d=16'b0000000010000000; select=4'b0111; 
			#3 d=16'b0000000100000000; select=4'b1000; 
			#3 d=16'b0000001000000000; select=4'b1001; 
			#3 d=16'b0000010000000000; select=4'b1010; 
			#3 d=16'b0000100000000000; select=4'b1011; 
			#3 d=16'b0001000000000000; select=4'b1100; 
			#3 d=16'b0010000000000000; select=4'b1101; 
			#3 d=16'b0100000000000000; select=4'b1110; 
			#3 d=16'b1000000000000000; select=4'b1111;
		end

	initial
		begin
			$dumpfile("mux16to1.vcd");
			$dumpvars;
		end

endmodule
