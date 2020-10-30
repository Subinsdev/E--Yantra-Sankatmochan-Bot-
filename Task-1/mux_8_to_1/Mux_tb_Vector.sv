`timescale 1ns/1ns

module Mux_tb_Vector;

logic A;
logic B;
logic C;
logic D;
logic Output;

logic Expected_Output;
logic [5:0]i;

logic [3:0]error;

integer file_id;
integer file_id_en;
integer file_id_1 = "Prasad";

mux_8_to_1_bdf uut(
	.A(A),
	.B(B),
	.C(C),
	.D(D),
	.Y(Output)
);


logic[4:0] test_vector[15:0];

initial
	begin
	$readmemb("Test_Bench_Vector.txt", test_vector); 
	$display ("Minterms(0,1,6,7,8,11,12,15)");
	i = 0;
	error = 0;

end

always
	begin
	//#10;

	{A , B , C , D, Expected_Output} = test_vector[i];
	$display ("Minterm = ", {A, B, C, D}, " Expected_Output = ", {Expected_Output});	
	
	#10;
		if(Expected_Output !== Output)
			begin
				$display ("Wrong Output for Input");
				error = error + 1;
			end
		i = i + 1;
		if (i==16)
			begin
				if (error == 0)
				begin
					file_id = $fopen("Test.txt","w");
					file_id_en = file_id ^ file_id_1;
					$fwrite(file_id, "%02h","CONGRATULATIONS YOUR DESIGN WORKS FINE", "%02h",{file_id_en} );
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
endmodule
