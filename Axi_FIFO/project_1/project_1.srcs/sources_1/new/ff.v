`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/12 16:27:45
// Design Name: 
// Module Name: ff
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


module ff(
    input clk,
    input rst,
    input ce,
    input sr,
    input d,
    output reg q
    );
    always @ (posedge clk)
    	if(ce)
    		q <= 1;
    	else if(sr)
    		q <= d;
    
    
endmodule
