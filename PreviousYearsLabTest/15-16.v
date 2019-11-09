module Entries_16(X,MuxOut);

	input [3:0]X;
	output [8:0]MuxOut;
	reg [8:0]MuxOut;
	reg [4:0]twentyfive;

	always @ (X)
	begin
	    MuxOut=9'h0;
		twentyfive=5'b11001;
		case(X)
		4'h0: MuxOut=twentyfive*X;
		4'h1: MuxOut=twentyfive*X;
		4'h2: MuxOut=twentyfive*X;
		4'h3: MuxOut=twentyfive*X;
		4'h4: MuxOut=twentyfive*X;
		4'h5: MuxOut=twentyfive*X;
		4'h6: MuxOut=twentyfive*X;
		4'h7: MuxOut=twentyfive*X;
		4'h8: MuxOut=twentyfive*X;
		4'h9: MuxOut=twentyfive*X;
		4'hA: MuxOut=twentyfive*X;
		4'hB: MuxOut=twentyfive*X;
		4'hC: MuxOut=twentyfive*X;
		4'hD: MuxOut=twentyfive*X;
		4'hE: MuxOut=twentyfive*X;
		4'hF: MuxOut=twentyfive*X;
		endcase
	end

endmodule

module Adder_Register(clk,acc_rst1,acc_rst2,Y,MuxOut);

	input clk,acc_rst1,acc_rst2;
	input [8:0]MuxOut;
	output [12:0]Y;
	reg [12:0]AdderOut;

	initial
		AdderOut=13'b0;
	always @ (posedge clk)
	begin
		if(acc_rst1 == 1)
            AdderOut = AdderOut + {4'b0,MuxOut};
        else
            AdderOut = AdderOut;
	end

	always @(posedge acc_rst2 or negedge acc_rst2)
        AdderOut= 13'b0;

    assign Y = AdderOut;
	
endmodule

module dff(clk,reset,d,q,nq);

	input d;
	input clk;
	input reset;
	output q;
	output nq;
	reg q;
	reg nq;

	always @ (posedge clk or reset)
	begin
		if(reset)
		begin
			q=1'b0;
			nq=1'b1;
		end
		else
			begin
				q=d;
				nq=~q;
			end
	end

endmodule

module ACC_RST(clk,reset,acc_rst1,acc_rst2);

	input clk;
	input reset;

	output acc_rst1,acc_rst2;

	wire [3:0]q;
	wire [3:0]nq;

	dff d1(clk,reset,nq[0],q[0],nq[0]);
	dff d2(q[0],reset,nq[1],q[1],nq[1]);
	dff d3(q[1],reset,nq[2],q[2],nq[2]);
	dff d4(q[2],reset,nq[3],q[3],nq[3]);

	assign acc_rst2 = q[3];
	assign acc_rst1 = q[2];

endmodule

module INTG(clk,reset,X,Y);

	input [3:0]X;
	input clk,reset;
	wire [8:0]MuxOut;
	wire acc_rst2,acc_rst1;
	output [12:0]Y;

	Entries_16 e1(X,MuxOut);
	Adder_Register ar1(clk,acc_rst1,acc_rst2,Y,MuxOut);
	ACC_RST ar2(clk,reset,acc_rst1,acc_rst2);

endmodule

module tb_INTG;

	reg [3:0]X;
	reg clk,reset;
	wire [12:0]Y;

	INTG intg1(clk,reset,X,Y);

	initial 
	begin
        #0 clk = 1'b0; reset = 1'b1; X = 4'd0;

        #16 reset = 1'b0;

        #8 X = 4'd10;
        #16 X = 4'd5;
        #16 X = 4'd12;
        #16 X = 4'd1;

        #16 X = 4'd13;
        #16 X = 4'd7;
        #16 X = 4'd9;
        #16 X = 4'd2;

        #16 X = 4'd11;
        #16 X = 4'd5;
        #16 X = 4'd4;
        #16 X = 4'd2;

        #16 $finish;
    end

    always

        #8 clk = ~clk;

    initial begin
        $dumpfile("file.vcd");
        $dumpvars;
    end

endmodule


