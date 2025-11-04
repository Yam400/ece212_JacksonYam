//--------------------------------------------------------------
// aludec.sv - single-cycle MIPS ALU decode
// Dvid_Harris@hmc.edu and Sarah_Harris@hmc.edu 23 October 2005
// Updated to SystemVerilog dmh 12 November 2010
// Refactored into separate files & updated using additional SystemVerilog
// features by John Nestor May 2018
// Key modifications to this file:
//    1. Use enum for function codes declared in external package
//    2. Use blocking assignments for comb. logic
//--------------------------------------------------------------

module aludec(
    mips_decls_p::funct_t funct,
    input  logic [1:0] aluop,
    output logic [2:0] alucontrol
    );

    
    import mips_decls_p::*;

    always_comb begin
        alucontrol = 3'b010;

        unique case (aluop)
            2'b00: begin
                alucontrol = 3'b010;
            end
            2'b01: begin
                alucontrol = 3'b110;
            end
            2'b10: begin
                unique case (funct)
                    F_ADD: alucontrol = 3'b010;
                    F_SUB: alucontrol = 3'b110;
                    F_AND: alucontrol = 3'b000;
                    F_OR: alucontrol = 3'b001;
                    F_SLT: alucontrol = 3'b111;
                    default alucontrol = 3'b010;
                endcase
            end 
            default: begin 
                alucontrol = 3'b010;
            end
        endcase
    end

   
endmodule
