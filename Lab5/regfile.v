`include "regmuxdec.v"
`include "register32bit.v"

module RegFile(clk,reset,ReadReg1,ReadReg2,WriteData,WriteReg,RegWrite,ReadData1,ReadData2);

	input clk, reset, RegWrite;
  	input [4:0] ReadReg1, ReadReg2, WriteReg;
  	input [31:0]  WriteData;
  	output  [31:0]  ReadData1, ReadData2; 

  	wire [31:0]q0,q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,q11,q12,q13,q14,q15,q16,q17,q18,q19,q20,q21,q22,q23,q24,q25,q26,q27,q28,q29,q30,q31;
  	wire [31:0]decode;
  	wire [31:0]c; //Clock Gating
  	genvar j;

  	decoder5_32 dec(decode, WriteReg);

  	generate
	    for(j=0; j <32; j=j+1) 
	    begin:and_loop
	    and g(c[j],RegWrite,decode[j],clk);
	    end
    endgenerate

    reg_32bit r0(q0, WriteData, c[0], reset);
	reg_32bit r1(q1, WriteData, c[1], reset);
	reg_32bit r2(q2, WriteData, c[2], reset);
	reg_32bit r3(q3, WriteData, c[3], reset);
	reg_32bit r4(q4, WriteData, c[4], reset);
	reg_32bit r5(q5, WriteData, c[5], reset);
	reg_32bit r6(q6, WriteData, c[6], reset);
	reg_32bit r7(q7, WriteData, c[7], reset);
	reg_32bit r8(q8, WriteData, c[8], reset);
	reg_32bit r9(q9, WriteData, c[9], reset);
	reg_32bit r10(q10, WriteData, c[10], reset);
	reg_32bit r11(q11, WriteData, c[11], reset);
	reg_32bit r12(q12, WriteData, c[12], reset);
	reg_32bit r13(q13, WriteData, c[13], reset);
	reg_32bit r14(q14, WriteData, c[14], reset);
	reg_32bit r15(q15, WriteData, c[15], reset);
	reg_32bit r16(q16, WriteData, c[16], reset);
	reg_32bit r17(q17, WriteData, c[17], reset);
	reg_32bit r18(q18, WriteData, c[18], reset);
	reg_32bit r19(q19, WriteData, c[19], reset);
	reg_32bit r20(q20, WriteData, c[20], reset);
	reg_32bit r21(q21, WriteData, c[21], reset);
	reg_32bit r22(q22, WriteData, c[22], reset);
	reg_32bit r23(q23, WriteData, c[23], reset);
	reg_32bit r24(q24, WriteData, c[24], reset);
	reg_32bit r25(q25, WriteData, c[25], reset);
	reg_32bit r26(q26, WriteData, c[26], reset);
	reg_32bit r27(q27, WriteData, c[27], reset);
	reg_32bit r28(q28, WriteData, c[28], reset);
	reg_32bit r29(q29, WriteData, c[29], reset);
	reg_32bit r30(q30, WriteData, c[30], reset);
	reg_32bit r31(q31, WriteData, c[31], reset);

	mux32_1 m1(ReadData1,q0,q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,q11,q12,q13,q14,q15,q16,q17,q18,q19,q20,q21,q22,q23,q24,q25,q26,q27,q28,q29,q30,q31,ReadReg1);
	mux32_1 m2(ReadData2,q0,q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,q11,q12,q13,q14,q15,q16,q17,q18,q19,q20,q21,q22,q23,q24,q25,q26,q27,q28,q29,q30,q31,ReadReg2);

endmodule

module tbRegFile32;

  reg clk, reset, RegWrite;
  reg [4:0] ReadReg1, ReadReg2, WriteReg;
  reg [31:0]  WriteData;
  wire  [31:0]  ReadData1, ReadData2;

  RegFile rgf(clk,reset,ReadReg1,ReadReg2,WriteData,WriteReg,RegWrite,ReadData1,ReadData2);
  
  initial 
  begin

    $monitor($time, ": reset = %b, RegWrite = %b, ReadReg1 = %b, ReadReg2 = %b, WriteReg = %b, WriteData = %b, ReadData1 = %b, ReadData2 = %b.", reset, RegWrite, ReadReg1, ReadReg2, WriteReg, WriteData, ReadData1, ReadData2);
    #0   clk = 1'b1; ReadReg1 = 5'b00000; ReadReg2 = 5'b11111; reset = 1'b1;
    #2   reset = 1'b0;
    #10   reset = 1'b1; RegWrite = 1'b1;  WriteData = 32'h00000001; WriteReg = 5'b00000;
    repeat(31)   
    begin
        #10   WriteData = WriteData + 32'h00000001;   WriteReg = WriteReg + 5'b00001;
    end
    #10   RegWrite = 1'b0;   ReadReg1 = 5'b00000;   ReadReg2 = 5'b00001;
    repeat(15)   
    begin
        #10   ReadReg1 = ReadReg1 + 5'b00010;   ReadReg2 = ReadReg2 + 5'b00010;
    end
    #10   $finish;

  end

  always
    #5  clk= ~clk;

endmodule