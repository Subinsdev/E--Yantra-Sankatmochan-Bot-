/*
This is the color senser module implemented by us
----------------------------------------------------------------------------------------------------------------------
Attributes

     DESCRIPTION                                                                                   PINS ASSIGNED
	  -----------------------------------------------------------------------------------------------------------------
Inputs:-
     
     clk - Base clock for counting frequency of square wave of color sensor (Taken as 8 KHz)         Pll output
	  c_clk - out of color sensor which gives frequency modulated square wave                         GPIO_15

Outputs:-
     color - color which is supplied for further communication                                       Further used by 
	           0 => No color                                                                          detect_change module
				  1 => Red Color
				  2 => Green Color
				  3 => Blue Color
	  
	  
	  out_s2 - for setting different color filters either logic 1 or 0                                 GPIO_13                                      
	  out_s3 - for setting different color filters either logic 1 or 0                                 GPIO_12
	  
	  
------------------------------------------------------------------------------------------------------------------------	  

--------------------------Some more info regarding this module-----------------------

Frequency scaling - Set as 20%

We took observation/counting for around 0.1 seconds i.e., for 800 clock pulses of base clock of 8 kHz
and them uses relative measure frequency equivalent to 0.1 s for out 
Ex - if  we get out pulses count as 60 then it means that out wave is of 600 Hz at that moment (60/0.1 = 600)

*/


module Color_Sensor(
						input clk,
						input c_clk,
						input rst,
						output [2:0]color,
						output out_s2,
						output out_s3
);
    
	// State parameters
	parameter IDLE = 3'b000;
	parameter RED_START = 3'b001;
	parameter RED_READ = 3'b010;
	parameter GREEN_START = 3'b011;
	parameter GREEN_READ = 3'b100;
	parameter BLUE_START = 3'b101;
	parameter BLUE_READ = 3'b110;
	parameter COMPARE = 3'b111;
	
	reg [9:0]counter = 0;   // 10 bit number for counting upto 800
	// color counters
	reg [9:0]red_counter = 0; // counters variable for color
	reg [9:0]green_counter = 0;
	reg [9:0]blue_counter = 0;
	reg [2:0]r_state = IDLE;
	reg [2:0]out_color = 0;
	reg s2 = 1;
	reg s3 = 0;
	
	always @(posedge clk)
		begin
			if(rst == 0)
			begin
				s2 = 1;
				s3 = 0;
				r_state = IDLE;
				out_color = 0;
				counter = 0;
			end
			else
			begin
				case(r_state)
					IDLE :
						begin
							s2 <= 1;
							s3 <= 0;
							r_state <= RED_START;
						end
					RED_START :
						begin
							// for red s2 and s3 is 0
							s2 <= 0;  
							s3 <= 0;
							counter <= 0;
							if(red_counter == 0)
								r_state <= RED_READ;
							else
								r_state <= RED_START;
						end
					RED_READ :
						begin
							if(counter < 800)
							begin
								counter <= counter + 1'b1;
								r_state <= RED_READ;
							end
							else
								r_state <= GREEN_START;
						end
					GREEN_START :
						begin
							// for green s2 and s3 is 1
							s2 <= 1;
							s3 <= 1;
							counter <= 0;
							if(green_counter == 0)
								r_state <= GREEN_READ;
							else
								r_state <= GREEN_START;
						end
					GREEN_READ :
						begin
							if(counter < 800)
							begin
								counter <= counter + 1'b1;
								r_state <= GREEN_READ;
							end
							else
								r_state <= BLUE_START;
						end
					BLUE_START :
						begin
							// for blue s2 is 0 and s3 is 1
							s2 <= 0;
							s3 <= 1;
							counter <= 0;
							if(blue_counter == 0)
								r_state <= BLUE_READ;
							else
								r_state <= BLUE_START;
						end
					BLUE_READ :
						begin
							if(counter < 800)
							begin
								counter <= counter + 1'b1;
								r_state <= BLUE_READ;
							end
							else
								r_state <= COMPARE;
						end
					COMPARE : 
						begin
							s2 <=0;
							s3 <=0;
							if (blue_counter>300 && green_counter > 300 && red_counter > 300)
							begin
								out_color <=0; // For white color detected
								r_state <= IDLE;
							end
							else if (red_counter>green_counter && red_counter > blue_counter)
							begin
								out_color <=1; // red color detected
								r_state <= RED_START;
							end
							else if (green_counter>red_counter && green_counter > blue_counter)
							begin
								out_color <=2; // green color detected
								r_state <= RED_START;
							end
							else if (blue_counter>green_counter && blue_counter > red_counter)
							begin
								out_color <=3; // blue color detected
								r_state <= RED_START;
							end
							else
							begin
								out_color <=0; // any color can be present except RGB
								r_state <= IDLE;
							end
						end
				endcase
			end
			
		end
	
	always@(posedge c_clk)  // counting clock pulses here for color sensor out
		begin
		   if (s2 == 0 && s3==0) // reading red intensity/frequency
			begin
				red_counter = red_counter + 1'b1;
				if(counter == 0)
					red_counter <= 0;
		  	end
		   else if (s2 == 1 && s3==1) // reading green intensity/frequency
			begin
				green_counter = green_counter + 1'b1;
				if(counter == 0)
					green_counter <= 0;
		  	end
		   else if (s2 == 0 && s3==1) // reading blue intensity/frequency
			begin
				blue_counter = blue_counter + 1'b1;
				if(counter == 0)
					blue_counter <= 0;
		  	end
			else
			begin
				red_counter = 0;
				green_counter = 0;
				blue_counter = 0;
			end
		end
								
	assign color = out_color;
	assign out_s2 = s2;
	assign out_s3 = s3;
	
endmodule 