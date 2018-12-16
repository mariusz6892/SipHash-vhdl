transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/MarWin/Desktop/SEMESTR 8/MUC/FPGACOMMEXAMPLE2/RS232_INTERFACE_PKG.vhd}
vcom -93 -work work {C:/Users/MarWin/Desktop/SEMESTR 8/MUC/FPGACOMMEXAMPLE2/BINTOASCII.vhd}
vcom -93 -work work {C:/Users/MarWin/Desktop/SEMESTR 8/MUC/FPGACOMMEXAMPLE2/ASCIITOBIN.vhd}
vcom -93 -work work {C:/Users/MarWin/Desktop/SEMESTR 8/MUC/FPGACOMMEXAMPLE2/SIPROUND.vhd}
vcom -93 -work work {C:/Users/MarWin/Desktop/SEMESTR 8/MUC/FPGACOMMEXAMPLE2/EXAMPLE2.vhd}
vcom -93 -work work {C:/Users/MarWin/Desktop/SEMESTR 8/MUC/FPGACOMMEXAMPLE2/COMMAND_CONTROL.vhd}
vcom -93 -work work {C:/Users/MarWin/Desktop/SEMESTR 8/MUC/FPGACOMMEXAMPLE2/SIPHASHSTATES.vhd}
vcom -93 -work work {C:/Users/MarWin/Desktop/SEMESTR 8/MUC/FPGACOMMEXAMPLE2/RS232_STANDARD_INTERFACE.vhd}
vcom -93 -work work {C:/Users/MarWin/Desktop/SEMESTR 8/MUC/FPGACOMMEXAMPLE2/RS232_RECEIVER.vhd}
vcom -93 -work work {C:/Users/MarWin/Desktop/SEMESTR 8/MUC/FPGACOMMEXAMPLE2/RS232_MEMORY.vhd}
vcom -93 -work work {C:/Users/MarWin/Desktop/SEMESTR 8/MUC/FPGACOMMEXAMPLE2/RS232_INTERFACE.vhd}
vcom -93 -work work {C:/Users/MarWin/Desktop/SEMESTR 8/MUC/FPGACOMMEXAMPLE2/FPGAX.vhd}
vcom -93 -work work {C:/Users/MarWin/Desktop/SEMESTR 8/MUC/FPGACOMMEXAMPLE2/FPGAY.vhd}
vcom -93 -work work {C:/Users/MarWin/Desktop/SEMESTR 8/MUC/FPGACOMMEXAMPLE2/FPGAY_TB.vhd}
vcom -93 -work work {C:/Users/MarWin/Desktop/SEMESTR 8/MUC/FPGACOMMEXAMPLE2/EXAMPLE2_TB.vhd}
vcom -93 -work work {C:/Users/MarWin/Desktop/SEMESTR 8/MUC/FPGACOMMEXAMPLE2/SIPHASHSTATES_TB.vhd}
vcom -93 -work work {C:/Users/MarWin/Desktop/SEMESTR 8/MUC/FPGACOMMEXAMPLE2/SIPROUND_TB.vhd}
vcom -93 -work work {C:/Users/MarWin/Desktop/SEMESTR 8/MUC/FPGACOMMEXAMPLE2/RS232_TRANSMITTER.vhd}

