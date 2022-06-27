`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/01/2022 08:09:51 PM
// Design Name: 
// Module Name: ALU_control
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


module ALU_control(
    input wire [5:0] instruction,
    input wire [1:0] ALUOp,
    output reg [3:0] ALUoperation
    );
    
    // Update ALUoperation whenever there is a control instruction
    always @(ALUOp or instruction)
    // Using the truth table of the MIPS_architecture
    begin
        if (ALUOp == 2'b00) ALUoperation <= 4'b0010;                   // add
        else if ((ALUOp == 2'b01) || (ALUOp == 2'b11)) ALUoperation <= 4'b0110;              // subtract (with 2s complement)
        else begin
            if (instruction[3:0] == 4'b0000) ALUoperation <= 4'b0010;   // add
            if (instruction[3:0] == 4'b0010) ALUoperation <= 4'b0110;   // subtract (with 2s complement)
            if (instruction[3:0] == 4'b0100) ALUoperation <= 4'b0000;   // AND
            if (instruction[3:0] == 4'b0101) ALUoperation <= 4'b0001;   // OR
            if (instruction[3:0] == 4'b1010) ALUoperation <= 4'b0111;   // Set less than
        end
    end
endmodule
