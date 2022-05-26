`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2022 10:13:41 PM
// Design Name: 
// Module Name: data_memory
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


module data_memory(
    input [31:0] address,
    input [31:0] write_data,
    input mem_write,
    input mem_read,
    input CLK,
    output reg [31:0] read_data
    );
    
    // Define 32 bit x 128 memory
    reg [31:0] memory[0:63];
    
    // According to the data sheet, only write is edge triggered by clock
    always @(mem_read)
    begin
        // Avoid writing while reading data
        if((~mem_write) & (mem_read)) read_data <= memory[address >> 2];
    end
    // According to the data sheet, only write is edge triggered by clock
    always @(posedge CLK)
    begin
        if (mem_write == 1'b1) memory[address >> 2] <= write_data;
    end
endmodule
