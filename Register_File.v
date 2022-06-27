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
    
    
    //Instruction register is updated at negative edge (latched at positive edge)
    always @(Read_Register_1 or Read_Register_2)
    begin
        Read_Data_1 <= Registers[Read_Register_1];
        Read_Data_2 <= Registers[Read_Register_2];
    end

    //Writes are edge triggered
    always @(posedge CLK)
    begin
        if (RegWrite) Registers[Write_Register] <= Write_Data;
    end
  
//////////// Load values for the testing ///////////////
    initial begin
    // Initialize
        Registers[0] <= 32'd0;
        Registers[1] <= 32'd0;
        Registers[2] <= 32'd0;
        Registers[3] <= 32'd0;
        Registers[4] <= 32'd0;
        Registers[5] <= 32'd0;
        Registers[6] <= 32'd0;
        Registers[7] <= 32'd0;
        Registers[8] <= 32'd0;
        Registers[9] <= 32'd0;
        Registers[10] <= 32'd0;
        Registers[11] <= 32'd0;
    end
///////////////////////////////////////////////////////

endmodule