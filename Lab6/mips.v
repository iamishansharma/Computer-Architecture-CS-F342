`include "shiftleft.v"
`include "concat.v"
`include "programcounter.v"
`include "alu.v"
`include "mux2to132bit.v"
`include "instructmem.v"
`include "datamemory.v"
`include "regfile.v"
`include "alucontrol.v"
`include "maincontroller.v"
`include "signex.v"
`include "MUX_2to1_5Bit.v"
`include "fadder32bit.v"

module mipsSCDataPath(ALUOutput, PCCurrent, PC, reset, clk);

  input clk, reset;
  input [31:0]PC;
  output [31:0]ALUOutput,PCCurrent;
  wire [31:0]Instruction;
  wire [31:0]PCNew1,PCNew2;
  reg [31:0]PCCurrent;
  wire RegDst,Jump,ALUSrc,MemToReg,RegWrite,MemRead,MemWrite,Branch;
  wire [1:0]ALUOp;
  wire [2:0]Op;
  wire [4:0]MuxRegWriteAddress;
  wire [31:0]MuxALU2Src,MuxWriteDataSrc,MuxJumpOut,DataMemOut;
  wire [31:0]ReadData1,ReadData2,SignExtend,ShiftLeft,ShiftLeft2,AdderOut,JumpAddress,BranchAddress;
  wire Zero,BranchDest,CarryOut,Carry1,Carry2;

  instructionmemory IM1(Instruction, PC, clk); //Read the instruction at positive edge of clock
  
  fadder32bit progcount1(PC,32'h4,PCNew1,1'b0,Carry1); //PC = PC + 4
  
  signextender s1(Instruction[15:0],SignExtend); //Sign Extend the Branch Offset
  
  Shift_Left upper1(ShiftLeft,SignExtend); //Shift left by 2 bits the Sign Extended Branch Offset
  
  Shift_Left upper2(ShiftLeft2,{6'b000000,Instruction[25:0]}); //Shift left by 2 bits the Jump Offset
  
  concatJuPC c1(JumpAddress, ShiftLeft2, PCNew1);//Concat PC and Left Shifted Jump Offset
  
  maincontrolunit m1(RegDst, Jump, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, Branch, ALUOp[0], ALUOp[1], Instruction[31:26]); //Generate the Control Signals
  
  MUX5Bit_2To1  mux1(MuxRegWriteAddress, RegDst, Instruction[20:16], Instruction[15:11]); //Selecting the writing register
  
  RegFile r1(clk,reset,Instruction[25:21],Instruction[20:16],MuxWriteDataSrc,MuxRegWriteAddress,RegWrite,ReadData1,ReadData2); //Reading from the register file
  
  alucontrol aluc1(ALUOp[0],ALUOp[1],Instruction[5:0],Op); //Generating the ALU Control Signals
  
  bit32_2to1mux mux2(MuxALU2Src,ALUSrc,ReadData2,SignExtend); //Selecting the second ALU Source
  
  ALU32Bit a1(Zero,CarryOut,ALUOutput,ReadData1,MuxALU2Src,Op); //Doing the ALU Operation
  
  fadder32bit progcount2(PCNew1,ShiftLeft,PCNew2,1'b0,Carry2);//Generating the Branch Address
  
  and a2(BranchDest,Branch,Zero); //Generating the signal whether to branch or not
  
  bit32_2to1mux mux3(BranchAddress,BranchDest,PCNew1,PCNew2); //Generating the new address after the branch MUX
  
  bit32_2to1mux mux4(MuxJumpOut,Jump,BranchAddress,JumpAddress); //Generating the new address after the Jump MUX
  
  datamemory d1(clk, MemRead, ALUOutput, DataMemOut, MemWrite, ALUOutput, ReadData2);      //Operating on Data memory
  
  bit32_2to1mux mux5(MuxWriteDataSrc,MemToReg,ALUOutput,DataMemOut); //Writing back to register file
  
  RegFile r2(clk,reset,Instruction[25:21],Instruction[20:16],MuxWriteDataSrc,MuxRegWriteAddress,1'b0,ReadData1,ReadData2);  //Writing into register file

  initial 
  begin
    PCCurrent = PC;
  end
  always @ (negedge clk) 
  begin
    PCCurrent = MuxJumpOut;
  end

endmodule