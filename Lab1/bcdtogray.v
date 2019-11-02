//GateLevelModelling

module bcdtogray(bcd,gray);

	input [3:0]bcd;
	output [3:0]gray;

	assign gray[3]=bcd[3];

	xor x1(gray[2],bcd[3],bcd[2]);
	xor x2(gray[1],bcd[2],bcd[1]);
	xor x3(gray[0],bcd[1],bcd[0]);

endmodule

module tb_bcdtogray;

	reg [3:0]bcd;
	wire [3:0]gray;

	bcdtogray bcdg1(bcd,gray);

	initial
		begin
			$monitor(,$time," bcd=%4b, gray=%4b",bcd,gray);
			#0 bcd=4'b0000;
			#2 bcd=4'b0001;
			#4 bcd=4'b0010;
			#6 bcd=4'b0011;
			#8 bcd=4'b0100;
			#10 bcd=4'b0101;
			#12 bcd=4'b0110;
			#14 bcd=4'b0111;
			#16 bcd=4'b1000;
			#18 bcd=4'b1001;
			#20 bcd=4'b1010;
			#22 bcd=4'b1011;
			#24 bcd=4'b1100;
			#28 bcd=4'b1101;
			#30 bcd=4'b1110;
			#32 bcd=4'b1111;
			$finish;
		end

	initial 

	begin

      $dumpfile("bcdtogray.vcd");
      $dumpvars;

   	end

endmodule