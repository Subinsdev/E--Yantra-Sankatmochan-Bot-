// Sankatmochan Bot : Task 1 A : 4Bit Comparator
/*
Instructions
-------------------
Students are not allowed to make any changes in the Module declaration.
This file is used to design 2 bit comparator.

Recommended Quartus Version : 19.1
The submitted project file must be 19.1 compatible as the evaluation will be done on Quartus Prime Lite 19.1.

Warning: The error due to compatibility will not be entertained.
			Do not make any changes to Test_Bench_Vector.txt file. Violating will result into Disqualification.
-------------------
*/

//2 bit comparator design
//Inputs (2 bit): A1,A0,B1,B0
//Outputs : A_Greater (A>B), Equal (A=B), B_Greater (A<B)

//////////////////DO NOT MAKE ANY CHANGES IN MODULE//////////////////
module Two_Bit_Comparator(
	input		A1,               //MSB OF INPUT A   
	input		A0,					//LSB OF INPUT A
	input		B1,					//MSB OF INPUT B
	input		B0,					//LSB OF INPUT B					
	output	A_Greater,			//OUTPUT BIT A>B
	output	Equal,				//OUTPUT BIT A=B
	output	B_Greater			//OUTPUT BIT A<B
);

////////////////////////WRITE YOUR CODE FROM HERE//////////////////// 
	wire w1, w2, w3, w4, w5, w6;
	
	//for Equal
	xnor o1(w1, A0, B0);  // Applying xnor relation on LSB, logic will be 1 when both A0,B0 are either 1 or 0
	xnor o2(w2, A1, B1);  // Applying xnor relation on MSB, logic will be 1 when both A1,B1 are either 1 or 0
	
	assign Equal = w2 & w1 ; // finaly if both are 1 then the no. are equal
	
	//For A_Greater
	assign w3 =  A1 & (~B1);  // if MSB of A greater than MSB of B then 1
   assign w4 = w2 & A0 & (~B0);  // if MSB of A = MSB of B but A0 greater than B0 then true
   assign A_Greater = w3 | w4 ;  // or of both either one make overall true

   //For B_greater
   assign w5 =  (~A1) & B1;  // if MSB of A less than MSB of B then 1
   assign w6 = w2 & (~A0) & B0;  // if MSB of A = MSB of B but A0 less than B0 then true
   assign B_Greater = w5 | w6 ;  // or of both either one make overall true

   	
  

////////////////////////YOUR CODE ENDS HERE//////////////////////////
endmodule
///////////////////////////////MODULE ENDS///////////////////////////