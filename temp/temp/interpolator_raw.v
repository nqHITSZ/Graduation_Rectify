`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: HITSZ
// Engineer: NQ
// 
// Create Date: 2018/11/13 18:24:29
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


module  interpolator_raw # //"raw" means that this model is not wrapped with AXI
(
    parameter D_width = 6
)
(
    input clk,rst,
    input clk_en,
    input din_valid,
    input [D_width-1:0]dx,dy,
    input [7:0] lu,ru,ld,rd,
    output dout_valid,
    output [7:0] p

);
//stage 1
reg [D_width-1:0] keep_dx,keep_dy;
reg [D_width-1:0] sub_dx,sub_dy;
reg [7:0] lu_1,ru_1,ld_1,rd_1;
always @ (posedge clk)
    if(rst) begin
        keep_dx <= 0;
        keep_dy <= 0;
        sub_dx <= 0;
        sub_dy <= 0;
        lu_1 <= 0;
        ru_1 <= 0;
        ld_1 <= 0;
        rd_1 <= 0;
    end
    else if(clk_en) begin
        keep_dx <= dx;
        keep_dy <= dy;
        sub_dx <= {D_width {1'b1}} - dx;
        sub_dy <= {D_width {1'b1}} - dy;
        lu_1 <= lu;
        ru_1 <= ru;
        ld_1 <= ld;
        rd_1 <= rd;
    end
//stage 2
reg [7:0] lu_2,ru_2,ld_2,rd_2;
localparam S2_width = D_width * 2;
reg [S2_width-1:0] mul_1,mul_2,mul_3,mul_4;
always @ (posedge clk)
    if(rst) begin
        mul_1 <= 0;
        mul_2 <= 0;
        mul_3 <= 0;
        mul_4 <= 0;
        lu_2 <= 0;
        ru_2 <= 0;
        ld_2 <= 0;
        rd_2 <= 0;
    end
    else if(clk_en) begin
        mul_1 <= sub_dx * sub_dy;
        mul_2 <= keep_dx * sub_dy;
        mul_3 <= keep_dy * sub_dx;
        mul_4 <= keep_dx * keep_dy;
        lu_2 <= lu_1;
        ru_2 <= ru_1;
        ld_2 <= ld_1;
        rd_2 <= rd_1;
    end
//stage 3
localparam S3_width = S2_width + 8;
reg [S3_width-1:0] mul_lu,mul_ru,mul_ld,mul_rd;
always @ (posedge clk)
    if(rst) begin
        mul_lu <= 0;
        mul_ru <= 0;
        mul_ld <= 0;
        mul_rd <= 0;
    end
    else if(clk_en) begin
        mul_lu <= mul_1 * lu_2;
        mul_ru <= mul_2 * ru_2;
        mul_ld <= mul_3 * ld_2;
        mul_rd <= mul_4 * rd_2;
    end
//stage 4
localparam S4_width = S3_width;
reg [S4_width-1:0] sum;
always @ (posedge clk)
    if(rst) begin
        sum <= 0;
    end
    else if(clk_en) begin
        sum <= mul_lu+mul_ru+mul_ld+mul_rd;
    end
//pixel output
assign p = sum[S4_width-1 -: 8];


_latency #(
    .Latency(4),
    .DATA_Width(1),
    .RST_Enable(1)
) ulatecny
(
    .clk(clk),
    .clk_en(clk_en),
    .rst(rst),
    .din(din_valid),
    .dout(dout_valid) 
);


endmodule
