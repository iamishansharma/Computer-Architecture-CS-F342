module mux2to1c1(out,sel,in1,in2);

    input in1,in2,sel;
    output out;
    wire not_sel,a1,a2;
    not (not_sel,sel);
    and (a1,sel,in2);
    and (a2,not_sel,in1);
    or(out,a1,a2);
    
endmodule

module MUX5Bit_2To1(out, select, q1, q2);
	input  [4:0] q1, q2;
	input select;
	output [4:0] out;
	genvar  j;
  generate  for(j = 0; j < 5; j = j + 1)  
    begin:  mux_loop
      mux2to1c1 Mux(out[j], select, q1[j], q2[j]);
    end
  endgenerate
endmodule

/*module TBMux5Bit_2To1;
  reg [4:0] q1, q2;
  reg select;
  wire [4:0] out;
  MUX5Bit_2To1 mux(out, select, q1, q2);
  initial begin
    $monitor($time, " Q1 = %b, Q2 = %b, Select = %b, Output = %b.", q1, q2, select, out);
    #0  q1 = 5'b10101; q2 = 5'b01010; select = 1'b0;
    #50  select = 1'b1;
    #100 $finish;
  end
endmodule*/