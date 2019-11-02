module bcdtograydat(bcd,gray);

	input [3:0]bcd;
	output [3:0]gray;

	assign gray[3]=bcd[3];

	assign gray[2]=bcd[3]^bcd[2];

	assign gray[1]=bcd[2]^bcd[1];

	assign gray[0]=bcd[1]^bcd[0];

endmodule

module tb_bcdtogray;

	reg [3:0]bcd;
	wire [3:0]gray;

	bcdtograydat bcdgraydat1(bcd,gray);

	initial
		begin
			$monitor(,$time," bcd=%4b, gray=%4b",bcd,gray);
			#0 bcd=4'b0000;
			#2 bcd=4'b0001;
			#2 bcd=4'b0010;
			#2 bcd=4'b0011;
			#2 bcd=4'b0100;
			#2 bcd=4'b0101;
			#2 bcd=4'b0110;
			#2 bcd=4'b0111;
			#2 bcd=4'b1000;
			#2 bcd=4'b1001;
			#2 bcd=4'b1010;
			#2 bcd=4'b1011;
			#2 bcd=4'b1100;
			#2 bcd=4'b1101;
			#2 bcd=4'b1110;
			#2 bcd=4'b1111;
			$finish;
		end

	initial 

	begin

      $dumpfile("bcdtogray.vcd");
      $dumpvars;

   	end

endmodule
