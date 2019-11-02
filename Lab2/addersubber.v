module fulladderbehav(a,b,sum,cout,cin);

	input a,b,cin;
	output sum,cout;
	reg sum,cout;

	always @ (a or b or cin)

		if(a==0 && b==0 && cin==0)
		begin
			sum=0;
			cout=0;
		end

		else if((a==0 && b==0 && cin==1)||(a==1 && b==0 && cin==0)||(a==0 && b==1 && cin==0))
		begin
			sum=1;
			cout=0;
		end

		else if((a==1 && b==1 && cin==0)||(a==0 && b==1 && cin==1)||(a==1 && b==0 && cin==1))
		begin
			sum=0;
			cout=1;
		end

		else 
		begin
			sum=1;
			cout=1;
		end

endmodule

module addersubber(a,b,sum,cout,m,v);

	input [3:0]a;
	input [3:0]b;
	input m;
	output [3:0]sum;
	output cout;
	output v;
	wire c1,c2,c3;
	wire [3:0]rb;

	assign rb[0]=b[0]^m;
	assign rb[1]=b[1]^m;
	assign rb[2]=b[2]^m;
	assign rb[3]=b[3]^m;

	fulladderbehav f1(a[0],rb[0],sum[0],c1,m);
	fulladderbehav f2(a[1],rb[1],sum[1],c2,c1);
	fulladderbehav f3(a[2],rb[2],sum[2],c3,c2);
	fulladderbehav f4(a[3],rb[3],sum[3],cout,c3);

	assign v=cout^c3;

endmodule 

module tb_addersubber;

	reg [3:0]a;
	reg [3:0]b;
	reg m;
	wire [3:0]sum;
	wire cout;
	wire v;

	addersubber as1(a,b,sum,cout,m,v);

	initial
		begin
			$monitor(,$time," a=%4b, b=%4b, s=%b, sum=%4b, cout=%b, v=%b",a,b,m,sum,cout,v);

			#0 a=4'b1011;b=4'b1000;m=1'b0;
			#2 a=4'b1011;b=4'b0100;m=1'b1;

			$finish;
		end

	initial
		begin
			$dumpfile("addersubber.vcd");
			$dumpvars;
		end

endmodule