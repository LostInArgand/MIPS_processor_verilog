`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2022 03:12:25 PM
// Design Name: 
// Module Name: ALU
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
// ALU op codes
// 0000 -> AND
// 0001 -> OR
// 0010 -> add
// 0110 -> substract
// 0111 -> set on less than
// 1100 -> NOR
//////////////////////////////////////////////////////////////////////////////////


module ALU(
    input [31:0] A,
    input [31:0] B,
    output reg [31:0] ALU_Result,
    input [3:0] ALU_op,
    output reg zero
    );
    
    //Whenever there is a signal at ALU operation input or at ALU inputs, ALU should compute the result
    //Therefore,
    always @(A, B, ALU_op)
    begin
        case(ALU_op)
            4'b0000: ALU_Result <= A & B; // AND
            4'b0001: ALU_Result <= A | B; // OR
            4'b0010: ALU_Result <= A + B; // add
            4'b0110: ALU_Result <= A + (~B + 1); // subtract (with 2s complement)
            4'b0111: ALU_Result <= (A < B) ? 32'd1 : 32'd0; // Set less than
            4'b1100: ALU_Result <= ~(A | B);
        endcase
    end
    
    //If the ALU_Result is 0, set zero flag
    always @(ALU_Result)
    begin
        if(ALU_Result == 32'd0) zero <= 1'b1;
        else zero <= 1'b0;
    end
endmodule