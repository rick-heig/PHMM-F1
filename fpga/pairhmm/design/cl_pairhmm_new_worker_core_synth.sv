//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : cl_pairhmm_new_worker_core_synth.sv
// Description  :
//
// Author       : Rick Wertenbroek
// Date         : 13.02.19
// Version      : 0.1
//
// Dependencies :
//
// Modifications //------------------------------------------------------------
// Version   Author Date               Description
// 0.0       RWE    13.02.19           Creation
// 0.1       RWE    25.03.19           Made the core synth friendly
//-----------------------------------------------------------------------------

`include "cl_pairhmm_package.vh"

module cl_pairhmm_new_worker_core_synth #(
    parameter MAX_SEQUENCE_LENGTH = 1024,
    parameter DEBUG_VERBOSITY = 0,
    parameter WORKER_ID = 0
) (
    input logic                                   clock_i,
    input logic                                   reset_i,

    /* When enabled a computation is being run */
    input logic                                   enable_i,
    input logic [$clog2(MAX_SEQUENCE_LENGTH)-1:0] read_len_i,
    input logic [$clog2(MAX_SEQUENCE_LENGTH)-1:0] hap_len_i,
    input PairHMMPackage::floating_point_t        initial_condition_i,

    /* Access to the BRAMs containing the read and haplotype data */
    /* Note : We need the current base and the next base qualities for the precomputation (tmp) */
    bram_if.master_read read_info_bus,
    bram_if.master_read hap_info_bus,

    /* To send compute requests */
    fifo_if.master_write compute_request_bus,

    /* To get compute results */
    fifo_if.master_read compute_result_bus,

    /* To send the result of the computation */
    axi_stream_simple_if.master result_sum_bus,
    axi_stream_simple_if.slave  sum_result_bus,
    axi_stream_simple_if.master final_result_bus,
    output logic [7:0]          tid
);
    /* TODO : Document MCR, MFR */


    /* This limits the max read / haplotype size this module can handle. */
    localparam TEMP_BUFFER_LENGTH = MAX_SEQUENCE_LENGTH;
    localparam POSITION_COUNTER_WIDTH = $clog2(TEMP_BUFFER_LENGTH);

    /* This will restrict the maximum matrix size */
    typedef logic [POSITION_COUNTER_WIDTH-1:0] pos_counter_t;

    /* Position in the matrix */
    typedef struct {
        pos_counter_t x;
        pos_counter_t y;
    } position_t;

    /* Initial position */
    const position_t INITIAL_POSITION = '{0,0};

    /* Matrix dimensions */
    typedef position_t dimension_t;
    dimension_t matrix_dimensions;

    /* Initial condition */
    PairHMMPackage::result_t initial_result;

    /* Temporary results needed to launch the next computation */
    PairHMMPackage::result_t left_result_reg;
    logic          left_result_valid_reg;
    PairHMMPackage::result_t top_result_reg;
    logic          top_result_valid_reg;
    PairHMMPackage::result_t left_temps;

    /* Internal signals */
    logic          send_compute_request;
    logic          read_result_fifo;

    logic          mfr_destination_reg_ready;
    logic          mfr_will_fill_top;
    logic          mfr_will_fill_left;
    logic          mcr_tries_to_invalidate_left;
    logic          mcr_tries_to_invalidate_top;
    logic          mfr_in_last_column;

    logic          last_request_sent;

    logic [POSITION_COUNTER_WIDTH-1:0] read_read_addr;
    logic [POSITION_COUNTER_WIDTH-1:0] hap_read_addr;

    /* Summation bus related signals */
    PairHMMPackage::floating_point_t result_acc_reg;
    logic result_acc_reg_busy;
    logic waiting_for_last_result;

    /* Result bus related signals */
    PairHMMPackage::floating_point_t res_reg_1;
    PairHMMPackage::floating_point_t res_reg_2;
    logic res_reg_1_full;
    logic res_reg_2_full;
    logic get_result;
    logic send_result_sum;
    logic wait_for_res_shift_reg;
    logic tlast_reg_1;
    logic tlast_reg_2;

    /***********************/
    /* Internal Interfaces */
    /***********************/

    /* Nested interfaces are not supported by Vivado 2017.4 */
    /* Therefore this was converted to signals */

    ///* Crawler interface, for internal crawler modules */
    //interface crawler_if (
    //);
    //    position_t position;
    //    position_t next_position;
    //    logic      move;
    //    logic      jump;
    //
    //    modport crawler_interface (
    //        output position,
    //        output next_position,
    //        input  move,
    //        output jump
    //    );
    //endinterface // crawler_if
    //
    ///* Crawler busses */
    //crawler_if mcr_crawler_bus();
    //crawler_if mfr_crawler_bus();

    position_t mcr_crawler_bus_position;
    position_t mcr_crawler_bus_next_position;
    logic      mcr_crawler_bus_move;
    logic      mcr_crawler_bus_jump;

    position_t mfr_crawler_bus_position;
    position_t mfr_crawler_bus_next_position;
    logic      mfr_crawler_bus_move;
    logic      mfr_crawler_bus_jump;

    /////////////////////
    // Crawler Modules //
    /////////////////////

    assign initial_result = '{0, 0, initial_condition_i, 0, 0};

    assign matrix_dimensions = '{read_len_i, hap_len_i};

    /* MCR should move if :
     * - worker is enabled and can send a compute request
     * */
    assign mcr_crawler_bus_move = enable_i && send_compute_request;

    /* Actually the MFR crawler is not needed */
    /* MFR shoud move if :
     * - a result is read
     * */
    assign mfr_crawler_bus_move = read_result_fifo;

    /* MCR Crawler */
    cl_matrix_crawler #(
        .POSITION_T(position_t)
    ) mcr (
        .reset_i(reset_i),
        .clock_i(clock_i),
        .position_o(mcr_crawler_bus_position),
        .next_position_o(mcr_crawler_bus_next_position),
        .move_i(mcr_crawler_bus_move),
        .jump_o(mcr_crawler_bus_jump),
        .enable_i(enable_i),
        .matrix_dimensions(matrix_dimensions)
    );

    /* MFR Crawler */
    cl_matrix_crawler #(
        .POSITION_T(position_t)
    ) mfr (
        .reset_i(reset_i),
        .clock_i(clock_i),
        .position_o(mfr_crawler_bus_position),
        .next_position_o(mfr_crawler_bus_next_position),
        .move_i(mfr_crawler_bus_move),
        .jump_o(mfr_crawler_bus_jump),
        .enable_i(enable_i),
        .matrix_dimensions(matrix_dimensions)
    );

    /* The results in the FIFO will be in the correct order */

    /* Validity registers */
    always_ff @(posedge clock_i) begin
        if (reset_i || !enable_i) begin
            left_result_valid_reg <= 1'b0;
            /* Top should be valid in all cases except when invalidated by mcr */
            /* Because top takes left values, and we don't move unless we have
             * correct left value */
            top_result_valid_reg  <= 1'b1;
        end else begin
            if (mfr_will_fill_left) begin
                left_result_valid_reg <= 1'b1;
            end else begin
                if (mcr_tries_to_invalidate_left) begin
                    left_result_valid_reg <= 1'b0;
                end
            end

            if (mfr_will_fill_top) begin
                top_result_valid_reg <= 1'b1;
            end else begin
                if (mcr_tries_to_invalidate_top) begin
                    top_result_valid_reg <= 1'b0;
                end
            end
        end
    end

    /* Actual data registers */
    always_ff @(posedge clock_i) begin
        if (mfr_will_fill_left) begin
            left_result_reg <= compute_result_bus.read_data;
        end
        if (mfr_will_fill_top) begin
            top_result_reg <= compute_result_bus.read_data;
        end else if (mcr_crawler_bus_move) begin
            top_result_reg <= left_result_reg;
        end
    end

    /* Needed to stop sending requests */
    always_ff @(posedge clock_i) begin
        if (reset_i || !enable_i) begin
            last_request_sent <= 'b0;
        end else if (mcr_crawler_bus_position == matrix_dimensions) begin
            if (send_compute_request) begin
                last_request_sent <= 'b1;
            end
        end
    end

    /*************************/
    /* Compute Request Logic */
    /*************************/

    /* The mfr process is in the last column when it's x position is the same as the matrix dim */
    assign mfr_in_last_column = (mfr_crawler_bus_position.x == matrix_dimensions.x);

    /* The destination of the mfr matrix fill register module is ready if empty (not valid)
     * or if the mcr process would otherwise make it empty, the destination depends on the
     * mfr position on the x axis */
    assign mfr_destination_reg_ready = mfr_in_last_column ?
                                       (!top_result_valid_reg  || mcr_tries_to_invalidate_top) :
                                       (!left_result_valid_reg || mcr_tries_to_invalidate_left);

    /* The top reg will be filled by the mfr if it is in the last column */
    assign mfr_will_fill_top = read_result_fifo && mfr_in_last_column;
    /* The left reg will be filled by the mfr if it is not in the last column */
    assign mfr_will_fill_left = read_result_fifo && !mfr_in_last_column;

    /* The mcr process will try to invalidate left in all cases except on the first column, x = 0 */
    assign mcr_tries_to_invalidate_left = send_compute_request && (mcr_crawler_bus_position.x != 0);
    /* The mcr process will try to invalidate top only if we jump to the last column at y > 0 */
    assign mcr_tries_to_invalidate_top  = send_compute_request && mcr_crawler_bus_jump && (mcr_crawler_bus_next_position.y != 0);

    /* Reading the result FIFO when it is not empty and we update the left result or when we wait for the last result */
    /* We may also need to wait for the result shift register */
    assign read_result_fifo = (!compute_result_bus.empty) && (!wait_for_res_shift_reg) && (mfr_destination_reg_ready || (mfr_crawler_bus_position == matrix_dimensions));
    assign compute_result_bus.read = read_result_fifo;

    /* The left result is ready if valid or if we use the initial conditions (when x = 0) */
    assign left_ready = left_result_valid_reg || (mcr_crawler_bus_position.x == 0);
    /* The top result is ready if valid of if we use the initial conditions (when x = 0 or y = 0) */
    /* x = 0 is the precomputation for the diagonal dependency, therefore it is a special case */
    /* For y = 0, this is the top row, so there is no temporary result above it */
    assign top_ready = top_result_valid_reg || (mcr_crawler_bus_position.x == 0) || (mcr_crawler_bus_position.y == 0);
    assign send_compute_request = left_ready && top_ready && !compute_request_bus.full && enable_i && !last_request_sent;

    /***********************/
    /* Compute Request Bus */
    /***********************/

    /* Initial conditions multiplexing */
    /* The column where x = 0 is to compute the diagonal dependency on the initial constant */
    /* The real computation are all columns right of x = 1 (included) but they need the temporary
     * results tmp_a/tmp_b to be precomputed (rest should still be null) */
    assign left_temps = '{0,0,0,left_result_reg.temp_A, left_result_reg.temp_B};
    assign compute_request_bus.write_data.result_left = (mcr_crawler_bus_position.x == 0) ? PairHMMPackage::NULL_RESULT :
                                                        (mcr_crawler_bus_position.x == 1) ? left_temps  :
                                                        left_result_reg;
    assign compute_request_bus.write_data.result_top = (mcr_crawler_bus_position.x == 0) ? initial_result :
                                                       (mcr_crawler_bus_position.y == 0) ? PairHMMPackage::NULL_RESULT :
                                                       top_result_reg;
    /* Compute request base qualities */
    assign compute_request_bus.write_data.base_quals              = read_info_bus.read_data.base_quals;
    /* When x is zero we need the first base qualities */
    assign compute_request_bus.write_data.insertion_qual_right    = (mcr_crawler_bus_position.x == 0) ? read_info_bus.read_data.base_quals.insertion_qual :
                                                                    read_info_bus.read_data.insertion_qual_right;
    assign compute_request_bus.write_data.deletion_qual_right     = (mcr_crawler_bus_position.x == 0) ? read_info_bus.read_data.base_quals.deletion_qual :
                                                                    read_info_bus.read_data.deletion_qual_right;
    assign compute_request_bus.write_data.continuation_qual_right = (mcr_crawler_bus_position.x == 0) ? read_info_bus.read_data.base_quals.continuation_qual :
                                                                    read_info_bus.read_data.continuation_qual_right;
    /* Compute request match info */
    assign compute_request_bus.write_data.match = (read_info_bus.read_data.base == hap_info_bus.read_data.base) ||
                                                  (read_info_bus.read_data.base == "N") ||
                                                  (hap_info_bus.read_data.base  == "N");

    /* Compute request write */
    assign compute_request_bus.write = send_compute_request;

    /******************/
    /* BRAM Interface */
    /******************/

    /* The address is 0 when the system is not enabled */
    assign read_read_addr = (mcr_crawler_bus_next_position.x == 0) ? 'b0 : mcr_crawler_bus_next_position.x - 1;
    assign read_info_bus.read_addr = enable_i ? read_read_addr :
                                                'b0;
    /* Read before the worker is enabled to be ready (BRAM clock cycle) */
    assign read_info_bus.read_en = !enable_i || send_compute_request;

    assign hap_read_addr = mcr_crawler_bus_next_position.y; /* next_y */
    assign hap_info_bus.read_addr = enable_i ? hap_read_addr :
                                               'b0;
    assign hap_info_bus.read_en = !enable_i || send_compute_request;

    /**************/
    /* Result Bus */
    /**************/
    assign get_result = (mfr_crawler_bus_position.x == matrix_dimensions.x) && read_result_fifo;

    /* Shows if there is data in the result shift register */
    always_ff @(posedge clock_i) begin
        /* Reset means empty */
        if (reset_i || !enable_i) begin
            res_reg_1_full <= 1'b0;
            res_reg_2_full <= 1'b0;
        /* Getting result means full */
        end else if (get_result) begin
            res_reg_1_full <= 1'b1;
            res_reg_2_full <= 1'b1;
        /* Result transmitted means shift */
        end else if (send_result_sum) begin
            res_reg_2_full <= 1'b0;
            res_reg_1_full <= res_reg_2_full;
        end
    end

    /* If the shift register is full we need to stall the pipeline */
    assign wait_for_res_shift_reg = (res_reg_1_full || res_reg_2_full) && (mfr_crawler_bus_position.x == matrix_dimensions.x);

    /* Data shift register */
    always_ff @(posedge clock_i) begin
        /* Getting results means fill the regs */
        if (get_result) begin
            res_reg_1 <= compute_result_bus.read_data.match;
            res_reg_2 <= compute_result_bus.read_data.insertion;
        /* Transmitting a result means shift */
        end else if (send_result_sum) begin
            res_reg_1 <= res_reg_2;
        end
    end

    /* The last data will be in register 2 first then shifted out */
    always_ff @(posedge clock_i) begin
        if (reset_i || !enable_i) begin
            tlast_reg_2 <= 1'b0;
            tlast_reg_1 <= 1'b0;
        end else if ((mfr_crawler_bus_position == matrix_dimensions) && read_result_fifo) begin
            tlast_reg_2 <= 1'b1;
            tlast_reg_1 <= 1'b0;
        end else if (send_result_sum) begin
            tlast_reg_2 <= 1'b0;
            tlast_reg_1 <= tlast_reg_2;
        end
    end // always_ff @

    /****************************/
    /* Sum bus for accumulation */
    /****************************/

    /* The data is valid when result register 1 is full */
    assign result_sum_bus.tvalid = res_reg_1_full && !result_acc_reg_busy;
    /* The data comes from result register 1 and result register (accumulated current result) */
    assign result_sum_bus.tdata  = {res_reg_1, result_acc_reg};
    /* The result is transmitted when the result register 1 is full and the bus is ready and the result
       register is not busy (accumulation taking place) */
    assign send_result_sum = res_reg_1_full && result_sum_bus.tready && !result_acc_reg_busy;

    /* We are always ready to get summation results */
    assign sum_result_bus.tready = 1'b1;

    /* End of accumulation */
    always_ff @(posedge clock_i) begin
        if (reset_i || !enable_i) begin
            waiting_for_last_result <= 'b0;
        /* If the last accumulation computation is sent we are waiting for the last result */
        end else if (send_result_sum && tlast_reg_1) begin
            waiting_for_last_result <= 'b1;
        /* When we receive a result we will not be waiting for the last result anymore */
        /* Because either we are waiting for the last result and receive it or we are */
        /* not waiting for it so this does not change because the value is already 0 */
        end else if (sum_result_bus.tvalid) begin
            waiting_for_last_result <= 'b0;
        end
    end

    /* Accumulator register */
    always_ff @(posedge clock_i) begin
        if (reset_i || !enable_i) begin
            result_acc_reg      <= 'b0;
            result_acc_reg_busy <= 'b0;
        /* If we get a result, store it in the accumulator register */
        end else if (sum_result_bus.tvalid) begin
            result_acc_reg      <= sum_result_bus.tdata;
            result_acc_reg_busy <= 'b0;
        end else if (send_result_sum) begin
            result_acc_reg_busy <= 'b1;
        end
    end

    /* Result Bus */
    always_ff @(posedge clock_i) begin
        if (reset_i || !enable_i) begin
            final_result_bus.tvalid <= 'b0;
        /* If the last sum result came, transmit to result bus */
        end else if(waiting_for_last_result && sum_result_bus.tvalid) begin
            final_result_bus.tvalid <= 'b1;
        end else if (final_result_bus.tready) begin
            final_result_bus.tvalid <= 'b0;
        end

        /* If the last sum result came, transmit to result bus */
        if (waiting_for_last_result && sum_result_bus.tvalid) begin
            final_result_bus.tdata <= sum_result_bus.tdata;
        end
    end

    /* Will allow to differenciate the results */
    assign tid   = WORKER_ID;

    /******************/
    /* DEBUG GENERATE */
    /******************/
    generate
        if (DEBUG_VERBOSITY == 1) begin
            always_ff @(posedge clock_i) begin
                if (send_compute_request) begin
                    $display("Compute request sent for (%d, %d)", mcr_crawler_bus_position.x, mcr_crawler_bus_position.y);
                    $monitor("this is done @%d ns",$time);
                end
                if (read_result_fifo) begin
                    if (mfr_crawler_bus_position.x != 0) begin
                        $display("Result FIFO was read for (%d, %d)", mfr_crawler_bus_position.x, mfr_crawler_bus_position.y);
                        $display("m : %e", $bitstoshortreal(compute_result_bus.read_data.match));
                        $display("x : %e", $bitstoshortreal(compute_result_bus.read_data.insertion));
                        $display("y : %e", $bitstoshortreal(compute_result_bus.read_data.deletion));
                    end else begin
                        $display("-----------------------------------");
                        $display("-----------------------------------");
                    end
                end
            end
        end
        else if (DEBUG_VERBOSITY == 2) begin
            always_ff @(posedge clock_i) begin
                if (read_result_fifo) begin
                    if (mfr_crawler_bus_position.x != 0) begin
                        $display("Result FIFO was read for (%d, %d)", mfr_crawler_bus_position.x, mfr_crawler_bus_position.y);
                        $display("Match     : %08x", compute_result_bus.read_data.match);
                        $display("Insertion : %08x", compute_result_bus.read_data.insertion);
                        $display("Deletion  : %08x", compute_result_bus.read_data.deletion);
                    end
                end
            end
        end
    endgenerate

endmodule // cl_pairhmm_new_worker_core_synth
