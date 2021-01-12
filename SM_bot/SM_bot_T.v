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
// CREATED		"Mon Jan 11 10:46:00 2021"

module SM_bot_T(
	adc_dout,
	adc_rst,
	cs_data,
	xbee_data_valid,
	pin_name2,
	adc_cs_r,
	adc_din,
	pwm_l1,
	pwm_l2,
	pwm_r1,
	pwm_r2,
	xbee_serial,
	xbee_done,
	cs_s2,
	cs_s3
);


input wire	adc_dout;
input wire	adc_rst;
input wire	cs_data;
input wire	xbee_data_valid;
input wire	pin_name2;
output wire	adc_cs_r;
output wire	adc_din;
output wire	pwm_l1;
output wire	pwm_l2;
output wire	pwm_r1;
output wire	pwm_r2;
output wire	xbee_serial;
output wire	xbee_done;
output wire	cs_s2;
output wire	cs_s3;

wire	[11:0] SYNTHESIZED_WIRE_0;
wire	[11:0] SYNTHESIZED_WIRE_1;
wire	[11:0] SYNTHESIZED_WIRE_2;
wire	SYNTHESIZED_WIRE_3;
wire	SYNTHESIZED_WIRE_4;
wire	SYNTHESIZED_WIRE_5;
wire	SYNTHESIZED_WIRE_6;
wire	[13:0] SYNTHESIZED_WIRE_7;
wire	[13:0] SYNTHESIZED_WIRE_8;
wire	SYNTHESIZED_WIRE_9;
wire	SYNTHESIZED_WIRE_10;
wire	SYNTHESIZED_WIRE_11;
wire	[2:0] SYNTHESIZED_WIRE_12;





Line_follow	b2v_inst(
	.in0(SYNTHESIZED_WIRE_0),
	.in1(SYNTHESIZED_WIRE_1),
	.in2(SYNTHESIZED_WIRE_2),
	.dir_l(SYNTHESIZED_WIRE_4),
	.dir_r(SYNTHESIZED_WIRE_5),
	.node(SYNTHESIZED_WIRE_11),
	.speed_l(SYNTHESIZED_WIRE_7),
	.speed_r(SYNTHESIZED_WIRE_8));
	defparam	b2v_inst.max_lim = 1800;


color_sense	b2v_inst2(
	.clk(SYNTHESIZED_WIRE_3),
	.c_clk(cs_data),
	.s2(cs_s2),
	.s3(cs_s3),
	.color(SYNTHESIZED_WIRE_12));
	defparam	b2v_inst2.B_THRESH_HIGH = 120;
	defparam	b2v_inst2.B_THRESH_LOW = 25;
	defparam	b2v_inst2.BLUE_READ = 3'b110;
	defparam	b2v_inst2.BLUE_START = 3'b101;
	defparam	b2v_inst2.G_THRESH_HIGH = 120;
	defparam	b2v_inst2.G_THRESH_LOW = 25;
	defparam	b2v_inst2.GREEN_READ = 3'b100;
	defparam	b2v_inst2.GREEN_START = 3'b011;
	defparam	b2v_inst2.IDLE = 3'b000;
	defparam	b2v_inst2.R_THRESH_HIGH = 120;
	defparam	b2v_inst2.R_THRESH_LOW = 25;
	defparam	b2v_inst2.RED_READ = 3'b010;
	defparam	b2v_inst2.RED_START = 3'b001;


pwm	b2v_inst3(
	.dir_l(SYNTHESIZED_WIRE_4),
	.dir_r(SYNTHESIZED_WIRE_5),
	.clk(SYNTHESIZED_WIRE_6),
	.speed_l(SYNTHESIZED_WIRE_7),
	.speed_r(SYNTHESIZED_WIRE_8),
	.l_1(pwm_l1),
	.l_2(pwm_l2),
	.r_1(pwm_r1),
	.r_2(pwm_r2));
	defparam	b2v_inst3.NUM_C = 11000;


ADC	b2v_inst4(
	.sclk(SYNTHESIZED_WIRE_9),
	.dout(adc_dout),
	.rst(adc_rst),
	.din(adc_din),
	.CS_n(adc_cs_r),
	.ADC_DATA_CH1(SYNTHESIZED_WIRE_0),
	.ADC_DATA_CH2(SYNTHESIZED_WIRE_1),
	.ADC_DATA_CH3(SYNTHESIZED_WIRE_2));


XBEE_transmit	b2v_inst5(
	.CLOCK(SYNTHESIZED_WIRE_10),
	.TX_DATA_VALID(xbee_data_valid),
	.nodex(SYNTHESIZED_WIRE_11),
	.color(SYNTHESIZED_WIRE_12),
	.O_TX_SERIAL(xbee_serial),
	.O_TX_DONE(xbee_done));
	defparam	b2v_inst5.CHARC = 8'b01000011;
	defparam	b2v_inst5.CHARD = 8'b01000100;
	defparam	b2v_inst5.CHARE = 8'b01000101;
	defparam	b2v_inst5.CHARF = 8'b01000110;
	defparam	b2v_inst5.CHARI = 8'b01001001;
	defparam	b2v_inst5.CHARN = 8'b01001110;
	defparam	b2v_inst5.CHARO = 8'b01001111;
	defparam	b2v_inst5.CHARS = 8'b01010011;
	defparam	b2v_inst5.CHART = 8'b01010100;
	defparam	b2v_inst5.CHARW = 8'b01010111;
	defparam	b2v_inst5.CLEANUP = 3'b101;
	defparam	b2v_inst5.clks_per_bit = 434;
	defparam	b2v_inst5.DASH = 8'b00101101;
	defparam	b2v_inst5.HASH = 8'b00100011;
	defparam	b2v_inst5.IDLE = 3'b000;
	defparam	b2v_inst5.TX_DATA_BITS = 3'b011;
	defparam	b2v_inst5.TX_START_BIT = 3'b001;
	defparam	b2v_inst5.TX_STOP_BIT = 3'b100;
	defparam	b2v_inst5.ZERO = 8'b00110000;


pll_ip	b2v_inst6(
	.inclk0(pin_name2),
	.c0(SYNTHESIZED_WIRE_6),
	.c1(SYNTHESIZED_WIRE_3),
	.c2(SYNTHESIZED_WIRE_10),
	.c3(SYNTHESIZED_WIRE_9));


endmodule
