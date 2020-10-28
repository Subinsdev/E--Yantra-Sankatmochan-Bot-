`timescale 1ns/1ns

module Binary_to_Ascii_tb_Vector;

logic clk;
logic [11:0]int_part;
logic [7:0]dec_part;
logic [31:0]int_ascii;
logic [15:0]dec_ascii;

logic [31:0]Expected_Output_int;
logic [15:0]Expected_Output_dec;
logic i;

logic error_int;
logic error_dec;

integer file_id;

Binary_to_Ascii uut(
	.int_part(int_part),
	.dec_part(dec_part),
	.int_ascii(int_ascii),
	.dec_ascii(dec_ascii),
	.clk(clk)
);


logic [67:0] test_vector[1:0];

initial
	begin
	$readmemb("Test_Bench_Vector.txt", test_vector); 
	i = 0;
	error_int = 0;
	error_dec = 0;
	{int_part , dec_part ,  Expected_Output_int , Expected_Output_dec} <= test_vector[i];
end

always@(posedge clk)
	begin
	//#150;

//	{int_part , dec_part ,  Expected_Output_int , Expected_Output_dec} <= test_vector[i];
	//$display ("Input = %d", {int_part} ," Output = %b", {Expected_Output_int});
	#110;
	if(Expected_Output_dec !== dec_ascii)
			begin
				$display ("Wrong Output for Decimal Input");
				error_dec = 1;
			end
	#50;
		if(Expected_Output_int !== int_ascii)
			begin
				$display ("Wrong Output for Integer Input");
				error_int = 1;
			end
		
		if (error_int == 0 & error_dec == 0)
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
			//$stop;
		end		

always
	begin
		clk <= 1; #5;
		clk <= 0; #5;
	end
endmodule
