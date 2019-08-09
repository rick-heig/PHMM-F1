# Packages
vlog -sv ../design/cl_pairhmm_package.vh
# Interfaces
vlog -sv ../design/cl_interfaces.sv
# DUT
vlog -sv +incdir+../design ../design/cl_pairhmm_worker_core.sv
# SIM files
vlog -sv +incdir+../design sim_compute_engine.sv
vlog -sv sim_simple_rom_from_file_bram_interface.sv
# TB
vlog -sv +incdir+../design sim_worker_tb.sv

# Start Simulation
vsim -voptargs=+acc work.sim_worker_tb

# Add waves

add wave -position insertpoint  \
sim:/sim_worker_tb/dut/clock_i \
sim:/sim_worker_tb/dut/reset_i \
sim:/sim_worker_tb/dut/enable_i \
sim:/sim_worker_tb/dut/read_len_i \
sim:/sim_worker_tb/dut/read_pos_o \
sim:/sim_worker_tb/dut/read_read_o \
sim:/sim_worker_tb/dut/read_base_i \
sim:/sim_worker_tb/dut/read_q_i \
sim:/sim_worker_tb/dut/read_i_i \
sim:/sim_worker_tb/dut/read_d_i \
sim:/sim_worker_tb/dut/read_c_i \
sim:/sim_worker_tb/dut/hap_len_i \
sim:/sim_worker_tb/dut/hap_pos_o \
sim:/sim_worker_tb/dut/hap_read_o \
sim:/sim_worker_tb/dut/hap_base_i \
sim:/sim_worker_tb/dut/compute_ready_i \
sim:/sim_worker_tb/dut/request_o \
sim:/sim_worker_tb/dut/write_req_o \
sim:/sim_worker_tb/dut/result_ready_i \
sim:/sim_worker_tb/dut/result_i \
sim:/sim_worker_tb/dut/result_o \
sim:/sim_worker_tb/dut/result_valid_o \
sim:/sim_worker_tb/dut/temporary_result_ready \
sim:/sim_worker_tb/dut/temporary_results \
sim:/sim_worker_tb/dut/temporary_circular_buffer \
sim:/sim_worker_tb/dut/temporary_from_circular_buffer \
sim:/sim_worker_tb/dut/INITIAL_POSITION \
sim:/sim_worker_tb/dut/matrix_dimensions \
sim:/sim_worker_tb/dut/mcr_position_reg \
sim:/sim_worker_tb/dut/mcr_position_next \
sim:/sim_worker_tb/dut/mcr_move \
sim:/sim_worker_tb/dut/mfr_position_reg \
sim:/sim_worker_tb/dut/mfr_position_next \
sim:/sim_worker_tb/dut/mfr_move \
sim:/sim_worker_tb/dut/send_compute_req \
sim:/sim_worker_tb/dut/mcr_in_matrix \
sim:/sim_worker_tb/dut/left_ready \
sim:/sim_worker_tb/dut/store_result \
sim:/sim_worker_tb/dut/mfr_in_matrix \
sim:/sim_worker_tb/dut/top_index \
sim:/sim_worker_tb/dut/left_index \
sim:/sim_worker_tb/read_result_obs

add wave -position insertpoint  \
sim:/sim_worker_tb/compute_core/clock_i \
sim:/sim_worker_tb/compute_core/reset_i \
sim:/sim_worker_tb/compute_core/request_i \
sim:/sim_worker_tb/compute_core/request_valid_i \
sim:/sim_worker_tb/compute_core/compute_engine_ready_o \
sim:/sim_worker_tb/compute_core/result_o \
sim:/sim_worker_tb/compute_core/result_valid_o

# Run
run 3 us
