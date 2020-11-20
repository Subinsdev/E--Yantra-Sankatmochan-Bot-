transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/amshra/E--Yantra-Sankatmochan-Bot-/Task-1/Binary_to_Ascii {/home/amshra/E--Yantra-Sankatmochan-Bot-/Task-1/Binary_to_Ascii/Binary_to_Ascii.v}

vlog -sv -work work +incdir+/home/amshra/E--Yantra-Sankatmochan-Bot-/Task-1/Binary_to_Ascii {/home/amshra/E--Yantra-Sankatmochan-Bot-/Task-1/Binary_to_Ascii/Binary_to_Ascii_tb_Vector.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  Binary_to_Ascii_tb_Vector

add wave *
view structure
view signals
run 160 ns
