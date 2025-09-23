`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2025 01:52:11 PM
// Design Name: 
// Module Name: prefix_8b
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


module prefix_8b(
        input logic [7:0] A, B,
        input logic Cin,
        output logic Cout,
        output logic [7:0] S
    );

    logic [7:0] P, G;

    //Initial Blude Nodes
    assign P[7:0] = A[7:0] | B[7:0];
    assign G[7:0] = A[7:0] & B[7:0];

    //Intermediate Green Nodes
    //Row 1
    logic p1, g1;
    assign p1 = P[6] & P[5];
    assign g1 = G[6] | (P[6] & G[5]);

    logic p2, g2;
    assign p2 = P[4] & P[3];
    assign g2 = G[4] | (P[4] & G[3]);

    logic p3, g3;
    assign p3 = P[2] & P[1];
    assign g3 = G[2] | (P[2] & G[1]);

    logic p4, g4;
    assign p4 = P[0] & 1'b0;
    assign g4 = G[0] | (P[0] & Cin);

    //Row 2
    logic p5, g5;
    assign p5 = p1 & p2;
    assign g5 = g1 | (p1 & g2);

    logic p6, g6;
    assign p6 = P[5] & p2;
    assign g6 = G[5] | (P[5] & g2);

    logic p7, g7;
    assign p7 = p3 & p4;
    assign g7 = g3 | (p3 & g4);

    logic p8, g8;
    assign p8 = P[1] & p4;
    assign g8 = G[1] | (P[1] & g4);

    //Row 3
    logic p9, g9;
    assign p9 = p5 & p7;
    assign g9 = g5| (p5 & g7);

    logic p10, g10;
    assign p10 = p6 & p7;
    assign g10 = g6 | (p6 & g7);

    logic p11, g11;
    assign p11 = p2 & p7;
    assign g11 = g2 | (p2 & g7);

    logic p12, g12;
    assign p12 = P[3] & p7;
    assign g12 = G[3] | (P[3] & g7);

    //Row 4
    logic p13, g13;
    assign p13 = P[7] & p9;
    assign g13 = G[7] | (P[7] & g9);

    //Final Yellow Nodes
    assign Cout = g13;
    assign S[7] = A[7] ^ B[7] ^ g9;
    assign S[6] = A[6] ^ B[6] ^ g10;
    assign S[5] = A[5] ^ B[5] ^ g11;
    assign S[4] = A[4] ^ B[4] ^ g12;
    assign S[3] = A[3] ^ B[3] ^ g7;
    assign S[2] = A[2] ^ B[2] ^ g8;
    assign S[1] = A[1] ^ B[1] ^ g4;
    assign S[0] = A[0] ^ B[0] ^ Cin;





endmodule
