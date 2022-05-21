`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2022 10:55:29 AM
// Design Name: 
// Module Name: Register_File
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


module Register_File(
     input [4:0] Read_Register_1,
     input [4:0] Read_Register_2,
     input [4:0] Write_Register,
     input [31:0] Write_Data,
     input RegWrite,
     input CLK,
     output reg [31:0] Read_Data_1,
     output reg [31:0] Read_Data_2
    );
    // Register addresses are 5 bits
    // Therefore the data space should be (2^5) x 32bit
    reg [31:0] Registers[31:0];
    
    //First clear the register file
    //Not sure whether this is necessary
//     initial begin
//        Registers[0] <= 32'h00000000;
//        Registers[1] <= 32'h00000000;
//        Registers[2] <= 32'h00000000;
//        Registers[3] <= 32'h00000000;
//        Registers[4] <= 32'h00000000;
//        Registers[5] <= 32'h00000000;
//        Registers[6] <= 32'h00000000;
//        Registers[7] <= 32'h00000000;
//        Registers[8] <= 32'h00000000;
//        Registers[9] <= 32'h00000000;
//        Registers[10] <= 32'h00000000;
//        Registers[11] <= 32'h00000000;
//        Registers[12] <= 32'h00000000;
//        Registers[13] <= 32'h00000000;
//        Registers[14] <= 32'h00000000;
//        Registers[15] <= 32'h00000000;
//        Registers[16] <= 32'h00000000;
//        Registers[17] <= 32'h00000000;.............
        
//     end
    
    
    //Instruction register is updated at negative edge (latched at positive edge)
    always @(negedge CLK)
    begin
        Read_Data_1 <= Registers[Read_Register_1];
        Read_Data_2 <= Registers[Read_Register_2];
    end

    //Writes are edge triggered
    always @(posedge CLK)
    begin
        if (RegWrite) Registers[Write_Register] <= Write_Data;
    end
endmodule
