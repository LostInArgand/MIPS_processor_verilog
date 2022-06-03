`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/03/2022 12:23:04 PM
// Design Name: 
// Module Name: left_shift_for_jump
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


module left_shift_for_jump(
    input wire [25:0] Instruction,
    input wire [3:0] from_PC,
    output wire [32:0] Jump_Address
    );
    
    wire [27:0] left_shift_instruction;
    assign left_shift_instruction = {2'b00, Instruction};
    assign Jump_Address = {from_PC, (left_shift_instruction << 2)};
endmodule
