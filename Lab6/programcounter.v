module programcounter(count, clk, reset);

	input clk,reset;
	output [31:0]count;
	reg [31:0]count;

	always @ (posedge clk) 
	begin
		if (reset) 
		begin
			count=0;
		end

		else
		begin
			count=count+1;
		end
	end

endmodule

/*module TBPC;

  reg clk, reset;
  wire [31:0] count;
  programcounter pc(count, clk, reset);
  initial 
  begin
    repeat(1000)
    # 5 clk = ~clk;
  end
  initial 
  begin
    $monitor($time, " Reset = %b, Count= %b.", reset, count);
    #0  clk = 1'b0; reset = 1'b1;
    #11  reset = 1'b0;
    #30 reset=1'b1;
    #50 $finish;
  end

  initial
  begin
  	$dumpfile("programcounter.vcd");
  	$dumpvars;
  end

endmodule*/