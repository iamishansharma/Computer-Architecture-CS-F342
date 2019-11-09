`timescale 1ms/1ns

module DFF(clock,reset,set,D,Q);

	input clock,reset,D,set;
	output reg Q;

	initial
		Q=1'b0;

	always @(posedge clock or reset or set) 
	begin
		if (reset) 
		begin
			Q=1'b0;
		end
		else 
			Q<=D;
		if(set)
			Q <= 1'b1;
		else
			Q <= D;
	end

endmodule

module TFF(clock,reset,T,Q);

	input T,clock,reset;
	output reg Q;

	initial 
		Q <= 1'b0;

	always @ (posedge clock or reset)
		begin
			if(reset) 
				Q=1'b0;
			else 
				begin
					if(T)
						Q<=~Q;
					else 
						Q<=Q;
				end
		end

endmodule

module CONTROLLOGIC(S,Z,X,clock,set,T0,T1,T2);

	input S,Z,X,clock,set;
	output T0,T1,T2;
	wire d0,d1,d2;
	wire or1,or2,or3,or4,or5,or6,or7;
	wire NS,NX,NZ;

	not(NS,S);
	not(NX,X);
	not(NZ,Z);

	and(or1,T0,NS);
	and(or2,T2,Z);
	or(d0,or1,or2);

	and(or3,T0,S);
	and(or4,T2,NZ,NX);
	and(or5,T1,NX);
	or(d1,or3,or4,or5);

	and(or6,T1,X);
	and(or7,T2,NZ,X);
	or(d2,or6,or7);

	DFF dff1(clock,1'b0,set,d0,T0);
	DFF dff2(clock,1'b0,1'b0,d1,T1);
	DFF dff3(clock,1'b0,1'b0,d2,T2);

endmodule

module COUNTER_4BIT(clock,reset,EN,Q);

	input clock,reset,EN;
	output [3:0]Q;
	wire c1,c2;

	wire clk;

	assign clk = clock & EN;

	TFF tff1(clk,reset,EN,Q[0]);
	TFF tff2(clk,reset,Q[0],Q[1]);
	and(c1,Q[0],Q[1]);
	TFF tff3(clk,reset,c1,Q[2]);
	and(c2,c1,Q[2]);
	TFF tff4(clk,reset,c2,Q[3]);

endmodule

module INTG(S,clock,Q,G,X,set);

	input S,clock,X;
	output [3:0]Q;
	output G;
	input set;

	wire Z;
	wire EN,dg;
	wire [2:0]T;
	wire syncclear;

	assign syncclear=T[0]&S;
	assign EN=(T[1]&X)|(T[2]&(~Z)&X);

	COUNTER_4BIT c4b(clock,syncclear,EN,Q);

	assign Z=Q[0]&Q[1]&Q[2]&Q[3];

	CONTROLLOGIC cl1(S,Z,X,clock,set,T[0],T[1],T[2]);

	assign dg=T[2]&Z;

	DFF dffG(clock,reset,set,dg,G);

endmodule

module Testbench;

	reg S,clock,X;
	wire [3:0]Q;
	wire G;
	reg set;

	INTG intg1(S,clock,Q,G,X,set);

	initial
		begin
			set=1'b1;
			S = 1'b0;
			X = 1'b0;
		#5	S = 1'b1;
			set=1'b0;
			X = 1'b1;
		#100 $finish;
		end

	initial
		begin
			$dumpfile("18-19.vcd");
			$dumpvars;
		end

	initial
		clock=1'b0;
	always
		#0.5 clock=~clock;

		initial begin
		$monitor("S = %b, Set = %b, X = %b, Q = %d, G = %b", S,set, X, Q, G);
	end

endmodule