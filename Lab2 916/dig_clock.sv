`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2025 01:08:16 PM
// Design Name: 
// Module Name: dig_clock
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


module dig_clock(
    input logic clk, rst,
    output logic [6:0] hours, minutes, seconds
    );
    
    logic enb_1hz, add_minute, add_hour;
    
   clock_enable #(.PERIOD_MS(1000)) U_ENB (.clk(clk), .reset(rst), .enb_out(enb_1hz));
   
    always_ff @(posedge clk) begin
        if (rst || add_minute) seconds <= 7'd0;
        else if (enb_1hz)      seconds <= seconds + 1;
        else                   seconds <= seconds;
    end
    
    assign add_minute = (seconds == 7'd59) & enb_1hz; 
    
    always_ff @(posedge clk) begin
        if (rst || add_hour)   minutes <= 7'd0;
        else if (add_minute)   minutes <= minutes + 1;
        else                   minutes <= minutes;
    end
    
    assign add_hour = (minutes == 7'd59) & add_minute;

    always_ff @(posedge clk) begin
        if (rst || wrap_hour)  hours <= 7'd0;
        else if (add_hour)     hours <= hours + 1;
        else                   hours <= hours;
    end
    
    assign wrap_hour = (hours == 7'd23) & add_hour; 

    
endmodule
