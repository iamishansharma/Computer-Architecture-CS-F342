module dff_sync_clear(d,clearb,clock,q);

	input d,clearb,clock;
	output q;
	reg q;

	always @ (posedge clock)
	begin
		if(!clearb) q<=1'b0;
		else q<=d;
	end
endmodule
module reg_32bit(q,d,clk,reset);

	input [31:0]d;
	input clk,reset;
	output [31:0]q;

	genvar i;

	generate for(i=0; i<=31; i=i+1)

			begin: dffloop

			dff_sync_clear dff1(d[i],reset,clk,q[i]);
				
			end
		
	endgenerate
endmodule
module mux32_1(regData,q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,q11,q12,q13,q14,q15,q16,q17,q18,q19,q20,q21,q22,q23,q24,q25,q26,q27,q28,q29,q30,q31,q32,reg_no);

	input [31:0]q1,q2,q3,q4,q5,q6,q7,q8,q9,q10,q11,q12,q13,q14,q15,q16,q17,q18,q19,q20,q21,q22,q23,q24,q25,q26,q27,q28,q29,q30,q31,q32;
	
	output [31:0]regData;
	reg [31:0]regData;
	input [4:0]reg_no;

	always @ (q1 or q2 or q3 or q4 or q5 or q6 or q7 or q8 or q9 or q10 or q11 or q12 or q13 or q14 or q15 or q16 or q17 or q18 or q19 or q20 or q21 or q22 or q23 or q24 or q25 or q26 or q27 or q28 or q29 or q30 or q31 or q32 or reg_no)
	begin
		case(reg_no)
		5'b00000: regData=q1;
		5'b00001: regData=q2;
		5'b00010: regData=q3;
		5'b00011: regData=q4;
		5'b00100: regData=q5;
		5'b00101: regData=q6;
		5'b00110: regData=q7;
		5'b00111: regData=q8;
		5'b01000: regData=q9;
		5'b01001: regData=q10;
		5'b01010: regData=q11;
		5'b01011: regData=q12;
		5'b01100: regData=q13;
		5'b01101: regData=q14;
		5'b01110: regData=q15;
		5'b01111: regData=q16;
		5'b10000: regData=q17;
		5'b10001: regData=q18;
		5'b10010: regData=q19;
		5'b10011: regData=q20;
		5'b10100: regData=q21;
		5'b10101: regData=q22;
		5'b10110: regData=q23;
		5'b10111: regData=q24;
		5'b11000: regData=q25;
		5'b11001: regData=q26;
		5'b11010: regData=q27;
		5'b11011: regData=q28;
		5'b11100: regData=q29;
		5'b11101: regData=q30;
		5'b11110: regData=q31;
		5'b11111: regData=q32;
		endcase;
	end
endmodule

module decoder5_32(register,reg_no);

	input [4:0]reg_no;
	output [31:0]register;

	assign register[0]=((~reg_no[4])&(~reg_no[3])&(~reg_no[2])&(~reg_no[1])&(~reg_no[0]));
	assign register[1]=((~reg_no[4])&(~reg_no[3])&(~reg_no[2])&(~reg_no[1])&(reg_no[0]));
	assign register[2]=((~reg_no[4])&(~reg_no[3])&(~reg_no[2])&(reg_no[1])&(~reg_no[0]));
	assign register[3]=((~reg_no[4])&(~reg_no[3])&(~reg_no[2])&(reg_no[1])&(reg_no[0]));
	assign register[4]=((~reg_no[4])&(~reg_no[3])&(reg_no[2])&(~reg_no[1])&(~reg_no[0]));
	assign register[5]=((~reg_no[4])&(~reg_no[3])&(reg_no[2])&(~reg_no[1])&(reg_no[0]));
	assign register[6]=((~reg_no[4])&(~reg_no[3])&(reg_no[2])&(reg_no[1])&(~reg_no[0]));
	assign register[7]=((~reg_no[4])&(~reg_no[3])&(reg_no[2])&(reg_no[1])&(reg_no[0]));
	assign register[8]=((~reg_no[4])&(reg_no[3])&(~reg_no[2])&(~reg_no[1])&(~reg_no[0]));
	assign register[9]=((~reg_no[4])&(reg_no[3])&(~reg_no[2])&(~reg_no[1])&(reg_no[0]));
	assign register[10]=((~reg_no[4])&(reg_no[3])&(~reg_no[2])&(reg_no[1])&(~reg_no[0]));
	assign register[11]=((~reg_no[4])&(reg_no[3])&(~reg_no[2])&(reg_no[1])&(reg_no[0]));
	assign register[12]=((~reg_no[4])&(reg_no[3])&(reg_no[2])&(~reg_no[1])&(~reg_no[0]));
	assign register[13]=((~reg_no[4])&(reg_no[3])&(reg_no[2])&(~reg_no[1])&(reg_no[0]));
	assign register[14]=((~reg_no[4])&(reg_no[3])&(reg_no[2])&(reg_no[1])&(~reg_no[0]));
	assign register[15]=((~reg_no[4])&(reg_no[3])&(reg_no[2])&(reg_no[1])&(reg_no[0]));
	assign register[16]=((reg_no[4])&(~reg_no[3])&(~reg_no[2])&(~reg_no[1])&(~reg_no[0]));
	assign register[17]=((reg_no[4])&(~reg_no[3])&(~reg_no[2])&(~reg_no[1])&(reg_no[0]));
	assign register[18]=((reg_no[4])&(~reg_no[3])&(~reg_no[2])&(reg_no[1])&(~reg_no[0]));
	assign register[19]=((reg_no[4])&(~reg_no[3])&(~reg_no[2])&(reg_no[1])&(reg_no[0]));
	assign register[20]=((reg_no[4])&(~reg_no[3])&(reg_no[2])&(~reg_no[1])&(~reg_no[0]));
	assign register[21]=((reg_no[4])&(~reg_no[3])&(reg_no[2])&(~reg_no[1])&(reg_no[0]));
	assign register[22]=((reg_no[4])&(~reg_no[3])&(reg_no[2])&(reg_no[1])&(~reg_no[0]));
	assign register[23]=((reg_no[4])&(~reg_no[3])&(reg_no[2])&(reg_no[1])&(reg_no[0]));
	assign register[24]=((reg_no[4])&(reg_no[3])&(~reg_no[2])&(~reg_no[1])&(~reg_no[0]));
	assign register[25]=((reg_no[4])&(reg_no[3])&(~reg_no[2])&(~reg_no[1])&(reg_no[0]));
	assign register[26]=((reg_no[4])&(reg_no[3])&(~reg_no[2])&(reg_no[1])&(~reg_no[0]));
	assign register[27]=((reg_no[4])&(reg_no[3])&(~reg_no[2])&(reg_no[1])&(reg_no[0]));
	assign register[28]=((reg_no[4])&(reg_no[3])&(reg_no[2])&(~reg_no[1])&(~reg_no[0]));
	assign register[29]=((reg_no[4])&(reg_no[3])&(reg_no[2])&(~reg_no[1])&(reg_no[0]));
	assign register[30]=((reg_no[4])&(reg_no[3])&(reg_no[2])&(reg_no[1])&(~reg_no[0]));
	assign register[31]=((reg_no[4])&(reg_no[3])&(reg_no[2])&(reg_no[1])&(reg_no[0]));

endmodule

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

/*module tbRegFile32;

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

endmodule*/