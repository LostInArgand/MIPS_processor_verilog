`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2022 11:18:17 AM
// Design Name: 
// Module Name: Sign_Extension
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


module Sign_Extension(
    input [15:0] num_in,
    output reg [31:0] num_out
    );

    //Here, only the sign bit is left shifted while Twos complement notation properties are conserved
    always @(num_in)
    begin
        // If the sign is 1, just fill the most sigificant bits with 1s
        if (num_in[15]) num_out <= {16'hffff, num_in};
        
        // If the sign is 0, just fill the most sigificant bits with 0s
        else num_out <= {16'h0000, num_in};
    end
endmodule
