onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /sim_cached_worker_tb/dut_pairhmm_worker/worker/clock_i
add wave -noupdate /sim_cached_worker_tb/dut_pairhmm_worker/worker/reset_i
add wave -noupdate /sim_cached_worker_tb/dut_pairhmm_worker/worker/enable_i
add wave -noupdate /sim_cached_worker_tb/dut_pairhmm_worker/worker/read_len_i
add wave -noupdate /sim_cached_worker_tb/dut_pairhmm_worker/worker/hap_len_i
add wave -noupdate /sim_cached_worker_tb/dut_pairhmm_worker/worker/initial_condition_i
add wave -noupdate /sim_cached_worker_tb/dut_pairhmm_worker/worker/INITIAL_POSITION
add wave -noupdate /sim_cached_worker_tb/dut_pairhmm_worker/worker/matrix_dimensions
add wave -noupdate /sim_cached_worker_tb/dut_pairhmm_worker/worker/initial_result
add wave -noupdate /sim_cached_worker_tb/dut_pairhmm_worker/worker/left_result_reg
add wave -noupdate /sim_cached_worker_tb/dut_pairhmm_worker/worker/left_result_valid_reg
add wave -noupdate /sim_cached_worker_tb/dut_pairhmm_worker/worker/top_result_reg
add wave -noupdate /sim_cached_worker_tb/dut_pairhmm_worker/worker/top_result_valid_reg
add wave -noupdate /sim_cached_worker_tb/dut_pairhmm_worker/worker/left_temps
add wave -noupdate /sim_cached_worker_tb/dut_pairhmm_worker/worker/send_compute_request
add wave -noupdate /sim_cached_worker_tb/dut_pairhmm_worker/worker/update_left_result
add wave -noupdate /sim_cached_worker_tb/dut_pairhmm_worker/worker/update_top_result
add wave -noupdate /sim_cached_worker_tb/dut_pairhmm_worker/worker/left_result_valid
add wave -noupdate /sim_cached_worker_tb/dut_pairhmm_worker/worker/read_result_fifo
add wave -noupdate /sim_cached_worker_tb/dut_pairhmm_worker/worker/top_result_valid
add wave -noupdate /sim_cached_worker_tb/dut_pairhmm_worker/worker/read_read_addr
add wave -noupdate /sim_cached_worker_tb/dut_pairhmm_worker/worker/hap_read_addr
add wave -noupdate /sim_cached_worker_tb/dut_pairhmm_worker/worker/final_result_write_reg
add wave -noupdate /sim_cached_worker_tb/dut_pairhmm_worker/worker/final_result_reg
add wave -noupdate /sim_cached_worker_tb/dut_pairhmm_worker/worker/left_ready
add wave -noupdate /sim_cached_worker_tb/dut_pairhmm_worker/worker/top_ready
add wave -noupdate /sim_cached_worker_tb/compute_request_bus/clock
add wave -noupdate /sim_cached_worker_tb/compute_request_bus/read_data
add wave -noupdate -childformat {{/sim_cached_worker_tb/compute_request_bus/write_data.result_left -radix float32} {/sim_cached_worker_tb/compute_request_bus/write_data.result_top -radix float32} {/sim_cached_worker_tb/compute_request_bus/write_data.base_quals -radix decimal} {/sim_cached_worker_tb/compute_request_bus/write_data.insertion_qual_right -radix decimal} {/sim_cached_worker_tb/compute_request_bus/write_data.deletion_qual_right -radix decimal} {/sim_cached_worker_tb/compute_request_bus/write_data.continuation_qual_right -radix decimal}} -expand -subitemconfig {/sim_cached_worker_tb/compute_request_bus/write_data.result_left {-radix float32} /sim_cached_worker_tb/compute_request_bus/write_data.result_top {-radix float32} /sim_cached_worker_tb/compute_request_bus/write_data.base_quals {-radix decimal} /sim_cached_worker_tb/compute_request_bus/write_data.insertion_qual_right {-radix decimal} /sim_cached_worker_tb/compute_request_bus/write_data.deletion_qual_right {-radix decimal} /sim_cached_worker_tb/compute_request_bus/write_data.continuation_qual_right {-radix decimal}} /sim_cached_worker_tb/compute_request_bus/write_data
add wave -noupdate /sim_cached_worker_tb/compute_request_bus/full
add wave -noupdate /sim_cached_worker_tb/compute_request_bus/write
add wave -noupdate /sim_cached_worker_tb/compute_request_bus/empty
add wave -noupdate /sim_cached_worker_tb/compute_request_bus/read
add wave -noupdate /sim_cached_worker_tb/compute_result_bus/clock
add wave -noupdate -childformat {{/sim_cached_worker_tb/compute_result_bus/read_data.match -radix float32} {/sim_cached_worker_tb/compute_result_bus/read_data.insertion -radix float32} {/sim_cached_worker_tb/compute_result_bus/read_data.deletion -radix float32} {/sim_cached_worker_tb/compute_result_bus/read_data.temp_A -radix float32} {/sim_cached_worker_tb/compute_result_bus/read_data.temp_B -radix float32}} -expand -subitemconfig {/sim_cached_worker_tb/compute_result_bus/read_data.match {-radix float32} /sim_cached_worker_tb/compute_result_bus/read_data.insertion {-radix float32} /sim_cached_worker_tb/compute_result_bus/read_data.deletion {-radix float32} /sim_cached_worker_tb/compute_result_bus/read_data.temp_A {-radix float32} /sim_cached_worker_tb/compute_result_bus/read_data.temp_B {-radix float32}} /sim_cached_worker_tb/compute_result_bus/read_data
add wave -noupdate /sim_cached_worker_tb/compute_result_bus/write_data
add wave -noupdate /sim_cached_worker_tb/compute_result_bus/full
add wave -noupdate /sim_cached_worker_tb/compute_result_bus/write
add wave -noupdate /sim_cached_worker_tb/compute_result_bus/empty
add wave -noupdate /sim_cached_worker_tb/compute_result_bus/read
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 484
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {17564 ps}
