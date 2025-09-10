`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/09/2025 02:51:33 PM
// Design Name: 
// Module Name: round
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


module round(input logic [16:0]in, output logic [12:0] out );
    logic [12:0]temp;
    assign temp = in[16:4];
    assign out = (in[3] == 1'b1) ? (temp + 13'b0000000000001) : (temp);

endmodule
