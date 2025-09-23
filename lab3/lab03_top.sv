`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2025 07:17:21 PM
// Design Name: 
// Module Name: lab03_top
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


module lab03_top(
        input logic clk,
        input logic  [15:0]  SW,
        output logic [15:0] LED,
        output logic [6:0]  SEG,
        output logic [7:0]  AN
    );
    
    
    // Create adder inputs A and B, Assign value of switches
    logic [7:0] A;
    assign A = SW[7:0];
    logic [7:0] B;
    assign B = SW[15:8];
        
    // Instantiate your adder and connect to output S
    logic [7:0] S;
    /*** TO DO ***/
       

    // Display S out seven-segement display
    adder_display DISP(
        .a(A),                 /* Connect input A here */ 
        .b(B),                 /* Connect input B here */ 
        .s(S),                 /* Connect result S here */
        .clk(clk), .seg_n(SEG), .an(AN));
    assign LED[15:0] = SW[15:0];  
    
endmodule
