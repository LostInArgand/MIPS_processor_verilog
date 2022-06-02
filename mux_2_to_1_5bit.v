`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/03/2022 12:25:15 AM
// Design Name: 
// Module Name: mux_2_to_1_5bit
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


module mux_2_to_1_5bit(
    input wire [4:0] zero,
    input wire [4:0] one,
    input select,
    output reg [4:0] out
    );
    
    // Whenever an input changes, perform the multiplexing task
    always @(zero, one, select) begin
        if (select) out <= one;
        else out <= zero;
    end
endmodule
