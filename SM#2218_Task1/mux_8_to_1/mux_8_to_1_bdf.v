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
// CREATED		"Thu Oct 29 16:10:18 2020"

module mux_8_to_1_bdf(
	A,
	B,
	C,
	D,
	Y
);


input wire	A;
input wire	B;
input wire	C;
input wire	D;
output wire	Y;

wire	SYNTHESIZED_WIRE_7;
wire	SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;





mux_4_to_1	b2v_inst(
	.i3(SYNTHESIZED_WIRE_7),
	.i2(A),
	.i1(A),
	.i0(SYNTHESIZED_WIRE_7),
	.s1(C),
	.s0(B),
	.en(SYNTHESIZED_WIRE_7),
	.y(SYNTHESIZED_WIRE_6));


mux_4_to_1	b2v_inst1(
	.i3(SYNTHESIZED_WIRE_8),
	.i2(D),
	.i1(SYNTHESIZED_WIRE_8),
	.i0(D),
	.s1(C),
	.s0(B),
	.en(A),
	.y(SYNTHESIZED_WIRE_5));

assign	SYNTHESIZED_WIRE_7 =  ~A;

assign	SYNTHESIZED_WIRE_8 =  ~D;

assign	Y = SYNTHESIZED_WIRE_5 | SYNTHESIZED_WIRE_6;


endmodule
