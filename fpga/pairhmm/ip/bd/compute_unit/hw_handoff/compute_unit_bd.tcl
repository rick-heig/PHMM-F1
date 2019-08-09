
################################################################
# This is a generated script based on design: compute_unit
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2017.4
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source compute_unit_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xcvu9p-flgb2104-2-i
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name compute_unit

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set M_AXIS_ID [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS_ID ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {10000000} \
   ] $M_AXIS_ID
  set M_AXIS_RESULT_DELETION [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS_RESULT_DELETION ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {10000000} \
   ] $M_AXIS_RESULT_DELETION
  set M_AXIS_RESULT_INSERTION [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS_RESULT_INSERTION ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {10000000} \
   ] $M_AXIS_RESULT_INSERTION
  set M_AXIS_RESULT_MATCH [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS_RESULT_MATCH ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {10000000} \
   ] $M_AXIS_RESULT_MATCH
  set M_AXIS_RESULT_TA [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS_RESULT_TA ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {10000000} \
   ] $M_AXIS_RESULT_TA
  set M_AXIS_RESULT_TB [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 M_AXIS_RESULT_TB ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {10000000} \
   ] $M_AXIS_RESULT_TB
  set S_AXIS_C_QUAL [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_C_QUAL ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {10000000} \
   CONFIG.HAS_TKEEP {0} \
   CONFIG.HAS_TLAST {0} \
   CONFIG.HAS_TREADY {1} \
   CONFIG.HAS_TSTRB {0} \
   CONFIG.LAYERED_METADATA {undef} \
   CONFIG.TDATA_NUM_BYTES {4} \
   CONFIG.TDEST_WIDTH {0} \
   CONFIG.TID_WIDTH {0} \
   CONFIG.TUSER_WIDTH {0} \
   ] $S_AXIS_C_QUAL
  set S_AXIS_C_QUAL_BIS [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_C_QUAL_BIS ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {10000000} \
   CONFIG.HAS_TKEEP {0} \
   CONFIG.HAS_TLAST {0} \
   CONFIG.HAS_TREADY {1} \
   CONFIG.HAS_TSTRB {0} \
   CONFIG.LAYERED_METADATA {undef} \
   CONFIG.TDATA_NUM_BYTES {4} \
   CONFIG.TDEST_WIDTH {0} \
   CONFIG.TID_WIDTH {0} \
   CONFIG.TUSER_WIDTH {0} \
   ] $S_AXIS_C_QUAL_BIS
  set S_AXIS_D_QUAL [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_D_QUAL ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {10000000} \
   CONFIG.HAS_TKEEP {0} \
   CONFIG.HAS_TLAST {0} \
   CONFIG.HAS_TREADY {1} \
   CONFIG.HAS_TSTRB {0} \
   CONFIG.LAYERED_METADATA {undef} \
   CONFIG.TDATA_NUM_BYTES {4} \
   CONFIG.TDEST_WIDTH {0} \
   CONFIG.TID_WIDTH {0} \
   CONFIG.TUSER_WIDTH {0} \
   ] $S_AXIS_D_QUAL
  set S_AXIS_D_QUAL_RIGHT [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_D_QUAL_RIGHT ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {10000000} \
   CONFIG.HAS_TKEEP {0} \
   CONFIG.HAS_TLAST {0} \
   CONFIG.HAS_TREADY {1} \
   CONFIG.HAS_TSTRB {0} \
   CONFIG.LAYERED_METADATA {undef} \
   CONFIG.TDATA_NUM_BYTES {4} \
   CONFIG.TDEST_WIDTH {0} \
   CONFIG.TID_WIDTH {0} \
   CONFIG.TUSER_WIDTH {0} \
   ] $S_AXIS_D_QUAL_RIGHT
  set S_AXIS_ID [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_ID ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {10000000} \
   CONFIG.HAS_TKEEP {0} \
   CONFIG.HAS_TLAST {0} \
   CONFIG.HAS_TREADY {1} \
   CONFIG.HAS_TSTRB {0} \
   CONFIG.LAYERED_METADATA {undef} \
   CONFIG.TDATA_NUM_BYTES {4} \
   CONFIG.TDEST_WIDTH {0} \
   CONFIG.TID_WIDTH {0} \
   CONFIG.TUSER_WIDTH {0} \
   ] $S_AXIS_ID
  set S_AXIS_I_QUAL [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_I_QUAL ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {10000000} \
   CONFIG.HAS_TKEEP {0} \
   CONFIG.HAS_TLAST {0} \
   CONFIG.HAS_TREADY {1} \
   CONFIG.HAS_TSTRB {0} \
   CONFIG.LAYERED_METADATA {undef} \
   CONFIG.TDATA_NUM_BYTES {4} \
   CONFIG.TDEST_WIDTH {0} \
   CONFIG.TID_WIDTH {0} \
   CONFIG.TUSER_WIDTH {0} \
   ] $S_AXIS_I_QUAL
  set S_AXIS_I_QUAL_RIGHT [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_I_QUAL_RIGHT ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {10000000} \
   CONFIG.HAS_TKEEP {0} \
   CONFIG.HAS_TLAST {0} \
   CONFIG.HAS_TREADY {1} \
   CONFIG.HAS_TSTRB {0} \
   CONFIG.LAYERED_METADATA {undef} \
   CONFIG.TDATA_NUM_BYTES {4} \
   CONFIG.TDEST_WIDTH {0} \
   CONFIG.TID_WIDTH {0} \
   CONFIG.TUSER_WIDTH {0} \
   ] $S_AXIS_I_QUAL_RIGHT
  set S_AXIS_LEFT_INSERTION [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_LEFT_INSERTION ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {10000000} \
   CONFIG.HAS_TKEEP {0} \
   CONFIG.HAS_TLAST {0} \
   CONFIG.HAS_TREADY {1} \
   CONFIG.HAS_TSTRB {0} \
   CONFIG.LAYERED_METADATA {undef} \
   CONFIG.TDATA_NUM_BYTES {4} \
   CONFIG.TDEST_WIDTH {0} \
   CONFIG.TID_WIDTH {0} \
   CONFIG.TUSER_WIDTH {0} \
   ] $S_AXIS_LEFT_INSERTION
  set S_AXIS_LEFT_MATCH [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_LEFT_MATCH ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {10000000} \
   CONFIG.HAS_TKEEP {0} \
   CONFIG.HAS_TLAST {0} \
   CONFIG.HAS_TREADY {1} \
   CONFIG.HAS_TSTRB {0} \
   CONFIG.LAYERED_METADATA {undef} \
   CONFIG.TDATA_NUM_BYTES {4} \
   CONFIG.TDEST_WIDTH {0} \
   CONFIG.TID_WIDTH {0} \
   CONFIG.TUSER_WIDTH {0} \
   ] $S_AXIS_LEFT_MATCH
  set S_AXIS_LEFT_TA [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_LEFT_TA ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {10000000} \
   CONFIG.HAS_TKEEP {0} \
   CONFIG.HAS_TLAST {0} \
   CONFIG.HAS_TREADY {1} \
   CONFIG.HAS_TSTRB {0} \
   CONFIG.LAYERED_METADATA {undef} \
   CONFIG.TDATA_NUM_BYTES {4} \
   CONFIG.TDEST_WIDTH {0} \
   CONFIG.TID_WIDTH {0} \
   CONFIG.TUSER_WIDTH {0} \
   ] $S_AXIS_LEFT_TA
  set S_AXIS_LEFT_TB [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_LEFT_TB ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {10000000} \
   CONFIG.HAS_TKEEP {0} \
   CONFIG.HAS_TLAST {0} \
   CONFIG.HAS_TREADY {1} \
   CONFIG.HAS_TSTRB {0} \
   CONFIG.LAYERED_METADATA {undef} \
   CONFIG.TDATA_NUM_BYTES {4} \
   CONFIG.TDEST_WIDTH {0} \
   CONFIG.TID_WIDTH {0} \
   CONFIG.TUSER_WIDTH {0} \
   ] $S_AXIS_LEFT_TB
  set S_AXIS_ONE_CONSTANT [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_ONE_CONSTANT ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {10000000} \
   CONFIG.HAS_TKEEP {0} \
   CONFIG.HAS_TLAST {0} \
   CONFIG.HAS_TREADY {1} \
   CONFIG.HAS_TSTRB {0} \
   CONFIG.LAYERED_METADATA {undef} \
   CONFIG.TDATA_NUM_BYTES {4} \
   CONFIG.TDEST_WIDTH {0} \
   CONFIG.TID_WIDTH {0} \
   CONFIG.TUSER_WIDTH {0} \
   ] $S_AXIS_ONE_CONSTANT
  set S_AXIS_ONE_MIN_C_QUAL_RIGHT [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_ONE_MIN_C_QUAL_RIGHT ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {10000000} \
   CONFIG.HAS_TKEEP {0} \
   CONFIG.HAS_TLAST {0} \
   CONFIG.HAS_TREADY {1} \
   CONFIG.HAS_TSTRB {0} \
   CONFIG.LAYERED_METADATA {undef} \
   CONFIG.TDATA_NUM_BYTES {4} \
   CONFIG.TDEST_WIDTH {0} \
   CONFIG.TID_WIDTH {0} \
   CONFIG.TUSER_WIDTH {0} \
   ] $S_AXIS_ONE_MIN_C_QUAL_RIGHT
  set S_AXIS_PRIOR [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_PRIOR ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {10000000} \
   CONFIG.HAS_TKEEP {0} \
   CONFIG.HAS_TLAST {0} \
   CONFIG.HAS_TREADY {1} \
   CONFIG.HAS_TSTRB {0} \
   CONFIG.LAYERED_METADATA {undef} \
   CONFIG.TDATA_NUM_BYTES {4} \
   CONFIG.TDEST_WIDTH {0} \
   CONFIG.TID_WIDTH {0} \
   CONFIG.TUSER_WIDTH {0} \
   ] $S_AXIS_PRIOR
  set S_AXIS_TOP_DELETION [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_TOP_DELETION ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {10000000} \
   CONFIG.HAS_TKEEP {0} \
   CONFIG.HAS_TLAST {0} \
   CONFIG.HAS_TREADY {1} \
   CONFIG.HAS_TSTRB {0} \
   CONFIG.LAYERED_METADATA {undef} \
   CONFIG.TDATA_NUM_BYTES {4} \
   CONFIG.TDEST_WIDTH {0} \
   CONFIG.TID_WIDTH {0} \
   CONFIG.TUSER_WIDTH {0} \
   ] $S_AXIS_TOP_DELETION
  set S_AXIS_TOP_DELETION_BIS [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_TOP_DELETION_BIS ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {10000000} \
   CONFIG.HAS_TKEEP {0} \
   CONFIG.HAS_TLAST {0} \
   CONFIG.HAS_TREADY {1} \
   CONFIG.HAS_TSTRB {0} \
   CONFIG.LAYERED_METADATA {undef} \
   CONFIG.TDATA_NUM_BYTES {4} \
   CONFIG.TDEST_WIDTH {0} \
   CONFIG.TID_WIDTH {0} \
   CONFIG.TUSER_WIDTH {0} \
   ] $S_AXIS_TOP_DELETION_BIS
  set S_AXIS_TOP_INSERTION [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_TOP_INSERTION ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {10000000} \
   CONFIG.HAS_TKEEP {0} \
   CONFIG.HAS_TLAST {0} \
   CONFIG.HAS_TREADY {1} \
   CONFIG.HAS_TSTRB {0} \
   CONFIG.LAYERED_METADATA {undef} \
   CONFIG.TDATA_NUM_BYTES {4} \
   CONFIG.TDEST_WIDTH {0} \
   CONFIG.TID_WIDTH {0} \
   CONFIG.TUSER_WIDTH {0} \
   ] $S_AXIS_TOP_INSERTION
  set S_AXIS_TOP_MATCH [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_TOP_MATCH ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {10000000} \
   CONFIG.HAS_TKEEP {0} \
   CONFIG.HAS_TLAST {0} \
   CONFIG.HAS_TREADY {1} \
   CONFIG.HAS_TSTRB {0} \
   CONFIG.LAYERED_METADATA {undef} \
   CONFIG.TDATA_NUM_BYTES {4} \
   CONFIG.TDEST_WIDTH {0} \
   CONFIG.TID_WIDTH {0} \
   CONFIG.TUSER_WIDTH {0} \
   ] $S_AXIS_TOP_MATCH
  set S_AXIS_TOP_MATCH_BIS [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 S_AXIS_TOP_MATCH_BIS ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {10000000} \
   CONFIG.HAS_TKEEP {0} \
   CONFIG.HAS_TLAST {0} \
   CONFIG.HAS_TREADY {1} \
   CONFIG.HAS_TSTRB {0} \
   CONFIG.LAYERED_METADATA {undef} \
   CONFIG.TDATA_NUM_BYTES {4} \
   CONFIG.TDEST_WIDTH {0} \
   CONFIG.TID_WIDTH {0} \
   CONFIG.TUSER_WIDTH {0} \
   ] $S_AXIS_TOP_MATCH_BIS

  # Create ports
  set aclk [ create_bd_port -dir I -type clk aclk ]
  set_property -dict [ list \
   CONFIG.ASSOCIATED_BUSIF {S_AXIS_fI_j:S_AXIS_fD_j:S_AXIS_a_dm:S_AXIS_a_mm:S_AXIS_fM_j:S_AXIS_ta_i:S_AXIS_tb_i:S_AXIS_prior:S_AXIS_a_mi:S_AXIS_fM_i:S_AXIS_a_ii:S_AXIS_fI_i:S_AXIS_a_md:S_AXIS_fM_j_copy:S_AXIS_a_dd:S_AXIS_fD_j_copy:M_AXIS_RESULT_TBA:M_AXIS_RESULT_TB:M_AXIS_RESULT_MATCH:M_AXIS_RESULT_INSERTION:M_AXIS_RESULT_DELETION:M_AXIS_RESULT_TA:S_AXIS_TOP_INSERTION:S_AXIS_TOP_DELETION:S_AXIS_ONE_MIN_C_QUAL_RIGHT:S_AXIS_TOP_MATCH:S_AXIS_ONE_MIN_I_QUAL_RIGHT:S_AXIS_D_QUAL_RIGHT:S_AXIS_LEFT_TA:S_AXIS_LEFT_TB:S_AXIS_I_QUAL:S_AXIS_LEFT_MATCH:S_AXIS_C_QUAL:S_AXIS_LEFT_INSERTION:S_AXIS_D_QUAL:S_AXIS_TOP_MATCH_BIS:S_AXIS_C_QUAL_BIS:S_AXIS_TOP_DELETION_BIS:M_AXIS_ID:S_AXIS_ID:S_AXIS_ONE_CONSTANT:S_AXIS_I_QUAL_RIGHT} \
   CONFIG.FREQ_HZ {10000000} \
 ] $aclk
  set aresetn [ create_bd_port -dir I -type rst aresetn ]

  # Create instance: add_0, and set properties
  set add_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 add_0 ]
  set_property -dict [ list \
   CONFIG.Add_Sub_Value {Add} \
   CONFIG.C_Latency {12} \
   CONFIG.Flow_Control {Blocking} \
   CONFIG.Has_ARESETn {true} \
   CONFIG.Has_RESULT_TREADY {true} \
 ] $add_0

  # Create instance: add_1, and set properties
  set add_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 add_1 ]
  set_property -dict [ list \
   CONFIG.Add_Sub_Value {Add} \
   CONFIG.C_Latency {12} \
   CONFIG.Flow_Control {Blocking} \
   CONFIG.Has_ARESETn {true} \
   CONFIG.Has_RESULT_TREADY {true} \
 ] $add_1

  # Create instance: add_2, and set properties
  set add_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 add_2 ]
  set_property -dict [ list \
   CONFIG.Add_Sub_Value {Add} \
   CONFIG.C_Latency {12} \
   CONFIG.Flow_Control {Blocking} \
   CONFIG.Has_ARESETn {true} \
   CONFIG.Has_RESULT_TREADY {true} \
 ] $add_2

  # Create instance: add_3, and set properties
  set add_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 add_3 ]
  set_property -dict [ list \
   CONFIG.Add_Sub_Value {Add} \
   CONFIG.C_Latency {12} \
   CONFIG.Flow_Control {Blocking} \
   CONFIG.Has_ARESETn {true} \
   CONFIG.Has_RESULT_TREADY {true} \
 ] $add_3

  # Create instance: add_4, and set properties
  set add_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 add_4 ]
  set_property -dict [ list \
   CONFIG.Add_Sub_Value {Add} \
   CONFIG.C_Latency {6} \
   CONFIG.C_Mult_Usage {Full_Usage} \
   CONFIG.C_Rate {1} \
   CONFIG.C_Result_Exponent_Width {8} \
   CONFIG.C_Result_Fraction_Width {24} \
   CONFIG.Has_ARESETn {true} \
   CONFIG.Has_A_TLAST {false} \
   CONFIG.Maximum_Latency {false} \
   CONFIG.Operation_Type {Add_Subtract} \
   CONFIG.RESULT_TLAST_Behv {Null} \
   CONFIG.Result_Precision_Type {Single} \
 ] $add_4

  # Create instance: axis_data_fifo_0, and set properties
  set axis_data_fifo_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:1.1 axis_data_fifo_0 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.TDATA_NUM_BYTES {4} \
 ] $axis_data_fifo_0

  # Create instance: axis_data_fifo_1, and set properties
  set axis_data_fifo_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:1.1 axis_data_fifo_1 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.TDATA_NUM_BYTES {4} \
 ] $axis_data_fifo_1

  # Create instance: axis_data_fifo_2, and set properties
  set axis_data_fifo_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:1.1 axis_data_fifo_2 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {16} \
   CONFIG.TDATA_NUM_BYTES {4} \
 ] $axis_data_fifo_2

  # Create instance: axis_data_fifo_3, and set properties
  set axis_data_fifo_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo:1.1 axis_data_fifo_3 ]
  set_property -dict [ list \
   CONFIG.FIFO_DEPTH {32} \
   CONFIG.TDATA_NUM_BYTES {4} \
 ] $axis_data_fifo_3

  # Create instance: mul_0, and set properties
  set mul_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 mul_0 ]
  set_property -dict [ list \
   CONFIG.C_Latency {9} \
   CONFIG.C_Mult_Usage {Full_Usage} \
   CONFIG.C_Rate {1} \
   CONFIG.C_Result_Exponent_Width {8} \
   CONFIG.C_Result_Fraction_Width {24} \
   CONFIG.Flow_Control {Blocking} \
   CONFIG.Has_ARESETn {true} \
   CONFIG.Has_RESULT_TREADY {true} \
   CONFIG.Operation_Type {Multiply} \
   CONFIG.Result_Precision_Type {Single} \
 ] $mul_0

  # Create instance: mul_1, and set properties
  set mul_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 mul_1 ]
  set_property -dict [ list \
   CONFIG.C_Latency {9} \
   CONFIG.C_Mult_Usage {Full_Usage} \
   CONFIG.C_Rate {1} \
   CONFIG.C_Result_Exponent_Width {8} \
   CONFIG.C_Result_Fraction_Width {24} \
   CONFIG.Flow_Control {Blocking} \
   CONFIG.Has_ARESETn {true} \
   CONFIG.Has_RESULT_TREADY {true} \
   CONFIG.Operation_Type {Multiply} \
   CONFIG.Result_Precision_Type {Single} \
 ] $mul_1

  # Create instance: mul_2, and set properties
  set mul_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 mul_2 ]
  set_property -dict [ list \
   CONFIG.C_Latency {9} \
   CONFIG.C_Mult_Usage {Full_Usage} \
   CONFIG.C_Rate {1} \
   CONFIG.C_Result_Exponent_Width {8} \
   CONFIG.C_Result_Fraction_Width {24} \
   CONFIG.Flow_Control {Blocking} \
   CONFIG.Has_ARESETn {true} \
   CONFIG.Has_RESULT_TREADY {true} \
   CONFIG.Operation_Type {Multiply} \
   CONFIG.Result_Precision_Type {Single} \
 ] $mul_2

  # Create instance: mul_3, and set properties
  set mul_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 mul_3 ]
  set_property -dict [ list \
   CONFIG.C_Latency {9} \
   CONFIG.C_Mult_Usage {Full_Usage} \
   CONFIG.C_Rate {1} \
   CONFIG.C_Result_Exponent_Width {8} \
   CONFIG.C_Result_Fraction_Width {24} \
   CONFIG.Flow_Control {Blocking} \
   CONFIG.Has_ARESETn {true} \
   CONFIG.Has_RESULT_TREADY {true} \
   CONFIG.Operation_Type {Multiply} \
   CONFIG.Result_Precision_Type {Single} \
 ] $mul_3

  # Create instance: mul_4, and set properties
  set mul_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 mul_4 ]
  set_property -dict [ list \
   CONFIG.C_Latency {9} \
   CONFIG.C_Mult_Usage {Full_Usage} \
   CONFIG.C_Rate {1} \
   CONFIG.C_Result_Exponent_Width {8} \
   CONFIG.C_Result_Fraction_Width {24} \
   CONFIG.Flow_Control {Blocking} \
   CONFIG.Has_ARESETn {true} \
   CONFIG.Has_RESULT_TREADY {true} \
   CONFIG.Operation_Type {Multiply} \
   CONFIG.Result_Precision_Type {Single} \
 ] $mul_4

  # Create instance: mul_5, and set properties
  set mul_5 [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 mul_5 ]
  set_property -dict [ list \
   CONFIG.C_Latency {9} \
   CONFIG.C_Mult_Usage {Full_Usage} \
   CONFIG.C_Rate {1} \
   CONFIG.C_Result_Exponent_Width {8} \
   CONFIG.C_Result_Fraction_Width {24} \
   CONFIG.Flow_Control {Blocking} \
   CONFIG.Has_ARESETn {true} \
   CONFIG.Has_RESULT_TREADY {true} \
   CONFIG.Operation_Type {Multiply} \
   CONFIG.Result_Precision_Type {Single} \
 ] $mul_5

  # Create instance: mul_6, and set properties
  set mul_6 [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 mul_6 ]
  set_property -dict [ list \
   CONFIG.C_Latency {9} \
   CONFIG.C_Mult_Usage {Full_Usage} \
   CONFIG.C_Rate {1} \
   CONFIG.C_Result_Exponent_Width {8} \
   CONFIG.C_Result_Fraction_Width {24} \
   CONFIG.Flow_Control {Blocking} \
   CONFIG.Has_ARESETn {true} \
   CONFIG.Has_RESULT_TREADY {true} \
   CONFIG.Operation_Type {Multiply} \
   CONFIG.Result_Precision_Type {Single} \
 ] $mul_6

  # Create instance: sub_0, and set properties
  set sub_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:floating_point:7.1 sub_0 ]
  set_property -dict [ list \
   CONFIG.Add_Sub_Value {Subtract} \
   CONFIG.C_Latency {6} \
   CONFIG.Has_ACLKEN {false} \
   CONFIG.Has_ARESETn {true} \
   CONFIG.Maximum_Latency {false} \
 ] $sub_0

  # Create interface connections
  connect_bd_intf_net -intf_net S_AXIS_0_1 [get_bd_intf_ports S_AXIS_ONE_MIN_C_QUAL_RIGHT] [get_bd_intf_pins axis_data_fifo_0/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_0_2 [get_bd_intf_ports S_AXIS_TOP_MATCH] [get_bd_intf_pins axis_data_fifo_1/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_0_3 [get_bd_intf_ports S_AXIS_PRIOR] [get_bd_intf_pins axis_data_fifo_2/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_0_4 [get_bd_intf_ports S_AXIS_ID] [get_bd_intf_pins axis_data_fifo_3/S_AXIS]
  connect_bd_intf_net -intf_net S_AXIS_A_0_1 [get_bd_intf_ports S_AXIS_TOP_INSERTION] [get_bd_intf_pins add_0/S_AXIS_A]
  connect_bd_intf_net -intf_net S_AXIS_A_0_3 [get_bd_intf_ports S_AXIS_LEFT_TA] [get_bd_intf_pins add_1/S_AXIS_A]
  connect_bd_intf_net -intf_net S_AXIS_A_0_4 [get_bd_intf_ports S_AXIS_I_QUAL] [get_bd_intf_pins mul_3/S_AXIS_A]
  connect_bd_intf_net -intf_net S_AXIS_A_0_5 [get_bd_intf_ports S_AXIS_C_QUAL] [get_bd_intf_pins mul_4/S_AXIS_A]
  connect_bd_intf_net -intf_net S_AXIS_A_0_6 [get_bd_intf_ports S_AXIS_D_QUAL] [get_bd_intf_pins mul_5/S_AXIS_A]
  connect_bd_intf_net -intf_net S_AXIS_A_0_7 [get_bd_intf_ports S_AXIS_C_QUAL_BIS] [get_bd_intf_pins mul_6/S_AXIS_A]
  connect_bd_intf_net -intf_net S_AXIS_A_0_8 [get_bd_intf_ports S_AXIS_I_QUAL_RIGHT] [get_bd_intf_pins add_4/S_AXIS_A]
  connect_bd_intf_net -intf_net S_AXIS_B_0_1 [get_bd_intf_ports S_AXIS_TOP_DELETION] [get_bd_intf_pins add_0/S_AXIS_B]
  connect_bd_intf_net -intf_net S_AXIS_B_0_3 [get_bd_intf_ports S_AXIS_LEFT_TB] [get_bd_intf_pins add_1/S_AXIS_B]
  connect_bd_intf_net -intf_net S_AXIS_B_0_4 [get_bd_intf_ports S_AXIS_LEFT_MATCH] [get_bd_intf_pins mul_3/S_AXIS_B]
  connect_bd_intf_net -intf_net S_AXIS_B_0_5 [get_bd_intf_ports S_AXIS_LEFT_INSERTION] [get_bd_intf_pins mul_4/S_AXIS_B]
  connect_bd_intf_net -intf_net S_AXIS_B_0_6 [get_bd_intf_ports S_AXIS_TOP_MATCH_BIS] [get_bd_intf_pins mul_5/S_AXIS_B]
  connect_bd_intf_net -intf_net S_AXIS_B_0_7 [get_bd_intf_ports S_AXIS_TOP_DELETION_BIS] [get_bd_intf_pins mul_6/S_AXIS_B]
  connect_bd_intf_net -intf_net S_AXIS_D_QUAL_RIGHT_1 [get_bd_intf_ports S_AXIS_D_QUAL_RIGHT] [get_bd_intf_pins add_4/S_AXIS_B]
  connect_bd_intf_net -intf_net S_AXIS_ONE_CONSTANT_1 [get_bd_intf_ports S_AXIS_ONE_CONSTANT] [get_bd_intf_pins sub_0/S_AXIS_A]
  connect_bd_intf_net -intf_net add_0_M_AXIS_RESULT [get_bd_intf_pins add_0/M_AXIS_RESULT] [get_bd_intf_pins mul_0/S_AXIS_A]
  connect_bd_intf_net -intf_net add_1_M_AXIS_RESULT [get_bd_intf_pins add_1/M_AXIS_RESULT] [get_bd_intf_pins mul_2/S_AXIS_A]
  connect_bd_intf_net -intf_net add_2_M_AXIS_RESULT [get_bd_intf_ports M_AXIS_RESULT_INSERTION] [get_bd_intf_pins add_2/M_AXIS_RESULT]
  connect_bd_intf_net -intf_net add_3_M_AXIS_RESULT [get_bd_intf_ports M_AXIS_RESULT_DELETION] [get_bd_intf_pins add_3/M_AXIS_RESULT]
  connect_bd_intf_net -intf_net add_4_M_AXIS_RESULT [get_bd_intf_pins add_4/M_AXIS_RESULT] [get_bd_intf_pins sub_0/S_AXIS_B]
  connect_bd_intf_net -intf_net axis_data_fifo_0_M_AXIS [get_bd_intf_pins axis_data_fifo_0/M_AXIS] [get_bd_intf_pins mul_0/S_AXIS_B]
  connect_bd_intf_net -intf_net axis_data_fifo_1_M_AXIS [get_bd_intf_pins axis_data_fifo_1/M_AXIS] [get_bd_intf_pins mul_1/S_AXIS_A]
  connect_bd_intf_net -intf_net axis_data_fifo_3_M_AXIS [get_bd_intf_pins axis_data_fifo_2/M_AXIS] [get_bd_intf_pins mul_2/S_AXIS_B]
  connect_bd_intf_net -intf_net axis_data_fifo_3_M_AXIS1 [get_bd_intf_ports M_AXIS_ID] [get_bd_intf_pins axis_data_fifo_3/M_AXIS]
  connect_bd_intf_net -intf_net floating_point_0_M_AXIS_RESULT [get_bd_intf_pins mul_1/S_AXIS_B] [get_bd_intf_pins sub_0/M_AXIS_RESULT]
  connect_bd_intf_net -intf_net mul_0_M_AXIS_RESULT [get_bd_intf_ports M_AXIS_RESULT_TA] [get_bd_intf_pins mul_0/M_AXIS_RESULT]
  connect_bd_intf_net -intf_net mul_1_M_AXIS_RESULT [get_bd_intf_ports M_AXIS_RESULT_TB] [get_bd_intf_pins mul_1/M_AXIS_RESULT]
  connect_bd_intf_net -intf_net mul_2_M_AXIS_RESULT [get_bd_intf_ports M_AXIS_RESULT_MATCH] [get_bd_intf_pins mul_2/M_AXIS_RESULT]
  connect_bd_intf_net -intf_net mul_3_M_AXIS_RESULT [get_bd_intf_pins add_2/S_AXIS_A] [get_bd_intf_pins mul_3/M_AXIS_RESULT]
  connect_bd_intf_net -intf_net mul_4_M_AXIS_RESULT [get_bd_intf_pins add_2/S_AXIS_B] [get_bd_intf_pins mul_4/M_AXIS_RESULT]
  connect_bd_intf_net -intf_net mul_5_M_AXIS_RESULT [get_bd_intf_pins add_3/S_AXIS_A] [get_bd_intf_pins mul_5/M_AXIS_RESULT]
  connect_bd_intf_net -intf_net mul_6_M_AXIS_RESULT [get_bd_intf_pins add_3/S_AXIS_B] [get_bd_intf_pins mul_6/M_AXIS_RESULT]

  # Create port connections
  connect_bd_net -net aclk_0_1 [get_bd_ports aclk] [get_bd_pins add_0/aclk] [get_bd_pins add_1/aclk] [get_bd_pins add_2/aclk] [get_bd_pins add_3/aclk] [get_bd_pins add_4/aclk] [get_bd_pins axis_data_fifo_0/s_axis_aclk] [get_bd_pins axis_data_fifo_1/s_axis_aclk] [get_bd_pins axis_data_fifo_2/s_axis_aclk] [get_bd_pins axis_data_fifo_3/s_axis_aclk] [get_bd_pins mul_0/aclk] [get_bd_pins mul_1/aclk] [get_bd_pins mul_2/aclk] [get_bd_pins mul_3/aclk] [get_bd_pins mul_4/aclk] [get_bd_pins mul_5/aclk] [get_bd_pins mul_6/aclk] [get_bd_pins sub_0/aclk]
  connect_bd_net -net aresetn_1 [get_bd_ports aresetn] [get_bd_pins add_0/aresetn] [get_bd_pins add_1/aresetn] [get_bd_pins add_2/aresetn] [get_bd_pins add_3/aresetn] [get_bd_pins add_4/aresetn] [get_bd_pins axis_data_fifo_0/s_axis_aresetn] [get_bd_pins axis_data_fifo_1/s_axis_aresetn] [get_bd_pins axis_data_fifo_2/s_axis_aresetn] [get_bd_pins axis_data_fifo_3/s_axis_aresetn] [get_bd_pins mul_0/aresetn] [get_bd_pins mul_1/aresetn] [get_bd_pins mul_2/aresetn] [get_bd_pins mul_3/aresetn] [get_bd_pins mul_4/aresetn] [get_bd_pins mul_5/aresetn] [get_bd_pins mul_6/aresetn] [get_bd_pins sub_0/aresetn]

  # Create address segments


  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


