`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.03.2018 23:20:11
// Design Name: 
// Module Name: testBenchOfStepMotor
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


module testBenchOfStepMotor();

    logic clk, enable;
    logic direction;
    logic [1:0] speed;
    logic A, B, Ab, Bb;
    logic a, b, c, d, e, f, g, dp;
    logic [3:0] an;

Motor dut(clk, enable, direction, speed , A, B, Ab, Bb, a, b, c, d, e, f, g, dp,an );
 
initial begin
	clk = 1'b0;
	direction = 1'b0;
	speed = 2'b00;
	enable = 1'b0;
	
	#10
	clk = 1'b1;
    direction = 1'b0;
    speed = 2'b00;
    enable = 1'b0;
    
    #10	
	speed = 2'b11;

end
  
always 
	#5  clk =  !clk;  

endmodule
