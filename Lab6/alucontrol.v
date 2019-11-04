module alucontrol(ALUOp0,ALUOp1,Func,Operation);

	input ALUOp0,ALUOp1;
	input [5:0]Func;
	output [2:0]Operation;

	wire or1,or2,o3;
	wire a1,a2;

	assign or1=Func[0]|Func[3];
	assign a1=ALUOp1&Func[1];
	assign a2=ALUOp1&or1;
	assign or2=ALUOp0|a1;
	assign or3=(~ALUOp1)|(~Func[2]);

	assign Operation[0]=a2;
	assign Operation[1]=or3;
	assign Operation[2]=or2;

endmodule