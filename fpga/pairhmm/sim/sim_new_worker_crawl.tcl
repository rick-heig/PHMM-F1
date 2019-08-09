# Packages
vlog -sv ../design/cl_pairhmm_package.vh
# Interfaces
vlog -sv ../design/cl_interfaces.sv
# DUT
vlog -sv +incdir+../design ../design/cl_pairhmm_new_worker_core_synth.sv
# Sim files
vlog -sv +incdir+../design sim_simple_rom_from_file_bram_interface.sv
vlog -sv +incdir+../design sim_compute_engine_fifo_if.sv
# TB
vlog -sv +incdir+../design sim_new_worker_tb.sv

# Start Simulation
vsim -voptargs=+acc work.sim_new_worker_tb

# Add waves
add wave -position insertpoint  \
    sim:/sim_new_worker_tb/dut/mcr/jump \
    sim:/sim_new_worker_tb/dut/mcr/position_reg \
    sim:/sim_new_worker_tb/dut/mcr/jump_reg \
    sim:/sim_new_worker_tb/dut/clock_i \
    sim:/sim_new_worker_tb/dut/reset_i \
    sim:/sim_new_worker_tb/dut/enable_i \
    sim:/sim_new_worker_tb/dut/read_len_i \
    sim:/sim_new_worker_tb/dut/hap_len_i \
    sim:/sim_new_worker_tb/dut/INITIAL_POSITION \
    sim:/sim_new_worker_tb/dut/matrix_dimensions \
    sim:/sim_new_worker_tb/dut/left_result_reg \
    sim:/sim_new_worker_tb/dut/left_result_valid_reg \
    sim:/sim_new_worker_tb/dut/top_result_reg \
    sim:/sim_new_worker_tb/dut/top_result_valid_reg \
    sim:/sim_new_worker_tb/dut/left_temps \
    sim:/sim_new_worker_tb/dut/send_compute_request \
    sim:/sim_new_worker_tb/dut/update_left_result \
    sim:/sim_new_worker_tb/dut/update_top_result \
    sim:/sim_new_worker_tb/dut/left_result_valid \
    sim:/sim_new_worker_tb/dut/read_result_fifo \
    sim:/sim_new_worker_tb/dut/top_result_valid \
    sim:/sim_new_worker_tb/dut/final_result_write_reg \
    sim:/sim_new_worker_tb/dut/final_result_reg \
    sim:/sim_new_worker_tb/dut/left_ready \
    sim:/sim_new_worker_tb/dut/top_ready \
    sim:/sim_new_worker_tb/dut/read_read_addr \
    sim:/sim_new_worker_tb/dut/hap_read_addr
add wave -position insertpoint -radix float32 \
    sim:/sim_new_worker_tb/compute_request_bus/write_data \
    sim:/sim_new_worker_tb/compute_result_bus/read_data

# run
run 500 ns
