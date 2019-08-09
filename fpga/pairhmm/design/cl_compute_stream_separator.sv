//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : cl_compute_stream_separator.sv
// Description  : This will separate the compute request stream into independent
//                data streams for the compute engine. This will allow to issue
//                all the data at to the compute engine without
//                having the tvalid signal to be dependent on tready (In
//                AXI4-Stream a master is not permitted to wait until tready is
//                asserted before asserting tvalid).
//
//                This module will also convert the data streams that need
//                conversion. (E.g., going from byte (phred score) to floating
//                point probability value).
//
// Author       : Rick Wertenbroek
// Date         : 05.03.19
// Version      : 0.3
//
// Dependencies :
//
// Modifications //------------------------------------------------------------
// Version   Author Date               Description
// 0.0       RWE    05.03.19           Creation
// 0.1       RWE    18.03.19           Used values from software for conversion
//                                     tables and fixed computation of Amm from
//                                     (1.0 - Qi) - Qd to 1.0 - (Qi + Qd)
// 0.2       RWE    11.06.19           Added tristate correction
// 0.3       RWE    11.06.19           Added quality offset
//-----------------------------------------------------------------------------

`include "cl_pairhmm_package.vh"

module cl_compute_stream_separator #(
    parameter DEBUG_VERBOSITY = 1,
    parameter USE_TRISTATE_CORRECTION = 1,
    parameter QUAL_OFFSET = 0//33 // Phred score offset (Unused)
) (
    input logic clock_i,
    input logic reset_i,

    // Compute requests from workers
    fifo_if.slave_write compute_req_bus,

    // AXI-Stream interfaces to compute engine
    axi_stream_simple_if.master m_axis_top_insertion,
    axi_stream_simple_if.master m_axis_top_deletion,
    axi_stream_simple_if.master m_axis_one_min_c_qual_right,
    axi_stream_simple_if.master m_axis_top_match,
    axi_stream_simple_if.master m_axis_one_constant,
    axi_stream_simple_if.master m_axis_i_qual_right,
    axi_stream_simple_if.master m_axis_d_qual_right,
    axi_stream_simple_if.master m_axis_left_ta,
    axi_stream_simple_if.master m_axis_left_tb,
    axi_stream_simple_if.master m_axis_prior,
    axi_stream_simple_if.master m_axis_i_qual,
    axi_stream_simple_if.master m_axis_left_match,
    axi_stream_simple_if.master m_axis_c_qual,
    axi_stream_simple_if.master m_axis_left_insertion,
    axi_stream_simple_if.master m_axis_d_qual,
    axi_stream_simple_if.master m_axis_top_match_bis,
    axi_stream_simple_if.master m_axis_c_qual_bis,
    axi_stream_simple_if.master m_axis_top_deletion_bis,
    axi_stream_simple_if.master m_axis_id
);
    ///////////////////////
    // Conversion tables //
    ///////////////////////
    PairHMMPackage::floating_point_t ph2pr_table[255:0];
    PairHMMPackage::floating_point_t one_min_ph2pr_table[255:0];
    PairHMMPackage::floating_point_t ph2pr_table_tristate[255:0];

    /////////////
    // Signals //
    /////////////

    // Data registers for the compute engine
    PairHMMPackage::floating_point_t top_insertion_reg;
    PairHMMPackage::floating_point_t top_deletion_reg;
    PairHMMPackage::floating_point_t one_min_c_qual_right_reg;
    PairHMMPackage::floating_point_t top_match_reg;
    PairHMMPackage::floating_point_t i_qual_right_reg;
    PairHMMPackage::floating_point_t d_qual_right_reg;
    PairHMMPackage::floating_point_t left_ta_reg;
    PairHMMPackage::floating_point_t left_tb_reg;
    PairHMMPackage::floating_point_t prior_reg;
    PairHMMPackage::floating_point_t i_qual_reg;
    PairHMMPackage::floating_point_t left_match_reg;
    PairHMMPackage::floating_point_t c_qual_reg;
    PairHMMPackage::floating_point_t left_insertion_reg;
    PairHMMPackage::floating_point_t d_qual_reg;
    PairHMMPackage::floating_point_t id_reg;

    // Data registers "full" registers
    logic top_insertion_full_reg;
    logic top_deletion_full_reg;
    logic one_min_c_qual_right_full_reg;
    logic top_match_full_reg;
    logic i_qual_right_full_reg;
    logic d_qual_right_full_reg;
    logic left_ta_full_reg;
    logic left_tb_full_reg;
    logic prior_full_reg;
    logic i_qual_full_reg;
    logic left_match_full_reg;
    logic c_qual_full_reg;
    logic left_insertion_full_reg;
    logic d_qual_full_reg;
    logic top_match_bis_full_reg;
    logic c_qual_bis_full_reg;
    logic top_deletion_bis_full_reg;
    logic id_full_reg;

    // Comb signals
    logic ready_to_receive;
    logic will_fill;

    ///////////////////////
    // Conversion Tables //
    ///////////////////////

    initial begin
        /* Fill the conversion tables (ROMs, look-up tables) */
        for (int i = 0; i < 256; i++) begin
            ph2pr_table[i]          = 'b0;
            ph2pr_table_tristate[i] = 'b0;
            //ph2pr_table[i]         = $shortrealtobits(shortreal'(10.0) ** ((-(i - QUAL_OFFSET)) / shortreal'(10.0)));
            //one_min_ph2pr_table[i] = $shortrealtobits(shortreal'(1.0) - (shortreal'(10.0) ** ((-(i - QUAL_OFFSET)) / shortreal'(10.0))));
            //ph2pr_table[i]         = $shortrealtobits(shortreal'(10.0 ** (real'(i - QUAL_OFFSET) / -10.0)));
            //one_min_ph2pr_table[i] = $shortrealtobits(shortreal'(1.0 - (10.0 ** (real'(i - QUAL_OFFSET) / -10.0))));
            //if (DEBUG_VERBOSITY) begin
            //    $display("i : %d - (%e, %e)", i, $bitstoshortreal(ph2pr_table[i]), $bitstoshortreal(one_min_ph2pr_table[i]));
            //    $display("i : %d - %08x", i, ph2pr_table[i]);
            //end
        end

        // Values extracted from software version
        // pairhmm_impl.h line 52, PRECISION is float (i is offset by 33)
        // m_ph2pr.push_back(pow(static_cast<PRECISION>(10.0), (-i) / static_cast<PRECISION>(10.0)));
        ph2pr_table[33-QUAL_OFFSET]  = 'h3f800000;
        ph2pr_table[34-QUAL_OFFSET]  = 'h3f4b5918;
        ph2pr_table[35-QUAL_OFFSET]  = 'h3f21866c;
        ph2pr_table[36-QUAL_OFFSET]  = 'h3f004dce;
        ph2pr_table[37-QUAL_OFFSET]  = 'h3ecbd4b4;
        ph2pr_table[38-QUAL_OFFSET]  = 'h3ea1e89b;
        ph2pr_table[39-QUAL_OFFSET]  = 'h3e809bcc;
        ph2pr_table[40-QUAL_OFFSET]  = 'h3e4c509b;
        ph2pr_table[41-QUAL_OFFSET]  = 'h3e224b06;
        ph2pr_table[42-QUAL_OFFSET]  = 'h3e00e9fa;
        ph2pr_table[43-QUAL_OFFSET]  = 'h3dcccccd;
        ph2pr_table[44-QUAL_OFFSET]  = 'h3da2adad;
        ph2pr_table[45-QUAL_OFFSET]  = 'h3d813855;
        ph2pr_table[46-QUAL_OFFSET]  = 'h3d4d494c;
        ph2pr_table[47-QUAL_OFFSET]  = 'h3d231091;
        ph2pr_table[48-QUAL_OFFSET]  = 'h3d0186e2;
        ph2pr_table[49-QUAL_OFFSET]  = 'h3ccdc613;
        ph2pr_table[50-QUAL_OFFSET]  = 'h3ca373ae;
        ph2pr_table[51-QUAL_OFFSET]  = 'h3c81d59f;
        ph2pr_table[52-QUAL_OFFSET]  = 'h3c4e4329;
        ph2pr_table[53-QUAL_OFFSET]  = 'h3c23d70a;
        ph2pr_table[54-QUAL_OFFSET]  = 'h3c02248c;
        ph2pr_table[55-QUAL_OFFSET]  = 'h3bcec088;
        ph2pr_table[56-QUAL_OFFSET]  = 'h3ba43aa3;
        ph2pr_table[57-QUAL_OFFSET]  = 'h3b8273a5;
        ph2pr_table[58-QUAL_OFFSET]  = 'h3b4f3e37;
        ph2pr_table[59-QUAL_OFFSET]  = 'h3b249e78;
        ph2pr_table[60-QUAL_OFFSET]  = 'h3b02c2f1;
        ph2pr_table[61-QUAL_OFFSET]  = 'h3acfbc32;
        ph2pr_table[62-QUAL_OFFSET]  = 'h3aa50285;
        ph2pr_table[63-QUAL_OFFSET]  = 'h3a83126f;
        ph2pr_table[64-QUAL_OFFSET]  = 'h3a503a7a;
        ph2pr_table[65-QUAL_OFFSET]  = 'h3a2566d3;
        ph2pr_table[66-QUAL_OFFSET]  = 'h3a03621c;
        ph2pr_table[67-QUAL_OFFSET]  = 'h39d0b907;
        ph2pr_table[68-QUAL_OFFSET]  = 'h39a5cb5f;
        ph2pr_table[69-QUAL_OFFSET]  = 'h3983b1fa;
        ph2pr_table[70-QUAL_OFFSET]  = 'h395137e9;
        ph2pr_table[71-QUAL_OFFSET]  = 'h39263028;
        ph2pr_table[72-QUAL_OFFSET]  = 'h39040204;
        ph2pr_table[73-QUAL_OFFSET]  = 'h38d1b717;
        ph2pr_table[74-QUAL_OFFSET]  = 'h38a6952f;
        ph2pr_table[75-QUAL_OFFSET]  = 'h38845248;
        ph2pr_table[76-QUAL_OFFSET]  = 'h3852368c;
        ph2pr_table[77-QUAL_OFFSET]  = 'h3826fa6c;
        ph2pr_table[78-QUAL_OFFSET]  = 'h3804a2b3;
        ph2pr_table[79-QUAL_OFFSET]  = 'h37d2b65d;
        ph2pr_table[80-QUAL_OFFSET]  = 'h37a75ff3;
        ph2pr_table[81-QUAL_OFFSET]  = 'h3784f34f;
        ph2pr_table[82-QUAL_OFFSET]  = 'h3753366c;
        ph2pr_table[83-QUAL_OFFSET]  = 'h3727c5ac;
        ph2pr_table[84-QUAL_OFFSET]  = 'h37054425;
        ph2pr_table[85-QUAL_OFFSET]  = 'h36d3b6d9;
        ph2pr_table[86-QUAL_OFFSET]  = 'h36a82ba3;
        ph2pr_table[87-QUAL_OFFSET]  = 'h36859523;
        ph2pr_table[88-QUAL_OFFSET]  = 'h36543784;
        ph2pr_table[89-QUAL_OFFSET]  = 'h362891e4;
        ph2pr_table[90-QUAL_OFFSET]  = 'h3605e65c;
        ph2pr_table[91-QUAL_OFFSET]  = 'h35d4b87e;
        ph2pr_table[92-QUAL_OFFSET]  = 'h35a8f857;
        ph2pr_table[93-QUAL_OFFSET]  = 'h358637bd;
        ph2pr_table[94-QUAL_OFFSET]  = 'h355539d5;
        ph2pr_table[95-QUAL_OFFSET]  = 'h35295f14;
        ph2pr_table[96-QUAL_OFFSET]  = 'h3506894f;
        ph2pr_table[97-QUAL_OFFSET]  = 'h34d5bb6c;
        ph2pr_table[98-QUAL_OFFSET]  = 'h34a9c603;
        ph2pr_table[99-QUAL_OFFSET]  = 'h3486db1d;
        ph2pr_table[100-QUAL_OFFSET] = 'h34563d61;
        ph2pr_table[101-QUAL_OFFSET] = 'h342a2d31;
        ph2pr_table[102-QUAL_OFFSET] = 'h34072d12;
        ph2pr_table[103-QUAL_OFFSET] = 'h33d6bf95;
        ph2pr_table[104-QUAL_OFFSET] = 'h33aa94ab;
        ph2pr_table[105-QUAL_OFFSET] = 'h33877f43;
        ph2pr_table[106-QUAL_OFFSET] = 'h33574218;
        ph2pr_table[107-QUAL_OFFSET] = 'h332afc56;
        ph2pr_table[108-QUAL_OFFSET] = 'h3307d19c;
        ph2pr_table[109-QUAL_OFFSET] = 'h32d7c4fb;
        ph2pr_table[110-QUAL_OFFSET] = 'h32ab644d;
        ph2pr_table[111-QUAL_OFFSET] = 'h32882428;
        ph2pr_table[112-QUAL_OFFSET] = 'h3258481d;
        ph2pr_table[113-QUAL_OFFSET] = 'h322bcc77;
        ph2pr_table[114-QUAL_OFFSET] = 'h320876e5;
        ph2pr_table[115-QUAL_OFFSET] = 'h31d8cb9f;
        ph2pr_table[116-QUAL_OFFSET] = 'h31ac34e0;
        ph2pr_table[117-QUAL_OFFSET] = 'h3188c9e8;
        ph2pr_table[118-QUAL_OFFSET] = 'h31594f60;
        ph2pr_table[119-QUAL_OFFSET] = 'h312c9d89;
        ph2pr_table[120-QUAL_OFFSET] = 'h31091d0b;
        ph2pr_table[121-QUAL_OFFSET] = 'h30d9d373;
        ph2pr_table[122-QUAL_OFFSET] = 'h30ad068a;
        ph2pr_table[123-QUAL_OFFSET] = 'h3089705f;
        ph2pr_table[124-QUAL_OFFSET] = 'h305a57d5;
        ph2pr_table[125-QUAL_OFFSET] = 'h302d6fb2;
        ph2pr_table[126-QUAL_OFFSET] = 'h3009c3e7;
        ph2pr_table[127-QUAL_OFFSET] = 'h2fdadca7;
        ph2pr_table[128-QUAL_OFFSET] = 'h2fadd91a;
        ph2pr_table[129-QUAL_OFFSET] = 'h2f8a17a1;
        ph2pr_table[130-QUAL_OFFSET] = 'h2f5b61ab;
        ph2pr_table[131-QUAL_OFFSET] = 'h2f2e42c2;
        ph2pr_table[132-QUAL_OFFSET] = 'h2f0a6ba2;
        ph2pr_table[133-QUAL_OFFSET] = 'h2edbe6ff;
        ph2pr_table[134-QUAL_OFFSET] = 'h2eaeacaa;
        ph2pr_table[135-QUAL_OFFSET] = 'h2e8abfc2;
        ph2pr_table[136-QUAL_OFFSET] = 'h2e5c6ca4;
        ph2pr_table[137-QUAL_OFFSET] = 'h2e2f16ec;
        ph2pr_table[138-QUAL_OFFSET] = 'h2e0b1415;
        ph2pr_table[139-QUAL_OFFSET] = 'h2ddcf29b;
        ph2pr_table[140-QUAL_OFFSET] = 'h2daf8155;
        ph2pr_table[141-QUAL_OFFSET] = 'h2d8b689b;
        ph2pr_table[142-QUAL_OFFSET] = 'h2d5d7903;
        ph2pr_table[143-QUAL_OFFSET] = 'h2d2febff;
        ph2pr_table[144-QUAL_OFFSET] = 'h2d0bbd55;
        ph2pr_table[145-QUAL_OFFSET] = 'h2cddff9c;
        ph2pr_table[146-QUAL_OFFSET] = 'h2cb056ea;
        ph2pr_table[147-QUAL_OFFSET] = 'h2c8c1256;
        ph2pr_table[148-QUAL_OFFSET] = 'h2c5e8688;
        ph2pr_table[149-QUAL_OFFSET] = 'h2c30c215;
        ph2pr_table[150-QUAL_OFFSET] = 'h2c0c6777;
        ph2pr_table[151-QUAL_OFFSET] = 'h2bdf0dc5;
        ph2pr_table[152-QUAL_OFFSET] = 'h2bb12d9c;
        ph2pr_table[153-QUAL_OFFSET] = 'h2b8cbccc;
        ph2pr_table[154-QUAL_OFFSET] = 'h2b5f9555;
        ph2pr_table[155-QUAL_OFFSET] = 'h2b31994a;
        ph2pr_table[156-QUAL_OFFSET] = 'h2b0d1255;
        ph2pr_table[157-QUAL_OFFSET] = 'h2ae01d57;
        ph2pr_table[158-QUAL_OFFSET] = 'h2ab20539;
        ph2pr_table[159-QUAL_OFFSET] = 'h2a8d6811;
        ph2pr_table[160-QUAL_OFFSET] = 'h2a60a58c;

        for (int i = 0; i < 256; i++) begin
            one_min_ph2pr_table[i] = 'h3f800000; // 1.0
            // This is simulation only :
            //ph2pr_table_tristate[i] = $shortrealtobits($bitstoshortreal(ph2pr_table[i]) / shortreal'(3.0));
            //one_min_ph2pr_table[i] = $shortrealtobits(shortreal'(1.0) - $bitstoshortreal(ph2pr_table[i]));
            //
            //if (DEBUG_VERBOSITY) begin
            //    $display("i : %d - %08x", i, ph2pr_table_tristate[i]);
            //    $display("i : %d - (%e, %e)", i, $bitstoshortreal(ph2pr_table[i]), $bitstoshortreal(one_min_ph2pr_table[i]));
            //    $display("i : %d - %08x", i, one_min_ph2pr_table[i]);
            //end
        end

        // Values added by hand because synthesis does not support $shortrealtobits()
        // "By hand" means generated and replaced with a regexp.
        ph2pr_table_tristate[33-QUAL_OFFSET] = 'h3eaaaaab;
        ph2pr_table_tristate[34-QUAL_OFFSET] = 'h3e8790bb;
        ph2pr_table_tristate[35-QUAL_OFFSET] = 'h3e575de5;
        ph2pr_table_tristate[36-QUAL_OFFSET] = 'h3e2b1268;
        ph2pr_table_tristate[37-QUAL_OFFSET] = 'h3e07e323;
        ph2pr_table_tristate[38-QUAL_OFFSET] = 'h3dd7e0cf;
        ph2pr_table_tristate[39-QUAL_OFFSET] = 'h3dab7a65;
        ph2pr_table_tristate[40-QUAL_OFFSET] = 'h3d8835bd;
        ph2pr_table_tristate[41-QUAL_OFFSET] = 'h3d586408;
        ph2pr_table_tristate[42-QUAL_OFFSET] = 'h3d2be2a3;
        ph2pr_table_tristate[43-QUAL_OFFSET] = 'h3d088889;
        ph2pr_table_tristate[44-QUAL_OFFSET] = 'h3cd8e791;
        ph2pr_table_tristate[45-QUAL_OFFSET] = 'h3cac4b1c;
        ph2pr_table_tristate[46-QUAL_OFFSET] = 'h3c88db88;
        ph2pr_table_tristate[47-QUAL_OFFSET] = 'h3c596b6c;
        ph2pr_table_tristate[48-QUAL_OFFSET] = 'h3c2cb3d8;
        ph2pr_table_tristate[49-QUAL_OFFSET] = 'h3c092eb7;
        ph2pr_table_tristate[50-QUAL_OFFSET] = 'h3bd9ef93;
        ph2pr_table_tristate[51-QUAL_OFFSET] = 'h3bad1cd4;
        ph2pr_table_tristate[52-QUAL_OFFSET] = 'h3b89821b;
        ph2pr_table_tristate[53-QUAL_OFFSET] = 'h3b5a740d;
        ph2pr_table_tristate[54-QUAL_OFFSET] = 'h3b2d8610;
        ph2pr_table_tristate[55-QUAL_OFFSET] = 'h3b09d5b0;
        ph2pr_table_tristate[56-QUAL_OFFSET] = 'h3adaf8d9;
        ph2pr_table_tristate[57-QUAL_OFFSET] = 'h3aadef87;
        ph2pr_table_tristate[58-QUAL_OFFSET] = 'h3a8a297a;
        ph2pr_table_tristate[59-QUAL_OFFSET] = 'h3a5b7df5;
        ph2pr_table_tristate[60-QUAL_OFFSET] = 'h3a2e5941;
        ph2pr_table_tristate[61-QUAL_OFFSET] = 'h3a0a7d77;
        ph2pr_table_tristate[62-QUAL_OFFSET] = 'h39dc035c;
        ph2pr_table_tristate[63-QUAL_OFFSET] = 'h39aec33f;
        ph2pr_table_tristate[64-QUAL_OFFSET] = 'h398ad1a7;
        ph2pr_table_tristate[65-QUAL_OFFSET] = 'h395c8919;
        ph2pr_table_tristate[66-QUAL_OFFSET] = 'h392f2d7b;
        ph2pr_table_tristate[67-QUAL_OFFSET] = 'h390b2605;
        ph2pr_table_tristate[68-QUAL_OFFSET] = 'h38dd0f29;
        ph2pr_table_tristate[69-QUAL_OFFSET] = 'h38af97f8;
        ph2pr_table_tristate[70-QUAL_OFFSET] = 'h388b7a9b;
        ph2pr_table_tristate[71-QUAL_OFFSET] = 'h385d958b;
        ph2pr_table_tristate[72-QUAL_OFFSET] = 'h383002b0;
        ph2pr_table_tristate[73-QUAL_OFFSET] = 'h380bcf65;
        ph2pr_table_tristate[74-QUAL_OFFSET] = 'h37de1c3f;
        ph2pr_table_tristate[75-QUAL_OFFSET] = 'h37b06db5;
        ph2pr_table_tristate[76-QUAL_OFFSET] = 'h378c245d;
        ph2pr_table_tristate[77-QUAL_OFFSET] = 'h375ea33b;
        ph2pr_table_tristate[78-QUAL_OFFSET] = 'h3730d8ef;
        ph2pr_table_tristate[79-QUAL_OFFSET] = 'h370c7993;
        ph2pr_table_tristate[80-QUAL_OFFSET] = 'h36df2a99;
        ph2pr_table_tristate[81-QUAL_OFFSET] = 'h36b14469;
        ph2pr_table_tristate[82-QUAL_OFFSET] = 'h368ccef3;
        ph2pr_table_tristate[83-QUAL_OFFSET] = 'h365fb23b;
        ph2pr_table_tristate[84-QUAL_OFFSET] = 'h3631b031;
        ph2pr_table_tristate[85-QUAL_OFFSET] = 'h360d2491;
        ph2pr_table_tristate[86-QUAL_OFFSET] = 'h35e03a2f;
        ph2pr_table_tristate[87-QUAL_OFFSET] = 'h35b21c2f;
        ph2pr_table_tristate[88-QUAL_OFFSET] = 'h358d7a58;
        ph2pr_table_tristate[89-QUAL_OFFSET] = 'h3560c285;
        ph2pr_table_tristate[90-QUAL_OFFSET] = 'h3532887b;
        ph2pr_table_tristate[91-QUAL_OFFSET] = 'h350dd054;
        ph2pr_table_tristate[92-QUAL_OFFSET] = 'h34e14b1f;
        ph2pr_table_tristate[93-QUAL_OFFSET] = 'h34b2f4fc;
        ph2pr_table_tristate[94-QUAL_OFFSET] = 'h348e268e;
        ph2pr_table_tristate[95-QUAL_OFFSET] = 'h3461d41b;
        ph2pr_table_tristate[96-QUAL_OFFSET] = 'h343361bf;
        ph2pr_table_tristate[97-QUAL_OFFSET] = 'h340e7cf3;
        ph2pr_table_tristate[98-QUAL_OFFSET] = 'h33e25d59;
        ph2pr_table_tristate[99-QUAL_OFFSET] = 'h33b3ced1;
        ph2pr_table_tristate[100-QUAL_OFFSET] = 'h338ed396;
        ph2pr_table_tristate[101-QUAL_OFFSET] = 'h3362e6ec;
        ph2pr_table_tristate[102-QUAL_OFFSET] = 'h33343c18;
        ph2pr_table_tristate[103-QUAL_OFFSET] = 'h330f2a63;
        ph2pr_table_tristate[104-QUAL_OFFSET] = 'h32e370e4;
        ph2pr_table_tristate[105-QUAL_OFFSET] = 'h32b4a9af;
        ph2pr_table_tristate[106-QUAL_OFFSET] = 'h328f8165;
        ph2pr_table_tristate[107-QUAL_OFFSET] = 'h3263fb1d;
        ph2pr_table_tristate[108-QUAL_OFFSET] = 'h3235177b;
        ph2pr_table_tristate[109-QUAL_OFFSET] = 'h320fd8a7;
        ph2pr_table_tristate[110-QUAL_OFFSET] = 'h31e485bc;
        ph2pr_table_tristate[111-QUAL_OFFSET] = 'h31b5858b;
        ph2pr_table_tristate[112-QUAL_OFFSET] = 'h31903013;
        ph2pr_table_tristate[113-QUAL_OFFSET] = 'h3165109f;
        ph2pr_table_tristate[114-QUAL_OFFSET] = 'h3135f3dc;
        ph2pr_table_tristate[115-QUAL_OFFSET] = 'h311087bf;
        ph2pr_table_tristate[116-QUAL_OFFSET] = 'h30e59bd5;
        ph2pr_table_tristate[117-QUAL_OFFSET] = 'h30b6628b;
        ph2pr_table_tristate[118-QUAL_OFFSET] = 'h3090df95;
        ph2pr_table_tristate[119-QUAL_OFFSET] = 'h30662761;
        ph2pr_table_tristate[120-QUAL_OFFSET] = 'h3036d164;
        ph2pr_table_tristate[121-QUAL_OFFSET] = 'h301137a2;
        ph2pr_table_tristate[122-QUAL_OFFSET] = 'h2fe6b363;
        ph2pr_table_tristate[123-QUAL_OFFSET] = 'h2fb7407f;
        ph2pr_table_tristate[124-QUAL_OFFSET] = 'h2f918fe3;
        ph2pr_table_tristate[125-QUAL_OFFSET] = 'h2f673f98;
        ph2pr_table_tristate[126-QUAL_OFFSET] = 'h2f37afdf;
        ph2pr_table_tristate[127-QUAL_OFFSET] = 'h2f11e86f;
        ph2pr_table_tristate[128-QUAL_OFFSET] = 'h2ee7cc23;
        ph2pr_table_tristate[129-QUAL_OFFSET] = 'h2eb81f81;
        ph2pr_table_tristate[130-QUAL_OFFSET] = 'h2e92411d;
        ph2pr_table_tristate[131-QUAL_OFFSET] = 'h2e685903;
        ph2pr_table_tristate[132-QUAL_OFFSET] = 'h2e388f83;
        ph2pr_table_tristate[133-QUAL_OFFSET] = 'h2e1299ff;
        ph2pr_table_tristate[134-QUAL_OFFSET] = 'h2de8e638;
        ph2pr_table_tristate[135-QUAL_OFFSET] = 'h2db8ffad;
        ph2pr_table_tristate[136-QUAL_OFFSET] = 'h2d92f318;
        ph2pr_table_tristate[137-QUAL_OFFSET] = 'h2d6973e5;
        ph2pr_table_tristate[138-QUAL_OFFSET] = 'h2d39701c;
        ph2pr_table_tristate[139-QUAL_OFFSET] = 'h2d134c67;
        ph2pr_table_tristate[140-QUAL_OFFSET] = 'h2cea01c7;
        ph2pr_table_tristate[141-QUAL_OFFSET] = 'h2cb9e0cf;
        ph2pr_table_tristate[142-QUAL_OFFSET] = 'h2c93a602;
        ph2pr_table_tristate[143-QUAL_OFFSET] = 'h2c6a8fff;
        ph2pr_table_tristate[144-QUAL_OFFSET] = 'h2c3a51c7;
        ph2pr_table_tristate[145-QUAL_OFFSET] = 'h2c13ffbd;
        ph2pr_table_tristate[146-QUAL_OFFSET] = 'h2beb1e8d;
        ph2pr_table_tristate[147-QUAL_OFFSET] = 'h2bbac31d;
        ph2pr_table_tristate[148-QUAL_OFFSET] = 'h2b9459b0;
        ph2pr_table_tristate[149-QUAL_OFFSET] = 'h2b6bad71;
        ph2pr_table_tristate[150-QUAL_OFFSET] = 'h2b3b349f;
        ph2pr_table_tristate[151-QUAL_OFFSET] = 'h2b14b3d9;
        ph2pr_table_tristate[152-QUAL_OFFSET] = 'h2aec3cd0;
        ph2pr_table_tristate[153-QUAL_OFFSET] = 'h2abba665;
        ph2pr_table_tristate[154-QUAL_OFFSET] = 'h2a950e39;
        ph2pr_table_tristate[155-QUAL_OFFSET] = 'h2a6ccc63;
        ph2pr_table_tristate[156-QUAL_OFFSET] = 'h2a3c1871;
        ph2pr_table_tristate[157-QUAL_OFFSET] = 'h2a1568e5;
        ph2pr_table_tristate[158-QUAL_OFFSET] = 'h29ed5c4c;
        ph2pr_table_tristate[159-QUAL_OFFSET] = 'h29bc8ac1;
        ph2pr_table_tristate[160-QUAL_OFFSET] = 'h2995c3b3;

        // Values added by hand because synthesis does not support $shortrealtobits()
        one_min_ph2pr_table[33-QUAL_OFFSET] = 'h00000000;
        one_min_ph2pr_table[34-QUAL_OFFSET] = 'h3e529ba0;
        one_min_ph2pr_table[35-QUAL_OFFSET] = 'h3ebcf328;
        one_min_ph2pr_table[36-QUAL_OFFSET] = 'h3eff6464;
        one_min_ph2pr_table[37-QUAL_OFFSET] = 'h3f1a15a6;
        one_min_ph2pr_table[38-QUAL_OFFSET] = 'h3f2f0bb2;
        one_min_ph2pr_table[39-QUAL_OFFSET] = 'h3f3fb21a;
        one_min_ph2pr_table[40-QUAL_OFFSET] = 'h3f4cebd9;
        one_min_ph2pr_table[41-QUAL_OFFSET] = 'h3f576d3e;
        one_min_ph2pr_table[42-QUAL_OFFSET] = 'h3f5fc582;
        one_min_ph2pr_table[43-QUAL_OFFSET] = 'h3f666666;
        one_min_ph2pr_table[44-QUAL_OFFSET] = 'h3f6baa4a;
        one_min_ph2pr_table[45-QUAL_OFFSET] = 'h3f6fd8f5;
        one_min_ph2pr_table[46-QUAL_OFFSET] = 'h3f732b6b;
        one_min_ph2pr_table[47-QUAL_OFFSET] = 'h3f75cef7;
        one_min_ph2pr_table[48-QUAL_OFFSET] = 'h3f77e792;
        one_min_ph2pr_table[49-QUAL_OFFSET] = 'h3f7991cf;
        one_min_ph2pr_table[50-QUAL_OFFSET] = 'h3f7ae463;
        one_min_ph2pr_table[51-QUAL_OFFSET] = 'h3f7bf153;
        one_min_ph2pr_table[52-QUAL_OFFSET] = 'h3f7cc6f3;
        one_min_ph2pr_table[53-QUAL_OFFSET] = 'h3f7d70a4;
        one_min_ph2pr_table[54-QUAL_OFFSET] = 'h3f7df76e;
        one_min_ph2pr_table[55-QUAL_OFFSET] = 'h3f7e627f;
        one_min_ph2pr_table[56-QUAL_OFFSET] = 'h3f7eb78b;
        one_min_ph2pr_table[57-QUAL_OFFSET] = 'h3f7efb19;
        one_min_ph2pr_table[58-QUAL_OFFSET] = 'h3f7f30c2;
        one_min_ph2pr_table[59-QUAL_OFFSET] = 'h3f7f5b62;
        one_min_ph2pr_table[60-QUAL_OFFSET] = 'h3f7f7d3d;
        one_min_ph2pr_table[61-QUAL_OFFSET] = 'h3f7f9822;
        one_min_ph2pr_table[62-QUAL_OFFSET] = 'h3f7fad7f;
        one_min_ph2pr_table[63-QUAL_OFFSET] = 'h3f7fbe77;
        one_min_ph2pr_table[64-QUAL_OFFSET] = 'h3f7fcbf1;
        one_min_ph2pr_table[65-QUAL_OFFSET] = 'h3f7fd6a6;
        one_min_ph2pr_table[66-QUAL_OFFSET] = 'h3f7fdf27;
        one_min_ph2pr_table[67-QUAL_OFFSET] = 'h3f7fe5e9;
        one_min_ph2pr_table[68-QUAL_OFFSET] = 'h3f7feb47;
        one_min_ph2pr_table[69-QUAL_OFFSET] = 'h3f7fef8a;
        one_min_ph2pr_table[70-QUAL_OFFSET] = 'h3f7ff2ed;
        one_min_ph2pr_table[71-QUAL_OFFSET] = 'h3f7ff59d;
        one_min_ph2pr_table[72-QUAL_OFFSET] = 'h3f7ff7c0;
        one_min_ph2pr_table[73-QUAL_OFFSET] = 'h3f7ff972;
        one_min_ph2pr_table[74-QUAL_OFFSET] = 'h3f7ffacb;
        one_min_ph2pr_table[75-QUAL_OFFSET] = 'h3f7ffbdd;
        one_min_ph2pr_table[76-QUAL_OFFSET] = 'h3f7ffcb7;
        one_min_ph2pr_table[77-QUAL_OFFSET] = 'h3f7ffd64;
        one_min_ph2pr_table[78-QUAL_OFFSET] = 'h3f7ffded;
        one_min_ph2pr_table[79-QUAL_OFFSET] = 'h3f7ffe5b;
        one_min_ph2pr_table[80-QUAL_OFFSET] = 'h3f7ffeb1;
        one_min_ph2pr_table[81-QUAL_OFFSET] = 'h3f7ffef6;
        one_min_ph2pr_table[82-QUAL_OFFSET] = 'h3f7fff2d;
        one_min_ph2pr_table[83-QUAL_OFFSET] = 'h3f7fff58;
        one_min_ph2pr_table[84-QUAL_OFFSET] = 'h3f7fff7b;
        one_min_ph2pr_table[85-QUAL_OFFSET] = 'h3f7fff96;
        one_min_ph2pr_table[86-QUAL_OFFSET] = 'h3f7fffac;
        one_min_ph2pr_table[87-QUAL_OFFSET] = 'h3f7fffbd;
        one_min_ph2pr_table[88-QUAL_OFFSET] = 'h3f7fffcb;
        one_min_ph2pr_table[89-QUAL_OFFSET] = 'h3f7fffd6;
        one_min_ph2pr_table[90-QUAL_OFFSET] = 'h3f7fffdf;
        one_min_ph2pr_table[91-QUAL_OFFSET] = 'h3f7fffe5;
        one_min_ph2pr_table[92-QUAL_OFFSET] = 'h3f7fffeb;
        one_min_ph2pr_table[93-QUAL_OFFSET] = 'h3f7fffef;
        one_min_ph2pr_table[94-QUAL_OFFSET] = 'h3f7ffff3;
        one_min_ph2pr_table[95-QUAL_OFFSET] = 'h3f7ffff5;
        one_min_ph2pr_table[96-QUAL_OFFSET] = 'h3f7ffff8;
        one_min_ph2pr_table[97-QUAL_OFFSET] = 'h3f7ffff9;
        one_min_ph2pr_table[98-QUAL_OFFSET] = 'h3f7ffffb;
        one_min_ph2pr_table[99-QUAL_OFFSET] = 'h3f7ffffc;
        one_min_ph2pr_table[100-QUAL_OFFSET] = 'h3f7ffffd;
        one_min_ph2pr_table[101-QUAL_OFFSET] = 'h3f7ffffd;
        one_min_ph2pr_table[102-QUAL_OFFSET] = 'h3f7ffffe;
        one_min_ph2pr_table[103-QUAL_OFFSET] = 'h3f7ffffe;
        one_min_ph2pr_table[104-QUAL_OFFSET] = 'h3f7fffff;
        one_min_ph2pr_table[105-QUAL_OFFSET] = 'h3f7fffff;
        one_min_ph2pr_table[106-QUAL_OFFSET] = 'h3f7fffff;
        one_min_ph2pr_table[107-QUAL_OFFSET] = 'h3f7fffff;
        one_min_ph2pr_table[108-QUAL_OFFSET] = 'h3f7fffff;
        one_min_ph2pr_table[109-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[110-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[111-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[112-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[113-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[114-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[115-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[116-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[117-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[118-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[119-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[120-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[121-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[122-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[123-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[124-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[125-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[126-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[127-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[128-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[129-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[130-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[131-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[132-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[133-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[134-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[135-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[136-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[137-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[138-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[139-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[140-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[141-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[142-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[143-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[144-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[145-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[146-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[147-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[148-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[149-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[150-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[151-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[152-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[153-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[154-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[155-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[156-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[157-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[158-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[159-QUAL_OFFSET] = 'h3f800000;
        one_min_ph2pr_table[160-QUAL_OFFSET] = 'h3f800000;

    end

    ///////////////
    // Registers //
    ///////////////

    // Necessary conversion are done on register load
    // Note : The combinatorial conversion tables may be too much to satisfy timing requirements
    //        If this is the case add a register stage here or use BRAM as ROMs or both
    always_ff @(posedge clock_i) begin
        if (will_fill) begin
            top_insertion_reg        <= compute_req_bus.write_data.result_top.insertion;
            top_deletion_reg         <= compute_req_bus.write_data.result_top.deletion;
            // Convert byte to float
            one_min_c_qual_right_reg <= one_min_ph2pr_table[compute_req_bus.write_data.continuation_qual_right];
            top_match_reg            <= compute_req_bus.write_data.result_top.match;
            // Convert byte to float
            i_qual_right_reg         <= ph2pr_table[compute_req_bus.write_data.insertion_qual_right];
            // Convert byte to float
            d_qual_right_reg         <= ph2pr_table[compute_req_bus.write_data.deletion_qual_right];
            left_ta_reg              <= compute_req_bus.write_data.result_left.temp_A;
            left_tb_reg              <= compute_req_bus.write_data.result_left.temp_B;
            // Compute prior from match and byte to float
            prior_reg                <= (compute_req_bus.write_data.match) ? one_min_ph2pr_table[compute_req_bus.write_data.base_quals.base_qual]  :
                                        (USE_TRISTATE_CORRECTION)          ? ph2pr_table_tristate[compute_req_bus.write_data.base_quals.base_qual] :
                                                                             ph2pr_table[compute_req_bus.write_data.base_quals.base_qual];
            // Convert byte to float
            i_qual_reg               <= ph2pr_table[compute_req_bus.write_data.base_quals.insertion_qual];
            left_match_reg           <= compute_req_bus.write_data.result_left.match;
            // Convert byte to float
            c_qual_reg               <= ph2pr_table[compute_req_bus.write_data.base_quals.continuation_qual];
            left_insertion_reg       <= compute_req_bus.write_data.result_left.insertion;
            // Convert byte to float
            d_qual_reg               <= ph2pr_table[compute_req_bus.write_data.base_quals.deletion_qual];
            id_reg                   <= '0; // TODO
        end
    end

    // These registers indicate if there is unconsumed data in the registers
    // (Some channels share the same data register)
    always_ff @(posedge clock_i) begin
        // Reset
        if (reset_i) begin
            top_insertion_full_reg        <= 'b0;
            top_deletion_full_reg         <= 'b0;
            one_min_c_qual_right_full_reg <= 'b0;
            top_match_full_reg            <= 'b0;
            i_qual_right_full_reg         <= 'b0;
            d_qual_right_full_reg         <= 'b0;
            left_ta_full_reg              <= 'b0;
            left_tb_full_reg              <= 'b0;
            prior_full_reg                <= 'b0;
            i_qual_full_reg               <= 'b0;
            left_match_full_reg           <= 'b0;
            c_qual_full_reg               <= 'b0;
            left_insertion_full_reg       <= 'b0;
            d_qual_full_reg               <= 'b0;
            top_match_bis_full_reg        <= 'b0;
            c_qual_bis_full_reg           <= 'b0;
            top_deletion_bis_full_reg     <= 'b0;
            id_full_reg                   <= 'b0;
        end else begin
            // Set
            if (will_fill) begin
                top_insertion_full_reg        <= 'b1;
                top_deletion_full_reg         <= 'b1;
                one_min_c_qual_right_full_reg <= 'b1;
                top_match_full_reg            <= 'b1;
                i_qual_right_full_reg         <= 'b1;
                d_qual_right_full_reg         <= 'b1;
                left_ta_full_reg              <= 'b1;
                left_tb_full_reg              <= 'b1;
                prior_full_reg                <= 'b1;
                i_qual_full_reg               <= 'b1;
                left_match_full_reg           <= 'b1;
                c_qual_full_reg               <= 'b1;
                left_insertion_full_reg       <= 'b1;
                d_qual_full_reg               <= 'b1;
                top_match_bis_full_reg        <= 'b1;
                c_qual_bis_full_reg           <= 'b1;
                top_deletion_bis_full_reg     <= 'b1;
                id_full_reg                   <= 'b1;
            // Normal operation, empty on ready
            end else begin
                if (m_axis_top_insertion.tready) begin
                    top_insertion_full_reg <= 'b0;
                end
                if (m_axis_top_deletion.tready) begin
                    top_deletion_full_reg <= 'b0;
                end
                if (m_axis_one_min_c_qual_right.tready) begin
                    one_min_c_qual_right_full_reg <= 'b0;
                end
                if (m_axis_top_match.tready) begin
                    top_match_full_reg <= 'b0;
                end
                if (m_axis_i_qual_right.tready) begin
                    i_qual_right_full_reg <= 'b0;
                end
                if (m_axis_d_qual_right.tready) begin
                    d_qual_right_full_reg <= 'b0;
                end
                if (m_axis_left_ta.tready) begin
                    left_ta_full_reg <= 'b0;
                end
                if (m_axis_left_tb.tready) begin
                    left_tb_full_reg <= 'b0;
                end
                if (m_axis_prior.tready) begin
                    prior_full_reg <= 'b0;
                end
                if (m_axis_i_qual.tready) begin
                    i_qual_full_reg <= 'b0;
                end
                if (m_axis_left_match.tready) begin
                    left_match_full_reg <= 'b0;
                end
                if (m_axis_c_qual.tready) begin
                    c_qual_full_reg <= 'b0;
                end
                if (m_axis_left_insertion.tready) begin
                    left_insertion_full_reg <= 'b0;
                end
                if (m_axis_d_qual.tready) begin
                    d_qual_full_reg <= 'b0;
                end
                if (m_axis_top_match_bis.tready) begin
                    top_match_bis_full_reg <= 'b0;
                end
                if (m_axis_c_qual_bis.tready) begin
                    c_qual_bis_full_reg <= 'b0;
                end
                if (m_axis_top_deletion_bis.tready) begin
                    top_deletion_bis_full_reg <= 'b0;
                end
                if (m_axis_id.tready) begin
                    id_full_reg <= 'b0;
                end
            end
        end
    end

    /////////////////////////
    // Combinatorial Logic //
    /////////////////////////

    // We will fill the registers if we are ready to receive and the master writes the compute request
    assign will_fill = ready_to_receive & compute_req_bus.write;

    // We are ready to receive a new compute request when all registers are empty (consumed) or will be next cycle
    // It is necessary to indicate we can receive if we will be empty the next cycle otherwise the
    // throughput will be divided by two (since there needs to be a clock cycle where all regs are
    // empty if we do this, i.e., a lost clock cycle).
    assign ready_to_receive = &{ {(~top_insertion_full_reg) | m_axis_top_insertion.tready},
                                 {(~top_deletion_full_reg) | m_axis_top_deletion.tready},
                                 {(~one_min_c_qual_right_full_reg) | m_axis_one_min_c_qual_right.tready},
                                 {(~top_match_full_reg) | m_axis_top_match.tready},
                                 {(~i_qual_right_full_reg) | m_axis_i_qual_right.tready},
                                 {(~d_qual_right_full_reg) | m_axis_d_qual_right.tready},
                                 {(~left_ta_full_reg) | m_axis_left_ta.tready},
                                 {(~left_tb_full_reg) | m_axis_left_tb.tready},
                                 {(~prior_full_reg) | m_axis_prior.tready},
                                 {(~i_qual_full_reg) | m_axis_i_qual.tready},
                                 {(~left_match_full_reg) | m_axis_left_match.tready},
                                 {(~c_qual_full_reg) | m_axis_c_qual.tready},
                                 {(~left_insertion_full_reg) | m_axis_left_insertion.tready},
                                 {(~d_qual_full_reg) | m_axis_d_qual.tready},
                                 {(~top_match_bis_full_reg) | m_axis_top_match_bis.tready},
                                 {(~c_qual_bis_full_reg) | m_axis_c_qual_bis.tready},
                                 {(~top_deletion_bis_full_reg) | m_axis_top_deletion_bis.tready},
                                 {(~id_full_reg) | m_axis_id.tready}
                              };

    /////////////
    // Outputs //
    /////////////

    // If we are not ready to receive set our fifo interface to "full"
    assign compute_req_bus.full               = ~ready_to_receive;

    // Assign validity signals
    assign m_axis_top_insertion.tvalid        = top_insertion_full_reg;
    assign m_axis_top_deletion.tvalid         = top_deletion_full_reg;
    assign m_axis_one_min_c_qual_right.tvalid = one_min_c_qual_right_full_reg;
    assign m_axis_top_match.tvalid            = top_match_full_reg;
    assign m_axis_i_qual_right.tvalid         = i_qual_right_full_reg;
    assign m_axis_d_qual_right.tvalid         = d_qual_right_full_reg;
    assign m_axis_left_ta.tvalid              = left_ta_full_reg;
    assign m_axis_left_tb.tvalid              = left_tb_full_reg;
    assign m_axis_prior.tvalid                = prior_full_reg;
    assign m_axis_i_qual.tvalid               = i_qual_full_reg;
    assign m_axis_left_match.tvalid           = left_match_full_reg;
    assign m_axis_c_qual.tvalid               = c_qual_full_reg;
    assign m_axis_left_insertion.tvalid       = left_insertion_full_reg;
    assign m_axis_d_qual.tvalid               = d_qual_full_reg;
    assign m_axis_top_match_bis.tvalid        = top_match_bis_full_reg;
    assign m_axis_c_qual_bis.tvalid           = c_qual_bis_full_reg;
    assign m_axis_top_deletion_bis.tvalid     = top_deletion_bis_full_reg;
    assign m_axis_id.tvalid                   = id_full_reg;

    // Assign data signals
    assign m_axis_top_insertion.tdata         = top_insertion_reg;
    assign m_axis_top_deletion.tdata          = top_deletion_reg;
    assign m_axis_one_min_c_qual_right.tdata  = one_min_c_qual_right_reg;
    assign m_axis_top_match.tdata             = top_match_reg;
    assign m_axis_i_qual_right.tdata          = i_qual_right_reg;
    assign m_axis_d_qual_right.tdata          = d_qual_right_reg;
    assign m_axis_left_ta.tdata               = left_ta_reg;
    assign m_axis_left_tb.tdata               = left_tb_reg;
    assign m_axis_prior.tdata                 = prior_reg;
    assign m_axis_i_qual.tdata                = i_qual_reg;
    assign m_axis_left_match.tdata            = left_match_reg;
    assign m_axis_c_qual.tdata                = c_qual_reg;
    assign m_axis_left_insertion.tdata        = left_insertion_reg;
    assign m_axis_d_qual.tdata                = d_qual_reg;
    assign m_axis_top_match_bis.tdata         = top_match_reg;
    assign m_axis_c_qual_bis.tdata            = c_qual_reg;
    assign m_axis_top_deletion_bis.tdata      = top_deletion_reg;
    assign m_axis_id.tdata                    = id_reg;

    assign m_axis_one_constant.tdata          = 'h3f800000; // This is a constant, the value is 1.0 (float32)
    assign m_axis_one_constant.tvalid         = 'b1; // Always ready

endmodule // cl_compute_stream_separator
