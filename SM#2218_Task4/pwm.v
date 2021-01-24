/*
PWM generator module
------------------------------------------------------
Attributes

      DESCRIPTION                                                          PINS ASSIGNMENT
---------------------------------------------------------------------------------------------------
Inputs:-
      dir_l - polarity of left motor                                        from Line follow module
		dir_r - polarity of right motor                                       from Line follower module
		speed_l - left motor speed                                            from Line follower module
      speed_l - right motor speed                                           from Line follower module		
     	clk - Base clock of 10 MHz for counting purpose	                            -
--------------------------------------------------------------------------------------------------------





Pins Assignment for Motors:-
   Left motors:-
	 LV1 - GPIO_027
	 LV2 - GPIO_029
	 
Right Motors:-
	 LV3 - GPIO_033
	 LV4 - GPIO_031
   
*/










module pwm(
				input rst,
				input dir_l,
				input dir_r,
				input wire [13:0]speed_l,
				input wire [13:0]speed_r,
				input clk,
				output l_1,
				output l_2,
				output r_1,
				output r_2
);
	reg [13:0] counter;
	reg pwm_l;
	reg pwm_r;
	parameter NUM_C = 11000; // counter max value motor speed varies within (0- NUM_C)
	
	always@(posedge clk)
	begin
		if(rst == 1)
		begin
			if (counter < speed_l)
				pwm_l = 1'b1;
			
			else
				pwm_l = 1'b0;
			
			if (counter < speed_r)
				pwm_r = 1'b1;
				
			else
				pwm_r = 1'b0;
			///////////
			
			
			counter = counter + 1;
			if (counter == NUM_C)
				counter = 0;
		end
		else
		begin
			counter = 0;
			pwm_l = 0;
			pwm_r = 0;
		end
	end
	
	assign l_1 = (dir_l == 1)? pwm_l: 0;
	assign l_2 = (dir_l == 0)? pwm_l: 0;
	assign r_1 = (dir_r == 1)? pwm_r: 0;
	assign r_2 = (dir_r == 0)? pwm_r: 0;
	
endmodule
		