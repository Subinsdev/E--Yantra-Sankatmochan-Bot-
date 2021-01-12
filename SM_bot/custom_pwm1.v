// Copyright (C) 2019  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and any partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 19.1.0 Build 670 09/22/2019 SJ Lite Edition"
// CREATED		"Tue Jan 12 14:22:53 2021"

module custom_pwm1(
	CLK_50,
	L1,
	L2,
	R1,
	R2
);


input wire	CLK_50;
output wire	L1;
output wire	L2;
output wire	R1;
output wire	R2;

wire	SYNTHESIZED_WIRE_0;





custom_pwm	b2v_inst(
	.clk(SYNTHESIZED_WIRE_0),
	.l_1(L1),
	.l_2(L2),
	.r_1(R1),
	.r_2(R2));
	defparam	b2v_inst.NUM_C = 11000;


pll_1	b2v_inst1(
	.inclk0(CLK_50),
	.c0(SYNTHESIZED_WIRE_0));


endmodule
