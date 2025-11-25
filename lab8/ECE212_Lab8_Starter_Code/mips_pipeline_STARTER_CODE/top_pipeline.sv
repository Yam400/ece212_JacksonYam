//--------------------------------------------------------------------
// top.v - top-level MIPS multi cycle with instruction and data memories
// David_Harris@hmc.edu 9 November 2005
// Updated to SystemVerilog and modfied for clarity
// John Nestor, May 2018
// Lauren Biernacki, November 2024
// Key changes to this module:
//   1. Modfied dmem to use byte addressing rather than word addressing
//      for consistency
//   2. Added datapath implementation
//--------------------------------------------------------------------

module top_pipeline(
    input logic         clk, reset,
    output logic [31:0] writedata, dataadr,
    output logic        memwrite
    );

  import mips_decls_p::*;

  // Instantiate necessary datapath signals
  logic [31:0]   branchaddr_d, branchaddr_e, jumpaddr, pcplus4_f, pcplus4_d,
                 instr_f, instr_d, instr_e, instr_m, instr_w,
                 rd1_d, rd2_d, rd1_e, rd2_e, rd2_m, extimm_d, extimm_e,
                 aluresult_e, aluresult_m, aluresult_w, memresult_m, memresult_w,
                 result_w;
  logic [4:0]    destreg_e, destreg_m, destreg_w;
   
  // Instantiate necessary control signals
  logic         pcsrc_e, jump_d, iszero_e;
                
 
 
  //--------------------------------------------------------------
  //   FETCH Stage
  //--------------------------------------------------------------
  fetch_stage   FETCH(.clk(clk), .reset(reset),
                            .pcen_c(1'b1), .pcsrc_c(pcsrc_e), .jump_c(jump_d),       // External control signals used by stage 
                            .pcbranchaddr_i(branchaddr_e), .pcjumpaddr_i(jumpaddr),    // Inputs to stage  
                            .instr_o(instr_f), .pcplus4_o(pcplus4_f));               // Outputs of stage                 
                    
  pr_f_d        FD_PIPEREG(.clk(clk), .reset(reset), 
                            .instr_i(instr_f), .pcplus4_i(pcplus4_f),                // Pipeline register
                            .instr_o(instr_d), .pcplus4_o(pcplus4_d));
  
  
  //--------------------------------------------------------------
  //   DECODE Stage
  //--------------------------------------------------------------            
  decode_stage  DECODE(.clk(clk), .reset(reset), .instr_i(instr_d), 
                            .regwrite_c(regwrite_w),                                                // External control signals used by stage 
                            .pcplus4_i(pcplus4_d), .wadr3_i(destreg_w), .wd3_i(result_w),           // Inputs to stage              
                            .pcjumpaddr_o(jumpaddr), .pcbranchaddr_o(branchaddr_d),                 // Outputs of stage
                            .rd1_o(rd1_d), .rd2_o(rd2_d), .signextimm_o(extimm_d),
                            .jump_o(jump_d)); 
                                           
  pr_d_e        DE_PIPEREG(.clk(clk), .reset(reset), 
                            .instr_i(instr_d), .rd1_i(rd1_d), .rd2_i(rd2_d), .signimm_i(extimm_d),   // Pipeline register
                            .branchaddr_i(branchaddr_d), .branchaddr_o(branchaddr_e),
                            .instr_o(instr_e), .rd1_o(rd1_e), .rd2_o(rd2_e), .signimm_o(extimm_e));
                            
                            
  //--------------------------------------------------------------
  //   EXECUTE Stage
  //--------------------------------------------------------------
  execute_stage EXECUTE(.clk(clk), .reset(reset), .instr_i(instr_e),                                     
                            .rd1_i(rd1_e), .rd2_i(rd2_e), .signextimm_i(extimm_e),                  // Inputs to stage 
                            .aluresult_o(aluresult_e), .destreg_o(destreg_e),                       // Outputs of stage
                            .iszero_o(iszero_e), .pcsrc_o(pcsrc_e));                             // Is Zero

  pr_e_m        EM_PIPEREG(.clk(clk), .reset(reset), 
                            .instr_i(instr_e), .aluresult_i(aluresult_e), .rd2_i(rd2_e), .destreg_i(destreg_e),  // Pipeline register
                            .instr_o(instr_m), .aluresult_o(aluresult_m), .rd2_o(rd2_m), .destreg_o(destreg_m));
                            
                            
  //--------------------------------------------------------------
  //   MEMORY Stage
  //--------------------------------------------------------------
  memory_stage  MEMORY(.clk(clk), .reset(reset), .instr_i(instr_m), 
                            .addr_i(aluresult_m), .wd_i(rd2_m),                                   // Inputs to stage
                            .rd_o(memresult_m),                                                   // Outputs of stage
                            .writedata_o(writedata), .dataadr_o(dataadr), .memwrite_o(memwrite)); // Testbench output signals
    
  pr_m_w        MW_PIPEREG(.clk(clk), .reset(reset),
                            .instr_i(instr_m), .aluresult_i(aluresult_m), .memresult_i(memresult_m), .destreg_i(destreg_m), // Pipeline register
                            .instr_o(instr_w), .aluresult_o(aluresult_w), .memresult_o(memresult_w), .destreg_o(destreg_w));
                        
                            
  //--------------------------------------------------------------
  //   WRITEBACK Stage
  //--------------------------------------------------------------                           
  writeback_stage  WRITEBACK(.clk(clk), .reset(reset), .instr_i(instr_w),        
                            .aluresult_i(aluresult_w), .memresult_i(memresult_w),   // Inputs to stage
                            .result_o(result_w), .regwrite_o(regwrite_w));          // Outputs to stage
    



endmodule
