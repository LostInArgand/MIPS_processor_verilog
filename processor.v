`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/03/2022 12:22:45 AM
// Design Name: 
// Module Name: processor
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


module processor(
    input wire CLK,
    input wire RESET
    );
    
    // Load the required modules
    
    ALU_control alu_control();
    ALU alu();
    Sign_Extension sign_extension();
    data_memory data_mem();
    
    mux_2_to_1_32bit mux_32bit_1();
    mux_2_to_1_32bit mux_32bit_2();
    
    // Load instruction fetch module
    wire [31:0] adder_output;
    wire [31:0] Instruction;
    Instruction_Fetch_Module instruction_fetch_module(RESET, CLK, Instruction, adder_output);
    
    //Load Control module
    wire RegDst, Jump, Branch, MemRead, MemtoReg, memWrite, ALUSrc, RegWrite;
    wire [1:0] ALUOp;
    Control control(Instruction[31:26], RegDst, Jump, Branch, MemRead, MemtoReg, ALUOp, memWrite, ALUSrc, RegWrite);
    
////////////////////////// Datapath for R-type and Load/Store /////////////////////////////////////////

    // Load 5bit multiplexer
    wire [4:0] mux_to_write_reg;
    mux_2_to_1_5bit mux_5bit_1(Instruction[20:16], Instruction[15:11], RegDst, mux_to_write_reg);
    
    // Load Register File
    // Input Format :- Read_Register_1, Read_Register_2, Write_Register, Write_Data, RegWrite, CLK, Read_Data_1, Read_Data_2
    wire [31:0] mux_to_write_data;
    wire [31:0] read_data_1_to_ALU;
    wire [31:0] read_data_1_to_mux;
    Register_File register_file(Instruction[25:21], Instruction[20:16], mux_to_write_reg, mux_to_write_data, RegWrite, CLK, read_data_1_to_ALU, read_data_1_to_mux);
    
endmodule
