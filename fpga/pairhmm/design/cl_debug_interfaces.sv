//-----------------------------------------------------------------------------
// HEIG-VD, Haute Ecole d'Ingenierie et de Gestion du canton de Vaud
// Institut REDS, Reconfigurable & Embedded Digital Systems
//
// File         : cl_debug_interfaces.sv
// Description  : 
//
// Author       : Rick Wertenbroek
// Date         : 27.05.19
// Version      : 0.0
//
// Dependencies : 
//
// Modifications //------------------------------------------------------------
// Version   Author Date               Description
// 0.0       RWE    27.05.19           Creation
//-----------------------------------------------------------------------------

interface dbg_if;
    logic [31:0] axi_read_issued_counter;
    logic [31:0] axi_read_resp_counter;
    logic [31:0] axi_write_issued_counter;
    logic [31:0] axi_write_resp_counter;

    logic [31:0] number_of_jobs_created;
    logic [31:0] number_of_results_to_wb;
endinterface
