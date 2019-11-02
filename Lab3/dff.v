module dff_sync_clear(d,clearb,clock,q);

	input d,clearb,clock;
	output q;
	reg q;

	always @ (posedge clock)
	begin
		if(clearb) q<=1'b0;
		else q<=d;
	end

endmodule

module dff_async_clear(d, clearb, clock, q);

	input d, clearb, clock;
	output q;
	reg q;

	always @ (negedge clearb or posedge clock) 
	begin
		if (clearb) q <= 1'b0; 
		else q <= d;
	end

endmodule

/*module tb_dff;

	reg d, clock, clearb;
	wire q;

	dff_sync_clear dff1(d,clearb,clock,q);
	//dff_async_clear dff2(d, clearb, clock, q);
	
	//Always at rising edge of clock display the signals 
	always @(posedge clock)
	begin
		$display("d=%b, clk=%b, rst=%b, q=%b\n", d, clock, clearb, q); 
	end
		
		//Module to generate clock with period 10 time units 
	initial 
		begin
		forever
			begin
			clock=0;
			#5
			clock=1;
			#5
			clock=0;
			end
		end

	initial 
		begin 
		#0 d=0; clearb=1; 
		#4 d=1; clearb=0; 
		#50 d=1; clearb=1; 
		#20 d=0; clearb=0; 
		end

	initial
		begin
			$dumpfile("dff.vcd");
			$dumpvars;
		end

endmodule*/
