onerror {exit -code 1}
vlib work
vlog -work work Four_Bit_Comparator.vo
vlog -work work Two_bit_VWF.vwf.vt
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate_ver -L altera_lnsim_ver work.Two_Bit_Comparator_vlg_vec_tst
vcd file -direction 4_Bit_Comparator.msim.vcd
vcd add -internal Two_Bit_Comparator_vlg_vec_tst/*
vcd add -internal Two_Bit_Comparator_vlg_vec_tst/i1/*
proc simTimestamp {} {
    echo "Simulation time: $::now ps"
    if { [string equal running [runStatus]] } {
        after 2500 simTimestamp
    }
}
after 2500 simTimestamp
run -all
quit -f
