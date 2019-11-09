module REG1(clk,EN,numin,numout);

	input clk,EN;
	input [3:0]numin;
	output [3:0]numout;
	reg [3:0]numout;

	always @ (posedge clk)
	begin
		if(EN)
			begin
				{numout} <= numin;
			end
	end

endmodule

module ROTATOR(clk,Enable,numo,numrotated);

	input clk,Enable;
	input [3:0]numo;
	output [3:0]numrotated;
	reg [3:0]numrotated;
	reg [1:0]rot;

	always @ (posedge clk)
	begin
		if(Enable)
			begin
				rot[1:0]=numo[1:0];
				numrotated[1:0]=numo[3:2];
				numrotated[3:2]=rot[1:0];
			end
	end

endmodule

module MULTIPLIER(op1,op2,product);

	input [3:0]op1;
	input [3:0]op2;
	output [7:0]product;
	reg [7:0]product;
	reg c;
	reg [3:0]A;
	integer count;
	reg [3:0]M;
	reg [3:0]Q;

	always @ (op1 or op2)
		begin
			M=op1;
			Q=op2;
			count=4;
			c=1'b0;
			A=4'b0000;
			while(count!=0)
				begin
					if(Q[0]==1)
						{c,A}=A+M;
					{c,A,Q} = {1'b0,c,A,Q[3:1]};
					count=count-1;
				end
			product={A,Q};
		end

endmodule

module DECODER(sel,out1);

	input [3:0]sel;
	output [15:0]out1;
	reg [15:0]out1;

	always @ (sel)
	begin
		case(sel)

		4'b0000: begin
					out1[15:0]=16'b0000000000000000;
					out1[0]=1'b1;
				end
		4'b0001: begin
					out1[15:0]=16'b0000000000000000;
					out1[1]=1'b1;
				end
		4'b0010: begin
					out1[15:0]=16'b0000000000000000;
					out1[2]=1'b1;
				end
		4'b0011: begin
					out1[15:0]=16'b0000000000000000;
					out1[3]=1'b1;
				end

		4'b0100: begin
					out1[15:0]=16'b0000000000000000;
					out1[4]=1'b1;
				end

		4'b0101: begin
					out1[15:0]=16'b0000000000000000;
					out1[5]=1'b1;
				end

		4'b0110: begin
					out1[15:0]=16'b0000000000000000;
					out1[6]=1'b1;
				end

		4'b0111: begin
					out1[15:0]=16'b0000000000000000;
					out1[7]=1'b1;
				end

		4'b1000: begin
					out1[15:0]=16'b0000000000000000;
					out1[8]=1'b1;
				end

		4'b1001: begin
					out1[15:0]=16'b0000000000000000;
					out1[9]=1'b1;
				end

		4'b1010: begin
					out1[15:0]=16'b0000000000000000;
					out1[10]=1'b1;
				end

		4'b1011: begin
					out1[15:0]=16'b0000000000000000;
					out1[11]=1'b1;
				end

		4'b1100: begin
					out1[15:0]=16'b0000000000000000;
					out1[12]=1'b1;
				end
		4'b1101: begin
					out1[15:0]=16'b0000000000000000;
					out1[13]=1'b1;
				end
		4'b1110: begin
					out1[15:0]=16'b0000000000000000;
					out1[14]=1'b1;
				end
		4'b1111: begin
					out1[15:0]=16'b0000000000000000;
					out1[15]=1'b1;
				end
		endcase
	end

endmodule

module MEMORY(WE, datatowrite, regsel, readdata);

	input WE;
	input [7:0]datatowrite;
	input [15:0]regsel;
	output [7:0]readdata;
	reg [7:0]readdata;
	reg [7:0]Mem[0:15];

	always @ (WE or datatowrite or regsel) 
	begin
	    case(regsel)
	      16'b1000_0000_0000_0000: 
	      begin
	        if(WE)
	        Mem[4'h0] = datatowrite;
	        {readdata} = Mem[4'h0];
	      end
	      16'b0100_0000_0000_0000:
	      begin
	        if(WE)
	          Mem[4'h1] = datatowrite;
	        {readdata} = Mem[4'h1];
	      end
	      16'b0010_0000_0000_0000:
	      begin
	        if(WE)
	          Mem[4'h2] = datatowrite;
	        {readdata} = Mem[4'h2];
	      end
	      16'b0001_0000_0000_0000:
	      begin
	        if(WE)
	          Mem[4'h3] = datatowrite;
	        {readdata} = Mem[4'h3];
	      end
	      16'b0000_1000_0000_0000: 
	      begin
	        if(WE)
	          Mem[4'h4] = datatowrite;
	        {readdata} = Mem[4'h4];
	      end
	      16'b0000_0100_0000_0000: 
	      begin
	        if(WE)
	          Mem[4'h5] = datatowrite;
	        {readdata} = Mem[4'h5];
	      end
	      16'b0000_0010_0000_0000:
	      begin
	        if(WE)
	          Mem[4'h6] = datatowrite;
	        {readdata} = Mem[4'h6];
	      end
	      16'b0000_0001_0000_0000:
	      begin
	        if(WE)
	          Mem[4'h7] = datatowrite;
	        {readdata} = Mem[4'h7];
	      end
	      16'b0000_0000_1000_0000:
	      begin
	        if(WE)
	          Mem[4'h8] = datatowrite;
	        {readdata} = Mem[4'h8];
	      end
	      16'b0000_0000_0100_0000: 
	      begin
	        if(WE)
	          Mem[4'h9] = datatowrite;
	        {readdata} = Mem[4'h9];
	      end
	      16'b0000_0000_0010_0000:
	      begin
	        if(WE)
	          Mem[4'hA] = datatowrite;
	        {readdata} = Mem[4'hA];
	      end
	      16'b0000_0000_0001_0000:
	      begin
	        if(WE)
	          Mem[4'hB] = datatowrite;
	        {readdata} = Mem[4'hB];
	      end
	      16'b0000_0000_0000_1000: 
	      begin
	        if(WE)
	          Mem[4'hC] = datatowrite;
	        {readdata} = Mem[4'hC];
	      end
	      16'b0000_0000_0000_0100:
	      begin
	        if(WE)
	          Mem[4'hD] = datatowrite;
	        {readdata} = Mem[4'hD];
	      end
	      16'b0000_0000_0000_0010:
	      begin
	        if(WE)
	          Mem[4'hE] = datatowrite;
	        {readdata} = Mem[4'hE];
	      end
	      16'b0000_0000_0000_0001: 
	      begin
	        if(WE)
	          Mem[4'hF] = datatowrite;
	        {readdata} = Mem[4'hF];
	      end
	    endcase
	end

endmodule

module DATAPATH (num, key, storedvalue);

	input [3:0]num;
	input [3:0]key;
	output [7:0]storedvalue;
	output [3:0]numout;
	wire [3:0]numout;
	reg clk,EN,WEn;
	reg [3:0]sel;
	wire [3:0]numrotated;
	wire [7:0]product;
	wire [15:0]decoderout;

	initial 
		begin
	    	#0 clk = 1'b0; 
	    	EN = 1'b1; 
	    	WEn = 1'b1; 
	    	sel = 4'b1111;
	  	end

  	always  
	  	begin
	    	#2  clk = ~clk;
	  	end
	
	REG1 reg1(clk,EN,num,numout); // name cannot be reg otherwise problem arises
	ROTATOR rot1(clk,EN,numout,numrotated);
	MULTIPLIER mul1(numrotated,key,product);
	DECODER dec1(numout,decoderout);
	MEMORY mem1(WEn, product, decoderout, storedvalue);

endmodule

module TESTBENCH;

	reg [3:0]num;
	reg [3:0]key;
	wire [7:0]storedvalue;

	DATAPATH d1(num, key, storedvalue);

	initial
	begin
		$monitor($time," Num: %b, Key: %b, Stored Value: %b",num,key,storedvalue);
		#0  num = 4'b1000;  key = 4'b1000;
    	#20 num = 4'b1001;  key = 4'b1000;
    	#20 num = 4'b1100;  key = 4'b1010;
    	#20 num = 4'b1011;  key = 4'b1110;
		#50 $finish;
	end

	initial
	begin
		$dumpfile("file.vcd");
		$dumpvars;
	end

endmodule
