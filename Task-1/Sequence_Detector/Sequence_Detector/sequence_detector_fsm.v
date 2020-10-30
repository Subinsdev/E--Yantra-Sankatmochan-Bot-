// Sankatmochan Bot : Task 1 C : FSM
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design a Finite State Machine to detect patter/sequence 1100

Recommended Quartus Version : 19.1
The submitted project file must be 19.1 compatible as the evaluation will be done on Quartus Prime Lite 19.1.

Warning: The error due to compatibility will not be entertained.
			Do not make any changes to Test_Bench_Vector.txt file. Violating will result into Disqualification.
-------------------
*/

//Finite State Machine design
//Inputs : Clock, X (Input Stream)
//Output : Y (Y = 1 when 1100 pattern/sequence is detected)

//////////////////DO NOT MAKE ANY CHANGES IN MODULE///////////////////////////////
module sequence_detector_fsm(
		input Clk,		//Clock input
		input X,			//Input Bitstream 
		output Y			//Output: Y = 1 when 1100 pattern/sequence is detected.	
);

////////////////////////WRITE YOUR CODE FROM HERE////////////////////


parameter s0=3'b000,s1=3'b001,s2=3'b010,s3=3'b011,s4=3'b100;

reg[2:0] curr=s0;

always @(posedge Clk)

	begin

		case(curr)
		
			s0:
				begin
				
					if(X) curr <= s1;
					else curr <= s0;
				
				end
				
			s1:
				begin
				
					if(X) curr <= s2;
					else curr <= s0;
				
				end
				
			s2:
				begin
				
					if(X) curr = s2;
					else curr = s3;
				
				end
				
			s3:
				begin
				
					if(X) curr <= s1;
					else curr <= s4;
				
				end
				
			s4:
				begin
				
					if(X)curr <= s1;
					else curr<=s0;
				
				end
				
			endcase

	end
	
assign Y = curr==s4 ? 1 : 0;

// Tip : Write your code such that Quartus Generates a State Machine 
//			(Tools > Netlist Viewers > State Machine Viewer).
// 		For doing so, you will have to properly declare State Variables of the
//       State Machine and also perform State Assignments correctly.  
	
///////////////////////YOUR CODE ENDS HERE////////////////////////////
endmodule
///////////////////////////////MODULE ENDS///////////////////////////