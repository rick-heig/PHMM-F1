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


# TODO:
# Add check if CL_DIR and HDK_SHELL_DIR directories exist
# Add check if /build and /build/src_port_encryption directories exist
# Add check if the vivado_keyfile exist

set HDK_SHELL_DIR $::env(HDK_SHELL_DIR)
set CL_DIR $::env(CL_DIR)

set TARGET_DIR $CL_DIR/build/src_post_encryption
set UNUSED_TEMPLATES_DIR $HDK_SHELL_DIR/design/interfaces

# Remove any previously encrypted files, that may no longer be used
if {[llength [glob -nocomplain -dir $TARGET_DIR *]] != 0} {
  eval file delete -force [glob $TARGET_DIR/*]
}

#---- Developer would replace this section with design files ----

## Change file names and paths below to reflect your CL area.  DO NOT include AWS RTL files.

# Defines
file copy -force $CL_DIR/design/cl_defines.vh                         $TARGET_DIR
file copy -force $CL_DIR/design/cl_id_defines.vh                      $TARGET_DIR

# Package
file copy -force $CL_DIR/design/cl_pairhmm_package.vh                 $TARGET_DIR

# Pair-HMM related
file copy -force $CL_DIR/design/cl_axi_read_arbiter.sv                $TARGET_DIR
file copy -force $CL_DIR/design/cl_compute_engine_wrapper.sv          $TARGET_DIR
file copy -force $CL_DIR/design/cl_compute_result_combiner.sv         $TARGET_DIR
file copy -force $CL_DIR/design/cl_workgroup_controller.sv            $TARGET_DIR
file copy -force $CL_DIR/design/cl_pairhmm_workgroup.sv               $TARGET_DIR
file copy -force $CL_DIR/design/cl_pairhmm_worker_stream.sv           $TARGET_DIR
file copy -force $CL_DIR/design/cl_pairhmm_new_worker_core_synth.sv   $TARGET_DIR
file copy -force $CL_DIR/design/cl_main_controller.sv                 $TARGET_DIR
file copy -force $CL_DIR/design/cl_compute_stream_separator.sv        $TARGET_DIR
file copy -force $CL_DIR/design/cl_conveyer.sv                        $TARGET_DIR
file copy -force $CL_DIR/design/cl_conveyer_axi_s.sv                  $TARGET_DIR
file copy -force $CL_DIR/design/cl_interfaces.sv                      $TARGET_DIR
file copy -force $CL_DIR/design/cl_debug_interfaces.sv                $TARGET_DIR
file copy -force $CL_DIR/design/cl_job_logger.sv                      $TARGET_DIR
file copy -force $CL_DIR/design/cl_matrix_crawler.sv                  $TARGET_DIR
file copy -force $CL_DIR/design/cl_write_back.sv                      $TARGET_DIR
file copy -force $CL_DIR/design/cl_pairhmm_top.sv                     $TARGET_DIR
file copy -force $CL_DIR/design/cl_tie_down_axi_lite_master.sv        $TARGET_DIR
file copy -force $CL_DIR/design/cl_tie_down_axi_master.sv             $TARGET_DIR
file copy -force $CL_DIR/design/cl_zero_axi_lite_slave.sv             $TARGET_DIR

# Amazon F1 Top related
file copy -force $CL_DIR/design/cl_axi_read_arbiter.sv                $TARGET_DIR
file copy -force $CL_DIR/design/cl_axi_register_slice.sv              $TARGET_DIR
file copy -force $CL_DIR/design/cl_axi_interconnect_2_to_1_wrapper.sv $TARGET_DIR
file copy -force $CL_DIR/design/cl_axi_interconnect_4_to_1_wrapper.sv $TARGET_DIR
file copy -force $CL_DIR/design/cl_axi_lite_interconnect_1_to_4_wrapper.sv $TARGET_DIR

file copy -force $CL_DIR/design/cl_top.sv                             $TARGET_DIR

# Common files
file copy -force $UNUSED_TEMPLATES_DIR/unused_apppf_irq_template.inc  $TARGET_DIR
#file copy -force $UNUSED_TEMPLATES_DIR/unused_aurora_template.inc     $TARGET_DIR
file copy -force $UNUSED_TEMPLATES_DIR/unused_cl_sda_template.inc     $TARGET_DIR
file copy -force $UNUSED_TEMPLATES_DIR/unused_ddr_a_b_d_template.inc  $TARGET_DIR
file copy -force $UNUSED_TEMPLATES_DIR/unused_ddr_c_template.inc      $TARGET_DIR
file copy -force $UNUSED_TEMPLATES_DIR/unused_dma_pcis_template.inc   $TARGET_DIR
file copy -force $UNUSED_TEMPLATES_DIR/unused_flr_template.inc        $TARGET_DIR
#file copy -force $UNUSED_TEMPLATES_DIR/unused_hmc_template.inc        $TARGET_DIR
file copy -force $UNUSED_TEMPLATES_DIR/unused_pcim_template.inc       $TARGET_DIR
file copy -force $UNUSED_TEMPLATES_DIR/unused_sh_bar1_template.inc    $TARGET_DIR
file copy -force $UNUSED_TEMPLATES_DIR/unused_sh_ocl_template.inc     $TARGET_DIR

#---- End of section replaced by Developer ---

# Make sure files have write permissions for the encryption
exec chmod +w {*}[glob $TARGET_DIR/*]

# encrypt .v/.sv/.vh/inc as verilog files
encrypt -k $HDK_SHELL_DIR/build/scripts/vivado_keyfile.txt -lang verilog  [glob -nocomplain -- $TARGET_DIR/*.?v] [glob -nocomplain -- $TARGET_DIR/*.vh] [glob -nocomplain -- $TARGET_DIR/*.inc]

# encrypt *vhdl files
encrypt -k $HDK_SHELL_DIR/build/scripts/vivado_vhdl_keyfile.txt -lang vhdl -quiet [ glob -nocomplain -- $TARGET_DIR/*.vhd? ]
