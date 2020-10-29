transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/amshra267/4_Bit_Comparator {/home/amshra267/4_Bit_Comparator/Four_Bit_Comparator_verilog.v}
vlog -vlog01compat -work work +incdir+/home/amshra267/4_Bit_Comparator {/home/amshra267/4_Bit_Comparator/Two_Bit_Comparator.v}

vlog -sv -work work +incdir+/home/amshra267/4_Bit_Comparator {/home/amshra267/4_Bit_Comparator/Comparator_4_bit_tb_Vector.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  Comparator_4_bit_tb_Vector

add wave *
view structure
view signals
run 320 ns
