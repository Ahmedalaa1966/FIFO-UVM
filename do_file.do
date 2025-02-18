vlib work
vlog +define+assertion -f sre_files. list +cover -covercells vsim -voptargs=+acc work.top -classdebug -uvmcontrol=all -cover add wave -position insertpoint sim:/top/fifo_test_vif/* coverage save fifo_tb.ucdb -onexit
run -all
#cover report fifo_tb.ucdb -details -all -output coverage_rpt_fifo.txt