`timescale 1ns / 1ps
//-----------------------------------------------------------------------------
// Module Name   : lab02_top - top-level module for temp. display
// Project       : ECE 212 - Digital Circuits II
//-----------------------------------------------------------------------------
// Author        : John Nestor  <nestorj@lafayette.edu>
// Created       : Jan 2022
// Modified      : Sept 2024 <biernacl@lafayette.edu>
//-----------------------------------------------------------------------------
// Description   : displays temperature in either Celsuis or Fahrenheit
// using the Nexys A7 temperature sensor
//-----------------------------------------------------------------------------



module lab02_top(
    input logic clk, rst, BTNL, BTNR,
    input logic  [15:0] SW,
    output logic [15:0] LED,
    output logic [7:0] AN,
    output logic [6:0] SEG,
    output logic DP,
    inout  TMP_SCL,
    inout  TMP_SDA
    );
    
    
    // Show current switch values on the LEDs
    assign LED[15:0]   = SW[15:0]; 
        
    // Instantiate the VHDL temperature sensor controller
    logic [12:0] temp_sensor;
    logic tmp_rdy, temp_err;
    TempSensorCtl U_TSCTL (.TMP_SCL(TMP_SCL), .TMP_SDA(TMP_SDA), .TEMP_O(temp_sensor),
                            .RDY_O(tmp_rdy), .ERR_O(tmp_err), .CLK_I(clk), .SRST_I(rst)
    );
    


    /* Implement your solution here! */
    logic en;
    clock_enable #(.PERIOD_MS(2000)) D0(.clk(clk), .reset(reset), .enb_out(en));
    
    logic [1:0]state;
    fsm fsm1(.clk(clk), .reset(rst), .enable(en), .sw14(SW[14]), .sw15(SW[15]), .state(state));
    
    logic[6:0] h, m, s;
    dig_clock dc(.clk(clk), .rst(rst), .hours(h), .minutes(m), .seconds(s));
    
    logic [6:0] clock_seg_n;
    logic [7:0] clock_an;
    clock_display cd(.hours(h), .minutes(m), .seconds(s), .clk(clk), .seg_n(clock_seg_n),  .an(clock_an)); 
    
    
    
    
    logic [12:0] celsius;
    logic [12:0] fahrenheight;
    
    assign celsius = temp_sensor;
    logic [16:0] unroundedFahren;
    celsius_to_fahren_x10(.celsius(celsius),.fahren(unroundedFahren));
    round rd(.in(unroundedFahren),.out(fahrenheight));
    
    
    logic show_celsius;
    
    logic a;
    logic b;
    assign a = ~state[0] ? 1'b1: 1'b0;
    assign b = ~state[0] ? 1'b0: 1'b0 ;
    
    assign show_celsius = ~state[1] ? b : a;
    
    
    logic [12:0] temp_final;
    assign temp_final = ~show_celsius ? celsius : fahrenheight;
    
    logic [6:0]temp_seg_n;
    logic [7:0]temp_an;
    temperature_display td(.temp(temp_final), .select_cf(show_celsius), .clk(clk),.seg_n(temp_seg_n), .an(temp_an));
    
    logic [6:0]c;
    logic [6:0]d;
    assign c = ~state[0] ? temp_seg_n: 1'b0;
    assign d = ~state[0] ? clock_seg_n: temp_seg_n;
    
    assign SEG = ~state[1] ? d : c;
    
    logic [7:0]e;
    logic [7:0]f;
    assign e = ~state[0] ? temp_an: 1'b0;
    assign f = ~state[0] ? clock_an: temp_an;
    
    assign AN = ~state[1] ? f : e;
     
    


endmodule
