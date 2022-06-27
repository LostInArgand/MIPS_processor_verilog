`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/03/2022 12:15:23 AM
// Design Name: 
// Module Name: Control
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


module Control(
    input wire [5:0] opcode,
    output reg RegDst,
    output reg Jump,
    output reg Branch,
    output reg MemRead,
    output reg MemtoReg,
    output reg [1:0] ALUOp,
    output reg MemWrite,
    output reg ALUSrc,
    output reg RegWrite
    );
    
    initial begin
        RegDst <= 1'b0;
        Jump <= 1'b0;
        ALUSrc <= 1'b0;
        MemtoReg <= 1'b0;
        RegWrite  <= 1'b0;
        MemRead <= 1'b0;
        MemWrite <= 1'b0;
        Branch <= 1'b0;
        ALUOp <= 2'b00;
    end
    
    
        // run when opcode changes
        always @(opcode) begin
        case(opcode)
            0: begin            // R-type instruction
                RegDst <= 1'b1;
                Jump <= 1'b0;
                ALUSrc <= 1'b0;
                MemtoReg <= 1'b0;
                RegWrite  <= 1'b1;
                MemRead <= 1'b0;
                MemWrite <= 1'b0;
                Branch <= 1'b0;
                ALUOp <= 2'b10;
            end
            2: begin            // Jump
                RegDst <= 1'b0;
                Jump <= 1'b1;
                ALUSrc <= 1'b0;
                MemtoReg <= 1'b0;
                RegWrite  <= 1'b0;
                MemRead <= 1'b0;
                MemWrite <= 1'b0;
                Branch <= 1'b0;
                ALUOp <= 2'b00;
            end
            35: begin            // Load Word
                RegDst <= 1'b0;
                Jump <= 1'b0;
                ALUSrc <= 1'b1;
                MemtoReg <= 1'b1;
                RegWrite  <= 1'b1;
                MemRead <= 1'b1;
                MemWrite <= 1'b0;
                Branch <= 1'b0;
                ALUOp <= 2'b00;
            end
            43: begin            // Store Word
                ALUSrc <= 1'b1;
                Jump <= 1'b0;
                RegWrite  <= 1'b0;
                MemRead <= 1'b0;
                MemWrite <= 1'b1;
                Branch <= 1'b0;
                ALUOp <= 2'b00;
            end
            4: begin            // Branch instruction
                ALUSrc <= 1'b0;
                Jump <= 1'b0;
                RegWrite  <= 1'b0;
                MemRead <= 1'b0;
                MemWrite <= 1'b0;
                Branch <= 1'b1;
                ALUOp <= 2'b01;
            end
        endcase
    end
    
    
endmodule
