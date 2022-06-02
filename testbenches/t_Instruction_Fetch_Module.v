//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/01/2022 12:13:40 AM
// Design Name: 
// Module Name: t_Instruction_Fetch_Module
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


module t_Instruction_Fetch_Module;
    reg RESET;
    reg CLK;
    wire [31:0] instruction_output;
    
    Instruction_Fetch_Module Ins_fetch_module1(RESET, CLK, instruction_output);
    
    // For .vcd file
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
    end
    
    
    // Stopwatch
    initial #200 $finish;
    
    
    initial begin
        // Initialize clock
        CLK <= 1'b0;
        
        // Initialize some instructions
        Ins_fetch_module1.instruction_memory[0] <= 32'd1;
        Ins_fetch_module1.instruction_memory[1] <= 32'd1;
        Ins_fetch_module1.instruction_memory[2] <= 32'd2;
        Ins_fetch_module1.instruction_memory[3] <= 32'd3;
        Ins_fetch_module1.instruction_memory[4] <= 32'd5;
        Ins_fetch_module1.instruction_memory[5] <= 32'd8;
        Ins_fetch_module1.instruction_memory[6] <= 32'd13;
        Ins_fetch_module1.instruction_memory[7] <= 32'd21;
        Ins_fetch_module1.instruction_memory[8] <= 32'd35;
    end
    
    // Generate clock pulses
    initial
        repeat(40)
            #5 CLK = ~CLK;
    
    // Check the module's operation
    initial begin
        RESET <= 1'b0;
        #45 RESET <= 1'b1;
        #15 RESET <= 1'b0;
    end
endmodule
