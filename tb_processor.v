`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/17/2022 10:03:06 PM
// Design Name: 
// Module Name: tb_processor
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


module tb_processor;
    reg CLK;
    reg reset;
    
    // Initial values
    initial begin
        CLK <= 1'b0;
        reset <= 1'b0;
        
        // Test reset function
        #210 reset <= 1'b1;
        #10 reset <= 1'b0;
    end

    // Input format:- clk, reset
    processor mips(CLK, reset);
    
    // For .vcd file
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end

    // stopwatch
    initial #230 $finish;
        
    initial
        repeat(100)
            #5 CLK <= ~CLK;
    
    // Check processor
    initial begin
        
    end
endmodule


