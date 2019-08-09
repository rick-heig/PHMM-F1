`include "cl_defines.vh"

`ifndef __PAIRHMMPACKAGE__
`define __PAIRHMMPACKAGE__

// These are constants, i.e., they are not meant to be changed (or you'll
// need to adapt the rest of the code).
`define MAX_NUMBER_OF_READS 2048
`define MAX_NUMBER_OF_HAPS  2048

package PairHMMPackage;

    typedef logic [`FLOATING_POINT_WIDTH-1:0] floating_point_t;

    // ID is actually read_number * (number of haps) + hap_number
    // ID is also the position of the result in the final result array
    typedef logic [$clog2(`MAX_NUMBER_OF_READS)+$clog2(`MAX_NUMBER_OF_HAPS)-1:0] id_t;

    // These are bytes for now but could be changed into smaller representations.
    typedef logic [7:0]                       nucleotide_t;
    // Qualities
    typedef logic [7:0]                       quality_t;

    typedef struct {
        floating_point_t result;
        id_t             id;
    } final_result_t;

    typedef struct {
        // Note : The lengths must be -1 because we are 0 indexed
        logic [/*READ_ADDR_SIZE*/32-1:0]                read_addr;
        logic [$clog2(/*MAX_SEQUENCE_LENGTH*/2048)-1:0] read_len_min_1;
        logic [/*HAP_ADDR_SIZE*/32-1:0]                 hap_addr;
        logic [$clog2(/*MAX_SEQUENCE_LENGTH*/2048)-1:0] hap_len_min_1;
        floating_point_t                                initial_condition;
        id_t                                            id;
    } work_request_t;

    typedef struct {
        // Note : The lengths must be -1 because we are 0 indexed
        logic [$clog2(/*MAX_SEQUENCE_LENGTH*/2048)-1:0] read_len_min_1;
        logic [$clog2(/*MAX_SEQUENCE_LENGTH*/2048)-1:0] hap_len_min_1;
        floating_point_t                                initial_condition;
        id_t                                            id;
    } work_request_2_t;

    /* Result */
    typedef struct {
        floating_point_t match;
        floating_point_t insertion;
        floating_point_t deletion;
        floating_point_t temp_A;
        floating_point_t temp_B;
    } result_t;

    /* This constant should at most be max float / max possible read/hap length */
    //const shortreal INITIAL_CONDITION = 5.18723e+35; /* 2^1020 (double) in GATK */
    //const shortreal INITIAL_CONDITION = 3.54461e+36; /* 2^1020 (double) in GATK */

    const result_t NULL_RESULT    = '{0,0,0,0,0};
    //const result_t INITIAL_RESULT = '{0,0,$shortrealtobits(INITIAL_CONDITION),0,0};

    typedef struct {
        floating_point_t value_1;
        floating_point_t value_2;
    } float_tuple_t;

    /* Read Base Quality Info */
    typedef struct {
        quality_t base_qual;
        quality_t insertion_qual;
        quality_t deletion_qual;
        quality_t continuation_qual;
    } base_qualities_t;

    /* Read Base Info */
    typedef struct {
        nucleotide_t     base;
        base_qualities_t base_quals;
        /* These are here to simplify busses */
        quality_t        insertion_qual_right;
        quality_t        deletion_qual_right;
        quality_t        continuation_qual_right;
    } read_base_info_t;

    /* Haplotype Base Info */
    typedef struct {
        nucleotide_t     base;
    } hap_base_info_t;

    /* Request */
    typedef struct {
        /* Dependencies */
        result_t         result_left;
        result_t         result_top;
        /* Current base qualities */
        base_qualities_t base_quals;
        /* Qualities of the next base are needed to precompute tmp_A and tmp_B */
        /* I.e., the diagonal dependency */
        quality_t        insertion_qual_right;
        quality_t        deletion_qual_right;
        quality_t        continuation_qual_right;
        logic            match;
    } request_t;

    /* Store Type */
    typedef enum         {STORE_R, STORE_Q, STORE_I, STORE_D, STORE_C, STORE_H} store_type_t;
    typedef store_type_t stream_type_t;

endpackage: PairHMMPackage

`endif
