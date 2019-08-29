/*************************************************************
Design Name 	: Traffic Light Controller Test Bench
File Name   	: trafficlightcontroller_tb.v
Function    	: Manages traffic and pedestrian signal in a 4-way intersection
Programer     	: Mohammad Abdul Moin Oninda
Last Modified	: 29-08-2019
*************************************************************/
module trafficlightcontroller_tb(); 

//Declaring wires and registers
wire [2:0] A_out;
wire [2:0] B_out;
wire [2:0] C_out;
wire [2:0] D_out;
wire [2:0] WW_out;
reg Clk;
reg Rst;
reg [3:0] A_in;
reg [3:0] B_in;
reg [3:0] C_in;
reg [3:0] D_in;

//Instantiating module
trafficlightcontroller dut(.clk(Clk), 					//Clock
									.rst(Rst),					//Reset
									.roada_in(A_in),			//Road A input
									.roadb_in(B_in),			//Road B input
									.roadc_in(C_in),			//Road C input
									.roadd_in(D_in),			//Road D input
									.roada_out(A_out),		//Road A output
									.roadb_out(B_out),		//Road B output
									.roadc_out(C_out),		//Road C output
									.roadd_out(D_out),		//Road D output
									.walk_way_out(WW_out));	//Walk way output
	
//Initial statement for result monitoring
initial			
	begin
		$monitor($time,"CLOCK=%h \t RESET=%h \t A_in=%h \t B_in=%h \t C_in=%h \t D_in=%h \t A_out=%h \t B_out=%h \t C_out=%h \t D_out=%h \t WW_out=%h", Clk, Rst, A_in, B_in, C_in, D_in, A_out, B_out, C_out, D_out, WW_out);
	end

//Initial statement for clock signal generation
initial 
	begin
		Clk = 1'b0;
		forever #1 Clk = ~Clk;
	end

//Stimulus 	
initial 
	begin
		A_in = 4'b1111;
		B_in = 4'b0011;
		C_in = 4'b0111;
		D_in = 4'b1010;
		Rst = 1'b1;
		#20;
		Rst = 1'b0;
		#500;
		$finish;
	end
endmodule //Endmodule Test Bench