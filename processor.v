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
    

    
    // Load instruction fetch module
    // I/O format -: RESET, CLK, PC_in, IR, adder_output
    wire [31:0] PC_in;
    wire [31:0] adder_output;
    wire [31:0] Instruction;
    Instruction_Fetch_Module instruction_fetch_module(RESET, CLK, PC_in, Instruction, adder_output);
    
    //Load Control module
    wire RegDst, Jump, Branch, MemRead, MemtoReg, memWrite, ALUSrc, RegWrite;
    wire [1:0] ALUOp;
    Control control(Instruction[31:26], RegDst, Jump, Branch, MemRead, MemtoReg, ALUOp, memWrite, ALUSrc, RegWrite);
    
////////////////////////// Datapath for R-type and Load/Store /////////////////////////////////////////

    // Load 5bit multiplexer
    wire [4:0] mux_to_write_reg;
    mux_2_to_1_5bit mux_5bit_1(Instruction[20:16], Instruction[15:11], RegDst, mux_to_write_reg);
    
    // Load Register File
    // I/O Format :- Read_Register_1, Read_Register_2, Write_Register, Write_Data, RegWrite, CLK, Read_Data_1, Read_Data_2
    wire [31:0] mux_to_write_data;
    wire [31:0] read_data_1_to_ALU;
    wire [31:0] read_data_2;
    Register_File register_file(Instruction[25:21], Instruction[20:16], mux_to_write_reg, mux_to_write_data, RegWrite, CLK, read_data_1_to_ALU, read_data_2);
    
    // Load Sign Extend
    wire [31:0] sign_ext_out;
    Sign_Extension sign_extension(Instruction[15:0], sign_ext_out);
    
    // Load 32bit mux 1
    wire [31:0] mux_to_ALU;
    mux_2_to_1_32bit mux_32bit_1(read_data_2, sign_ext_out, ALUSrc, mux_to_ALU);
    
    // Load ALU control
    wire [3:0] ALU_operation;
    ALU_control alu_control(Instruction[5:0], ALUOp, ALU_operation);
    
    // Load ALU
    // I/O format -: A, B, ALU_Result, ALU_op, zero
    wire [31:0] ALU_result;
    wire ALU_zero;
    ALU alu(read_data_1_to_ALU, mux_to_ALU, ALU_result, ALU_operation, ALU_zero);
    
    // Load Data memory
    // I/O format -: address, write_data, mem_write, mem_read, CLK, read_data
    wire [31:0] Read_data_mem;
    data_memory data_mem(ALU_result, read_data_2, memWrite, MemRead, CLK, Read_data_mem);
    
    // Load 32bit mux 2
    // I/O format -: zero, one, select, out
    mux_2_to_1_32bit mux_32bit_2(ALU_result, Read_data_mem, MemtoReg, mux_to_write_data);
    
//////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////// Additional datapath for Branch instructions ////////////////////
    // Load Adder with left shift
    wire [31:0] branch_target;
    Adder_with_left_shift adder_with_left_shift(adder_output, sign_ext_out, branch_target);
    
    // Load 32bit mux 3
    // I/O format -: zero, one, select, out
    wire [31:0] mux_3_out;
    wire branch_control;
    assign branch_control = Branch & ALU_zero;
    mux_2_to_1_32bit mux_32bit_3(adder_output, branch_target, branch_control, mux_3_out);
////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////// Datapath for R-type, Load/Store, Branch & Jump ////////////////
    // Load left shift for jump
    // I/O format -: Instruction, from_PC + 4, Jump_Address
    wire [31:0] Jump_Address;
    left_shift_for_jump left_shift_jump(Instruction[25:0], adder_output[31:28], Jump_Address);
    
    // Load 32bit mux 4
    // I/O format -: zero, one, select, out
    mux_2_to_1_32bit mux_32bit_4(mux_3_out, Jump_Address, Jump, PC_in);
///////////////////////////////////////////////////////////////////////////////////////////////////
endmodule
