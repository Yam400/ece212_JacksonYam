//--------------------------------------------------------------
// maindec.sv - single-cycle MIPS instruction decode
// David_Harris@hmc.edu and Sarah_Harris@hmc.edu 23 October 2005
// Updated to SystemVerilog dmh 12 November 2010
// Refactored into separate files & updated using additional SystemVerilog
// features by John Nestor May 2018
// Key modifications to this file:
//    1. Use enum for opcodes declared in external package
//    2. Rewrite code to show control signals explicitly rather than
//       packed into a binary string (make intent clearer)
//    3. Use enum for control signals declared in external package
//    4. Use blocking assignments for comb. logic
//--------------------------------------------------------------

module maindec (
	input mips_decls_p::opcode_t opcode,
	output logic memtoreg, memwrite, branch, alusrc, regdst, regwrite, jump,
	output logic [1:0] aluop
	);

	import mips_decls_p::*;

always_comb begin
    if(opcode == OP_RTYPE) begin
        regdst = 1'b1;
        memtoreg = 1'b0;
        regwrite = 1'b1;
        alusrc = 1'b0;
        aluop = 2'b10;
        memwrite = 1'b0;
        branch = 1'b0; 
    end
    else if (opcode == OP_LW) begin
        regdst = 1'b0;
        memtoreg = 1'b1;
        regwrite = 1'b1;
        alusrc = 1'b1;
        aluop = 2'b00;
        memwrite = 1'b0;
        branch = 1'b0; 
    end
    else if (opcode == OP_SW) begin
        regdst = 1'b0;
        memtoreg = 1'b0;
        regwrite = 1'b0;
        alusrc = 1'b1;
        aluop = 2'b00;
        memwrite = 1'b1;
        branch = 1'b0; 
    end
    else if (opcode == OP_BEQ) begin 
        regdst = 1'b1;
        memtoreg = 1'b0;
        regwrite = 1'b0;
        alusrc = 1'b0;
        aluop = 2'b01;
        memwrite = 1'b0;
        branch = 1'b1; 
    end
    else begin
        regdst = 1'b0;
        memtoreg = 1'b0;
        regwrite = 1'b1;
        alusrc = 1'b1;
        aluop = 2'b00;
        memwrite = 1'b0;
        branch = 1'b0; 
    end 
end

endmodule // maindec
