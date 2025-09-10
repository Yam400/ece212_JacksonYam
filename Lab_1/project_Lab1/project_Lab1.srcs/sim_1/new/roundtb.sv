`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/09/2025 03:02:48 PM
// Design Name: 
// Module Name: roundtb
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


module roundtb(  );
logic [16:0]a;
logic [12:0]b;
round jasonisverycool(.in(a),.out(b));

    initial
    begin
    a = 17'b00001110101001000;
    #10;
    a = 17'b00110010100010010;
    #10;
    end
endmodule
