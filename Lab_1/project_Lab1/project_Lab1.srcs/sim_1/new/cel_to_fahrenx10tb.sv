`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/09/2025 02:36:27 PM
// Design Name: 
// Module Name: cel_to_fahrenx10tb
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


module cel_to_fahrenx10tb();
logic [12:0] a;
logic [16:0]b;
celsius_to_fahren_x10 farting(.celsius(a),.fahren(b));

    initial
    begin
    a = 13'b0000010000100;
    #10;
    a = 13'b0000100001000;
    #10;
    a = 13'b0010010000001;
    #10;
    end
endmodule
