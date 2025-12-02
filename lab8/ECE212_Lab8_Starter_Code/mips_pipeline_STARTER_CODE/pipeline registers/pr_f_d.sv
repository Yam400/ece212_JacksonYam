`timescale 1ns / 1ps

module pr_f_d(input logic clk, reset, en,
  input logic [31:0] instr_i, pcplus4_i,
  output logic [31:0] instr_o, pcplus4_o);

  always_ff @ (posedge clk)
  
      if (reset) begin
        instr_o <= '0;
        pcplus4_o <= '0;
      end
      else if (en) begin
          instr_o <= instr_i;
          pcplus4_o <= pcplus4_i;
      end
      else if (!en) begin
          instr_o <= instr_o;
          pcplus4_o <= pcplus4_o;
      end
      
endmodule: pr_f_d
