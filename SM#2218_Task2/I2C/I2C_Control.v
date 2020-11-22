
module I2C_Control(
		input clk,
		input rst,
		input core_busy,
		output data_valid,
		output rw,
		output wire [6:0]slave_addr,
		output wire [7:0]reg_addr,
		output wire [7:0]reg_data);
	parameter IDLE = 3'b000;
	parameter SET_RESOLUTION = 3'b001;
	parameter WAIT_1_CYCLE_1 = 3'b010;
	parameter START_OPERATION = 3'b011;
	parameter WAIT_1_CYCLE_2 = 3'b100;
	parameter READ_DATA = 3'b101;
	reg [2:0]r_state = IDLE;
	reg r_data_valid = 0;
	reg r_rw = 0;
	reg flag = 0;
	// for setting resolution data_format register with data 00001100 address 49
	// for start operation power_ctl register with data 00001000 address 45
	// for reading data two registers 50, 51
	reg [6:0]r_slave_addr = 83;
	reg [7:0]r_reg_addr = 0;
	reg [7:0]r_reg_data = 0;
	
	assign rw = r_rw;// read data from accelerometer
	assign data_valid = r_data_valid;
	assign slave_addr = r_slave_addr;
	assign reg_addr = r_reg_addr;
	assign reg_data = r_reg_data;
	
	always @(posedge clk, negedge rst)
		begin
			if (rst == 0)
				begin
					r_state = IDLE;
				end
			else
				begin
					case(r_state)
							IDLE :
								begin
									r_reg_addr <= 0;
									r_reg_data <= 0;
									r_data_valid <= 0;
									r_state = SET_RESOLUTION;
								end
							SET_RESOLUTION :
								begin
									if (core_busy == 0)
										begin
											r_data_valid = 1;
											r_rw = 1;
											r_reg_addr = 49;
											r_reg_data = 8'b00001100;
											r_state = WAIT_1_CYCLE_1;
										end
									else
										begin
											r_data_valid <= 0;
											r_state = SET_RESOLUTION;
										end
								end
							WAIT_1_CYCLE_1 :
								begin
									r_state = START_OPERATION;
								end
							START_OPERATION :
								begin
									if (core_busy == 0)
										begin
											r_data_valid = 1;
											r_rw = 1;
											r_reg_addr = 45;
											r_reg_data = 8'b00001000;
											r_state = WAIT_1_CYCLE_2;
										end
									else
										begin
											r_data_valid <= 0;
											r_state = START_OPERATION;
										end
								end
							WAIT_1_CYCLE_2 :
								begin
									r_state = READ_DATA;
								end
							READ_DATA :
								begin
									if (core_busy == 0)
										begin
											r_data_valid = 1;
											r_rw = 1;
											if (flag == 0)
												begin
													r_reg_addr = 51;
													flag = 1;
												end
											else
												begin
													r_reg_addr = 50;
													flag = 0;
												end
										end
									else
										r_data_valid <= 0;
									r_state = READ_DATA;
								end
					endcase
				end
		end
endmodule
	