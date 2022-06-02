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
//    input PC_write_enable,
    output reg [31:0]  IR,
    output wire [31:0] adder_output
    );
    reg [31:0] PC;
    wire [31:0] PC_out;
    wire [31:0] PC_in;
    wire [31:0] read_address;
    wire [31:0] instruction;
    
    reg [31:0] instruction_memory [0:4096]; //Let the instruction space be 4K x 31 bits

////////////////Program Counter Adder/////////////////

    assign adder_output = PC_out + 32'h00000004;            // Adder output and PC_in is not connected (connect them in the testbench

//////////////////////////////////////////////////////

////////////////Program Counter part/////////////////
    // connect PC_out wire to PC
    assign PC_out = PC;

    //Inititial value
    initial begin
        PC <= 32'h00000000;
    end
    
    //PC latches at negative edge
    always @(posedge CLK)
    begin
        //reset program counter
        if (RESET) PC <= 32'h00000000;
        // update program counter
        else
        begin
            // only update the PC if PC write is active
            // unless PC will update at every clock pulse
//            if (PC_write_enable) PC <= PC_in;
            PC <= PC_in;
        end
    end
//////////////////////////////////////////////////////

//////////////////Instruction Memory///////////////////
    //Instruction memory is byte addressible.
    //Hence the 0th and the 1st bits of the address is ignored
    assign read_address = PC_out;
    assign instruction =  instruction_memory[read_address >> 2];
//////////////////////////////////////////////////////

//////////////////Instruction Register///////////////////
    //Instruction Register is latched at positive edge
    always @(negedge CLK)
    begin
        IR <= instruction;
    end
//////////////////////////////////////////////////////
endmodule
