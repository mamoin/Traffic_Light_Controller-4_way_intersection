/*************************************************************
Design Name 	: Traffic Light Controller
File Name   	: trafficlightcontroller.v
Function    	: Manages traffic and pedestrian signal in a 4-way intersection
Programer     	: Mohammad Abdul Moin Oninda, Mohammad Abdul Momen, Mir Tanveer Islam
Last Modified	: 29-08-2019
*************************************************************/
module trafficlightcontroller(	clk,				//Clock
											rst,				//Reset
											roada_in,		//Road A sensor
											roadb_in,		//Road B Sensor
											roadc_in,		//Road C Sensor
											roadd_in,		//Road D Sensor
											roada_out,		//Road A Signal
											roadb_out,		//Road B Signal
											roadc_out,		//Road C Signal
											roadd_out,		//Road D Signal
											walk_way_out); //Walk Way Signal
//Input Declaration
input wire clk;					//Input signal for clock
input wire rst;					//Input signal for reset
input wire [3:0] roada_in;		//Insut sensor signal for road A
input wire [3:0] roadb_in;		//Insut sensor signal for road B
input wire [3:0] roadc_in;		//Insut sensor signal for road C
input wire [3:0] roadd_in;		//Insut sensor signal for road D

//Output Declaration
output reg [2:0] roada_out; 	//Output signal for road A
output reg [2:0] roadb_out;	//Output signal for road B
output reg [2:0] roadc_out;	//Output signal for road C
output reg [2:0] roadd_out;	//Output signal for road D
output reg [2:0] walk_way_out;//Output signal for walk way

//State Declaration
reg [2:0] pres_state;			//Present State
reg [2:0] next_state;			//Next State
reg [2:0] prev_state;			//Previous State
reg [2:0] post_tran_state;		//Post Transition State
wire [2:0] post_tran_state_return;//Post Transition State Return

//Internal Signal Declaration
reg time_rst;						//Timer reser
reg [5:0] sec;						//Second counter

//Signal Identification
parameter red = 0;				//001 for red signal
parameter yellow = 1;			//010 for yellow signal
parameter green = 2;				//100 for green signal

//Differentiating States
parameter SP = 3'b000;			//State Primary
parameter SA = 3'b001;			//State A
parameter SB = 3'b010;			//State B
parameter SC = 3'b011;			//State C
parameter SD = 3'b100;			//State D
parameter SW = 3'b101;			//State Walk Way
parameter ST = 3'b110; 			//State Transition


//State Change
always @(posedge clk)
	begin //beginning of always block 1
		if(rst == 1'b1)
			begin 
				time_rst = 1'b1;
				pres_state = SP; 
			end //end of if statement
		else
			begin
				pres_state = next_state;
				if(prev_state != pres_state)
					begin
						time_rst = 1'b1;
					end //end of if statement
				else
					begin
						time_rst = 1'b0; 
					end //end of else statement
			end //end of else statement
	end //end of always block 1
	
	
//Output signal
always @(pres_state)
	begin //beginning of always block 2
		case(pres_state) //beginning of case statement
			SP:
				begin
					roada_out[red] = 1'b0; roada_out[yellow] = 1'b0; roada_out[green] = 1'b0;
					roadb_out[red] = 1'b0; roadb_out[yellow] = 1'b0; roadb_out[green] = 1'b0;
					roadc_out[red] = 1'b0; roadc_out[yellow] = 1'b0; roadc_out[green] = 1'b0;
					roadd_out[red] = 1'b0; roadd_out[yellow] = 1'b0; roadd_out[green] = 1'b0;
					walk_way_out[red] = 1'b0; walk_way_out[yellow] = 1'b0; walk_way_out = 1'b0;
				end //end SP
			SA:
				begin
					roada_out[red] = 1'b0; roada_out[yellow] = 1'b0; roada_out[green] = 1'b1;
					roadb_out[red] = 1'b1; roadb_out[yellow] = 1'b0; roadb_out[green] = 1'b0;
					roadc_out[red] = 1'b1; roadc_out[yellow] = 1'b0; roadc_out[green] = 1'b0;
					roadd_out[red] = 1'b1; roadd_out[yellow] = 1'b0; roadd_out[green] = 1'b0;
					walk_way_out[red] = 1'b1; walk_way_out[yellow] = 1'b0; walk_way_out= 1'b0;
				end //end SA
			SB: 
				begin
					roada_out[red] = 1'b1; roada_out[yellow] = 1'b0; roada_out[green] = 1'b0;
					roadb_out[red] = 1'b0; roadb_out[yellow] = 1'b0; roadb_out[green] = 1'b1;
					roadc_out[red] = 1'b1; roadc_out[yellow] = 1'b0; roadc_out[green] = 1'b0;
					roadd_out[red] = 1'b1; roadd_out[yellow] = 1'b0; roadd_out[green] = 1'b0;
					walk_way_out[red] = 1'b1; walk_way_out[yellow] = 1'b0; walk_way_out= 1'b0;
				end //end SB
			SC:
				begin
					roada_out[red] = 1'b1; roada_out[yellow] = 1'b0; roada_out[green] = 1'b0;
					roadb_out[red] = 1'b1; roadb_out[yellow] = 1'b0; roadb_out[green] = 1'b0;
					roadc_out[red] = 1'b0; roadc_out[yellow] = 1'b0; roadc_out[green] = 1'b1;
					roadd_out[red] = 1'b1; roadd_out[yellow] = 1'b0; roadd_out[green] = 1'b0;
					walk_way_out[red] = 1'b1; walk_way_out[yellow] = 1'b0; walk_way_out= 1'b0;
				end //end SC
			SD:
				begin
					roada_out[red] = 1'b1; roada_out[yellow] = 1'b0; roada_out[green] = 1'b0;
					roadb_out[red] = 1'b1; roadb_out[yellow] = 1'b0; roadb_out[green] = 1'b0;
					roadc_out[red] = 1'b1; roadc_out[yellow] = 1'b0; roadc_out[green] = 1'b0;
					roadd_out[red] = 1'b0; roadd_out[yellow] = 1'b0; roadd_out[green] = 1'b1;
					walk_way_out[red] = 1'b1; walk_way_out[yellow] = 1'b0; walk_way_out= 1'b0;
				end //end SD
			SW:
				begin
					roada_out[red] = 1'b1; roada_out[yellow] = 1'b0; roada_out[green] = 1'b0;
					roadb_out[red] = 1'b1; roadb_out[yellow] = 1'b0; roadb_out[green] = 1'b0;
					roadc_out[red] = 1'b1; roadc_out[yellow] = 1'b0; roadc_out[green] = 1'b0;
					roadd_out[red] = 1'b1; roadd_out[yellow] = 1'b0; roadd_out[green] = 1'b0;
					walk_way_out[red] = 1'b0; walk_way_out[yellow] = 1'b0; walk_way_out= 1'b1;
				end //end SW
			ST:
				begin
					case(post_tran_state) //beginning of case statement ST
						SA:
							begin
								roada_out[yellow] = 1'b1;
								walk_way_out[yellow] = 1'b1;
							end //end ST - SA
						SB:
							begin
								roada_out[yellow] = 1'b1;
								roadb_out[yellow] = 1'b1;
							end //end ST - SB
						SC:
							begin
								roadb_out[yellow] = 1'b1;
								roadc_out[yellow] = 1'b1;
							end //end ST - SC
						SD:
							begin
								roadc_out[yellow] = 1'b1;
								roadd_out[yellow] = 1'b1;
							end //end ST - SD
						SW:
							begin
								roadd_out[yellow] = 1'b1;
								walk_way_out[yellow] = 1'b1;
							end //end ST - SW
						default:
							begin
								roada_out[yellow] = 1'b1;
								roadb_out[yellow] = 1'b1;
								roadc_out[yellow] = 1'b1;
								roadd_out[yellow] = 1'b1;
								walk_way_out[yellow] = 1'b1;
							end //end ST - default
					endcase //end of case statement ST
				end //end ST
			default:
				begin
					roada_out[yellow] = 1'b1;
					roadb_out[yellow] = 1'b1;
					roadc_out[yellow] = 1'b1;
					roadd_out[yellow] = 1'b1;
					walk_way_out[yellow] = 1'b1;
				end //end default
		endcase //end of case statement
	end //end of always block 2

//Counter fot second calculation
always @(posedge time_rst or posedge clk)
	begin //beginning of always block 3
		if(time_rst == 1'b1)
			begin
				sec = 6'd0;
			end //end of if statement
		else 
			begin
				if(sec == 6'd60)
					begin
						sec = 6'd0;
					end //end of if statement
				else
					begin
						sec = sec + 6'd1;
					end //end of else statement
			end //end of else statement
	end //end of always block 3

//State calculation
always @(pres_state or sec)
	begin //beginning of always block 4
		case(pres_state)
			SP:
				begin
					if(sec == 6'd2)
						begin
							next_state = SA;
							prev_state = SP;
						end
					else
						begin
							next_state = SP;
							prev_state = SP;
						end
				end //end SP
			SA:
				begin
					case(roada_in)
						4'b0000:
							begin
								if(sec ==6'd5)
									begin
										next_state = ST;
										prev_state = SA;
									end
								else
									begin
										next_state = SA;
										prev_state = SA;
									end
							end 
						4'b0001:
							begin
								if(sec == 6'd10)
									begin
										next_state = ST;
										prev_state = SA;
									end
								else
									begin
										next_state = SA;
										prev_state = SA;
									end
							end
						4'b0011:
							begin
								if(sec == 6'd20)
									begin
										next_state = ST;
										prev_state = SA;
									end
								else
									begin
										next_state = SA;
										prev_state = SA;
									end
							end
						4'b0111:
							begin
								if(sec == 6'd30)
									begin
										next_state = ST;
										prev_state = SA;
									end
								else
									begin
										next_state = SA;
										prev_state = SA;
									end
							end
						4'b1111:
							begin
								if(sec == 6'd45)
									begin
										next_state = ST;
										prev_state = SA;
									end
								else
									begin
										next_state = SA;
										prev_state = SA;
									end
							end
						default:
							begin
								if(sec == 6'd20)
									begin
										next_state = ST;
										prev_state = SA;
									end
								else
									begin
										next_state = SA;
										prev_state = SA;
									end
							end
					endcase //endcase statement
				end //end SA
			SB:
				begin
					case(roadb_in)
						4'b0000:
							begin
								if(sec ==6'd5)
									begin
										next_state = ST;
										prev_state = SB;
									end
								else
									begin
										next_state = SB;
										prev_state = SB;
									end
							end
						4'b0001:
							begin
								if(sec == 6'd10)
									begin
										next_state = ST;
										prev_state = SB;
									end
								else
									begin
										next_state = SB;
										prev_state = SB;
									end
							end
						4'b0011:
							begin
								if(sec == 6'd20)
									begin
										next_state = ST;
										prev_state = SB;
									end
								else
									begin
										next_state = SB;
										prev_state = SB;
									end
							end
						4'b0111:
							begin
								if(sec == 6'd30)
									begin
										next_state = ST;
										prev_state = SB;
									end
								else
									begin
										next_state = SB;
										prev_state = SB;
									end
							end
						4'b1111:
							begin
								if(sec == 6'd45)
									begin
										next_state = ST;
										prev_state = SB;
									end
								else
									begin
										next_state = SB;
										prev_state = SB;
									end
							end
						default:
							begin
								if(sec == 6'd20)
									begin
										next_state = ST;
										prev_state = SB;
									end
								else
									begin
										next_state = SB;
										prev_state = SB;
									end
							end
					endcase //endcase statement
				end //end SB
			SC:
				begin
					case(roadc_in)
						4'b0000:
							begin
								if(sec ==6'd5)
									begin
										next_state = ST;
										prev_state = SC;
									end
								else
									begin
										next_state = SC;
										prev_state = SC;
									end
							end
						4'b0001:
							begin
								if(sec == 6'd10)
									begin
										next_state = ST;
										prev_state = SC;
									end
								else
									begin
										next_state = SC;
										prev_state = SC;
									end
							end
						4'b0011:
							begin
								if(sec == 6'd20)
									begin
										next_state = ST;
										prev_state = SC;
									end
								else
									begin
										next_state = SC;
										prev_state = SC;
									end
							end
						4'b0111:
							begin
								if(sec == 6'd30)
									begin
										next_state = ST;
										prev_state = SC;
									end
								else
									begin
										next_state = SC;
										prev_state = SC;
									end
							end
						4'b1111:
							begin
								if(sec == 6'd45)
									begin
										next_state = ST;
										prev_state = SC;
									end
								else
									begin
										next_state = SC;
										prev_state = SC;
									end
							end
						default:
							begin
								if(sec == 6'd20)
									begin
										next_state = ST;
										prev_state = SC;
									end
								else
									begin
										next_state = SC;
										prev_state = SC;
									end
							end
					endcase //endcase statement
				end //end SC
			SD:
				begin
					case(roadd_in)
						4'b0000:
							begin
								if(sec ==6'd5)
									begin
										next_state = ST;
										prev_state = SD;
									end
								else
									begin
										next_state = SD;
										prev_state = SD;
									end
							end
						4'b0001:
							begin
								if(sec == 6'd10)
									begin
										next_state = ST;
										prev_state = SD;
									end
								else
									begin
										next_state = SD;
										prev_state = SD;
									end
							end
						4'b0011:
							begin
								if(sec == 6'd20)
									begin
										next_state = ST;
										prev_state = SD;
									end
								else
									begin
										next_state = SD;
										prev_state = SD;
									end
							end
						4'b0111:
							begin
								if(sec == 6'd30)
									begin
										next_state = ST;
										prev_state = SD;
									end
								else
									begin
										next_state = SD;
										prev_state = SD;
									end
							end
						4'b1111:
							begin
								if(sec == 6'd45)
									begin
										next_state = ST;
										prev_state = SD;
									end
								else
									begin
										next_state = SD;
										prev_state = SD;
									end
							end
						default:
							begin
								if(sec == 6'd20)
									begin
										next_state = ST;
										prev_state = SD;
									end
								else
									begin
										next_state = SD;
										prev_state = SD;
									end
							end
					endcase //endcase statement
				end //end SD
			SW:
				begin
					if(sec == 6'd20)
						begin
							next_state = ST;
							prev_state = SW;
						end
					else
						begin
							next_state = SW;
							prev_state = SW;
						end
				end //end SW
			ST:
				begin
					if(sec == 6'd5)
						begin
							next_state = post_tran_state;
							prev_state = ST;
						end
					else
						begin
							next_state = ST;
							prev_state = ST;
						end
				end //end ST
			default:
				begin
					next_state = SP;
				end //end default
		endcase
	end //end of always block 4


//Post Transition State Calculation	
assign post_tran_state_return = post_tran_state;

always @(pres_state)
	begin //beginning of always block 5
		case(pres_state)
			SP:
				begin
					post_tran_state = SA;
				end
			SA:
				begin
					post_tran_state = SB;
				end
			SB:
				begin
					post_tran_state = SC;
				end
			SC:
				begin
					post_tran_state = SD;
				end
			SD:
				begin
					post_tran_state = SW;
				end
			SW:
				begin
					post_tran_state = SA;
				end
			default:
				begin
					post_tran_state = post_tran_state_return;
				end
		endcase	//end case statement
	end //end of always block 5
endmodule //endmodule trafficlightcontroller
