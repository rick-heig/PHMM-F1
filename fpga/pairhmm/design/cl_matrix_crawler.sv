//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : cl_matrix_crawler.sv
// Description  : This module was created because nested modules are not
//                supported in synthesis by Vivado 2017.4
//
// Author       : Rick Wertenbroek
// Date         : 26.03.19
// Version      : 0.0
//
// Dependencies :
//
// Modifications //------------------------------------------------------------
// Version   Author Date               Description
// 0.0       RWE    26.03.19           Creation
//-----------------------------------------------------------------------------

module cl_matrix_crawler #(
    type POSITION_T = struct {logic[7:0] x; logic[7:0] y;} // Defined by the father module
) (
    // Standard inputs
    input logic  reset_i,
    input logic  clock_i,

    // Module signals
    output POSITION_T position_o,
    output POSITION_T next_position_o,
    input  logic move_i,
    output logic jump_o,

    // Father module signals
    input  logic      enable_i,
    input  POSITION_T matrix_dimensions
);

    logic      move;
    logic      jump;
    POSITION_T position_reg;
    POSITION_T next_position;
    POSITION_T jump_reg;

    /* Cantor's ZigZag :
     *
     * The traversal is implemented with two counters, one with the current
     * position of the crawler and another with the next position to jump to if
     * the crawler needs to jump (i.e., not continue along the anti-diagonal
     *
     *  .------> x
     *  | [1][2][4]
     *  v [3][5][7]
     *  y [6][8][9]
     *
     * jump : we jump at 1,3,6, and 8 (to the next number)
     * move : else we go down the anti diagonal at 2,4,5, and 7
     * stop : we stop at 9, the last cell
     *
     * 1 jump -> 2 -> 3 jump -> 4 -> 5 -> 6 jump -> 7 -> 8 jump -> 9 stop
     *
     * Evolution of the position counter :
     * (x,y) : (0,0), (1,0), (0,1), (2,0), (1,1), (0,2), (2,1), (1,1), (2,2)
     *
     * Evolution of the jump counter :
     * (x,y) : (1,0), (2,0),        (2,1),               (2,2)
     *
     * Note : This is not the best movement pattern for memory accesses if a cache is used
     * however if the read/hap are stored entirely in a BRAM this is not really an issue.
     * If caches are used it is better to partition the matrix in submatrices.
     *
     * Note : More parallelism can be obtained by doing multiple traversals in parallel,
     * e.g., one doing the odd numbers and another doing the even number.
     *
     * */

    assign move = move_i &&
                  !((position_reg.x == matrix_dimensions.x) && (position_reg.y == matrix_dimensions.y)); // This line could be removed if handled out of the crawler.

    /* Crawler should jump if :
     * - Crawler will move and on an edge ((x == 0) or (y == y_max)) (matrix dimensions y)
     * */
    assign jump = move && ((position_reg.x == 0) || (position_reg.y == matrix_dimensions.y));

    /* Computation of the next position */
    always_comb begin
        /* If we jump we take the coordinates from the jump register */
        if (jump) begin
            next_position <= jump_reg;
        /* Else we move along the anti-diagonal */
        end else begin
            next_position.x <= position_reg.x - 1;
            next_position.y <= position_reg.y + 1;
        end
    end

    /* Position counter */
    always_ff @(posedge clock_i) begin
        if (reset_i || !enable_i) begin
            position_reg <= '{0,0};
        /* This register is only updated if the crawler moves */
        end else if (move) begin
            position_reg <= next_position;
        end
    end

    /* Jump counter */
    always_ff @(posedge clock_i) begin
        if (reset_i || !enable_i) begin
            jump_reg <= '{1,0};
        /* This register is only updated if the crawler jumps */
        end else if (jump) begin
            /* If x is already at the edge increment y */
            if (jump_reg.x == matrix_dimensions.x) begin
                jump_reg.y <= jump_reg.y + 1;
            /* Else increment x */
            end else begin
                jump_reg.x <= jump_reg.x + 1;
            end
        end
    end

    /* Output */
    assign position_o      = position_reg;
    assign next_position_o = next_position;
    assign jump_o          = jump;

endmodule // cl_matrix_crawler
