`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/09/2025 02:24:02 PM
// Design Name: 
// Module Name: celsius_to_fahren_x10
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


module celsius_to_fahren_x10( input logic [12:0] celsius, output logic [16:0] fahren);
    logic [16:0] fahren1;
    
    assign fahren1 = (celsius << 4) + (celsius << 1);
    assign fahren = fahren1 + 13'b1010000000000;
endmodule
