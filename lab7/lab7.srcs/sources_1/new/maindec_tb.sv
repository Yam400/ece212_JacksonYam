`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2025 02:27:58 PM
// Design Name: 
// Module Name: maindec_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module controller_tb();

mips_decls_p::opcode_t op;
mips_decls_p::funct_t f;
logic zero;
logic memtoreg;
logic memwrite;

logic pcsrc;

logic alusrc;
logic regdst;
logic regwrite;
logic jump;
logic [2:0] alucontrol;

import mips_decls_p::*;

controller test(.opcode(op), .funct(f), .zero(zero), .memtoreg(memtoreg), .memwrite(memwrite), .pcsrc(pcsrc), .alusrc(alusrc), .regdst(regdst), .regwrite(regwrite), .jump(jump), .alucontrol(alucontrol));


initial begin
    zero = 1'b0;
    op = OP_RTYPE;
   #10;
   op = OP_LW;
   #10;
   op = OP_SW;
   #10;
   op = OP_BEQ;
   zero = 1'b1;
   #10;
   op = OP_ADDI;
   #10;
   op = OP_LW;
   f = F_ADD;
   #10;
   op = OP_BEQ;
   f = F_SUB;
   #10;
   op = OP_RTYPE;
   f = F_AND;
   #10;
   f = F_OR;
   #10;
   f = F_SLT;
   #10;
   
   #10;
   

end






endmodule
