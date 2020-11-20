transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/dell\ pc/Documents/e-yantra/mux_8_to_1 {C:/Users/dell pc/Documents/e-yantra/mux_8_to_1/mux_8_to_1_bdf.v}
vlog -vlog01compat -work work +incdir+C:/Users/dell\ pc/Documents/e-yantra/mux_8_to_1 {C:/Users/dell pc/Documents/e-yantra/mux_8_to_1/mux_4_to_1.v}

vlog -sv -work work +incdir+C:/Users/dell\ pc/Documents/e-yantra/mux_8_to_1 {C:/Users/dell pc/Documents/e-yantra/mux_8_to_1/Mux_tb_Vector.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  Mux_tb_Vector

add wave *
view structure
view signals
run 160 ns
