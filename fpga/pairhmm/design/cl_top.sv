//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : cl_top.sv
// Description  : Top module for Amazon F1 FPGA accelerator
//
// Author       : Rick Wertenbroek
// Date         : 22.01.19
// Version      : 0.0
//
// Dependencies :
//
// Modifications //------------------------------------------------------------
// Version   Author Date               Description
// 0.0       RWE    22.01.19           Creation
// 0.1       RWE    01.07.19           Multiple accelerator version
//-----------------------------------------------------------------------------

`include "cl_defines.vh"
`include "cl_id_defines.vh"
`include "cl_pairhmm_package.vh"

// Define all the parts used in this top
`define USE_DDR_C
`define USE_DMA_PCIS
`define USE_SH_OCL
`define USE_APPPF_IRQ
//`define USE_EXTRA_DDR_MODULES // In cl_defines.vh

module cl_top #(parameter DEBUG_ILA = 0, parameter NUM_WORKGROUPS = 4, parameter NUM_WORKERS_PER_WORKGROUP = 4, parameter NUMBER_OF_ACCELERATORS = 1)
(
    `include "cl_ports.vh" // Fixed port definition
);

    // REMEMBER TO TIE OFF ALL UNUSED INTERFACES
    // They are tied off in the code below but in newer versions it is
    // recommended to use the unused part templates in
    // /common/shell_vXXXXXX/design/interfaces/unused_xxx_template.inc

    // List of templates for unused interfaces
    `ifndef USE_APPPF_IRQ
     `include "unused_apppf_irq_template.inc"
    `endif
    `ifndef USE_CL_SDA
     `include "unused_cl_sda_template.inc"
    `endif
    `ifndef USE_DDR_C
     `include "unused_ddr_c_template.inc"
    `endif
    `ifndef USE_EXTRA_DDR_MODULES
     `include "unused_ddr_a_b_d_template.inc"
    `endif
    `ifndef USE_DMA_PCIS
     `include "unused_dma_pcis_template.inc"
    `endif
    `ifndef USE_FLR
     `include "unused_flr_template.inc"
    `endif
    `ifndef USE_PCIM
     `include "unused_pcim_template.inc"
    `endif
    `ifndef USE_SH_BAR1
     `include "unused_sh_bar1_template.inc"
    `endif
    `ifndef USE_SH_OCL
     `include "unused_sh_ocl_template.inc"
    `endif

    // Wires to connect my modules
    logic clk;
    logic pair_hmm_interrupt_a;
    logic pair_hmm_interrupt_b;
    logic pair_hmm_interrupt_c;
    logic pair_hmm_interrupt_d;
    logic pair_hmm_interrupt[4];

    // Note : _q signals are busses that come out of a register slice
    // They may be unused if the register slice is not needed
    axi_if sh_cl_dma_pcis_bus();
    axi_if sh_cl_dma_pcis_q();
    axi_if cl_axi_mstr_bus();
    axi_if cl_sh_ddr();
    axi_if cl_sh_ddr_q();
    axi_if lcl_cl_sh_ddra();
    axi_if lcl_cl_sh_ddra_q();
    axi_if lcl_cl_sh_ddrb();
    axi_if lcl_cl_sh_ddrb_q();
    axi_if lcl_cl_sh_ddrc();
    axi_if lcl_cl_sh_ddrc_q();
    axi_if lcl_cl_sh_ddrd();
    axi_if lcl_cl_sh_ddrd_q();
    axi_if cl_sh_ddra();
    axi_if cl_sh_ddrb();
    axi_if cl_sh_ddrc();
    axi_if cl_sh_ddrd();
    axi_if cl_phmm_ddra();
    axi_if cl_phmm_ddrb();
    axi_if cl_phmm_ddrc();
    axi_if cl_phmm_ddrd();

    axi_lite_if sh_ocl_bus();
    // OLC busses for when there are more than 1 accelerator
    axi_lite_if ocl_bus_a();
    axi_lite_if ocl_bus_b();
    axi_lite_if ocl_bus_c();
    axi_lite_if ocl_bus_d();

    // Wires to connect other DDR modules
    logic [15:0]  cl_sh_ddr_awid_2d[2:0];
    logic [63:0]  cl_sh_ddr_awaddr_2d[2:0];
    logic [7:0]   cl_sh_ddr_awlen_2d[2:0];
    logic [2:0]   cl_sh_ddr_awsize_2d[2:0];
    logic [1:0]   cl_sh_ddr_awburst_2d[2:0];
    logic         cl_sh_ddr_awvalid_2d [2:0];
    logic [2:0]   sh_cl_ddr_awready_2d;

    logic [15:0]  cl_sh_ddr_wid_2d[2:0];
    logic [511:0] cl_sh_ddr_wdata_2d[2:0];
    logic [63:0]  cl_sh_ddr_wstrb_2d[2:0];
    logic [2:0]   cl_sh_ddr_wlast_2d;
    logic [2:0]   cl_sh_ddr_wvalid_2d;
    logic [2:0]   sh_cl_ddr_wready_2d;

    logic [15:0]  sh_cl_ddr_bid_2d[2:0];
    logic [1:0]   sh_cl_ddr_bresp_2d[2:0];
    logic [2:0]   sh_cl_ddr_bvalid_2d;
    logic [2:0]   cl_sh_ddr_bready_2d;

    logic [15:0]  cl_sh_ddr_arid_2d[2:0];
    logic [63:0]  cl_sh_ddr_araddr_2d[2:0];
    logic [7:0]   cl_sh_ddr_arlen_2d[2:0];
    logic [2:0]   cl_sh_ddr_arsize_2d[2:0];
    logic [1:0]   cl_sh_ddr_arburst_2d[2:0];
    logic [2:0]   cl_sh_ddr_arvalid_2d;
    logic [2:0]   sh_cl_ddr_arready_2d;

    logic [15:0]  sh_cl_ddr_rid_2d[2:0];
    logic [511:0] sh_cl_ddr_rdata_2d[2:0];
    logic [1:0]   sh_cl_ddr_rresp_2d[2:0];
    logic [2:0]   sh_cl_ddr_rlast_2d;
    logic [2:0]   sh_cl_ddr_rvalid_2d;
    logic [2:0]   cl_sh_ddr_rready_2d;

    logic [2:0]   sh_cl_ddr_is_ready_2d;

    logic [7:0]   sh_ddr_stat_addr_2d[2:0];
    logic [2:0]   sh_ddr_stat_wr_2d;
    logic [2:0]   sh_ddr_stat_rd_2d;
    logic [31:0]  sh_ddr_stat_wdata_2d[2:0];
    logic [2:0]   ddr_sh_stat_ack_2d;
    logic [31:0]  ddr_sh_stat_rdata_2d[2:0];
    logic [7:0]   ddr_sh_stat_int_2d[2:0];

    `ifdef USE_EXTRA_DDR_MODULES
    // Wires to connect ddr controller inputs to 0
    logic [2:0]        tie_zero;
    logic [2:0][5:0]   tie_zero_id;
    logic [2:0][63:0]  tie_zero_addr;
    logic [2:0][7:0]   tie_zero_len;
    logic [2:0][511:0] tie_zero_data;
    logic [2:0][63:0]  tie_zero_strb;
    `endif

    assign clk = clk_main_a0;

    //-------------------------------------------------
    // Reset Synchronization
    //-------------------------------------------------
    logic pre_sync_rst_n;
    logic sync_rst_n;

    always_ff @(negedge rst_main_n or posedge clk_main_a0)
        if (!rst_main_n)
            begin
                pre_sync_rst_n <= 0;
                sync_rst_n     <= 0;
            end
        else
            begin
                pre_sync_rst_n <= 1;
                sync_rst_n     <= pre_sync_rst_n;
            end

    //reset synchronizers
    (* dont_touch = "true" *) logic dma_pcis_slv_sync_rst_n;
lib_pipe #(.WIDTH(1), .STAGES(4)) DMA_PCIS_SLV_SLC_RST_N (.clk(clk), .rst_n(1'b1), .in_bus(sync_rst_n), .out_bus(dma_pcis_slv_sync_rst_n));
    (* dont_touch = "true" *) logic slr0_sync_aresetn;
    (* dont_touch = "true" *) logic slr1_sync_aresetn;
    (* dont_touch = "true" *) logic slr2_sync_aresetn;
    lib_pipe #(.WIDTH(1), .STAGES(4)) SLR0_PIPE_RST_N (.clk(clk_main_a0), .rst_n(1'b1), .in_bus(dma_pcis_slv_sync_rst_n), .out_bus(slr0_sync_aresetn));
    lib_pipe #(.WIDTH(1), .STAGES(4)) SLR1_PIPE_RST_N (.clk(clk_main_a0), .rst_n(1'b1), .in_bus(dma_pcis_slv_sync_rst_n), .out_bus(slr1_sync_aresetn));
    lib_pipe #(.WIDTH(1), .STAGES(4)) SLR2_PIPE_RST_N (.clk(clk_main_a0), .rst_n(1'b1), .in_bus(dma_pcis_slv_sync_rst_n), .out_bus(slr2_sync_aresetn));

    // Get a positive reset for our own designs
    assign positive_reset = ~sync_rst_n;

    //-----------------------//
    // Pair-HMM modules here //
    //-----------------------//

    // Control bus
    assign sh_ocl_bus.awvalid      = sh_ocl_awvalid;
    assign sh_ocl_bus.awaddr[31:0] = sh_ocl_awaddr;
    assign ocl_sh_awready          = sh_ocl_bus.awready;
    assign sh_ocl_bus.wvalid       = sh_ocl_wvalid;
    assign sh_ocl_bus.wdata[31:0]  = sh_ocl_wdata;
    assign sh_ocl_bus.wstrb[3:0]   = sh_ocl_wstrb;
    assign ocl_sh_wready           = sh_ocl_bus.wready;
    assign ocl_sh_bvalid           = sh_ocl_bus.bvalid;
    assign ocl_sh_bresp            = sh_ocl_bus.bresp;
    assign sh_ocl_bus.bready       = sh_ocl_bready;
    assign sh_ocl_bus.arvalid      = sh_ocl_arvalid;
    assign sh_ocl_bus.araddr[31:0] = sh_ocl_araddr;
    assign ocl_sh_arready          = sh_ocl_bus.arready;
    assign ocl_sh_rvalid           = sh_ocl_bus.rvalid;
    assign ocl_sh_rresp            = sh_ocl_bus.rresp;
    assign ocl_sh_rdata            = sh_ocl_bus.rdata[31:0];
    assign sh_ocl_bus.rready       = sh_ocl_rready;

    // At most one top (accelerator) per DDR4 module
    generate
        if (NUMBER_OF_ACCELERATORS == 1) begin
            // If only one accelerator there is no need for an interconnect on the OCL bus

            // First top
            cl_pairhmm_top #(
                .VERSION_MAGIC(`VERSION_MAGIC),
                .NUMBER_OF_WORKGROUPS(NUM_WORKGROUPS),
                .NUMBER_OF_WORKERS_PER_WORKGROUP(NUM_WORKERS_PER_WORKGROUP),
                .DEBUG_VERBOSITY(0))
            pairhmm_top_inst_a (
                .clock_i(clk), // Is shared with the AXI interfaces - Must be the same clock
                .reset_i(positive_reset),
                .axi_lite_slave_control_bus(sh_ocl_bus),
                .axi_master_to_ddr4(cl_phmm_ddra),
                .interrupt_o(pair_hmm_interrupt_a));
        end else begin

            // When more than a single accelerator we need an interconnect module on the OCL bus
            // OCL interconnect
            cl_axi_lite_interconnect_1_to_4_wrapper ocl_interconnect (
                .aclk(clk),
                .aresetn(dma_pcis_slv_sync_rst_n),
                .s00_axi_lite(sh_ocl_bus),
                .m00_axi_lite(ocl_bus_a),
                .m01_axi_lite(ocl_bus_b),
                .m02_axi_lite(ocl_bus_c),
                .m03_axi_lite(ocl_bus_d));

            // First top (This time connected to the interconnect instead of directly to the OCL bus)
            cl_pairhmm_top #(
                .VERSION_MAGIC(`VERSION_MAGIC),
                .NUMBER_OF_WORKGROUPS(NUM_WORKGROUPS),
                .NUMBER_OF_WORKERS_PER_WORKGROUP(NUM_WORKERS_PER_WORKGROUP),
                .DEBUG_VERBOSITY(0))
            pairhmm_top_inst_a (
                .clock_i(clk), // Is shared with the AXI interfaces - Must be the same clock
                .reset_i(positive_reset),
                .axi_lite_slave_control_bus(ocl_bus_a),
                .axi_master_to_ddr4(cl_phmm_ddra),
                .interrupt_o(pair_hmm_interrupt_a));
        end

        if (NUMBER_OF_ACCELERATORS > 1) begin
            // Second Pair-HMM top
            cl_pairhmm_top #(
                .DDR4_MODULE_OFFSET(64'h4_0000_0000),
                .VERSION_MAGIC(`VERSION_MAGIC),
                .NUMBER_OF_WORKGROUPS(NUM_WORKGROUPS),
                .NUMBER_OF_WORKERS_PER_WORKGROUP(NUM_WORKERS_PER_WORKGROUP),
                .DEBUG_VERBOSITY(0))
            pairhmm_top_inst_b (
                .clock_i(clk), // Is shared with the AXI interfaces - Must be the same clock
                .reset_i(positive_reset),
                .axi_lite_slave_control_bus(ocl_bus_b),
                .axi_master_to_ddr4(cl_phmm_ddrb),
                .interrupt_o(pair_hmm_interrupt_b));
        end else begin
            // No second top
            cl_tie_down_axi_master tie_your_master_down_b (
                .axi_master_bus(cl_phmm_ddrb));
            // Reading in the second top address space will always return 0
            cl_zero_axi_lite_slave the_zero_b (
                .axi_lite_slave_bus(ocl_bus_b));
            // No interrupt
            assign pair_hmm_interrupt_b = 1'b0;
        end

        if (NUMBER_OF_ACCELERATORS > 2) begin
            // Third Pair-HMM top
            cl_pairhmm_top #(
                .DDR4_MODULE_OFFSET(64'h8_0000_0000),
                .VERSION_MAGIC(`VERSION_MAGIC),
                .NUMBER_OF_WORKGROUPS(NUM_WORKGROUPS),
                .NUMBER_OF_WORKERS_PER_WORKGROUP(NUM_WORKERS_PER_WORKGROUP),
                .DEBUG_VERBOSITY(0))
            pairhmm_top_inst_c (
                .clock_i(clk), // Is shared with the AXI interfaces - Must be the same clock
                .reset_i(positive_reset),
                .axi_lite_slave_control_bus(ocl_bus_c),
                .axi_master_to_ddr4(cl_phmm_ddrc),
                .interrupt_o(pair_hmm_interrupt_c));
        end else begin
            // No third top
            cl_tie_down_axi_master tie_your_master_down_c (
                .axi_master_bus(cl_phmm_ddrc));
            // Reading in the third top address space will always return 0
            cl_zero_axi_lite_slave the_zero_c (
                .axi_lite_slave_bus(ocl_bus_c));
            // No interrupt
            assign pair_hmm_interrupt_c = 1'b0;
        end

        if (NUMBER_OF_ACCELERATORS > 3) begin
            // Fourth Pair-HMM top
            cl_pairhmm_top #(
                .DDR4_MODULE_OFFSET(64'hC_0000_0000),
                .VERSION_MAGIC(`VERSION_MAGIC),
                .NUMBER_OF_WORKGROUPS(NUM_WORKGROUPS),
                .NUMBER_OF_WORKERS_PER_WORKGROUP(NUM_WORKERS_PER_WORKGROUP),
                .DEBUG_VERBOSITY(0))
            pairhmm_top_inst_d (
                .clock_i(clk), // Is shared with the AXI interfaces - Must be the same clock
                .reset_i(positive_reset),
                .axi_lite_slave_control_bus(ocl_bus_d),
                .axi_master_to_ddr4(cl_phmm_ddrd),
                .interrupt_o(pair_hmm_interrupt_d));
        end else begin
            // No fourth top
            cl_tie_down_axi_master tie_your_master_down_d (
                .axi_master_bus(cl_phmm_ddrd));
            // Reading in the fourth top address space will always return 0
            cl_zero_axi_lite_slave the_zero_d (
                .axi_lite_slave_bus(ocl_bus_d));
            // No interrupt
            assign pair_hmm_interrupt_d = 1'b0;
        end

        if (NUMBER_OF_ACCELERATORS > 4) begin
            $warning("Only up to 4 accelerators are supported for now, only 4 of %d will be created.", NUMBER_OF_ACCELERATORS);
        end

    endgenerate


    //-----------------//
    // AXI Connections //
    //-----------------//

    assign sh_cl_dma_pcis_bus.awid[15:6] = 10'b0;
    assign sh_cl_dma_pcis_bus.wid        = 'b0;
    assign sh_cl_dma_pcis_bus.arid[15:6] = 10'b0;
    assign sh_cl_dma_pcis_q.bid[15:6]    = 11'b0;
    assign sh_cl_dma_pcis_q.rid[15:6]    = 11'b0;

    // IDs on AXI busses to DDR4 modules
    assign lcl_cl_sh_ddra.awid[15:7]     = 11'b0;
    assign lcl_cl_sh_ddra.wid            = 'b0;
    assign lcl_cl_sh_ddra.arid[15:7]     = 11'b0;
    assign lcl_cl_sh_ddrb.awid[15:7]     = 11'b0;
    assign lcl_cl_sh_ddrb.wid            = 'b0;
    assign lcl_cl_sh_ddrb.arid[15:7]     = 11'b0;
    assign lcl_cl_sh_ddrc.awid[15:7]     = 11'b0;
    assign lcl_cl_sh_ddrc.wid            = 'b0;
    assign lcl_cl_sh_ddrc.arid[15:7]     = 11'b0;
    assign lcl_cl_sh_ddrd.awid[15:7]     = 11'b0;
    assign lcl_cl_sh_ddrd.wid            = 'b0;
    assign lcl_cl_sh_ddrd.arid[15:7]     = 11'b0;

    // Assign the PCIS DMA input on the bus
    assign sh_cl_dma_pcis_bus.awvalid   = sh_cl_dma_pcis_awvalid;
    assign sh_cl_dma_pcis_bus.awaddr    = sh_cl_dma_pcis_awaddr;
    assign sh_cl_dma_pcis_bus.awid[5:0] = sh_cl_dma_pcis_awid;
    assign sh_cl_dma_pcis_bus.awlen     = sh_cl_dma_pcis_awlen;
    assign sh_cl_dma_pcis_bus.awsize    = sh_cl_dma_pcis_awsize;
    assign cl_sh_dma_pcis_awready       = sh_cl_dma_pcis_bus.awready;
    assign sh_cl_dma_pcis_bus.wvalid    = sh_cl_dma_pcis_wvalid;
    assign sh_cl_dma_pcis_bus.wdata     = sh_cl_dma_pcis_wdata;
    assign sh_cl_dma_pcis_bus.wstrb     = sh_cl_dma_pcis_wstrb;
    assign sh_cl_dma_pcis_bus.wlast     = sh_cl_dma_pcis_wlast;
    assign cl_sh_dma_pcis_wready        = sh_cl_dma_pcis_bus.wready;
    assign cl_sh_dma_pcis_bvalid        = sh_cl_dma_pcis_bus.bvalid;
    assign cl_sh_dma_pcis_bresp         = sh_cl_dma_pcis_bus.bresp;
    assign sh_cl_dma_pcis_bus.bready    = sh_cl_dma_pcis_bready;
    assign cl_sh_dma_pcis_bid           = sh_cl_dma_pcis_bus.bid[5:0];
    assign sh_cl_dma_pcis_bus.arvalid   = sh_cl_dma_pcis_arvalid;
    assign sh_cl_dma_pcis_bus.araddr    = sh_cl_dma_pcis_araddr;
    assign sh_cl_dma_pcis_bus.arid[5:0] = sh_cl_dma_pcis_arid;
    assign sh_cl_dma_pcis_bus.arlen     = sh_cl_dma_pcis_arlen;
    assign sh_cl_dma_pcis_bus.arsize    = sh_cl_dma_pcis_arsize;
    assign cl_sh_dma_pcis_arready       = sh_cl_dma_pcis_bus.arready;
    assign cl_sh_dma_pcis_rvalid        = sh_cl_dma_pcis_bus.rvalid;
    assign cl_sh_dma_pcis_rid           = sh_cl_dma_pcis_bus.rid[5:0];
    assign cl_sh_dma_pcis_rlast         = sh_cl_dma_pcis_bus.rlast;
    assign cl_sh_dma_pcis_rresp         = sh_cl_dma_pcis_bus.rresp;
    assign cl_sh_dma_pcis_rdata         = sh_cl_dma_pcis_bus.rdata;
    assign sh_cl_dma_pcis_bus.rready    = sh_cl_dma_pcis_rready;

    // AXI Register slice (Check : IP has no SLR crossing enabled as configured by amazon in the common section)
    cl_axi_register_slice axi_register_slice_pcis (
        .aclk(clk),
        .aresetn(dma_pcis_slv_sync_rst_n),
        .s_axi(sh_cl_dma_pcis_bus),
        .m_axi(sh_cl_dma_pcis_q));

    // Tie down
    //assign sh_cl_dma_pcis_bus.awid[15:6] = 10'b0;
    //assign sh_cl_dma_pcis_bus.wid[15:6]  = 10'b0;
    //assign sh_cl_dma_pcis_bus.arid[15:6] = 10'b0;

    // DDR C
    assign cl_sh_ddr_awid     = cl_sh_ddrc.awid;
    assign cl_sh_ddr_awaddr   = cl_sh_ddrc.awaddr;
    assign cl_sh_ddr_awlen    = cl_sh_ddrc.awlen;
    assign cl_sh_ddr_awsize   = cl_sh_ddrc.awsize;
    assign cl_sh_ddr_awvalid  = cl_sh_ddrc.awvalid;
    assign cl_sh_ddr_awburst  = cl_sh_ddrc.awburst;
    assign cl_sh_ddrc.awready = sh_cl_ddr_awready;
    assign cl_sh_ddr_wid      = 16'b0;
    assign cl_sh_ddr_wdata    = cl_sh_ddrc.wdata;
    assign cl_sh_ddr_wstrb    = cl_sh_ddrc.wstrb;
    assign cl_sh_ddr_wlast    = cl_sh_ddrc.wlast;
    assign cl_sh_ddr_wvalid   = cl_sh_ddrc.wvalid;
    assign cl_sh_ddrc.wready  = sh_cl_ddr_wready;
    assign cl_sh_ddrc.bid     = sh_cl_ddr_bid;
    assign cl_sh_ddrc.bresp   = sh_cl_ddr_bresp;
    assign cl_sh_ddrc.bvalid  = sh_cl_ddr_bvalid;
    assign cl_sh_ddr_bready   = cl_sh_ddrc.bready;
    assign cl_sh_ddr_arid     = cl_sh_ddrc.arid;
    assign cl_sh_ddr_araddr   = cl_sh_ddrc.araddr;
    assign cl_sh_ddr_arlen    = cl_sh_ddrc.arlen;
    assign cl_sh_ddr_arsize   = cl_sh_ddrc.arsize;
    assign cl_sh_ddr_arvalid  = cl_sh_ddrc.arvalid;
    assign cl_sh_ddr_arburst  = cl_sh_ddrc.arburst;
    assign cl_sh_ddrc.arready = sh_cl_ddr_arready;
    assign cl_sh_ddrc.rid     = sh_cl_ddr_rid;
    assign cl_sh_ddrc.rresp   = sh_cl_ddr_rresp;
    assign cl_sh_ddrc.rvalid  = sh_cl_ddr_rvalid;
    assign cl_sh_ddrc.rdata   = sh_cl_ddr_rdata;
    assign cl_sh_ddrc.rlast   = sh_cl_ddr_rlast;
    assign cl_sh_ddr_rready   = cl_sh_ddrc.rready;

    //-------------------------------------------------------//
    // axi interconnect for DDR address decoding (16GB each) //
    // for AXI PCIS DMA - Tier 1 interconnect                //
    //-------------------------------------------------------//

    // We se here why SystemVerilog interfaces are a blessing,
    // compare this instanciation with the ones below
    (* dont_touch = "true" *) cl_axi_interconnect AXI_CROSSBAR
       (.ACLK(clk),
        .ARESETN(slr1_sync_aresetn),

        .M00_AXI_araddr(lcl_cl_sh_ddra.araddr),
        .M00_AXI_arburst(lcl_cl_sh_ddra.arburst),
        .M00_AXI_arcache(),
        .M00_AXI_arid(lcl_cl_sh_ddra.arid[6:0]),
        .M00_AXI_arlen(lcl_cl_sh_ddra.arlen),
        .M00_AXI_arlock(),
        .M00_AXI_arprot(),
        .M00_AXI_arqos(),
        .M00_AXI_arready(lcl_cl_sh_ddra.arready),
        .M00_AXI_arregion(),
        .M00_AXI_arsize(lcl_cl_sh_ddra.arsize),
        .M00_AXI_arvalid(lcl_cl_sh_ddra.arvalid),
        .M00_AXI_awaddr(lcl_cl_sh_ddra.awaddr),
        .M00_AXI_awburst(lcl_cl_sh_ddra.awburst),
        .M00_AXI_awcache(),
        .M00_AXI_awid(lcl_cl_sh_ddra.awid[6:0]),
        .M00_AXI_awlen(lcl_cl_sh_ddra.awlen),
        .M00_AXI_awlock(),
        .M00_AXI_awprot(),
        .M00_AXI_awqos(),
        .M00_AXI_awready(lcl_cl_sh_ddra.awready),
        .M00_AXI_awregion(),
        .M00_AXI_awsize(lcl_cl_sh_ddra.awsize),
        .M00_AXI_awvalid(lcl_cl_sh_ddra.awvalid),
        .M00_AXI_bid(lcl_cl_sh_ddra.bid[6:0]),
        .M00_AXI_bready(lcl_cl_sh_ddra.bready),
        .M00_AXI_bresp(lcl_cl_sh_ddra.bresp),
        .M00_AXI_bvalid(lcl_cl_sh_ddra.bvalid),
        .M00_AXI_rdata(lcl_cl_sh_ddra.rdata),
        .M00_AXI_rid(lcl_cl_sh_ddra.rid[6:0]),
        .M00_AXI_rlast(lcl_cl_sh_ddra.rlast),
        .M00_AXI_rready(lcl_cl_sh_ddra.rready),
        .M00_AXI_rresp(lcl_cl_sh_ddra.rresp),
        .M00_AXI_rvalid(lcl_cl_sh_ddra.rvalid),
        .M00_AXI_wdata(lcl_cl_sh_ddra.wdata),
        .M00_AXI_wlast(lcl_cl_sh_ddra.wlast),
        .M00_AXI_wready(lcl_cl_sh_ddra.wready),
        .M00_AXI_wstrb(lcl_cl_sh_ddra.wstrb),
        .M00_AXI_wvalid(lcl_cl_sh_ddra.wvalid),

        .M01_AXI_araddr(lcl_cl_sh_ddrb.araddr),
        .M01_AXI_arburst(lcl_cl_sh_ddrb.arburst),
        .M01_AXI_arcache(),
        .M01_AXI_arid(lcl_cl_sh_ddrb.arid[6:0]),
        .M01_AXI_arlen(lcl_cl_sh_ddrb.arlen),
        .M01_AXI_arlock(),
        .M01_AXI_arprot(),
        .M01_AXI_arqos(),
        .M01_AXI_arready(lcl_cl_sh_ddrb.arready),
        .M01_AXI_arregion(),
        .M01_AXI_arsize(lcl_cl_sh_ddrb.arsize),
        .M01_AXI_arvalid(lcl_cl_sh_ddrb.arvalid),
        .M01_AXI_awaddr(lcl_cl_sh_ddrb.awaddr),
        .M01_AXI_awburst(lcl_cl_sh_ddrb.awburst),
        .M01_AXI_awcache(),
        .M01_AXI_awid(lcl_cl_sh_ddrb.awid[6:0]),
        .M01_AXI_awlen(lcl_cl_sh_ddrb.awlen),
        .M01_AXI_awlock(),
        .M01_AXI_awprot(),
        .M01_AXI_awqos(),
        .M01_AXI_awready(lcl_cl_sh_ddrb.awready),
        .M01_AXI_awregion(),
        .M01_AXI_awsize(lcl_cl_sh_ddrb.awsize),
        .M01_AXI_awvalid(lcl_cl_sh_ddrb.awvalid),
        .M01_AXI_bid(lcl_cl_sh_ddrb.bid[6:0]),
        .M01_AXI_bready(lcl_cl_sh_ddrb.bready),
        .M01_AXI_bresp(lcl_cl_sh_ddrb.bresp),
        .M01_AXI_bvalid(lcl_cl_sh_ddrb.bvalid),
        .M01_AXI_rdata(lcl_cl_sh_ddrb.rdata),
        .M01_AXI_rid(lcl_cl_sh_ddrb.rid[6:0]),
        .M01_AXI_rlast(lcl_cl_sh_ddrb.rlast),
        .M01_AXI_rready(lcl_cl_sh_ddrb.rready),
        .M01_AXI_rresp(lcl_cl_sh_ddrb.rresp),
        .M01_AXI_rvalid(lcl_cl_sh_ddrb.rvalid),
        .M01_AXI_wdata(lcl_cl_sh_ddrb.wdata),
        .M01_AXI_wlast(lcl_cl_sh_ddrb.wlast),
        .M01_AXI_wready(lcl_cl_sh_ddrb.wready),
        .M01_AXI_wstrb(lcl_cl_sh_ddrb.wstrb),
        .M01_AXI_wvalid(lcl_cl_sh_ddrb.wvalid),

        .M02_AXI_araddr(lcl_cl_sh_ddrc.araddr),
        .M02_AXI_arburst(lcl_cl_sh_ddrc.arburst),
        .M02_AXI_arcache(),
        .M02_AXI_arid(lcl_cl_sh_ddrc.arid[6:0]),
        .M02_AXI_arlen(lcl_cl_sh_ddrc.arlen),
        .M02_AXI_arlock(),
        .M02_AXI_arprot(),
        .M02_AXI_arqos(),
        .M02_AXI_arready(lcl_cl_sh_ddrc.arready),
        .M02_AXI_arregion(),
        .M02_AXI_arsize(lcl_cl_sh_ddrc.arsize),
        .M02_AXI_arvalid(lcl_cl_sh_ddrc.arvalid),
        .M02_AXI_awaddr(lcl_cl_sh_ddrc.awaddr),
        .M02_AXI_awburst(lcl_cl_sh_ddrc.awburst),
        .M02_AXI_awcache(),
        .M02_AXI_awid(lcl_cl_sh_ddrc.awid[6:0]),
        .M02_AXI_awlen(lcl_cl_sh_ddrc.awlen),
        .M02_AXI_awlock(),
        .M02_AXI_awprot(),
        .M02_AXI_awqos(),
        .M02_AXI_awready(lcl_cl_sh_ddrc.awready),
        .M02_AXI_awregion(),
        .M02_AXI_awsize(lcl_cl_sh_ddrc.awsize),
        .M02_AXI_awvalid(lcl_cl_sh_ddrc.awvalid),
        .M02_AXI_bid(lcl_cl_sh_ddrc.bid[6:0]),
        .M02_AXI_bready(lcl_cl_sh_ddrc.bready),
        .M02_AXI_bresp(lcl_cl_sh_ddrc.bresp),
        .M02_AXI_bvalid(lcl_cl_sh_ddrc.bvalid),
        .M02_AXI_rdata(lcl_cl_sh_ddrc.rdata),
        .M02_AXI_rid(lcl_cl_sh_ddrc.rid[6:0]),
        .M02_AXI_rlast(lcl_cl_sh_ddrc.rlast),
        .M02_AXI_rready(lcl_cl_sh_ddrc.rready),
        .M02_AXI_rresp(lcl_cl_sh_ddrc.rresp),
        .M02_AXI_rvalid(lcl_cl_sh_ddrc.rvalid),
        .M02_AXI_wdata(lcl_cl_sh_ddrc.wdata),
        .M02_AXI_wlast(lcl_cl_sh_ddrc.wlast),
        .M02_AXI_wready(lcl_cl_sh_ddrc.wready),
        .M02_AXI_wstrb(lcl_cl_sh_ddrc.wstrb),
        .M02_AXI_wvalid(lcl_cl_sh_ddrc.wvalid),

        .M03_AXI_araddr(lcl_cl_sh_ddrd.araddr),
        .M03_AXI_arburst(lcl_cl_sh_ddrd.arburst),
        .M03_AXI_arcache(),
        .M03_AXI_arid(lcl_cl_sh_ddrd.arid[6:0]),
        .M03_AXI_arlen(lcl_cl_sh_ddrd.arlen),
        .M03_AXI_arlock(),
        .M03_AXI_arprot(),
        .M03_AXI_arqos(),
        .M03_AXI_arready(lcl_cl_sh_ddrd.arready),
        .M03_AXI_arregion(),
        .M03_AXI_arsize(lcl_cl_sh_ddrd.arsize),
        .M03_AXI_arvalid(lcl_cl_sh_ddrd.arvalid),
        .M03_AXI_awaddr(lcl_cl_sh_ddrd.awaddr),
        .M03_AXI_awburst(lcl_cl_sh_ddrd.awburst),
        .M03_AXI_awcache(),
        .M03_AXI_awid(lcl_cl_sh_ddrd.awid[6:0]),
        .M03_AXI_awlen(lcl_cl_sh_ddrd.awlen),
        .M03_AXI_awlock(),
        .M03_AXI_awprot(),
        .M03_AXI_awqos(),
        .M03_AXI_awready(lcl_cl_sh_ddrd.awready),
        .M03_AXI_awregion(),
        .M03_AXI_awsize(lcl_cl_sh_ddrd.awsize),
        .M03_AXI_awvalid(lcl_cl_sh_ddrd.awvalid),
        .M03_AXI_bid(lcl_cl_sh_ddrd.bid[6:0]),
        .M03_AXI_bready(lcl_cl_sh_ddrd.bready),
        .M03_AXI_bresp(lcl_cl_sh_ddrd.bresp),
        .M03_AXI_bvalid(lcl_cl_sh_ddrd.bvalid),
        .M03_AXI_rdata(lcl_cl_sh_ddrd.rdata),
        .M03_AXI_rid(lcl_cl_sh_ddrd.rid[6:0]),
        .M03_AXI_rlast(lcl_cl_sh_ddrd.rlast),
        .M03_AXI_rready(lcl_cl_sh_ddrd.rready),
        .M03_AXI_rresp(lcl_cl_sh_ddrd.rresp),
        .M03_AXI_rvalid(lcl_cl_sh_ddrd.rvalid),
        .M03_AXI_wdata(lcl_cl_sh_ddrd.wdata),
        .M03_AXI_wlast(lcl_cl_sh_ddrd.wlast),
        .M03_AXI_wready(lcl_cl_sh_ddrd.wready),
        .M03_AXI_wstrb(lcl_cl_sh_ddrd.wstrb),
        .M03_AXI_wvalid(lcl_cl_sh_ddrd.wvalid),



        .S00_AXI_araddr({sh_cl_dma_pcis_q.araddr[63:37], 1'b0, sh_cl_dma_pcis_q.araddr[35:0]}),
        .S00_AXI_arburst(2'b1),
        .S00_AXI_arcache(4'b11),
        .S00_AXI_arid(sh_cl_dma_pcis_q.arid[5:0]),
        .S00_AXI_arlen(sh_cl_dma_pcis_q.arlen),
        .S00_AXI_arlock(1'b0),
        .S00_AXI_arprot(3'b10),
        .S00_AXI_arqos(4'b0),
        .S00_AXI_arready(sh_cl_dma_pcis_q.arready),
        .S00_AXI_arregion(4'b0),
        .S00_AXI_arsize(sh_cl_dma_pcis_q.arsize),
        .S00_AXI_arvalid(sh_cl_dma_pcis_q.arvalid),
        .S00_AXI_awaddr({sh_cl_dma_pcis_q.awaddr[63:37], 1'b0, sh_cl_dma_pcis_q.awaddr[35:0]}),
        .S00_AXI_awburst(2'b1),
        .S00_AXI_awcache(4'b11),
        .S00_AXI_awid(sh_cl_dma_pcis_q.awid[5:0]),
        .S00_AXI_awlen(sh_cl_dma_pcis_q.awlen),
        .S00_AXI_awlock(1'b0),
        .S00_AXI_awprot(3'b10),
        .S00_AXI_awqos(4'b0),
        .S00_AXI_awready(sh_cl_dma_pcis_q.awready),
        .S00_AXI_awregion(4'b0),
        .S00_AXI_awsize(sh_cl_dma_pcis_q.awsize),
        .S00_AXI_awvalid(sh_cl_dma_pcis_q.awvalid),
        .S00_AXI_bid(sh_cl_dma_pcis_q.bid[5:0]),
        .S00_AXI_bready(sh_cl_dma_pcis_q.bready),
        .S00_AXI_bresp(sh_cl_dma_pcis_q.bresp),
        .S00_AXI_bvalid(sh_cl_dma_pcis_q.bvalid),
        .S00_AXI_rdata(sh_cl_dma_pcis_q.rdata),
        .S00_AXI_rid(sh_cl_dma_pcis_q.rid[5:0]),
        .S00_AXI_rlast(sh_cl_dma_pcis_q.rlast),
        .S00_AXI_rready(sh_cl_dma_pcis_q.rready),
        .S00_AXI_rresp(sh_cl_dma_pcis_q.rresp),
        .S00_AXI_rvalid(sh_cl_dma_pcis_q.rvalid),
        .S00_AXI_wdata(sh_cl_dma_pcis_q.wdata),
        .S00_AXI_wlast(sh_cl_dma_pcis_q.wlast),
        .S00_AXI_wready(sh_cl_dma_pcis_q.wready),
        .S00_AXI_wstrb(sh_cl_dma_pcis_q.wstrb),
        .S00_AXI_wvalid(sh_cl_dma_pcis_q.wvalid),

        .S01_AXI_araddr({cl_axi_mstr_bus.araddr[63:37], 1'b0, cl_axi_mstr_bus.araddr[35:0]}),
        .S01_AXI_arburst(2'b1),
        .S01_AXI_arcache(4'b11),
        .S01_AXI_arid(cl_axi_mstr_bus.arid[5:0]),
        .S01_AXI_arlen(cl_axi_mstr_bus.arlen),
        .S01_AXI_arlock(1'b0),
        .S01_AXI_arprot(3'b10),
        .S01_AXI_arqos(4'b0),
        .S01_AXI_arready(cl_axi_mstr_bus.arready),
        .S01_AXI_arregion(4'b0),
        .S01_AXI_arsize(cl_axi_mstr_bus.arsize),
        .S01_AXI_arvalid(cl_axi_mstr_bus.arvalid),
        .S01_AXI_awaddr({cl_axi_mstr_bus.awaddr[63:37], 1'b0, cl_axi_mstr_bus.awaddr[35:0]}),
        .S01_AXI_awburst(2'b1),
        .S01_AXI_awcache(4'b11),
        .S01_AXI_awid(cl_axi_mstr_bus.awid[5:0]),
        .S01_AXI_awlen(cl_axi_mstr_bus.awlen),
        .S01_AXI_awlock(1'b0),
        .S01_AXI_awprot(3'b10),
        .S01_AXI_awqos(4'b0),
        .S01_AXI_awready(cl_axi_mstr_bus.awready),
        .S01_AXI_awregion(4'b0),
        .S01_AXI_awsize(cl_axi_mstr_bus.awsize),
        .S01_AXI_awvalid(cl_axi_mstr_bus.awvalid),
        .S01_AXI_bid(cl_axi_mstr_bus.bid[5:0]),
        .S01_AXI_bready(cl_axi_mstr_bus.bready),
        .S01_AXI_bresp(cl_axi_mstr_bus.bresp),
        .S01_AXI_bvalid(cl_axi_mstr_bus.bvalid),
        .S01_AXI_rdata(cl_axi_mstr_bus.rdata),
        .S01_AXI_rid(cl_axi_mstr_bus.rid[5:0]),
        .S01_AXI_rlast(cl_axi_mstr_bus.rlast),
        .S01_AXI_rready(cl_axi_mstr_bus.rready),
        .S01_AXI_rresp(cl_axi_mstr_bus.rresp),
        .S01_AXI_rvalid(cl_axi_mstr_bus.rvalid),
        .S01_AXI_wdata(cl_axi_mstr_bus.wdata),
        .S01_AXI_wlast(cl_axi_mstr_bus.wlast),
        .S01_AXI_wready(cl_axi_mstr_bus.wready),
        .S01_AXI_wstrb(cl_axi_mstr_bus.wstrb),
        .S01_AXI_wvalid(cl_axi_mstr_bus.wvalid));

    // Unused (Tied down)
    assign cl_axi_mstr_bus.awid    = '0;
    assign cl_axi_mstr_bus.awaddr  = '0;
    assign cl_axi_mstr_bus.awlen   = '0;
    assign cl_axi_mstr_bus.awsize  = '0;
    assign cl_axi_mstr_bus.awburst = '0;
    assign cl_axi_mstr_bus.awvalid = '0;

    assign cl_axi_mstr_bus.wid     = '0;
    assign cl_axi_mstr_bus.wdata   = '0;
    assign cl_axi_mstr_bus.wstrb   = '0;
    assign cl_axi_mstr_bus.wlast   = '0;
    assign cl_axi_mstr_bus.wvalid  = '0;

    assign cl_axi_mstr_bus.bready  = '0;

    assign cl_axi_mstr_bus.arid    = '0;
    assign cl_axi_mstr_bus.araddr  = '0;
    assign cl_axi_mstr_bus.arlen   = '0;
    assign cl_axi_mstr_bus.arsize  = '0;
    assign cl_axi_mstr_bus.arburst = '0;
    assign cl_axi_mstr_bus.arvalid = '0;

    assign cl_axi_mstr_bus.rready  = '0;

    //-----------------------------------------//
    // axi interconnect for DDR access from CL //
    // Tier 2 interconnect                     //
    //-----------------------------------------//
    cl_axi_interconnect_2_to_1_wrapper axi_interconnect_2_to_ddra (
        .aclk(clk),
        .aresetn(dma_pcis_slv_sync_rst_n),
        .s00_axi(lcl_cl_sh_ddra),
        .s01_axi(cl_phmm_ddra),
        .m00_axi(cl_sh_ddra));

//    generate
//        if (NUMBER_OF_ACCELERATORS > 1) begin
            cl_axi_interconnect_2_to_1_wrapper axi_interconnect_2_to_ddrb (
                .aclk(clk),
                .aresetn(dma_pcis_slv_sync_rst_n),
                .s00_axi(lcl_cl_sh_ddrb),
                .s01_axi(cl_phmm_ddrb),
                .m00_axi(cl_sh_ddrb));
//        end else begin
//            cl_axi_register_slice axi_reg_slice_ddrb (
//                .aclk(clk),
//                .aresetn(dma_pcis_slv_sync_rst_n),
//                .s_axi(lcl_cl_sh_ddrb),
//                .m_axi(cl_sh_ddrb));
//        end
//
//        if (NUMBER_OF_ACCELERATORS > 2) begin
            cl_axi_interconnect_2_to_1_wrapper axi_interconnect_2_to_ddrc (
                .aclk(clk),
                .aresetn(dma_pcis_slv_sync_rst_n),
                .s00_axi(lcl_cl_sh_ddrc),
                .s01_axi(cl_phmm_ddrc),
                .m00_axi(cl_sh_ddrc));
//        end else begin
//            cl_axi_register_slice axi_reg_slice_ddrc (
//                .aclk(clk),
//                .aresetn(dma_pcis_slv_sync_rst_n),
//                .s_axi(lcl_cl_sh_ddrc),
//                .m_axi(cl_sh_ddrc));
//        end
//
//        if (NUMBER_OF_ACCELERATORS > 3) begin
            cl_axi_interconnect_2_to_1_wrapper axi_interconnect_2_to_ddrd (
                .aclk(clk),
                .aresetn(dma_pcis_slv_sync_rst_n),
                .s00_axi(lcl_cl_sh_ddrd),
                .s01_axi(cl_phmm_ddrd),
                .m00_axi(cl_sh_ddrd));
//        end else begin
//            cl_axi_register_slice axi_reg_slice_ddrd (
//                .aclk(clk),
//                .aresetn(dma_pcis_slv_sync_rst_n),
//                .s_axi(lcl_cl_sh_ddrd),
//                .m_axi(cl_sh_ddrd));
//        end
//    endgenerate

    //-------------------------------------------
    // Interrrupts
    //-------------------------------------------
    logic [15:0] irq_mask;

    // Named signals to indexed signals
    assign pair_hmm_interrupt[0] = pair_hmm_interrupt_a;
    assign pair_hmm_interrupt[1] = pair_hmm_interrupt_b;
    assign pair_hmm_interrupt[2] = pair_hmm_interrupt_c;
    assign pair_hmm_interrupt[3] = pair_hmm_interrupt_d;

    // We only use the first 4 interrupts, so tie all the others to 0
    assign irq_mask[15:4]            = 'b0;
    assign cl_sh_apppf_irq_req[15:4] = 'b0;

    generate
        genvar i;
        for (i = 0; i < 4; i++) begin

            // Interrupt management
            always_ff @(posedge clk) begin
                if (positive_reset) begin
                    cl_sh_apppf_irq_req[i] <= 1'b0;
                end else begin
                    // Single pulse, so if it is asserted, deassert it
                    if (cl_sh_apppf_irq_req[i]) begin
                        cl_sh_apppf_irq_req[i] <= 1'b0;
                    end else begin
                        cl_sh_apppf_irq_req[i] <= irq_mask[i] && pair_hmm_interrupt[i];
                    end
                end
            end

            // Interrupt mask (not to send a second pulse before ack'ed by the SH)
            always_ff @(posedge clk) begin
                if (positive_reset) begin
                    irq_mask[i] <= 1'b1;
                end else begin
                    if (sh_cl_apppf_irq_ack[i]) begin
                        irq_mask[i] <= 1'b1;
                    end else if (pair_hmm_interrupt[i]) begin
                        irq_mask[i] <= 1'b0;
                    end
                end
            end
        end
    endgenerate

    //-------------------------------------------
    // Tie-Off Unused Signals
    //-------------------------------------------
    // Unused 'full' signals
    assign cl_sh_dma_rd_full  = 1'b0;
    assign cl_sh_dma_wr_full  = 1'b0;

    //-------------------------------------------
    // Tie-Off Global Signals
    //-------------------------------------------
    `ifndef CL_VERSION
     `define CL_VERSION 32'hee_ee_ee_00
    `endif

    // Note : The two first fields below must be set accordingly to
    // $CL_DIR/design/cl_id_defines.vh
    // Otherwise the FPGA image will not be loaded by
    // fpga-load-local-image
    // because it will give an cl-id-mismatch error.
    // (Checked against IDs in the manifest of the design sent to
    // aws for AFI creation)
    assign cl_sh_id0[31:0]       = `CL_SH_ID0;
    assign cl_sh_id1[31:0]       = `CL_SH_ID1;
    assign cl_sh_status0[31:0]   = 32'h0000_0000;
    assign cl_sh_status1[31:0]   = `CL_VERSION;

    `ifdef USE_EXTRA_DDR_MODULES
    //-----------------------------------------
    // DDR controller instantiation
    //-----------------------------------------
    // All designs should instantiate the sh_ddr module even if not utilizing the
    // DDR controllers. It must be instantiated in order to prevent build errors
    // related to DDR pin constraints.

    // Only the DDR pins are connected. The AXI and stats interfaces are tied-off.

    sh_ddr #(.DDR_A_PRESENT(`DDR_A_PRESENT),
             .DDR_B_PRESENT(`DDR_B_PRESENT),
             .DDR_D_PRESENT(`DDR_D_PRESENT)) SH_DDR
        (
         .clk(clk_main_a0),
         .rst_n(sync_rst_n),
         .stat_clk(clk_main_a0),
         .stat_rst_n(sync_rst_n),

         .CLK_300M_DIMM0_DP(CLK_300M_DIMM0_DP),
         .CLK_300M_DIMM0_DN(CLK_300M_DIMM0_DN),
         .M_A_ACT_N(M_A_ACT_N),
         .M_A_MA(M_A_MA),
         .M_A_BA(M_A_BA),
         .M_A_BG(M_A_BG),
         .M_A_CKE(M_A_CKE),
         .M_A_ODT(M_A_ODT),
         .M_A_CS_N(M_A_CS_N),
         .M_A_CLK_DN(M_A_CLK_DN),
         .M_A_CLK_DP(M_A_CLK_DP),
         .M_A_PAR(M_A_PAR),
         .M_A_DQ(M_A_DQ),
         .M_A_ECC(M_A_ECC),
         .M_A_DQS_DP(M_A_DQS_DP),
         .M_A_DQS_DN(M_A_DQS_DN),
         .cl_RST_DIMM_A_N(cl_RST_DIMM_A_N),

         .CLK_300M_DIMM1_DP(CLK_300M_DIMM1_DP),
         .CLK_300M_DIMM1_DN(CLK_300M_DIMM1_DN),
         .M_B_ACT_N(M_B_ACT_N),
         .M_B_MA(M_B_MA),
         .M_B_BA(M_B_BA),
         .M_B_BG(M_B_BG),
         .M_B_CKE(M_B_CKE),
         .M_B_ODT(M_B_ODT),
         .M_B_CS_N(M_B_CS_N),
         .M_B_CLK_DN(M_B_CLK_DN),
         .M_B_CLK_DP(M_B_CLK_DP),
         .M_B_PAR(M_B_PAR),
         .M_B_DQ(M_B_DQ),
         .M_B_ECC(M_B_ECC),
         .M_B_DQS_DP(M_B_DQS_DP),
         .M_B_DQS_DN(M_B_DQS_DN),
         .cl_RST_DIMM_B_N(cl_RST_DIMM_B_N),

         .CLK_300M_DIMM3_DP(CLK_300M_DIMM3_DP),
         .CLK_300M_DIMM3_DN(CLK_300M_DIMM3_DN),
         .M_D_ACT_N(M_D_ACT_N),
         .M_D_MA(M_D_MA),
         .M_D_BA(M_D_BA),
         .M_D_BG(M_D_BG),
         .M_D_CKE(M_D_CKE),
         .M_D_ODT(M_D_ODT),
         .M_D_CS_N(M_D_CS_N),
         .M_D_CLK_DN(M_D_CLK_DN),
         .M_D_CLK_DP(M_D_CLK_DP),
         .M_D_PAR(M_D_PAR),
         .M_D_DQ(M_D_DQ),
         .M_D_ECC(M_D_ECC),
         .M_D_DQS_DP(M_D_DQS_DP),
         .M_D_DQS_DN(M_D_DQS_DN),
         .cl_RST_DIMM_D_N(cl_RST_DIMM_D_N),

         //------------------------------------------------------
         // DDR-4 Interface from CL (AXI-4)
         //------------------------------------------------------
         .cl_sh_ddr_awid     (cl_sh_ddr_awid_2d),
         .cl_sh_ddr_awaddr   (cl_sh_ddr_awaddr_2d),
         .cl_sh_ddr_awlen    (cl_sh_ddr_awlen_2d),
         .cl_sh_ddr_awsize   (cl_sh_ddr_awsize_2d),
         .cl_sh_ddr_awvalid  (cl_sh_ddr_awvalid_2d),
         .cl_sh_ddr_awburst  (cl_sh_ddr_awburst_2d),
         .sh_cl_ddr_awready  (sh_cl_ddr_awready_2d),

         .cl_sh_ddr_wid      (cl_sh_ddr_wid_2d),
         .cl_sh_ddr_wdata    (cl_sh_ddr_wdata_2d),
         .cl_sh_ddr_wstrb    (cl_sh_ddr_wstrb_2d),
         .cl_sh_ddr_wlast    (cl_sh_ddr_wlast_2d),
         .cl_sh_ddr_wvalid   (cl_sh_ddr_wvalid_2d),
         .sh_cl_ddr_wready   (sh_cl_ddr_wready_2d),

         .sh_cl_ddr_bid      (sh_cl_ddr_bid_2d),
         .sh_cl_ddr_bresp    (sh_cl_ddr_bresp_2d),
         .sh_cl_ddr_bvalid   (sh_cl_ddr_bvalid_2d),
         .cl_sh_ddr_bready   (cl_sh_ddr_bready_2d),

         .cl_sh_ddr_arid     (cl_sh_ddr_arid_2d),
         .cl_sh_ddr_araddr   (cl_sh_ddr_araddr_2d),
         .cl_sh_ddr_arlen    (cl_sh_ddr_arlen_2d),
         .cl_sh_ddr_arsize   (cl_sh_ddr_arsize_2d),
         .cl_sh_ddr_arvalid  (cl_sh_ddr_arvalid_2d),
         .cl_sh_ddr_arburst  (cl_sh_ddr_arburst_2d),
         .sh_cl_ddr_arready  (sh_cl_ddr_arready_2d),

         .sh_cl_ddr_rid      (sh_cl_ddr_rid_2d),
         .sh_cl_ddr_rdata    (sh_cl_ddr_rdata_2d),
         .sh_cl_ddr_rresp    (sh_cl_ddr_rresp_2d),
         .sh_cl_ddr_rlast    (sh_cl_ddr_rlast_2d),
         .sh_cl_ddr_rvalid   (sh_cl_ddr_rvalid_2d),
         .cl_sh_ddr_rready   (cl_sh_ddr_rready_2d),

         .sh_cl_ddr_is_ready (sh_cl_ddr_is_ready_2d),

         .sh_ddr_stat_addr0  (sh_ddr_stat_addr_2d[0]),
         .sh_ddr_stat_wr0    (sh_ddr_stat_wr_2d[0]),
         .sh_ddr_stat_rd0    (sh_ddr_stat_rd_2d[0]),
         .sh_ddr_stat_wdata0 (sh_ddr_stat_wdata_2d[0]),

         .ddr_sh_stat_ack0   (ddr_sh_stat_ack_2d[0]),
         .ddr_sh_stat_rdata0 (ddr_sh_stat_rdata_2d[0]),
         .ddr_sh_stat_int0   (ddr_sh_stat_int_2d[0]),

         .sh_ddr_stat_addr1  (sh_ddr_stat_addr_2d[1]),
         .sh_ddr_stat_wr1    (sh_ddr_stat_wr_2d[1]),
         .sh_ddr_stat_rd1    (sh_ddr_stat_rd_2d[1]),
         .sh_ddr_stat_wdata1 (sh_ddr_stat_wdata_2d[1]),

         .ddr_sh_stat_ack1   (ddr_sh_stat_ack_2d[1]),
         .ddr_sh_stat_rdata1 (ddr_sh_stat_rdata_2d[1]),
         .ddr_sh_stat_int1   (ddr_sh_stat_int_2d[1]),

         .sh_ddr_stat_addr2  (sh_ddr_stat_addr_2d[2]),
         .sh_ddr_stat_wr2    (sh_ddr_stat_wr_2d[2]),
         .sh_ddr_stat_rd2    (sh_ddr_stat_rd_2d[2]),
         .sh_ddr_stat_wdata2 (sh_ddr_stat_wdata_2d[2]),

         .ddr_sh_stat_ack2   (ddr_sh_stat_ack_2d[2]),
         .ddr_sh_stat_rdata2 (ddr_sh_stat_rdata_2d[2]),
         .ddr_sh_stat_int2   (ddr_sh_stat_int_2d[2])
         );

    generate
        if (`DDR_A_PRESENT) begin // Connections to the interface

            // Stats
            assign ddr_sh_stat_ack0        = ddr_sh_stat_ack_2d[0];
            assign ddr_sh_stat_rdata0      = ddr_sh_stat_rdata_2d[0];
            assign ddr_sh_stat_int0        = ddr_sh_stat_int_2d[0];
            assign sh_ddr_stat_addr_2d[0]  = sh_ddr_stat_addr0;
            assign sh_ddr_stat_wr_2d[0]    = sh_ddr_stat_wr0;
            assign sh_ddr_stat_rd_2d[0]    = sh_ddr_stat_rd0;
            assign sh_ddr_stat_wdata_2d[0] = sh_ddr_stat_wdata0;

            //--------------------//
            // Connect DDR A here //
            //--------------------//
            assign cl_sh_ddr_awid_2d[0]    = cl_sh_ddra.awid;
            assign cl_sh_ddr_awaddr_2d[0]  = cl_sh_ddra.awaddr;
            assign cl_sh_ddr_awlen_2d[0]   = cl_sh_ddra.awlen;
            assign cl_sh_ddr_awsize_2d[0]  = cl_sh_ddra.awsize;
            assign cl_sh_ddr_awburst_2d[0] = cl_sh_ddra.awburst;
            assign cl_sh_ddr_awvalid_2d[0] = cl_sh_ddra.awvalid;
            assign cl_sh_ddra.awready      = sh_cl_ddr_awready_2d[0];

            assign cl_sh_ddr_wid_2d[0]     = cl_sh_ddra.wid;
            assign cl_sh_ddr_wdata_2d[0]   = cl_sh_ddra.wdata;
            assign cl_sh_ddr_wstrb_2d[0]   = cl_sh_ddra.wstrb;
            assign cl_sh_ddr_wlast_2d[0]   = cl_sh_ddra.wlast;
            assign cl_sh_ddr_wvalid_2d[0]  = cl_sh_ddra.wvalid;
            assign cl_sh_ddra.wready       = sh_cl_ddr_wready_2d[0];

            assign cl_sh_ddra.bid          = sh_cl_ddr_bid_2d[0];
            assign cl_sh_ddra.bresp        = sh_cl_ddr_bresp_2d[0];
            assign cl_sh_ddra.bvalid       = sh_cl_ddr_bvalid_2d[0];
            assign cl_sh_ddr_bready_2d[0]  = cl_sh_ddra.bready;

            assign cl_sh_ddr_arid_2d[0]    = cl_sh_ddra.arid;
            assign cl_sh_ddr_araddr_2d[0]  = cl_sh_ddra.araddr;
            assign cl_sh_ddr_arlen_2d[0]   = cl_sh_ddra.arlen;
            assign cl_sh_ddr_arsize_2d[0]  = cl_sh_ddra.arsize;
            assign cl_sh_ddr_arburst_2d[0] = cl_sh_ddra.arburst;
            assign cl_sh_ddr_arvalid_2d[0] = cl_sh_ddra.arvalid;
            assign cl_sh_ddra.arready      = sh_cl_ddr_arready_2d[0];

            assign cl_sh_ddra.rid          = sh_cl_ddr_rid_2d[0];
            assign cl_sh_ddra.rdata        = sh_cl_ddr_rdata_2d[0];
            assign cl_sh_ddra.rresp        = sh_cl_ddr_rresp_2d[0];
            assign cl_sh_ddra.rlast        = sh_cl_ddr_rlast_2d[0];
            assign cl_sh_ddra.rvalid       = sh_cl_ddr_rvalid_2d[0];
            assign cl_sh_ddr_rready_2d[0]  = cl_sh_ddra.rready;

            //sh_cl_ddr_is_ready_2d[0] // Unused for now - TODO : Connect to control

        end
        else begin

            // DDR AXI Signals
            assign cl_sh_ddr_awid_2d[0]    = tie_zero_id[0];
            assign cl_sh_ddr_awaddr_2d[0]  = tie_zero_addr[0];
            assign cl_sh_ddr_awlen_2d[0]   = tie_zero_len[0];
            assign cl_sh_ddr_awvalid_2d[0] = tie_zero[0];

            assign cl_sh_ddr_wid_2d[0]     = tie_zero_id[0];
            assign cl_sh_ddr_wdata_2d[0]   = tie_zero_data[0];
            assign cl_sh_ddr_wstrb_2d[0]   = tie_zero_strb[0];
            assign cl_sh_ddr_wlast_2d[0]   = tie_zero[0];
            assign cl_sh_ddr_wvalid_2d[0]  = tie_zero[0];

            assign cl_sh_ddr_bready_2d[0]  = tie_zero[0];

            assign cl_sh_ddr_arid_2d[0]    = tie_zero_id[0];
            assign cl_sh_ddr_araddr_2d[0]  = tie_zero_addr[0];
            assign cl_sh_ddr_arlen_2d[0]   = tie_zero_len[0];
            assign cl_sh_ddr_arvalid_2d[0] = tie_zero[0];

            assign cl_sh_ddr_rready_2d[0]  = tie_zero[0];

            // Stats
            assign ddr_sh_stat_ack0        = 1'b1; // Needed in order not to hang the interface
            assign ddr_sh_stat_rdata0      = 32'b0;
            assign ddr_sh_stat_int0        = 8'b0;

            // AXI Bus
            assign cl_sh_ddra.awready      = '0;
            assign cl_sh_ddra.wready       = '0;
            assign cl_sh_ddra.bid          = '0;
            assign cl_sh_ddra.bresp        = '0;
            assign cl_sh_ddra.bvalid       = '0;
            assign cl_sh_ddra.arready      = '0;
            assign cl_sh_ddra.rid          = '0;
            assign cl_sh_ddra.rdata        = '0;
            assign cl_sh_ddra.rresp        = '0;
            assign cl_sh_ddra.rlast        = '0;
            assign cl_sh_ddra.rvalid       = '0;
            //sh_cl_ddr_is_ready_2d[0] // Unused for now - TODO : Connect to control
        end
    endgenerate

    generate
        if (`DDR_B_PRESENT) begin

            // Stats
            assign ddr_sh_stat_ack1        = ddr_sh_stat_ack_2d[1];
            assign ddr_sh_stat_rdata1      = ddr_sh_stat_rdata_2d[1];
            assign ddr_sh_stat_int1        = ddr_sh_stat_int_2d[1];
            assign sh_ddr_stat_addr_2d[1]  = sh_ddr_stat_addr1;
            assign sh_ddr_stat_wr_2d[1]    = sh_ddr_stat_wr1;
            assign sh_ddr_stat_rd_2d[1]    = sh_ddr_stat_rd1;
            assign sh_ddr_stat_wdata_2d[1] = sh_ddr_stat_wdata1;

            //--------------------//
            // Connect DDR B here //
            //--------------------//
            assign cl_sh_ddr_awid_2d[1]    = cl_sh_ddrb.awid;
            assign cl_sh_ddr_awaddr_2d[1]  = cl_sh_ddrb.awaddr;
            assign cl_sh_ddr_awlen_2d[1]   = cl_sh_ddrb.awlen;
            assign cl_sh_ddr_awsize_2d[1]  = cl_sh_ddrb.awsize;
            assign cl_sh_ddr_awburst_2d[1] = cl_sh_ddrb.awburst;
            assign cl_sh_ddr_awvalid_2d[1] = cl_sh_ddrb.awvalid;
            assign cl_sh_ddrb.awready      = sh_cl_ddr_awready_2d[1];

            assign cl_sh_ddr_wid_2d[1]     = cl_sh_ddrb.wid;
            assign cl_sh_ddr_wdata_2d[1]   = cl_sh_ddrb.wdata;
            assign cl_sh_ddr_wstrb_2d[1]   = cl_sh_ddrb.wstrb;
            assign cl_sh_ddr_wlast_2d[1]   = cl_sh_ddrb.wlast;
            assign cl_sh_ddr_wvalid_2d[1]  = cl_sh_ddrb.wvalid;
            assign cl_sh_ddrb.wready       = sh_cl_ddr_wready_2d[1];

            assign cl_sh_ddrb.bid          = sh_cl_ddr_bid_2d[1];
            assign cl_sh_ddrb.bresp        = sh_cl_ddr_bresp_2d[1];
            assign cl_sh_ddrb.bvalid       = sh_cl_ddr_bvalid_2d[1];
            assign cl_sh_ddr_bready_2d[1]  = cl_sh_ddrb.bready;

            assign cl_sh_ddr_arid_2d[1]    = cl_sh_ddrb.arid;
            assign cl_sh_ddr_araddr_2d[1]  = cl_sh_ddrb.araddr;
            assign cl_sh_ddr_arlen_2d[1]   = cl_sh_ddrb.arlen;
            assign cl_sh_ddr_arsize_2d[1]  = cl_sh_ddrb.arsize;
            assign cl_sh_ddr_arburst_2d[1] = cl_sh_ddrb.arburst;
            assign cl_sh_ddr_arvalid_2d[1] = cl_sh_ddrb.arvalid;
            assign cl_sh_ddrb.arready      = sh_cl_ddr_arready_2d[1];

            assign cl_sh_ddrb.rid          = sh_cl_ddr_rid_2d[1];
            assign cl_sh_ddrb.rdata        = sh_cl_ddr_rdata_2d[1];
            assign cl_sh_ddrb.rresp        = sh_cl_ddr_rresp_2d[1];
            assign cl_sh_ddrb.rlast        = sh_cl_ddr_rlast_2d[1];
            assign cl_sh_ddrb.rvalid       = sh_cl_ddr_rvalid_2d[1];
            assign cl_sh_ddr_rready_2d[1]  = cl_sh_ddrb.rready;

            //sh_cl_ddr_is_ready_2d[1] // Unused for now - TODO : Connect to control

        end
        else begin

            // DDR AXI Signals
            assign cl_sh_ddr_awid_2d[1]    = tie_zero_id[1];
            assign cl_sh_ddr_awaddr_2d[1]  = tie_zero_addr[1];
            assign cl_sh_ddr_awlen_2d[1]   = tie_zero_len[1];
            assign cl_sh_ddr_awvalid_2d[1] = tie_zero[1];

            assign cl_sh_ddr_wid_2d[1]     = tie_zero_id[1];
            assign cl_sh_ddr_wdata_2d[1]   = tie_zero_data[1];
            assign cl_sh_ddr_wstrb_2d[1]   = tie_zero_strb[1];
            assign cl_sh_ddr_wlast_2d[1]   = tie_zero[1];
            assign cl_sh_ddr_wvalid_2d[1]  = tie_zero[1];

            assign cl_sh_ddr_bready_2d[1]  = tie_zero[1];

            assign cl_sh_ddr_arid_2d[1]    = tie_zero_id[1];
            assign cl_sh_ddr_araddr_2d[1]  = tie_zero_addr[1];
            assign cl_sh_ddr_arlen_2d[1]   = tie_zero_len[1];
            assign cl_sh_ddr_arvalid_2d[1] = tie_zero[1];

            assign cl_sh_ddr_rready_2d[1]  = tie_zero[1];

            // Stats
            assign ddr_sh_stat_ack1        = 1'b1; // Needed in order not to hang the interface
            assign ddr_sh_stat_rdata1      = 32'b0;
            assign ddr_sh_stat_int1        = 8'b0;

            // AXI Bus
            assign lcl_cl_sh_ddrb.awready  = '0;
            assign lcl_cl_sh_ddrb.wready   = '0;
            assign lcl_cl_sh_ddrb.bid      = '0;
            assign lcl_cl_sh_ddrb.bresp    = '0;
            assign lcl_cl_sh_ddrb.bvalid   = '0;
            assign lcl_cl_sh_ddrb.arready  = '0;
            assign lcl_cl_sh_ddrb.rid      = '0;
            assign lcl_cl_sh_ddrb.rdata    = '0;
            assign lcl_cl_sh_ddrb.rresp    = '0;
            assign lcl_cl_sh_ddrb.rlast    = '0;
            assign lcl_cl_sh_ddrb.rvalid   = '0;
            //sh_cl_ddr_is_ready_2d[1] // Unused for now - TODO : Connect to control
        end
    endgenerate

    generate
        if (`DDR_D_PRESENT) begin

            // Stats
            assign ddr_sh_stat_ack2        = ddr_sh_stat_ack_2d[2];
            assign ddr_sh_stat_rdata2      = ddr_sh_stat_rdata_2d[2];
            assign ddr_sh_stat_int2        = ddr_sh_stat_int_2d[2];
            assign sh_ddr_stat_addr_2d[2]  = sh_ddr_stat_addr2;
            assign sh_ddr_stat_wr_2d[2]    = sh_ddr_stat_wr2;
            assign sh_ddr_stat_rd_2d[2]    = sh_ddr_stat_rd2;
            assign sh_ddr_stat_wdata_2d[2] = sh_ddr_stat_wdata2;

            //--------------------//
            // Connect DDR D here //
            //--------------------//
            assign cl_sh_ddr_awid_2d[2]    = cl_sh_ddrd.awid;
            assign cl_sh_ddr_awaddr_2d[2]  = cl_sh_ddrd.awaddr;
            assign cl_sh_ddr_awlen_2d[2]   = cl_sh_ddrd.awlen;
            assign cl_sh_ddr_awsize_2d[2]  = cl_sh_ddrd.awsize;
            assign cl_sh_ddr_awburst_2d[2] = cl_sh_ddrd.awburst;
            assign cl_sh_ddr_awvalid_2d[2] = cl_sh_ddrd.awvalid;
            assign cl_sh_ddrd.awready      = sh_cl_ddr_awready_2d[2];

            assign cl_sh_ddr_wid_2d[2]     = cl_sh_ddrd.wid;
            assign cl_sh_ddr_wdata_2d[2]   = cl_sh_ddrd.wdata;
            assign cl_sh_ddr_wstrb_2d[2]   = cl_sh_ddrd.wstrb;
            assign cl_sh_ddr_wlast_2d[2]   = cl_sh_ddrd.wlast;
            assign cl_sh_ddr_wvalid_2d[2]  = cl_sh_ddrd.wvalid;
            assign cl_sh_ddrd.wready       = sh_cl_ddr_wready_2d[2];

            assign cl_sh_ddrd.bid          = sh_cl_ddr_bid_2d[2];
            assign cl_sh_ddrd.bresp        = sh_cl_ddr_bresp_2d[2];
            assign cl_sh_ddrd.bvalid       = sh_cl_ddr_bvalid_2d[2];
            assign cl_sh_ddr_bready_2d[2]  = cl_sh_ddrd.bready;

            assign cl_sh_ddr_arid_2d[2]    = cl_sh_ddrd.arid;
            assign cl_sh_ddr_araddr_2d[2]  = cl_sh_ddrd.araddr;
            assign cl_sh_ddr_arlen_2d[2]   = cl_sh_ddrd.arlen;
            assign cl_sh_ddr_arsize_2d[2]  = cl_sh_ddrd.arsize;
            assign cl_sh_ddr_arburst_2d[2] = cl_sh_ddrd.arburst;
            assign cl_sh_ddr_arvalid_2d[2] = cl_sh_ddrd.arvalid;
            assign cl_sh_ddrd.arready      = sh_cl_ddr_arready_2d[2];

            assign cl_sh_ddrd.rid          = sh_cl_ddr_rid_2d[2];
            assign cl_sh_ddrd.rdata        = sh_cl_ddr_rdata_2d[2];
            assign cl_sh_ddrd.rresp        = sh_cl_ddr_rresp_2d[2];
            assign cl_sh_ddrd.rlast        = sh_cl_ddr_rlast_2d[2];
            assign cl_sh_ddrd.rvalid       = sh_cl_ddr_rvalid_2d[2];
            assign cl_sh_ddr_rready_2d[2]  = cl_sh_ddrd.rready;

            //sh_cl_ddr_is_ready_2d[2] // Unused for now - TODO : Connect to control

        end
        else begin

            // DDR AXI Signals
            assign cl_sh_ddr_awid_2d[2]    = tie_zero_id[2];
            assign cl_sh_ddr_awaddr_2d[2]  = tie_zero_addr[2];
            assign cl_sh_ddr_awlen_2d[2]   = tie_zero_len[2];
            assign cl_sh_ddr_awvalid_2d[2] = tie_zero[2];

            assign cl_sh_ddr_wid_2d[2]     = tie_zero_id[2];
            assign cl_sh_ddr_wdata_2d[2]   = tie_zero_data[2];
            assign cl_sh_ddr_wstrb_2d[2]   = tie_zero_strb[2];
            assign cl_sh_ddr_wlast_2d[2]   = tie_zero[2];
            assign cl_sh_ddr_wvalid_2d[2]  = tie_zero[2];

            assign cl_sh_ddr_bready_2d[2]  = tie_zero[2];

            assign cl_sh_ddr_arid_2d[2]    = tie_zero_id[2];
            assign cl_sh_ddr_araddr_2d[2]  = tie_zero_addr[2];
            assign cl_sh_ddr_arlen_2d[2]   = tie_zero_len[2];
            assign cl_sh_ddr_arvalid_2d[2] = tie_zero[2];

            assign cl_sh_ddr_rready_2d[2]  = tie_zero[2];

            // Stats
            assign ddr_sh_stat_ack2        = 1'b1; // Needed in order not to hang the interface
            assign ddr_sh_stat_rdata2      = 32'b0;
            assign ddr_sh_stat_int2        = 8'b0;

            // AXI Bus
            assign lcl_cl_sh_ddrd.awready  = '0;
            assign lcl_cl_sh_ddrd.wready   = '0;
            assign lcl_cl_sh_ddrd.bid      = '0;
            assign lcl_cl_sh_ddrd.bresp    = '0;
            assign lcl_cl_sh_ddrd.bvalid   = '0;
            assign lcl_cl_sh_ddrd.arready  = '0;
            assign lcl_cl_sh_ddrd.rid      = '0;
            assign lcl_cl_sh_ddrd.rdata    = '0;
            assign lcl_cl_sh_ddrd.rresp    = '0;
            assign lcl_cl_sh_ddrd.rlast    = '0;
            assign lcl_cl_sh_ddrd.rvalid   = '0;
            //sh_cl_ddr_is_ready_2d[2] // Unused for now - TODO : Connect to control
        end
    endgenerate

    // Tie-off AXI interfaces to sh_ddr module
    assign tie_zero[2]      = 1'b0;
    assign tie_zero[1]      = 1'b0;
    assign tie_zero[0]      = 1'b0;

    assign tie_zero_id[2]   = 6'b0;
    assign tie_zero_id[1]   = 6'b0;
    assign tie_zero_id[0]   = 6'b0;

    assign tie_zero_addr[2] = 64'b0;
    assign tie_zero_addr[1] = 64'b0;
    assign tie_zero_addr[0] = 64'b0;

    assign tie_zero_len[2]  = 8'b0;
    assign tie_zero_len[1]  = 8'b0;
    assign tie_zero_len[0]  = 8'b0;

    assign tie_zero_data[2] = 512'b0;
    assign tie_zero_data[1] = 512'b0;
    assign tie_zero_data[0] = 512'b0;

    assign tie_zero_strb[2] = 64'b0;
    assign tie_zero_strb[1] = 64'b0;
    assign tie_zero_strb[0] = 64'b0;

    `else // !`ifdef USE_EXTRA_DDR_MODULES

    // DDR Stat Interface from CL to SH
    assign ddr_sh_stat_ack[2:0] =  3'b111; // Needed in order not to hang the interface
    assign ddr_sh_stat_rdata[2] = 32'b0;
    assign ddr_sh_stat_rdata[1] = 32'b0;
    assign ddr_sh_stat_rdata[0] = 32'b0;
    assign ddr_sh_stat_int[2]   =  8'b0;
    assign ddr_sh_stat_int[1]   =  8'b0;
    assign ddr_sh_stat_int[0]   =  8'b0;

    `endif

    //------------------------------------
    // Tie-Off Aurora Interfaces
    //------------------------------------
    assign aurora_sh_stat_ack   =  1'b0;
    assign aurora_sh_stat_rdata = 32'b0;
    assign aurora_sh_stat_int   =  8'b0;

endmodule // cl_top
