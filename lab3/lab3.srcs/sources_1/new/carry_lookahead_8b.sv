`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2025 01:33:28 PM
// Design Name: 
// Module Name: carry_lookahead_8b
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


module carry_lookahead_8b(input logic [7:0] a, b, input logic cin,
output logic cout, output logic [7:0] s );

logic [3:0] p;
logic [3:0] g;
logic cla;
logic [6:0] carry;

assign p[3:0] = a[3:0] | b[3:0];
assign g[3:0] = a[3:0] & b[3:0];

assign cla = (cin & (((p[3]&p[2])&p[1])&p[0]) )|( ((((((g[0]&p[1])|g[1])&p[2])|g[2])&p[3])|g[3]) );

    full_adder D0(.cin(cin),      .a(a[0]), .b(b[0]), .s(s[0]), .cout(carry[0]));
    full_adder D1(.cin(carry[0]), .a(a[1]), .b(b[1]), .s(s[1]), .cout(carry[1]));
    full_adder D2(.cin(carry[1]), .a(a[2]), .b(b[2]), .s(s[2]), .cout(carry[2]));
    full_adder D3(.cin(carry[2]), .a(a[3]), .b(b[3]), .s(s[3]), .cout());
    full_adder D4(.cin(cla), .a(a[4]), .b(b[4]), .s(s[4]), .cout(carry[4]));
    full_adder D5(.cin(carry[4]), .a(a[5]), .b(b[5]), .s(s[5]), .cout(carry[5]));
    full_adder D6(.cin(carry[5]), .a(a[6]), .b(b[6]), .s(s[6]), .cout(carry[6]));
    full_adder D7(.cin(carry[6]), .a(a[7]), .b(b[7]), .s(s[7]), .cout(cout));

//k=4
endmodule
