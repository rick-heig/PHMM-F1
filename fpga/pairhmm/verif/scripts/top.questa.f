# Amazon FPGA Hardware Development Kit
#
# Copyright 2016 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Amazon Software License (the "License"). You may not use
# this file except in compliance with the License. A copy of the License is
# located at
#
#    http://aws.amazon.com/asl/
#
# or in the "license" file accompanying this file. This file is distributed on
# an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, express or
# implied. See the License for the specific language governing permissions and
# limitations under the License.

+define+QUESTA_SIM

+libext+.v
+libext+.sv
+libext+.svh

-y ${CL_ROOT}/design
-y ${SH_LIB_DIR}
-y ${SH_INF_DIR}
-y ${HDK_SHELL_DESIGN_DIR}/sh_ddr/sim

#######################
# Include directories #
#######################

# User includes
+incdir+${CL_ROOT}/../common/design
+incdir+${CL_ROOT}/design
+incdir+${CL_ROOT}/verif/sv
+incdir+${CL_ROOT}/verif/tests

# User sim includes
+incdir+${CL_ROOT}/ip/bd/compute_unit/ipshared/0ab1/hdl


# Other includes
+incdir+${SH_LIB_DIR}
+incdir+${SH_INF_DIR}
+incdir+${HDK_COMMON_DIR}/verif/include
+incdir+${SH_LIB_DIR}/../ip/cl_axi_interconnect/ipshared/7e3a/hdl
+incdir+${HDK_COMMON_DIR}/verif/models/fpga
+incdir+${HDK_SHELL_DESIGN_DIR}/sh_ddr/sim
+incdir+${HDK_SHELL_DESIGN_DIR}/ip/src_register_slice/hdl

################
# User Defines #
################
${CL_ROOT}/design/cl_defines.vh

${SH_LIB_DIR}/bram_2rw.sv
${SH_LIB_DIR}/flop_fifo.sv

${HDK_SHELL_DESIGN_DIR}/ip/cl_axi_interconnect/ipshared/9909/hdl/axi_data_fifo_v2_1_vl_rfs.v
${HDK_SHELL_DESIGN_DIR}/ip/cl_axi_interconnect/ipshared/c631/hdl/axi_crossbar_v2_1_vl_rfs.v
${HDK_SHELL_DESIGN_DIR}/ip/cl_axi_interconnect/ip/cl_axi_interconnect_xbar_0/sim/cl_axi_interconnect_xbar_0.v
${HDK_SHELL_DESIGN_DIR}/ip/cl_axi_interconnect/ip/cl_axi_interconnect_s00_regslice_0/sim/cl_axi_interconnect_s00_regslice_0.v
${HDK_SHELL_DESIGN_DIR}/ip/cl_axi_interconnect/ip/cl_axi_interconnect_s01_regslice_0/sim/cl_axi_interconnect_s01_regslice_0.v
${HDK_SHELL_DESIGN_DIR}/ip/cl_axi_interconnect/ip/cl_axi_interconnect_m00_regslice_0/sim/cl_axi_interconnect_m00_regslice_0.v
${HDK_SHELL_DESIGN_DIR}/ip/cl_axi_interconnect/ip/cl_axi_interconnect_m01_regslice_0/sim/cl_axi_interconnect_m01_regslice_0.v
${HDK_SHELL_DESIGN_DIR}/ip/cl_axi_interconnect/ip/cl_axi_interconnect_m02_regslice_0/sim/cl_axi_interconnect_m02_regslice_0.v
${HDK_SHELL_DESIGN_DIR}/ip/cl_axi_interconnect/ip/cl_axi_interconnect_m03_regslice_0/sim/cl_axi_interconnect_m03_regslice_0.v
${HDK_SHELL_DESIGN_DIR}/ip/cl_axi_interconnect/sim/cl_axi_interconnect.v
${HDK_SHELL_DESIGN_DIR}/ip/dest_register_slice/hdl/axi_register_slice_v2_1_vl_rfs.v
${HDK_SHELL_DESIGN_DIR}/ip/axi_clock_converter_0/simulation/fifo_generator_vlog_beh.v
${HDK_SHELL_DESIGN_DIR}/ip/axi_clock_converter_0/hdl/axi_clock_converter_v2_1_vl_rfs.v
${HDK_SHELL_DESIGN_DIR}/ip/axi_clock_converter_0/hdl/fifo_generator_v13_2_rfs.v
${HDK_SHELL_DESIGN_DIR}/ip/axi_clock_converter_0/sim/axi_clock_converter_0.v
${HDK_SHELL_DESIGN_DIR}/ip/dest_register_slice/sim/dest_register_slice.v
${HDK_SHELL_DESIGN_DIR}/ip/src_register_slice/sim/src_register_slice.v
${HDK_SHELL_DESIGN_DIR}/ip/axi_register_slice/sim/axi_register_slice.v
${HDK_SHELL_DESIGN_DIR}/ip/axi_register_slice_light/sim/axi_register_slice_light.v

##############################
# User IPs (ton of files...) #
##############################
${CL_ROOT}/ip/bd/ocl_interconnect/ip/ocl_interconnect_m00_regslice_0/sim/ocl_interconnect_m00_regslice_0.v
${CL_ROOT}/ip/bd/ocl_interconnect/ip/ocl_interconnect_m01_regslice_0/sim/ocl_interconnect_m01_regslice_0.v
${CL_ROOT}/ip/bd/ocl_interconnect/ip/ocl_interconnect_m02_regslice_0/sim/ocl_interconnect_m02_regslice_0.v
${CL_ROOT}/ip/bd/ocl_interconnect/ip/ocl_interconnect_m03_regslice_0/sim/ocl_interconnect_m03_regslice_0.v
${CL_ROOT}/ip/bd/ocl_interconnect/ip/ocl_interconnect_s00_regslice_0/sim/ocl_interconnect_s00_regslice_0.v
${CL_ROOT}/ip/bd/ocl_interconnect/ip/ocl_interconnect_xbar_1/sim/ocl_interconnect_xbar_1.v
${CL_ROOT}/ip/bd/ocl_interconnect/sim/ocl_interconnect.v

${CL_ROOT}/ip/bd/cl_axi_interconnect_2_to_1_bis/ip/cl_axi_interconnect_2_to_1_bis_m00_regslice_0/sim/cl_axi_interconnect_2_to_1_bis_m00_regslice_0.v
${CL_ROOT}/ip/bd/cl_axi_interconnect_2_to_1_bis/ip/cl_axi_interconnect_2_to_1_bis_s00_regslice_0/sim/cl_axi_interconnect_2_to_1_bis_s00_regslice_0.v
${CL_ROOT}/ip/bd/cl_axi_interconnect_2_to_1_bis/ip/cl_axi_interconnect_2_to_1_bis_s01_regslice_0/sim/cl_axi_interconnect_2_to_1_bis_s01_regslice_0.v
${CL_ROOT}/ip/bd/cl_axi_interconnect_2_to_1_bis/ip/cl_axi_interconnect_2_to_1_bis_xbar_0/sim/cl_axi_interconnect_2_to_1_bis_xbar_0.v
${CL_ROOT}/ip/bd/cl_axi_interconnect_2_to_1_bis/sim/cl_axi_interconnect_2_to_1_bis.v

${CL_ROOT}/ip/ip/result_fifo/sim/result_fifo.v

${CL_ROOT}/ip_user_files/bd/compute_unit/ip/compute_unit_axis_data_fifo_0_0/sim/compute_unit_axis_data_fifo_0_0.v
${CL_ROOT}/ip_user_files/bd/compute_unit/ip/compute_unit_axis_data_fifo_1_0/sim/compute_unit_axis_data_fifo_1_0.v
${CL_ROOT}/ip_user_files/bd/compute_unit/ip/compute_unit_axis_data_fifo_2_0/sim/compute_unit_axis_data_fifo_2_0.v
${CL_ROOT}/ip_user_files/bd/compute_unit/ip/compute_unit_axis_data_fifo_3_0/sim/compute_unit_axis_data_fifo_3_0.v

${CL_ROOT}/ip_user_files/bd/compute_unit/sim/compute_unit.v
${CL_ROOT}/ip_user_files/ip/worker_bram/sim/worker_bram.v

${CL_ROOT}/ip_user_files/bd/floating_point_sum/sim/floating_point_sum.v
${CL_ROOT}/ip/ip/bram_32b_x_2048/sim/bram_32b_x_2048.v
${CL_ROOT}/ip/ip/bram_11b_x_2048/sim/bram_11b_x_2048.v
${CL_ROOT}/ip/bd/compute_unit/hdl/compute_unit_wrapper.v
${CL_ROOT}/ip/bd/floating_point_sum/hdl/floating_point_sum_wrapper.v

${CL_ROOT}/ip/ip/job_log_bram/sim/job_log_bram.v

+define+DISABLE_VJTAG_DEBUG

##############
# User files #
##############

# Pair-HMM top
${CL_ROOT}/design/cl_axi_lite_interconnect_1_to_4_wrapper.sv
${CL_ROOT}/design/cl_tie_down_axi_master.sv
${CL_ROOT}/design/cl_dummy_workgroup.sv
${CL_ROOT}/design/cl_axi_read_arbiter.sv
${CL_ROOT}/design/cl_compute_engine_wrapper.sv
${CL_ROOT}/design/cl_compute_result_combiner.sv
${CL_ROOT}/design/cl_workgroup_controller.sv
${CL_ROOT}/design/cl_pairhmm_workgroup.sv
${CL_ROOT}/design/cl_pairhmm_worker_stream.sv
${CL_ROOT}/design/cl_pairhmm_new_worker_core_synth.sv
${CL_ROOT}/design/cl_main_controller.sv
${CL_ROOT}/design/cl_compute_stream_separator.sv
${CL_ROOT}/design/cl_conveyer.sv
${CL_ROOT}/design/cl_conveyer_axi_s.sv
${CL_ROOT}/design/cl_interfaces.sv
${CL_ROOT}/design/cl_debug_interfaces.sv
${CL_ROOT}/design/cl_matrix_crawler.sv
${CL_ROOT}/design/cl_write_back.sv
${CL_ROOT}/design/cl_pairhmm_top.sv

# Amazon F1 top
${CL_ROOT}/design/cl_id_defines.vh
#${CL_ROOT}/design/cl_defines.vh # This requires to be much sooner, because this decides the top design
${CL_ROOT}/design/cl_pairhmm_package.vh
${CL_ROOT}/design/cl_interfaces.sv
${CL_ROOT}/design/cl_axi_read_arbiter.sv
${CL_ROOT}/design/cl_axi_register_slice.sv
${CL_ROOT}/design/cl_top.sv

-f ${HDK_COMMON_DIR}/verif/tb/filelists/tb.${SIMULATOR}.f
${TEST_NAME}
