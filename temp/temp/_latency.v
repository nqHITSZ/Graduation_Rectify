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
module _latency #(
    parameter Latency = 7,
    parameter DATA_Width = 8,
    parameter RST_Enable = 1
)
(
    input clk,rst,clk_en,
    input [DATA_Width-1:0] din,
    output [DATA_Width-1:0] dout 
);
reg [DATA_Width-1:0] _delay [Latency-1:0];
integer i;
always @(posedge clk) begin
    if(clk_en) begin
        for(i=0; i<Latency-1; i=i+1)
            _delay[i+1] <= _delay[i];
        _delay[0] <= din;
    end

    if(RST_Enable) begin
        if(rst) begin
            for(i=0; i<Latency-1; i=i+1)
                _delay[i] <= 0;
        end
    end

end

assign dout = _delay[Latency-1];


endmodule
