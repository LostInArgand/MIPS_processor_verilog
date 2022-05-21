`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: University of Peradeniya
// Engineer: DMPM Alwis
// 
// Create Date: 05/20/2022 07:33:05 PM
// Design Name: 
// Module Name: PC
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


module Instruction_Fetch_Module(
    input RESET,
    input CLK,
    input PC_write_enable,
    output reg [31:0]  instruction_reg
    );
    reg [31:0] PC_out;
    wire [31:0] PC_next;
    
    reg [31:0] instruction_mem [0:4096]; //Let the instruction space be 4K x 31 bits

////////////////Program Counter Adder/////////////////

    assign PC_next = PC_out + 32'h00000004;

//////////////////////////////////////////////////////

////////////////Program Counter part/////////////////
    //Inititial value
    initial begin
        PC_out <= 32'h00000000;
    end
    
    //PC latches at negative edge
    always @(posedge CLK)
    begin
        //reset program counter
        if (RESET) PC_out <= 32'h00000000;
        // update program counter
        else
        begin
            // only update the PC if PC write is active
            // unless PC will update at every clock pulse
            if (PC_write_enable) PC_out <= PC_next;
        end
    end
//////////////////////////////////////////////////////

//////////////////Instruction Memory///////////////////
    //Instruction memory is byte addressible.
    //Hence the 0th and the 1st bits of the address is ignored
    assign address = PC_out;    //Implicit assingment
    assign instruction =  instruction_mem[address >> 2];
//////////////////////////////////////////////////////

//////////////////Instruction Register///////////////////
    //Instruction Register is latched at positive edge
    always @(negedge CLK)
    begin
        instruction_reg <= instruction;
    end
//////////////////////////////////////////////////////
endmodule
