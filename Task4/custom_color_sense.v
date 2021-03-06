module custom_color_sense(
						input clk,
						input c_clk,
						output [2:0]color,
						output out_s2,
						output out_s3,
						output reg LED
);
	
	parameter IDLE = 3'b000;
	parameter RED_START = 3'b001;
	parameter RED_READ = 3'b010;
	parameter GREEN_START = 3'b011;
	parameter GREEN_READ = 3'b100;
	parameter BLUE_START = 3'b101;
	parameter BLUE_READ = 3'b110;
	// clk time period = 3333ns taking c_clk minimum timeperiod = 8333ns or max frequency = 120khz
	// set the thresholds here
	// To test the program is correct or not please simulate waveform6.vwf with these thresholds and the specified parameters
	parameter R_THRESH_HIGH = 200;
	parameter R_THRESH_LOW = 100;
	parameter G_THRESH_HIGH = 100;
	parameter G_THRESH_LOW = 50;
	parameter B_THRESH_HIGH = 50;
	parameter B_THRESH_LOW = 0;
	
	reg [8:0]counter = 0;
	reg [8:0]c_counter = 0;
	reg [2:0]r_state = IDLE;
	reg [1:0]out_color = 0;
	reg s2 = 1;
	reg s3 = 0;
	always @(posedge clk)
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
						s2 <= 0;
						s3 <= 0;
						counter <= 0;
						if(c_counter == 0)
							r_state <= RED_READ;
						else
							r_state <= RED_START;
					end
				RED_READ :
					begin
						if(counter < 300)
						begin
							counter <= counter + 1'b1;
							r_state <= RED_READ;
						end
						else
						begin
							if(c_counter <= R_THRESH_HIGH && c_counter >= R_THRESH_LOW)
							begin
								out_color <= 1;
								r_state <= RED_START;
							end
							else
							begin
								out_color <= 0;
								r_state <= GREEN_START;
							end
						end
						
					end
				GREEN_START :
					begin
						s2 <= 1;
						s3 <= 1;
						counter <= 0;
						if(c_counter == 0)
							r_state <= GREEN_READ;
						else
							r_state <= GREEN_START;
					end
				GREEN_READ :
					begin
						if(counter < 300)
						begin
							counter <= counter + 1'b1;
							r_state <= GREEN_READ;
						end
						else
						begin
							if(c_counter <= G_THRESH_HIGH && c_counter >= G_THRESH_LOW)
							begin
								out_color <= 2;
								r_state <= GREEN_START;
							end
							else
							begin
								out_color <= 0;
								r_state <= BLUE_START;
							end
						end
						
					end
				BLUE_START :
					begin
						s2 <= 0;
						s3 <= 1;
						counter <= 0;
						if(c_counter == 0)
							r_state <= BLUE_READ;
						else
							r_state <= BLUE_START;
					end
				BLUE_READ :
					begin
						if(counter < 300)
						begin
							counter <= counter + 1'b1;
							r_state <= BLUE_READ;
						end
						else
						begin
							r_state <= IDLE;
							if(c_counter <= B_THRESH_HIGH && c_counter >= B_THRESH_LOW)
							begin
								out_color <= 3;
								r_state <= BLUE_START;
							end
							else
							begin
								out_color <= 0;
								r_state <= IDLE;
							end
						end
						
					end
				
			endcase
			
		end
	
	always@(posedge c_clk)
		begin

			c_counter <= c_counter + 1'b1;
			if (c_counter<60 && c_counter>100)
			   LED <= 1'b1;
			else
			   LED<=0;
			if(counter == 0)
			begin
				c_counter <= 0;
			end
		end
								
	assign color = out_color;
	assign out_s2 = s2;
	assign out_s3 = s3;
	
endmodule 