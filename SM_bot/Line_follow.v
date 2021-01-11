
module Line_follow(
			input wire [11:0]in0,
			input wire [11:0]in1,
			input wire [11:0]in2,
			output wire [13:0]speed_l,
			output dir_l,
			output wire [13:0]speed_r,
			output dir_r,
			output node
);
	// around 0.18v on bright surface and 2.2v on dark surface
	// normal position is achieved when ino and in2 both less than 1
	parameter max_lim = 1800;
	integer nm_in0 = 180;
	integer nm_in1 = 2200;
	integer nm_in2 = 180;
		
	reg [13:0]speed_1;
	reg [13:0]speed_2;
	reg dir_1;
	reg dir_2;
	reg r_node;
		
		
	integer diff_in0 = 0;
	integer diff_in1 = 0;
	integer diff_in2 = 0;
	
	
	always@( in0 or in1 or in2 )
	begin
		
		r_node <= 0;
		if (in0 < max_lim && in1 < max_lim && in2 < max_lim)
		begin
			speed_1 = 5500;
			speed_2 = 5500;
			dir_1 = 1;
			dir_2 = 0;
		end
		
		else if (in0 > max_lim && in1 > max_lim && in2 > max_lim)
		begin
			speed_1 = 5500;
			speed_2 = 5500;
			dir_1 = 1;
			dir_2 = 1;
			r_node <= 1;
		end
		
		else
		begin
			diff_in0 = nm_in0 - in0;
			diff_in1 = nm_in1 - in1;
			diff_in2 = nm_in2 - in2;
			
			speed_1 = 5500 + diff_in0 - diff_in1;
			speed_2 = 5500 + diff_in2 + diff_in1;
			dir_1 = 1;
			dir_2 = 1;
		end
	end
	
	assign speed_l = speed_1;
	assign speed_r = speed_2;
	assign dir_l = dir_1;
	assign dir_r = dir_2;
	assign node = r_node;
	
	

endmodule
			