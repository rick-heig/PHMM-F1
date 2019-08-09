`ifndef CL_DEFINES_REDS_
 `define CL_DEFINES_REDS_

 // DO NOT CHANGE VALUES BELOW !

 //Put module name of the CL design here.  This is used to instantiate in top.sv
 `define CL_NAME cl_top

 //Highly recommeneded.  For lib FIFO block, uses less async reset (take advantage of
 // FPGA flop init capability).  This will help with routing resources.
 `define FPGA_LESS_RST

 // DDR4 A,B, and D blocks
 `define USE_EXTRA_DDR_MODULES

 `ifdef USE_EXTRA_DDR_MODULES
  `define DDR_A_PRESENT 1
  `define DDR_B_PRESENT 1
  `define DDR_D_PRESENT 1
 `else
  `define DDR_A_PRESENT 0
  `define DDR_B_PRESENT 0
  `define DDR_D_PRESENT 0
 `endif

 // CL Register Addresses

 // Data type defines (don't change)
 `define FLOATING_POINT_WIDTH 32

`endif
