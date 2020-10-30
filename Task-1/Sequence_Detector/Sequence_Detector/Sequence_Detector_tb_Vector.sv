`timescale 1ns/1ns

module Sequence_Detector_tb_Vector;

logic Input;
logic clk;
logic Output;

logic Expected_Output;
logic [5:0]i;

logic [3:0]error;

integer file_id;

sequence_detector_fsm uut(
	.Clk(clk),
	.X(Input),
	.Y(Output)
);


logic[1:0] test_vector[15:0];

initial
	begin
	$readmemb("Test_Bench_Vector.txt", test_vector); 
	i = 0;
	error = 0;
	end

always@(posedge clk)
	begin
		#10;
		{Input , Expected_Output} = test_vector[i];
		$display ( "Input = %b ", {Input} ,"Output = %b ", {Expected_Output});
	end	
	
always@(negedge clk)
	begin
		#10;
		if(Expected_Output !== Output)
			begin
				$display ("Wrong Output for Input: Input = %b, Expected Output(%b) != Output(%b)", {Input} , {Expected_Output} , {Output});
				error = error + 1;
			end
		i = i + 1;
		if (i==16)
			begin
				if (error == 0)
				begin
					file_id = $fopen("Test.txt","w");
					$fwrite(file_id, "%02h","CONGRATULATIONS YOUR DESIGN WORKS FINE", "%02h",{file_id} );
					$fclose(file_id);
					$display ("CONGRATULATIONS YOUR DESIGN WORKS FINE");
				end
				else
				begin
					file_id = $fopen("Test.txt","w");
					$fwrite(file_id, "%02h","ERROR ENCOUNTERED IN YOUR DESIGN", "%02h",{file_id} );
					$fclose(file_id);
					$display ("ERROR ENCOUNTERED IN YOUR DESIGN");
				end
				i = 0;
		//$stop;
		end
	end
	
//always@(negedge clk)
//	begin
//		if (i==16)
//			begin
//				if (error == 0)
//				begin
//					$display ("CONGRATULATIONS YOUR DESIGN WORKS FINE");
//				end
//				else
//				begin
//					$display ("ERROR ENCOUNTERED AT YOUR DESIGN");
//				end
//				i = 0;
//		$stop;
//		end
//	end
//	
always
	begin
		clk <= 1; #5;
		clk <= 0; #5;
	end

	
endmodule
