//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : cl_interfaces.sv
// Description  :
//
// Author       : Rick Wertenbroek
// Date         : 28.01.19
// Version      : 0.0
//
// Dependencies :
//
// Modifications //------------------------------------------------------------
// Version   Author Date               Description
// 0.0       RWE    28.01.19           Creation
//-----------------------------------------------------------------------------

interface bram_t #(
    type T = logic [7:0],
    //parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 8
) (
    input logic clock
);
    T                      read_data;
    T                      write_data;
    logic [ADDR_WIDTH-1:0] read_addr;
    logic [ADDR_WIDTH-1:0] write_addr;
    logic                  read_en;
    logic                  write_en;

    modport master_read (
        input  clock,
        input  read_data,
        output read_addr,
        output read_en
        );

    modport slave_read (
        input  clock,
        output read_data,
        input  read_addr,
        input  read_en
        );

    modport master_write (
        input  clock,
        output write_data,
        output write_addr,
        output write_en
        );

    modport slave_write (
        input clock,
        input write_data,
        input write_addr,
        input write_en
        );

endinterface // bram_t

interface bram_if #(
    type T = logic [7:0],
    //parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 8
) (
    input logic clock
);
    T                      read_data;
    T                      write_data;
    logic [ADDR_WIDTH-1:0] read_addr;
    logic [ADDR_WIDTH-1:0] write_addr;
    logic                  read_en;
    logic                  write_en;

    modport master_read (
        input  clock,
        input  read_data,
        output read_addr,
        output read_en
        );

    modport slave_read (
        input  clock,
        output read_data,
        input  read_addr,
        input  read_en
        );

    modport master_write (
        input  clock,
        output write_data,
        output write_addr,
        output write_en
        );

    modport slave_write (
        input clock,
        input write_data,
        input write_addr,
        input write_en
        );

endinterface // bram_if

interface fifo_if #(
    type T = logic [7:0]
) (
    input logic clock
);

    T         read_data;
    T         write_data;
    logic     full;
    logic     write;
    logic     empty;
    logic     read;

    modport master_write (
        output write_data,
        input  full,
        output write
        );

    modport slave_write (
        input  write_data,
        output full,
        input  write
        );

    modport master_read (
        input  read_data,
        input  empty,
        output read
        );

    modport slave_read (
        output read_data,
        output empty,
        input  read
        );

endinterface // fifo_if

interface axi_stream_simple_if #(
    parameter WIDTH_IN_BYTES = 1
) (
    input logic aclk
);
    logic [WIDTH_IN_BYTES*8-1:0] tdata;
    logic                        tvalid;
    logic                        tready;

    modport master (
        output tdata,
        output tvalid,
        input  tready
        );

    modport slave (
        input  tdata,
        input  tvalid,
        output tready
        );

endinterface // axi_stream_simple_if

// This interface uses AXI Stream signaling but doesn't have
// a width that is necessarily a multiple of 8 (bytes)
interface axi_stream_generic_if #(
    type T = logic[7:0]
) ();
    T           tdata;
    logic       tvalid;
    logic       tready;

    modport master (
        output tdata,
        output tvalid,
        input  tready
        );

    modport slave (
        input  tdata,
        input  tvalid,
        output tready
        );

endinterface // axi_stream_generic_if

interface axi_lite_if #(
    parameter WIDTH_IN_BYTES = 4,
    parameter ADDR_WIDTH = 32
) ();
    logic                        aclk;
    logic                        aresetn;

    logic [ADDR_WIDTH-1:0]       awaddr;
    logic                        awvalid;
    logic                        awready;

    logic [WIDTH_IN_BYTES*8-1:0] wdata;
    logic [WIDTH_IN_BYTES-1:0]   wstrb;
    logic                        wvalid;
    logic                        wready;

    logic [1:0]                  bresp;
    logic                        bvalid;
    logic                        bready;

    logic [ADDR_WIDTH-1:0]       araddr;
    logic                        arvalid;
    logic                        arready;

    logic [WIDTH_IN_BYTES*8-1:0] rdata;
    logic [1:0]                  rresp;
    logic                        rvalid;
    logic                        rready;

    modport master (
        input  aclk,
        input  aresetn,

        output awaddr,
        output awvalid,
        input  awready,

        output wdata,
        output wstrb,
        output wvalid,
        input  wready,

        input  bresp,
        input  bvalid,
        output bready,

        output araddr,
        output arvalid,
        input  arready,

        input  rdata,
        input  rresp,
        input  rvalid,
        output rready
        );

    modport slave (
        input  aclk,
        input  aresetn,

        input  awaddr,
        input  awvalid,
        output awready,

        input  wdata,
        input  wstrb,
        input  wvalid,
        output wready,

        output bresp,
        output bvalid,
        input  bready,

        input  araddr,
        input  arvalid,
        output arready,

        output rdata,
        output rresp,
        output rvalid,
        input  rready
        );

endinterface // axi_lite_if

interface axi_if #(
    parameter WIDTH_IN_BYTES = 64,
    parameter ADDR_WIDTH = 64,
    parameter ID_WIDTH = 16
) ();
    logic                        aclk;
    logic                        aresetn;

    logic [ID_WIDTH-1:0]         awid;
    logic [ADDR_WIDTH-1:0]       awaddr;
    logic [7:0]                  awlen;
    logic [2:0]                  awsize;
    logic [1:0]                  awburst;
    logic                        awvalid;
    logic                        awready;

    logic [ID_WIDTH-1:0]         wid;
    logic [WIDTH_IN_BYTES*8-1:0] wdata;
    logic [WIDTH_IN_BYTES-1:0]   wstrb;
    logic                        wlast;
    logic                        wvalid;
    logic                        wready;

    logic [ID_WIDTH-1:0]         bid;
    logic [1:0]                  bresp;
    logic                        bvalid;
    logic                        bready;

    logic [ID_WIDTH-1:0]         arid;
    logic [ADDR_WIDTH-1:0]       araddr;
    logic [7:0]                  arlen;
    logic [2:0]                  arsize;
    logic [1:0]                  arburst;
    logic                        arvalid;
    logic                        arready;

    logic [ID_WIDTH-1:0]         rid;
    logic [WIDTH_IN_BYTES*8-1:0] rdata;
    logic [1:0]                  rresp;
    logic                        rlast;
    logic                        rvalid;
    logic                        rready;

    modport master (
        input  aclk,
        input  aresetn,

        output awid,
        output awaddr,
        output awlen,
        output awsize,
        output awburst,
        output awvalid,
        input  awready,

        output wid,
        output wdata,
        output wstrb,
        output wlast,
        output wvalid,
        input  wready,

        input  bid,
        input  bresp,
        input  bvalid,
        output bready,

        output arid,
        output araddr,
        output arlen,
        output arsize,
        output arburst,
        output arvalid,
        input  arready,

        input  rid,
        input  rdata,
        input  rresp,
        input  rlast,
        input  rvalid,
        output rready
        );

    modport slave (
        input  aclk,
        input  aresetn,

        input  awid,
        input  awaddr,
        input  awlen,
        input  awsize,
        input  awburst,
        input  awvalid,
        output awready,

        input  wid,
        input  wdata,
        input  wstrb,
        input  wlast,
        input  wvalid,
        output wready,

        output bid,
        output bresp,
        output bvalid,
        input  bready,

        input  arid,
        input  araddr,
        input  arlen,
        input  arsize,
        input  arburst,
        input  arvalid,
        output arready,

        output rid,
        output rdata,
        output rresp,
        output rlast,
        output rvalid,
        input  rready
        );

endinterface // axi_if
