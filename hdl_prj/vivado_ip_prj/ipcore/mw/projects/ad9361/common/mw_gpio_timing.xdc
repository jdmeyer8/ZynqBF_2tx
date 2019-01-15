# Set false paths from the user logic to the I/O clock sync registers
set_false_path -from [get_clocks clk_div_sel*] -to [get_cells -hierarchical *up_enable_int*]
set_false_path -from [get_clocks clk_div_sel*] -to [get_cells -hierarchical *up_txnrx_int*]