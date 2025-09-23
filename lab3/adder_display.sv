`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/22/2025 07:21:21 PM
// Design Name: 
// Module Name: adder_display
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


module adder_display(
    input logic [7:0] a, b,
    input logic [7:0] s, 
    input logic clk,
    output logic [6:0] seg_n,  //connect to board seg pin
    output logic [7:0] an      //connect to board en pin
    );
    
    // Make A, B, and Y Binary-Coded Decimal
    // "tens" are really ones, "ones" are really tenths
    logic [3:0] a_tens, a_ones, b_tens, b_ones, y_huds, y_tens, y_ones;
    dbl_dabble_ext U_DBLX_A (.b(a), .tens(a_tens), .ones(a_ones), .hundreds(), .thousands());
    dbl_dabble_ext U_DBLX_B (.b(b), .tens(b_tens), .ones(b_ones), .hundreds(), .thousands());
    dbl_dabble_ext U_DBLX_Y (.b(s), .tens(y_tens), .ones(y_ones), .hundreds(y_huds), .thousands());
    
    // Decode the binary values a, b, and y to
    // get the representation on the seven-segement display
    logic [6:0] seg_a_tens, seg_a_ones, seg_b_tens, seg_b_ones, seg_y_tens, seg_y_ones, seg_y_huds;
    adv_seven_seg_n D0(.data(a_tens), .segs_n(seg_a_tens));
    adv_seven_seg_n D1(.data(b_tens), .segs_n(seg_b_tens));
    adv_seven_seg_n D2(.data(y_tens), .segs_n(seg_y_tens));
    adv_seven_seg_n D3(.data(a_ones), .segs_n(seg_a_ones));
    adv_seven_seg_n D4(.data(b_ones), .segs_n(seg_b_ones));
    adv_seven_seg_n D5(.data(y_ones), .segs_n(seg_y_ones));
    adv_seven_seg_n D6(.data(y_huds), .segs_n(seg_y_huds));


    logic [6:0] seg_equals = 7'b0110111; 

    logic [6:0] zero = 7'b1000000; 

    logic [6:0] seg7, seg6, seg5, seg4, seg3, seg2, seg1, seg0;
    always_comb begin
    if(s < 8'd100) begin
            //Display as AA+BB=YY
            seg7 = seg_a_tens;  
            seg6 = seg_a_ones;
            seg5 = 7'b0001100;
            seg4 = seg_b_tens;
            seg3 = seg_b_ones;
            seg2 = seg_equals;
            seg1 = seg_y_tens;
            seg0 = seg_y_ones;
    end
    else begin
            seg7 = 7'b1111111;  
            seg6 = 7'b1111111;
            seg5 = 7'b1111111;
            seg4 = 7'b1111111;
            seg3 = seg_equals;
            seg2 = seg_y_huds;
            seg1 = seg_y_tens;
            seg0 = seg_y_ones;
    end
    end
    
    disp_mux_seven_seg D7(.clk(clk), .reset(1'b0), 
       .seg7(seg7),     /* a            */ 
	   .seg6(seg6),     /* a            */ 
	   .seg5(seg5), 	/* add/subtract */ 
	   .seg4(seg4), 	/* b            */ 
       .seg3(seg3), 	/* b            */ 
	   .seg2(seg2),     /* equals       */ 
	   .seg1(seg1), 	/* y_tens or -  */ 
	   .seg0(seg0),	    /* y_ones       */ 
       .seg_dis(8'd0), 
       .seg_n(seg_n), .an(an)
    );
    
endmodule


//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////



module dbl_dabble_ext(input logic [12:0] b,
                  output logic [3:0] thousands, hundreds, tens, ones);

logic [12:0] bs;

always_comb
    begin
        $display("dbl_dabble input: %d", b);
        bs = b;
        {thousands, hundreds, tens, ones} = 16'h0;
        for (int i=1; i<=13; i++)
            begin
                if ((i > 3) && (ones >= 4'd5)) begin
                    ones = ones + 3;
                    $display("add3o %1d %4b %4b %4b %4b %8b", i, thousands, hundreds, tens, ones, bs);
                end
                if ((i > 6) && (tens >= 4'd5)) begin
                    tens = tens + 3;
                    $display("add3o %1d %4b %4b %4b %4b %8b", i, thousands, hundreds, tens, ones, bs);
                end
                if ((i > 9) && (hundreds >= 4'd5)) begin
                    hundreds = hundreds + 3;
                    $display("add3o %1d %4b %4b %4b %4b %8b", i, thousands, hundreds, tens, ones, bs);
                end
                if ((i > 12) && (thousands >= 4'd5)) begin
                    thousands = thousands + 3;
                    $display("add3o %1d %4b %4b %4b %4b %8b", i, thousands, hundreds, tens, ones, bs);
                end
                {thousands, hundreds, tens, ones, bs} = {thousands, hundreds, tens, ones, bs} << 1;
            end
            $display("result    %d    %d   %d   %d", thousands, hundreds, tens, ones);
    end

endmodule: dbl_dabble_ext


//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
