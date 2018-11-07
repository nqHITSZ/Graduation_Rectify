`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: HITSZ
// Engineer: NQ
// 
// Create Date: 2018/08/27 08:55:29
// Design Name: 
// Module Name: ImgBoundaryFlag
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


module  CoordinateGen #
(
    parameter DIN_DATA_WIDTH = 8,
    parameter ROW = 480,
    parameter COL = 640
)
(
    input clk, rst,
    input din_valid,
    output reg [9:0] col_cnt, 
    output reg [9:0] row_cnt
);



always @ (posedge clk) begin
    if(rst)
        col_cnt <= 0;
    else if(!din_valid)
        col_cnt <= 0;
    else
        col_cnt <= (col_cnt==COL-1) ? 0 : col_cnt + 1;
end

always @ (posedge clk) begin
    if(rst)
        row_cnt <= 0;
    else if(!din_valid)
        row_cnt <= 0;
    else if(col_cnt==COL-1)
        row_cnt <= (row_cnt==ROW-1) ? 0 : row_cnt + 1;
end




endmodule
