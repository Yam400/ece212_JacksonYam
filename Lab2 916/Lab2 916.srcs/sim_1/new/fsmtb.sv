`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/16/2025 01:56:16 PM
// Design Name: 
// Module Name: fsmtb
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


module fsmtb();
    logic clk, rst, enb, sw14, sw15;
    logic [1:0]state;
    fsm fart(.clk(clk), .reset(rst), .enable(enb), .sw14(sw14), .sw15(sw15), .state(state));
    
    
    always begin
    clk = 1'b0;
    #5;
    clk = 1'b1;
    #5;
    end
    
    initial begin
    sw14 = 1'b0;
    sw15 = 1'b1;
    rst = 1'b1;
    enb = 1'b1;
    #20;
    sw14 = 1'b1;
    sw15 = 1'b0;
    rst = 1'b0;
    enb = 1'b0;
    #20;
    sw14 = 1'b0;
    sw15 = 1'b1;
    rst = 1'b0;
    enb = 1'b1;
    #20;
    sw14 = 1'b1;
    sw15 = 1'b1;
    rst = 1'b0;
    enb = 1'b1;
    #20;
    sw14 = 1'b0;
    sw15 = 1'b0;
    rst = 1'b0;
    enb = 1'b1;
    #20;
    sw14 = 1'b1;
    sw15 = 1'b0;
    rst = 1'b0;
    enb = 1'b1;
    #20;
    sw14 = 1'b0;
    sw15 = 1'b1;
    rst = 1'b0;
    enb = 1'b1;
    #20;
    sw14 = 1'b0;
    sw15 = 1'b1;
    rst = 1'b0;
    enb = 1'b1;
    #20;
    
    end
    
endmodule
