module pwm(
				input dir_l,
				input dir_r,
				input wire [13:0]speed_l,
				input wire [13:0]speed_r,
				input clk,
				output reg l_1,
				output reg l_2,
				output reg r_1,
				output reg r_2
);
	reg [13:0] counter;
	reg pwm_l;
	reg pwm_r;
	parameter NUM_C = 11000;
	// clock time period = 100 for test = 5
	// motor time period = 1100000 for test = 55000
	// 11000 clock cycles in one motor cycle
	// max counter value should be 11000
	initial
	begin
		$display("left speed : 0x%0h", speed_l);
		$display("right speed : 0x%0h", speed_r);
	end
	
	always@(posedge clk)
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
		if (dir_l == 0)
		begin
			l_1 = 0;
			l_2 = pwm_l;
		end
		
		else
		begin
			l_1 = pwm_l;
			l_2 = 0;
		end
		//////////
		if (dir_r == 0)
		begin
			r_1 = 0;
			r_2 = pwm_r;
		end
		
		else
		begin
			r_1 = pwm_r;
			r_2 = 0;
		end
		
		counter = counter + 1;
		if (counter == NUM_C)
			counter = 0;
	end
	
endmodule
		