/*
this is the line foilower module implemented by us
Attributes:
---------------------------------------------------------
Input:-
     ADC contoller 12 bit digital values ----------------
	  channel   Pin no.   For this implementation we selected channel 0,1,2 of On board ADC
	  -----------------
	  0          in0
	  1          in1
 	  2          in1
----------------------------------------------------------	  
Output:-
    speed_l - Left motor speed 
	 speed_r - right motor speed
	 dir_l - It determine polarity for left motor (0 => Backward movement and 1=> forward movement)
	 dir_l - It determines polarity for left motor (0 => Backward movement and 1=> forward movement)
-----------------------------------------------------------

Pins Assignment for Motors:-
   Left motors:-
	 LV1 - GPIO_027
	 LV2 - GPIO_029
	 
	Right Motors:-
	 LV3 - GPIO_033
	 LV4 - GPIO_031
   
*/


module White_Line_Following(
			input rst,
			input wire [11:0]in0,
			input wire [11:0]in1,
			input wire [11:0]in2,
			output reg [13:0]speed_l,
			output reg dir_l,
			output reg [13:0]speed_r,
			output reg dir_r,
			output reg node
);
	// around 0.18v on bright surface and 2.2v on dark surface
	// After Calibration according to lighting conditions, value selected for upper and lower limit as follows
	parameter max_lim = 1600; 
	parameter min_lim = 600;
		
	reg [13:0]speed_1 = 11000;  //8800 is taken as the base speed
	reg [13:0]speed_2 = 11000;
	reg dir_1 = 1;   
	reg dir_2 = 1;
	reg r_node = 0;
	reg [11:0]prev_error = 0; // previous error term
	reg [11:0]error = 0;  // error term for making PD controller
   integer kp = 1;  //kp and kd selected by calibration
	integer kd = 1;
	
	always@( in0 or in1 or in2 )
	begin
		r_node = 0;
		if(rst == 0)
		begin
			prev_error = 0;
			error = 0;
			dir_1 = 1;
			dir_2 = 1;
			speed_1 = 0;
			speed_2 = 0;
		end
		else
		begin
			if (in0 < min_lim && in1 < min_lim && in2 < min_lim)
			begin
				speed_1 = 11000;
				speed_2 = 11000;
				dir_1 = 1;
				dir_2 = 0;
			end
			
			else if (in0 > max_lim && in1 > max_lim && in2 > max_lim)
			begin
				speed_1 = 11000;
				speed_2 = 11000;
				dir_1 = 1;
				dir_2 = 1;
				r_node = 1;
				
			end
			
			else
			begin
			// Implemenation of custom PD contoller with desired error
				if(in0 >= in2)
				begin
					error = in0 - in2;
					speed_1 = (11000 - error)/kp - (error - prev_error)/kd;
					speed_2 = (11000 + error)/kp + (error - prev_error)/kd;
				end
				else
				begin
					error = in2 - in0;
					speed_1 = (11000 + error)/kp + (error - prev_error)/kd;
					speed_2 = (11000 - error)/kp - (error - prev_error)/kd;
				end
				
				dir_1 = 1;
				dir_2 = 1;
			end
		end
		
		speed_l <= speed_1;
		speed_r <= speed_2;
		dir_l <= dir_1;
		dir_r <= dir_2;
		node <= r_node;
	   prev_error = error;
	end
	
	

endmodule 