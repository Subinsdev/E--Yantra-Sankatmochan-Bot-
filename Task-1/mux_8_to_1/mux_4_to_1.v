// Sankatmochan Bot : Task 1 B : Multiplexer
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design a 4:1 multiplexer.

Recommended Quartus Version : 19.1
The submitted project file must be 19.1 compatible as the evaluation will be done on Quartus Prime Lite 19.1.

Warning: The error due to compatibility will not be entertained.
			Do not make any changes to Test_Bench_Vector.txt file. Violating will result into Disqualification.
-------------------
*/

//4:1 multiplexer
//Inputs : 4 inputs - i3 to i0, 2 select lines - s1 and s0, enable input - en.
//Output : y

//////////////////DO NOT MAKE ANY CHANGES IN MODULE///////////////////////////////
module mux_4_to_1(
	input i3,i2,i1,i0,         //Inputs
	input s1,s0,               //Select Lines
	input en,                  //enable
	output y                   //output
	);
	
////////////////////////WRITE YOUR CODE FROM HERE////////////////////
	
	wire s0_nt ;
	wire s1_nt ;
	
	
	assign s0_nt = ~s0;
	assign s1_nt = ~s1;
			
	assign y = (i3 & s0_nt & s1_nt & en) | (i2 & s0_nt & s1 & en) | (i1 & s0 & s1_nt & en) | (i0 & s0 & s1 & en);
	
///////////////////////YOUR CODE ENDS HERE////////////////////////////
endmodule
///////////////////////////////MODULE ENDS///////////////////////////