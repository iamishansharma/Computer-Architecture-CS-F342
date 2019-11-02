module seq_10110(state,out,in,clk,reset);

	input in;
	input clk;
	output out;
	reg out;
	output [2:0]state;
	reg [2:0]state;
	input reset;

	always @ (posedge clk)

		begin
			if(reset)
				begin
					state=3'b000;
					out=0;
				end

			else 
				begin
					case(state)

					3'b000:

						begin
							if(in==0)
							begin
								state=3'b000;
								out=0;
							end
							else 
							begin
								state=3'b001;
								out=0;
							end
						end

					3'b001:

						begin
							if(in==0)
							begin
								state=3'b010;
								out=0;
							end
							else 
							begin
								state=3'b001;
								out=0;
							end
						end

					3'b010:

						begin
							if(in==0)
							begin
								state=3'b000;
								out=0;
							end
							else 
							begin
								state=3'b011;
								out=0;
							end
						end

					3'b011:

						begin
							if(in==0)
							begin
								state=3'b011;
								out=0;
							end
							else 
							begin
								state=3'b100;
								out=0;
							end
						end

					3'b100:

						begin
							if(in==0)
							begin
								state=3'b010;
								out=1;
							end
							else 
							begin
								state=3'b001;
								out=0;
							end
						end

					default:

						begin
								state=3'b000;
								out=0;
						end

					endcase
				end
		end

endmodule

module tb_seq_10110;

	reg in;
	reg clk;
	wire out;
	wire [2:0]state;
	reg reset;
	integer i;
	reg [15:0]seq1;

	seq_10110 seq(state,out,in,clk,reset);

	initial

		begin

			clk = 0;
			reset = 1;

			seq.out=0;
			seq.state=3'b000;

			assign seq1=16'b0101101100110110;

			#5 reset=0;

			for(i=15; i>=0; i=i-1)
			begin
				in=seq1[i];
				#2 clk = 1;
				#2 clk = 0;
				$display("Input = ",in," | Seq Detected = ",out," | State = %b",state);
			end

		end

	initial
		begin
			$dumpfile("seq.vcd");
			$dumpvars;
		end

endmodule