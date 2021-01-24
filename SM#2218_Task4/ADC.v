// verilog code for creating 3- channel ADC module

/* Some important considerations
 * The channel selected in our design are 0,1,2 
 *	in binary 000,001,010 means MSB is 0 for all,
 *	16 clock cycles, count_pulses is started from 0-15
 *	then again from 0-15 and 
 *	continuously in same manner
*/


module ADC( input sclk,
            input dout,
				input rst,
				output reg din,
				output CS_n,
				output reg [11:0] ADC_DATA_CH0, ADC_DATA_CH1, ADC_DATA_CH2 
				
			);
			

	// clk required of frequency = 3 MHz		
	wire          trigger;        // variable for starting the timing of sampling the address input		                
	reg  [11:0]   register;			// 12 bit internal register
	reg  [4:0]    sclk_count;     // variable for counting clock pulses
	reg  [1:0]    sample_addr;    // variable used for channel sample



	assign trigger = (sclk_count == 4'b0001);
	assign CS_n = 0; // assigning 0 to make the data continuously reading

	/*setting clock count
	  for a period of 16 cycles from 
	  4'b0000 to 4'b1111
	*/  
				
	 always @ (posedge sclk or negedge rst) begin
		 if (!rst)
			 sclk_count <= 4'b0000;
		 else if (CS_n)
			 sclk_count <= 4'b0000;  // if CS_n is high then it will be disconnected with on board ADC
			 
		 else if (sclk_count == 4'b1111)
			 sclk_count <= 4'b0000;  /* considering one more general case
												when neither cs nor reset is high
												but 16th clock cycle completed
												then assign it 0 to start same process again*/
		 
		 else
			 sclk_count <= sclk_count + 1'b1; // incrementing clock cycles
		
	end


	/* Handle address incrementing to cycle through all 
	3 channels */

	 always @ (posedge trigger or negedge rst) begin
		 if (!rst) 
			 sample_addr <= 2'b00;
		 else if(sample_addr == 2'b10)  // if the sample_addr becomes 2 then it will again becomes 0 and so on 0,1,2 cycles goes on
		    sample_addr <= 0;
		 else
			 sample_addr <= sample_addr + 1'b1;
	end

	/* Now outputting the din at negative edge 
		with sclk_count 2,3,4
		bit 2 is always 0 for 0,1,2 channel 
		hence taken in default
	*/

	 always @ (negedge sclk) begin 
		 case (sclk_count)
			 4'b0011 : din <= sample_addr[1];  // 2nd bit
			 4'b0100 : din <= sample_addr[0];  // 3rd bit
			 default : din <= 1'b0;	           // 1st bit 0 in default
		 endcase	
	end	
		
	// convert serial data into a parallel one by storing in internal register using 12-bit shift register	
			
	always @ (posedge sclk or negedge rst) begin
	  if (!rst)
			register <= 12'd0;
	  else begin
		 casez (sclk_count)
			4'b01??, 4'b1???: register <= {register[10:0],dout};  //from 5 to 16
		 endcase	 	 
	  end	  
	end
		 
	/* block for assigning data to address channel 
	corresponding to previous operational frame
	for example- in previous frame address is of channel 2 then the parallel data of present frame is assigned to ADC_DATA_CH2 and same for other cases.
	 */ 
	always @ (posedge sclk or negedge rst) begin

	  if (!rst) begin
			ADC_DATA_CH0 <= 12'd0;
			ADC_DATA_CH1 <= 12'd0;
			ADC_DATA_CH2 <= 12'd0;
	  end    

	  else if (sclk_count == 4'b1111) begin
			case(sample_addr)
			  2'b00 : ADC_DATA_CH2 <= register; // if present channel is 0 means the previous is 2 so assigned it to channel 2
			  2'b01 : ADC_DATA_CH0 <= register; // if present channel is 1 means the previous is 0 so assigned it to channel 0
			  2'b10 : ADC_DATA_CH1 <= register; // if present channel is 2 means the previous is 1 so assigned it to channel 1
			endcase  
	  end
	end

endmodule 