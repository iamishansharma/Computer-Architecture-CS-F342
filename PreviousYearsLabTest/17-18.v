module MUX_SMALL(Mux2_1In,sel,Mux2_1Out);

	input [1:0]Mux2_1In;
	input sel;
	output Mux2_1Out;

	assign Mux2_1Out=sel?Mux2_1In[1]:Mux2_1In[0];

endmodule


module MUX_BIG(Mux8_1In,sel,Mux8_1Out);

	input [7:0]Mux8_1In;
	input [2:0]sel;
	output Mux8_1Out;

	wire m1,m2,m3,m4,m5,m6,m7;

	MUX_SMALL mux1(Mux8_1In[1:0],sel[0],m1);
	MUX_SMALL mux2(Mux8_1In[3:2],sel[0],m2);
	MUX_SMALL mux3(Mux8_1In[5:4],sel[0],m3);
	MUX_SMALL mux4(Mux8_1In[7:6],sel[0],m4);
	MUX_SMALL mux5({m2,m1},sel[1],m5);
	MUX_SMALL mux6({m4,m3},sel[1],m6);
	MUX_SMALL mux7({m6,m5},sel[2],Mux8_1Out);

endmodule

module TFF(clock,reset,t,q);

	input t,clock,reset;
	output reg q;

	always @ (posedge clock or reset)
		begin
			if(reset) 
				q=0;
			else 
				begin
					if(t)
						q<=~q;
					else 
						q<=q;
				end
		end

endmodule

module COUNTER_4BIT(clock,clear,Q);

	input clock,clear;
	output [3:0]Q;
	wire w1,w2;

	TFF tff1(clock,clear,1'b1,Q[0]);
	TFF tff2(clock,clear,Q[0],Q[1]);
	assign w1=Q[2]&Q[1];
	TFF tff3(clock,clear,w1,Q[2]);
	assign w2=w1&Q[2];
	TFF tff4(clock,clear,w2,Q[3]);

endmodule

module COUNTER_3BIT(clock,clear,Q);

	input clock,clear;
	output [2:0]Q;
	wire w1;

	TFF tff1(clock,clear,1'b1,Q[0]);
	TFF tff2(clock,clear,Q[0],Q[1]);
	assign w1=Q[1]&Q[0];
	TFF tff3(clock,clear,w1,Q[2]);

endmodule

module MEMORY();

	reg [7:0]mem[0:15];
    integer i;

    initial 
    begin
        for (i=0; i<16; i=i+1) 
        begin

            if(i%2==0)
                mem[i]=8'hCC;

            else
                mem[i]=8'hAA;

        end
    end

endmodule

`timescale 1ms/1ns

module INTG(clock,reset,OpWave);

	input clock,reset;
	wire [2:0]c3out;
	wire [3:0]c4out;
	wire clock2;
	output OpWave;

	COUNTER_3BIT c3b(clock,reset,c3out);
	assign clock2=c3out[0]&c3out[1]&c3out[2];
	COUNTER_4BIT c4b(clock2,reset,c4out);
	MEMORY mem1();
	MUX_BIG bigmux(mem1.mem[c4out],c3out,OpWave);
	
endmodule

module tb;

	reg clock,reset;

	INTG intg1(clock,reset,OpWave);

    always
        #0.5 clock = ~clock;
    
    initial 
    begin
        #0 clock=1'b0;reset = 1'b1;
        #1 reset = 1'b0;
        #1000 $finish;
    end

    initial
    begin
    	$dumpfile("labtest.vcd");
    	$dumpvars;
    end

endmodule
