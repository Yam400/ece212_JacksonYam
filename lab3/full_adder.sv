`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/17/2024 08:07:58 AM
// Design Name: 
// Module Name: full_adder
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


module full_adder(
    input logic a,b,cin,
    output logic s, cout
    );
    logic c1,c2,c3;
    
    xor(c1, a, b);
    and(c2, a, b);
    xor(s, c1, cin);
    and(c3,c1, cin);
    or(cout, c3, c2); 
    
endmodule
