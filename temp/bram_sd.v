`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/08/27 16:11:15
// Design Name: 
// Module Name: bram_sd
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: simple_dual_ram_one_clock based on block ram
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module bram_sd
#(
    parameter ADDR_WIDTH = 10,
    parameter DATA_DEPTH = 640,
    parameter DATA_WIDTH = 28
)
(
    input clk,
    input [ADDR_WIDTH-1:0]  raddr,
    input re,
    input [ADDR_WIDTH-1:0]  waddr,
    input we,
    input [DATA_WIDTH-1:0]  din,
    output [DATA_WIDTH-1:0] dout
);

(* ram_style = "block" *) reg [DATA_WIDTH-1:0] mem [DATA_DEPTH-1:0];
reg [DATA_WIDTH-1:0]     rdata;


always @(posedge clk) begin
  if (we)
    mem[waddr] <= din;
  if (re)
    rdata <= mem[raddr];
end

assign dout = rdata;

endmodule
