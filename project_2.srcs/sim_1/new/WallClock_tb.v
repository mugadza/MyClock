`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2020 02:38:07 PM
// Design Name: 
// Module Name: WallClock_tb
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


module WallClock_tb();
 // Initialize all params of the module you want to test
   reg CLK100MHZ;
   reg button;
   reg MButton;
   reg HButton;
   wire [7:0] SevenSegment;
   wire [3:0] SegementDrivers;
   
   // Initialize the  Unit Under Test (uut)
    WallClock uut(
        .CLK100MHZ(CLK100MHZ),
        .button(button),
        .MButton(MButton),
        .HButton(HButton),
        .SevenSegment(SevenSegment),
        .SegementDrivers(SegementDrivers)
    );  
    
    initial begin
        CLK100MHZ <= 0;
        MButton <= 0;
        #150;
        MButton <= 1;
        #150;
        MButton <= 0;
        #150;
        MButton <= 1;
        #150;
        MButton <= 0;
        #150;
        MButton <= 1;
        #150;
        MButton <= 0;
        #150;
        MButton <= 1;
        #150;
        MButton <= 0;
        #150;
        MButton <= 1;
        #150;
        MButton <= 0;
    end
        
    always #1 CLK100MHZ = ~CLK100MHZ;
    
endmodule