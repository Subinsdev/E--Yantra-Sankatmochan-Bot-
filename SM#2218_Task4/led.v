module led(
				input [2:0]color,
				input rst,
				output reg r,
				output reg g,
				output reg b
);
	always@( color or rst)
	begin
		if(rst == 0)
		begin
			r <= 1;
			g <= 1;
			b <= 1;
		end
		else
		begin
			if(color == 1)
			begin
				r <= 0;
				g <= 1;
				b <= 1;
			end
			else if(color == 2)
			begin
				r <= 1;
				g <= 0;
				b <= 1;
			end
			else if(color == 3)
			begin
				r <= 1;
				g <= 1;
				b <= 0;
			end
		end
	end 
endmodule 