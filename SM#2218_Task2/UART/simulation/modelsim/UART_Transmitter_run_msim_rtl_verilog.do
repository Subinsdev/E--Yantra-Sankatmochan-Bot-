transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/dell\ pc/Documents/e-yantra/UART\ Transmitter {C:/Users/dell pc/Documents/e-yantra/UART Transmitter/UART_Transmitter.v}

