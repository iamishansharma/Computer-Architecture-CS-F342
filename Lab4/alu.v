`include "mux2to1.v"
`include "mux2to18bit.v"
`include "mux2to132bit.v"
`include "mux2to132bit3way.v"
`include "bit32AND.v"
`include "bit32OR.v"
`include "fadder32bit.v"

module ALU (a,b,Binvert,Carryin,Operation,Result,CarryOut);

	input [31:0] a,b;
	input [1:0] Operation;
	input Binvert, Carryin;
	output [31:0] Result;
	output CarryOut;
	wire [31:0] andout,orout,addout;
	wire [31:0] bout;

	bit32_2to1mux m1(bout,Binvert,b,((~b)+1));
	bit32AND m2(andout,a,bout);
	bit32OR m3(orout,a,bout);
	fadder32bit m4(a,bout,addout,Carryin,CarryOut);
	bit3data_32to2to1mux m5(Result,Operation,andout,orout,addout);
 
endmodule

/*module tb_alu;

	reg Binvert, Carryin;
	reg [1:0] Operation;
	reg [31:0] a,b;
	wire [31:0] Result;
	wire CarryOut;

	ALU a1(a,b,Binvert,Carryin,Operation,Result,CarryOut);

	initial
		begin

			a=32'b11100101_10101101_10110101_10100100;
			b=32'b01111010_11011010_01011011_01011010;
			Binvert=1'b0;
			Carryin=1'b0;
			#0 Operation=2'b00; //must perform AND resulting in zero 
			#100 Operation=2'b01; //OR
			#100 Operation=2'b10; //ADD
			#100 Binvert=1'b1;//SUB
			#200 $finish;
		end

	initial
	begin
		$dumpfile("alu.vcd");
		$dumpvars;
	end

endmodule*/