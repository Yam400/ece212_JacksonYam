`timescale 1ns / 1ps

module pr_f_d(input logic clk, reset, 
  input logic [31:0] instr_i, pcplus4_i,
  output logic [31:0] instr_o, pcplus4_o);

  always_ff @ (posedge clk)
  if (reset) begin
    instr_o <= '0;
    pcplus4_o <= '0;
  end
  else begin
    instr_o <= instr_i;
    pcplus4_o <= pcplus4_i;
  end
endmodule: pr_f_d
