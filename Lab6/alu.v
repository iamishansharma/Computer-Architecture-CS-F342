module  ALU32Bit(Zero, CarryOut, Result, A, B, Op);

  input [2:0] Op;
  input [31:0] A, B;
  output [31:0] Result;
  reg [31:0] Result;
  output CarryOut, Zero;
  reg CarryOut;
  assign Zero = (({Result} == 0)) ? 1 : 0;
  always @ (Op, A, B) begin
    case(Op)
      0:  Result <= A & B;
      1:  Result <= A | B;
      2:  {CarryOut, Result[31:0]} <= A + B;
      6:  {CarryOut, Result[31:0]} <= A - B;
      7:  Result <= A < B ? 1 : 0;
      default: Result <= 0;
    endcase
  end
  
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