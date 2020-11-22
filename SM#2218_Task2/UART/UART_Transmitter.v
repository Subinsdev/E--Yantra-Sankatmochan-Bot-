module UART_Transmitter(
				input CLOCK,
				input TX_DATA_VALID,
				input [7:0]TX_BYTE,
				output reg O_TX_SERIAL,
				output O_TX_DONE);

	parameter clks_per_bit = 434;
	parameter IDLE = 3'b000;
	parameter TX_START_BIT = 3'B001;
	parameter TX_DATA_BITS = 3'b011;
	parameter TX_STOP_BIT = 3'b100;
	parameter CLEANUP = 3'b101;
	
	reg [2:0]next;
	reg [2:0]r_state = IDLE;
	reg [8:0]r_clock_count = 0;
	reg [2:0]r_bit_index = 0;
	reg [7:0]r_data_bits = 0;
	reg r_TX_DONE = 0;
	
	always @(posedge CLOCK)
	begin
		case(r_state)
			IDLE :
				begin
					r_clock_count = 0;
					r_bit_index = 0;
					O_TX_SERIAL <= 1'b1;
					r_TX_DONE <= 1'b1;
					if(TX_DATA_VALID)
					begin
						r_state <= TX_START_BIT;
					end
					else
						r_state <= IDLE;
				end
				
			TX_START_BIT :
				begin
					O_TX_SERIAL <= 0;
					r_TX_DONE <= 0;
					if(r_clock_count < clks_per_bit-1)
					begin
						r_clock_count <= r_clock_count + 1'b1;
						r_state <= TX_START_BIT;
					end
					else
					begin
						r_clock_count <= 0;
						r_state <= TX_DATA_BITS;
						if (next == 0)
							r_data_bits = 8'b01010011;
						else if (next == 1)
							r_data_bits = 8'b01001101;
						else if (next == 2)
							r_data_bits = 8'b00000001;
						else
							r_data_bits = 8'b00001000;
					end
				end
				
			TX_DATA_BITS :
				begin
					O_TX_SERIAL <= r_data_bits[r_bit_index];
					
					if(r_clock_count < clks_per_bit-1)
					begin
						r_clock_count <= r_clock_count + 1'b1;
						r_state <= TX_DATA_BITS;
					end
					else
					begin
						if(r_bit_index == 7)
						begin
							r_clock_count <= 0;
							r_state <= TX_STOP_BIT;
						end
						else
						begin
							r_clock_count <= 0;
							r_state <= TX_DATA_BITS;
							r_bit_index <= r_bit_index + 1'b1;
						end
					end
				end
			
			TX_STOP_BIT :
				begin
					O_TX_SERIAL <= 1;
					r_TX_DONE <= 1;
					if(r_clock_count < clks_per_bit-1)
					begin
						r_clock_count <= r_clock_count + 1'b1;
						r_state <= TX_STOP_BIT;
					end
					else
					begin
						r_state = CLEANUP;
					end
				end
			
			CLEANUP :
				begin
					r_clock_count <= 0;
					r_bit_index <= 0;
					r_state <= IDLE;
					next = next + 1'b1;
				end
				
			default :
				begin
					r_state <= IDLE;
				end
				
		endcase
	end
	
	assign O_TX_DONE = r_TX_DONE;

endmodule 