onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /sim_new_worker_tb/dut/mcr/jump
add wave -noupdate /sim_new_worker_tb/dut/mcr/position_reg
add wave -noupdate /sim_new_worker_tb/dut/mcr/jump_reg
add wave -noupdate /sim_new_worker_tb/dut/clock_i
add wave -noupdate /sim_new_worker_tb/dut/reset_i
add wave -noupdate /sim_new_worker_tb/dut/enable_i
add wave -noupdate /sim_new_worker_tb/dut/read_len_i
add wave -noupdate /sim_new_worker_tb/dut/hap_len_i
add wave -noupdate /sim_new_worker_tb/dut/INITIAL_POSITION
add wave -noupdate /sim_new_worker_tb/dut/matrix_dimensions
add wave -noupdate /sim_new_worker_tb/dut/left_result_reg
add wave -noupdate /sim_new_worker_tb/dut/left_result_valid_reg
add wave -noupdate /sim_new_worker_tb/dut/top_result_reg
add wave -noupdate /sim_new_worker_tb/dut/top_result_valid_reg
add wave -noupdate /sim_new_worker_tb/dut/left_temps
add wave -noupdate /sim_new_worker_tb/dut/send_compute_request
add wave -noupdate /sim_new_worker_tb/dut/update_left_result
add wave -noupdate /sim_new_worker_tb/dut/update_top_result
add wave -noupdate /sim_new_worker_tb/dut/left_result_valid
add wave -noupdate /sim_new_worker_tb/dut/read_result_fifo
add wave -noupdate /sim_new_worker_tb/dut/top_result_valid
add wave -noupdate /sim_new_worker_tb/dut/final_result_write_reg
add wave -noupdate /sim_new_worker_tb/dut/final_result_reg
add wave -noupdate /sim_new_worker_tb/dut/left_ready
add wave -noupdate /sim_new_worker_tb/dut/top_ready
add wave -noupdate /sim_new_worker_tb/dut/read_read_addr
add wave -noupdate /sim_new_worker_tb/dut/hap_read_addr
add wave -noupdate -radix float32 -childformat {{/sim_new_worker_tb/compute_request_bus/write_data.result_left -radix float32 -childformat {{/sim_new_worker_tb/compute_request_bus/write_data.result_left.insertion -radix float32} {/sim_new_worker_tb/compute_request_bus/write_data.result_left.match -radix float32} {/sim_new_worker_tb/compute_request_bus/write_data.result_left.deletion -radix float32} {/sim_new_worker_tb/compute_request_bus/write_data.result_left.temp_A -radix float32} {/sim_new_worker_tb/compute_request_bus/write_data.result_left.temp_B -radix float32}}} {/sim_new_worker_tb/compute_request_bus/write_data.result_top -radix float32 -childformat {{/sim_new_worker_tb/compute_request_bus/write_data.result_top.insertion -radix float32} {/sim_new_worker_tb/compute_request_bus/write_data.result_top.match -radix float32} {/sim_new_worker_tb/compute_request_bus/write_data.result_top.deletion -radix float32} {/sim_new_worker_tb/compute_request_bus/write_data.result_top.temp_A -radix float32} {/sim_new_worker_tb/compute_request_bus/write_data.result_top.temp_B -radix float32}}} {/sim_new_worker_tb/compute_request_bus/write_data.base_quals -radix decimal} {/sim_new_worker_tb/compute_request_bus/write_data.insertion_qual_right -radix decimal} {/sim_new_worker_tb/compute_request_bus/write_data.deletion_qual_right -radix decimal} {/sim_new_worker_tb/compute_request_bus/write_data.continuation_qual_right -radix decimal} {/sim_new_worker_tb/compute_request_bus/write_data.match -radix float32}} -expand -subitemconfig {/sim_new_worker_tb/compute_request_bus/write_data.result_left {-radix float32 -childformat {{/sim_new_worker_tb/compute_request_bus/write_data.result_left.insertion -radix float32} {/sim_new_worker_tb/compute_request_bus/write_data.result_left.match -radix float32} {/sim_new_worker_tb/compute_request_bus/write_data.result_left.deletion -radix float32} {/sim_new_worker_tb/compute_request_bus/write_data.result_left.temp_A -radix float32} {/sim_new_worker_tb/compute_request_bus/write_data.result_left.temp_B -radix float32}}} /sim_new_worker_tb/compute_request_bus/write_data.result_left.insertion {-radix float32} /sim_new_worker_tb/compute_request_bus/write_data.result_left.match {-radix float32} /sim_new_worker_tb/compute_request_bus/write_data.result_left.deletion {-radix float32} /sim_new_worker_tb/compute_request_bus/write_data.result_left.temp_A {-radix float32} /sim_new_worker_tb/compute_request_bus/write_data.result_left.temp_B {-radix float32} /sim_new_worker_tb/compute_request_bus/write_data.result_top {-radix float32 -childformat {{/sim_new_worker_tb/compute_request_bus/write_data.result_top.insertion -radix float32} {/sim_new_worker_tb/compute_request_bus/write_data.result_top.match -radix float32} {/sim_new_worker_tb/compute_request_bus/write_data.result_top.deletion -radix float32} {/sim_new_worker_tb/compute_request_bus/write_data.result_top.temp_A -radix float32} {/sim_new_worker_tb/compute_request_bus/write_data.result_top.temp_B -radix float32}}} /sim_new_worker_tb/compute_request_bus/write_data.result_top.insertion {-radix float32} /sim_new_worker_tb/compute_request_bus/write_data.result_top.match {-radix float32} /sim_new_worker_tb/compute_request_bus/write_data.result_top.deletion {-radix float32} /sim_new_worker_tb/compute_request_bus/write_data.result_top.temp_A {-radix float32} /sim_new_worker_tb/compute_request_bus/write_data.result_top.temp_B {-radix float32} /sim_new_worker_tb/compute_request_bus/write_data.base_quals {-radix decimal} /sim_new_worker_tb/compute_request_bus/write_data.insertion_qual_right {-radix decimal} /sim_new_worker_tb/compute_request_bus/write_data.deletion_qual_right {-radix decimal} /sim_new_worker_tb/compute_request_bus/write_data.continuation_qual_right {-radix decimal} /sim_new_worker_tb/compute_request_bus/write_data.match {-radix float32}} /sim_new_worker_tb/compute_request_bus/write_data
add wave -noupdate -radix float32 -childformat {{/sim_new_worker_tb/compute_result_bus/read_data.insertion -radix float32} {/sim_new_worker_tb/compute_result_bus/read_data.match -radix float32} {/sim_new_worker_tb/compute_result_bus/read_data.deletion -radix float32} {/sim_new_worker_tb/compute_result_bus/read_data.temp_A -radix float32} {/sim_new_worker_tb/compute_result_bus/read_data.temp_B -radix float32}} -expand -subitemconfig {/sim_new_worker_tb/compute_result_bus/read_data.insertion {-radix float32} /sim_new_worker_tb/compute_result_bus/read_data.match {-radix float32} /sim_new_worker_tb/compute_result_bus/read_data.deletion {-radix float32} /sim_new_worker_tb/compute_result_bus/read_data.temp_A {-radix float32} /sim_new_worker_tb/compute_result_bus/read_data.temp_B {-radix float32}} /sim_new_worker_tb/compute_result_bus/read_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {255 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 222
configure wave -valuecolwidth 253
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {0 ns} {813 ns}
