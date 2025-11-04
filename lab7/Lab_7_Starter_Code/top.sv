//--------------------------------------------------------------------
// top.v - top-level MIPS single cycle with instruction and data memories
// David_Harris@hmc.edu 9 November 2005
// Updated to SystemVerilog and modfied for clarity
// John Nestor, May 2018
// Key changes to this module:
//   1. Modfied dmem to use byte addressing rather than word addressing
//      for consistency
//--------------------------------------------------------------------

module top(
    input logic         clk, reset,
    output logic [31:0] writedata, dataadr,
    output logic        memwrite
    );

    import mips_decls_p::*;

    // instantiate instruction memory
    logic [31:0]   pc, instr;
    imem imem(.adr(pc), .rd(instr));


    // Decode instruction opcode bits
    opcode_t opcode;
    assign opcode = opcode_t'(instr[31:26]);

    // Decode instruction funct bits
    // Caution: will show nonsense values for I-Type and J-Type
    funct_t funct;
    assign funct = funct_t'(instr[5:0]); 


    // instantiate datapath and control components




    // instantiate data memory
    logic [31:0]   readdata;
    dmem dmem(.clk, .w_en(memwrite), .adr(dataadr), .wd(writedata), .rd(readdata));


endmodule
