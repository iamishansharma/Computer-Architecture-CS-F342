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