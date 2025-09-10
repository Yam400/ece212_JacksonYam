`timescale 1ns / 1ps
//-----------------------------------------------------------------------------
// Module Name   : lab03_top - top-level module for temp. display
// Project       : ECE 212 - Digital Circuits II
//-----------------------------------------------------------------------------
// Author        : John Nestor  <nestorj@lafayette.edu>
// Created       : Jan 2022
// Modified      : Sept 2024 <biernacl@lafayette.edu>
//-----------------------------------------------------------------------------
// Description   : displays temperature in either Celsuis or Fahrenheit
// using the Nexys A7 temperature sensor
//-----------------------------------------------------------------------------



module lab01_top(
    input logic clk, rst, 
    input logic [ 15:0] SW,
    output logic [15:0] LED,
    output logic [7:0] AN,
    output logic [6:0] SEG,
    output logic DP,
    inout  TMP_SCL,
    inout  TMP_SDA
    );
    
    
    // Show switch values on green LEDs
    assign LED[15:0] = SW[15:0]; 

    // Declare the input signals 
    logic [12:0] temp_manual, temp_sensor;
    assign temp_manual = SW[12:0];

    // Instantiate the VHDL temperature sensor controller
    logic tmp_rdy, temp_err;
    TempSensorCtl U_TSCTL (.TMP_SCL(TMP_SCL), .TMP_SDA(TMP_SDA), .TEMP_O(temp_sensor),
                            .RDY_O(tmp_rdy), .ERR_O(tmp_err), .CLK_I(clk), .SRST_I(rst)
    );
    
    
    // Declare the output  signals 
    logic [12:0] temp_final;
    logic [12:0] cel;
    logic [12:0] cel2;
    logic [16:0] fah;
    logic [12:0] rounded;
    
    assign cel = (SW[15]) ? (temp_manual) : (temp_sensor);
    assign cel2 = (SW[15]) ? (temp_manual) : (temp_sensor);
    celsius_to_fahren_x10 thiscodeisreallycool(.celsius(cel),.fahren(fah));
    round shitting(.in(fah),.out(rounded));
    assign temp_final = (SW[14]) ? (rounded) : (cel2);
           
    
    
    
    
    // Connect result to temperature seven-segment display
    temperature_display U_TDISP(.temp(temp_final), .select_cf(SW[14]), .clk(clk),
                                .seg_n(SEG), .an(AN));  


endmodule
