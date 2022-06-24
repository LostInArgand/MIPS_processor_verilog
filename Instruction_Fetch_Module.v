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
    input wire [31:0] PC_in,
    output reg [31:0]  IR,
    output wire [31:0] adder_output
    );
    reg [31:0] PC;
    wire [31:0] PC_out;
//    wire [31:0] PC_in; 
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





/////////////////////////////////////////////////////
    // Program instructions for the testing //
    initial begin
    // Initialize
        instruction_memory[0] <= {6'd0, 5'd0, 5'd0, 5'd1, 5'd0, 6'h20};
    // Test Addition => 12 + 327 = 339 => r-type rs[2] rt[3] rd[4] add
        instruction_memory[1] <= {6'd0, 5'd2, 5'd3, 5'd4, 5'd0, 6'h20};
    // Test Substraction => 339 - 100 = 239 => r-type rs[4] rt[5] rd[6] sub
        instruction_memory[2] <= {6'd0, 5'd4, 5'd5, 5'd6, 5'd0, 6'h22};
    // Test AND => 47583 AND 125543 = 43079 => r-type rs[7] rt[8] rd[9] AND
        instruction_memory[3] <= {6'd0, 5'd7, 5'd8, 5'd9, 5'd0, 6'h24};
    // Test OR => 47583 OR 125543 = 130047 => r-type rs[7] rt[8] rd[10] OR
        instruction_memory[4] <= {6'd0, 5'd7, 5'd8, 5'd10, 5'd0, 6'h25};
    // Test set less than => 43079 < 130047 => r-type rs[9] rt[10] rd[11] slt
        instruction_memory[5] <= {6'd0, 5'd9, 5'd10, 5'd11, 5'd0, 6'h2a};
    // Test set less than => 130047 < 43079 => r-type rs[10] rt[9] rd[11] slt
        instruction_memory[6] <= {6'd0, 5'd10, 5'd9, 5'd12, 5'd0, 6'h2a};
    // Test load word => Load word from data memory[1] and store it in register[13]
        instruction_memory[7] <= {6'h23, 5'd0, 5'd13, 16'd4};   // Memory is byte addresssable
    end
/////////////////////////////////////////////////////



endmodule
