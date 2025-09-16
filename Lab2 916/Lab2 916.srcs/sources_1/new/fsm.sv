`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/16/2025 01:30:51 PM
// Design Name: 
// Module Name: fsm
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


module fsm(input logic clk, reset, enable, sw14, sw15, output logic [1:0]state);

always_ff @(posedge clk) begin

if (enable == 1'b1) begin
    if (sw14 == 1'b0 && sw15 == 1'b0 && state == 2'b00) begin
        state <= 2'b00;
    end
    else if (sw15 == 1'b1 && state == 2'b00) begin
        state <= 2'b01;
    end
    else if (sw14 != 1'b1 && sw15 != 1'b1 && state == 2'b01) begin
        state <= 2'b00;
    end
    else if (sw14 == 1'b1 && sw15 == 1'b0 && state == 2'b00) begin
        state <= 2'b10;
    end
    else if (state == 2'b10) begin
        state <= 2'b00;
    end
    else if (sw14 == 1'b1 && sw15 == 1'b1 && state == 2'b01) begin
        state <= 2'b10;
    end
    else begin
        state <= 2'b00;
    end
end
else if(reset == 1'b1) begin
    state <= 2'b00;
end
else begin
    state <= state;
end

end
endmodule
