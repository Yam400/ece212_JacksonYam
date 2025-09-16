`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2025 11:58:58 AM
// Design Name: 
// Module Name: clock_display
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


module clock_display(
    input logic [6:0] hours,
    input logic [6:0] minutes,
    input logic [6:0] seconds,
    input logic clk,
    output logic [6:0] seg_n,  //connect to board seg pin
    output logic [7:0] an      //connect to board en pin
    );
    
    // "tens" are really ones, "ones" are really tenths
    logic [3:0] h1, h0, m1, m0, s1, s0;
    dbl_dabble_ext U_DBLX_H (
        .b({6'd0, hours}), .thousands(), .hundreds(),
        .tens(h1), .ones(h0)
        );
    dbl_dabble_ext U_DBLX_M (
        .b({6'd0, minutes}), .thousands(), .hundreds(),
        .tens(m1), .ones(m0)
        );  
    dbl_dabble_ext U_DBLX_S (
        .b({6'd0, seconds}), .thousands(), .hundreds(),
        .tens(s1), .ones(s0)
        );  
            
    logic [6:0] seg_h1, seg_h0, seg_m1, seg_m0, seg_s1, seg_s0;
    adv_seven_seg_n D0(.data(h1), .segs_n(seg_h1));
    adv_seven_seg_n D1(.data(h0), .segs_n(seg_h0));
    adv_seven_seg_n D2(.data(m1), .segs_n(seg_m1));
    adv_seven_seg_n D3(.data(m0), .segs_n(seg_m0));
    adv_seven_seg_n D4(.data(s1), .segs_n(seg_s1));
    adv_seven_seg_n D5(.data(s0), .segs_n(seg_s0));
        
    localparam DASH  = 7'b0111111;

    
    disp_mux_seven_seg D6(.clk(clk), .reset(1'b0), 
	   .seg7(seg_h1),     
	   .seg6(seg_h0), 
	   .seg5(DASH),
	   .seg4(seg_m1), 		
       .seg3(seg_m0), 
       .seg2(DASH),		
	   .seg1(seg_s1),   
	   .seg0(seg_s0), 	
       .seg_dis(8'b00000000), .seg_n(seg_n), .an(an)
    );
    
    

endmodule
