`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: HIT
// Engineer: NQ
// 
// Create Date: 2018/11/21 21:08:21
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
//NOTE the latency in reading and writing processes
module frac_latency #(
    parameter Latency = 7,
    parameter DATA_Width = 8
)
(
    input clk,rst,
    input [DATA_Width-1:0] din,
    output [DATA_Width-1:0] dout 
);
//`define RST_Enable
reg [DATA_Width-1:0] _delay [Latency-1:0] ;
integer i;
always @(posedge clk) begin
    for(i=0; i<Latency-1; i=i+1)
        _delay[i+1] <= _delay[i];
    _delay[0] <= din;
    end
`ifdef RST_Enable
    if(rst) begin
        for(i=0; i<Latency-1; i=i+1)
            _delay[i] <= 0;
    end

`endif
assign dout = _delay[Latency-1];

endmodule
