# Back pressure unit
vlog -sv ../sim/sim_axis_back_pressure_unit.sv
# TB
vlog -sv sim_axis_back_pressure_tb.sv

# Start Simulation
vsim -voptargs=+acc work.sim_axis_back_pressure_tb

# Add waves
add wave -position insertpoint sim:/sim_axis_back_pressure_tb/reset
add wave -position insertpoint sim:/sim_axis_back_pressure_tb/axi_stream_bus_master/*
add wave -position insertpoint sim:/sim_axis_back_pressure_tb/axi_stream_bus_slave/*

# Run
run 500 ns
