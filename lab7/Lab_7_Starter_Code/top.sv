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


    //Wires & Registers
    logic [31:0] pc, pcnext, pcplus4, pcbranch, jumpaddr;

    //Instruction / decoded fields
    logic [31:0] instr;
    
    // PC register
    always_ff @(posedge clk or posedge reset) begin
        if (reset) pc <= 32'd0;
        else pc <= pcnext;
    end

    //Instruciton Memory
    imem Imem (
        .adr (pc),
        .rd (instr)
    );

    ///PC math
    assign pcplus4 = pc + 32'd4;
    assign jumpaddr = {pcplus4[31:28],instr[25:0],2'b00};

    //Decode fields and controller
    opcode_t opcode = opcode_t'(instr[31:26]);
    funct_t funct = funct_t'(instr[5:0]);

    logic memtoreg, alusrc, regdst, regwrite, branch_unused, jup;
    logic [2:0] alucontrol;
    logic pcsrc, zero;

    controller CTRL(
        .opcode (opcode),
        .funct (funct),
        .zero (zero),
        .memtoreg (memtoreg),
        .memwrite (memwrite),
        .pcsrc (pcsrc),
        .alusrc (alusrc),
        .regdst (regdst),
        .regwrite (regwrite),
        .jump (jump),
        .alucontrol (alucontrol)
    );

    //Register File + ALU data path

    logic [4:0] writereg;
    logic [31:0] rd1, rd2, scrb, aluout, readdata;
    logic [31:0] signimm, signimm_sl2, result;

    assign writereg = (regdst) ? instr[15:11] : instr[20:16];

    regfile RF (
        .clk (clk),
        .w_en (regwrite),
        .adr1 (instr[25:21]),
        .adr2 (instr[20:16]),
        .wadr3 (writereg),
        .rd1 (rd1),
        .rd2 (rd2)
    );

    assign signimm = {{16{instr[15]}}, instr[15:0]};
    assign signimm_s12 = signimm << 2;

    assign scrb = (alusrc) ? signimm : rd2;

    alu ALU (
        .a (rd1),
        .b (scrb),
        .f (alucontrol),
        .y (aluout),
        .zero(zero)
    );

    //Branch / Jump and next PC

    assign pcbranch = pcplus4 + signimm_s12;

    logic [31:0] pc_after_branch = (pcsrc) ? pcbranch : pcplus4;

    assign pcnext = (jump) ? jumpaddr : pc_after_branch;

    //Data Memory + writeback

    assign dataadr = aluout;
    assign writedata = rd2;

    dmem DMEM (
        .clk (clk),
        .w_en (memwrite),
        .adr (dataadr),
        .rd (readdata)
    )

    assign result = (memtoreg) ? readdata : aluout;

endmodule
