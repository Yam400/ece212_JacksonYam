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


module maindec_tb();

mips_decls_p::opcode_t op;
logic memtoreg;
logic memwrite;
logic branch;
logic alusrc;
logic regdst;
logic regwrite;
logic jump;
logic [1:0] aluop;

import mips_decls_p::*;

maindec test(.opcode(op), .memtoreg(memtoreg), .memwrite(memwrite), .branch(branch), .alusrc(alusrc), .regdst(regdst), .regwrite(regwrite), .jump(jump), .aluop(aluop));


initial begin
   op = OP_RTYPE;
   #10;
   op = OP_LW;
   #10;
   op = OP_SW;
   #10;
   op = OP_BEQ;
   #10;
   op = OP_ADDI;
   #10;

end






endmodule
