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
    // Test Addition => 12 + 327 = 339.
        // Here, load word and write word instructions are also tested
        // Load 12 => Load word from data memory[1] and store it in register[2]
        instruction_memory[1] <= {6'h23, 5'd0, 5'd2, 16'd4};   // Memory is byte addresssable
        // Load 327 => Load word from data memory[2] and store it in register[3]
        instruction_memory[2] <= {6'h23, 5'd0, 5'd3, 16'd8};   // Memory is byte addresssable
        // r-type rs[2] rt[3] rd[4] add
        instruction_memory[3] <= {6'd0, 5'd2, 5'd3, 5'd4, 5'd0, 6'h20};
        // Write result => Write result in register[4] to memory[3]
        instruction_memory[4] <= {6'h2b, 5'd0, 5'd4, 16'd12};   // Memory is byte addresssable
 
    // Test Substraction => 339 - 100 = 239
        // Load result from memory[3] to register[2]
        instruction_memory[5] <= {6'h23, 5'd0, 5'd2, 16'd12};   // Memory is byte addresssable
        // Load 100 => Load word from data memory[4] and store it in register[3]
        instruction_memory[6] <= {6'h23, 5'd0, 5'd3, 16'd16};   // Memory is byte addresssable
        // r-type rs[2] rt[3] rd[5] sub
        instruction_memory[7] <= {6'd0, 5'd2, 5'd3, 5'd5, 5'd0, 6'h22};

    // Test AND => 47583 AND 125543 = 43079
        // Load 47583 from memory[5] to register[2]
        instruction_memory[8] <= {6'h23, 5'd0, 5'd2, 16'd20};   // Memory is byte addresssable
        // Load 125543 from memory[6] to register[3]
        instruction_memory[9] <= {6'h23, 5'd0, 5'd3, 16'd24};   // Memory is byte addresssable
        // r-type rs[2] rt[3] rd[4] AND
        instruction_memory[10] <= {6'd0, 5'd2, 5'd3, 5'd4, 5'd0, 6'h24};

    // Test OR => 47583 OR 125543 = 130047 => r-type rs[2] rt[3] rd[5] OR
        instruction_memory[11] <= {6'd0, 5'd2, 5'd3, 5'd5, 5'd0, 6'h25};

    // Test set less than => 43079 < 130047 => r-type rs[4] rt[5] rd[6] slt
        instruction_memory[12] <= {6'd0, 5'd4, 5'd5, 5'd6, 5'd0, 6'h2a};
    // Test set less than => 130047 < 43079 => r-type rs[5] rt[4] rd[6] slt
        instruction_memory[13] <= {6'd0, 5'd5, 5'd4, 5'd6, 5'd0, 6'h2a};

    // Test Branch on Equal instruction
        // Compare register register[2] (47583) with register[3]
        // Load 47583 to register[3]
        instruction_memory[14] <= {6'h23, 5'd0, 5'd3, 16'd20};   // Memory is byte addresssable
        // If register[2] == register[4], goto instruction number 21
        // beq rs[2] rt[4] offset
        instruction_memory[15] <= {6'h4, 5'd2, 5'd4, 16'd5};
        // If register[2] == register[3], goto instruction number 21
        // beq rs[2] rt[3] offset
        instruction_memory[16] <= {6'h4, 5'd2, 5'd3, 16'd4};
        
      // These instructions are skipped
        instruction_memory[17] <= {6'h23, 5'd0, 5'd4, 16'd20};   // Memory is byte addresssable
        instruction_memory[18] <= {6'h23, 5'd0, 5'd4, 16'd20};   // Memory is byte addresssable
        instruction_memory[19] <= {6'h23, 5'd0, 5'd4, 16'd20};   // Memory is byte addresssable
        instruction_memory[20] <= {6'h23, 5'd0, 5'd4, 16'd20};   // Memory is byte addresssable
        
       // If beq is executing properly, substract register[3] from register[2]
         // r-type rs[2] rt[3] rd[4] sub
        instruction_memory[21] <= {6'd0, 5'd2, 5'd3, 5'd4, 5'd0, 6'h22};

      // Test jump instruction
        // Jump to instruction 5 (No need to multiply by 4)
        instruction_memory[22] <= {6'h2, 26'd5};
    end
///////////////////////////////////////////////////////////////////////////////////////////////////////



endmodule