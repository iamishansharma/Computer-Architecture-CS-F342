module encoder(OpCode,Func);

  input [7:0]Func;
  output  [2:0]OpCode;
  reg [2:0]OpCode;

  always  @ (Func)  
  begin

    if(Func[7])
      OpCode = 3'b000;
    else if(Func[6])
      OpCode = 3'b001;
    else if(Func[5])
      OpCode = 3'b010;
    else if(Func[4])
      OpCode = 3'b011;
    else if(Func[3])
      OpCode = 3'b100;
    else if(Func[2])
      OpCode = 3'b101;
    else if(Func[1])
      OpCode = 3'b110;
    else if(Func[0])
      OpCode = 3'b111;
    else
      OpCode = 3'bxxx;
  end

endmodule

module alu(A,B,OpCode,Result,Carry);

  input [2:0] OpCode;
  input [3:0] A, B;
  output  [3:0] Result;
  output  Carry;

  assign  {Carry,Result} = (OpCode == 3'b000) ? (A + B) : (OpCode == 3'b001)  ? (A - B) : (OpCode == 3'b010) ? (A ^ B) : (OpCode == 3'b011) ? (A | B) : (OpCode == 3'b100) ? (A & B) : (OpCode == 3'b101) ? (~(A | B)) : (OpCode == 3'b110) ? (~(A & B)) : (~(A ^ B));

endmodule

module paritygen(Result,parity);

	input [3:0]Result;
	output parity;

	assign parity=~(Result[0]^Result[1]^Result[2]^Result[3]);

endmodule

module pipelineinputfeed(clk,OpCode,a,b,OpOut,aout,bout);

	input [3:0] a, b;
  	input [2:0] OpCode;
   	input clk;
	output  [2:0] OpOut;
	output  [3:0] aout, bout;
	reg [2:0] OpOut;
	reg [3:0] aout, bout;

  always  @ (posedge clk)
  begin
    OpOut <= OpCode;
    aout  <= a;
    bout  <= b;
  end

endmodule

module pipelineoutputfeed(clk,Result,ResultOut);

  input clk;
  input [3:0]Result;
  output  [3:0]ResultOut;
  reg [3:0]ResultOut;

  always  @ (posedge clk) 
  begin
    ResultOut = Result;
  end

endmodule

module pipeline(clk,Func,a,b,POut);

  input clk;
  input [7:0]Func;
  input [3:0]a,b;
  wire [2:0]OpCode,OpOut;
  wire [3:0]aout,bout,Result,ResultOut;
  wire  Carry;
  output POut;


  encoder en1(OpCode,Func);
  pipelineinputfeed pip1(clk,OpCode,a,b,OpOut,aout,bout);
  alu a1(aout,bout,OpOut,Result,Carry);
  pipelineoutputfeed pip2(clk,Result,ResultOut);
  paritygen pg1(ResultOut,POut);

endmodule

/*module TESTBENCH;

  reg clock;
  reg [7:0] FuncCode;
  reg [3:0] A, B;
  wire  Out;

  pipeline mod(clock, FuncCode, A, B, Out);
  initial 
  begin
    $monitor($time, " A = %b, B = %b, Function Code = %b, OpCode = %b, AOut = %b, BOut = %b, OpOut = %b, X = %b, Carry = %b, XOut = %b, Output = %b.", A, B, FuncCode, mod.OpCode, mod.aout, mod.bout, mod.OpOut, mod.Result, mod.Carry, mod.ResultOut, Out);
    #0  clock = 1'b1;
    #4  A = 4'b0101; B = 4'b1110;  FuncCode = 8'b10000000;
    #20 FuncCode = 8'b01000000;
    #20 FuncCode = 8'b00100000;
    #20 FuncCode = 8'b00010000;
    #20 FuncCode = 8'b00001000;
    #20 FuncCode = 8'b00000100;
    #20 FuncCode = 8'b00000010;
    #20 FuncCode = 8'b00000001;
    #50 $finish;
  end
  always
    #2  clock = ~clock;

    initial
    begin
    	$dumpfile("pipeline.vcd");
    	$dumpvars;
    end

endmodule*/