`timescale 1ns / 1ps

module Fetch #(
   parameter img_width = 16
) 
(
    input clk, rst,
    input yint, xint,
    input [7:0] tdata,
    input tvalid,
    output [7:0] lu,ru,ld,rd
);
localparam BUF_height = 6;
//write pointer begin
reg [9:0] wy_pointer, wx_pointer;
always @ (posedge clk) begin
    if(rst) begin
        wy_pointer <= 0;
        wx_pointer <= 0;
    end
    else begin
        if(tvalid) begin
            if(wx_pointer==(img_width-1)) wy_pointer <= (wy_pointer==(BUF_height-1))? 0 : wy_pointer+1;
            wx_pointer <= (wx_pointer==(img_width-1))? 0 : wx_pointer+1;
        end
    end
end
//write pointer end

//read pointer begin
localparam Base_ry = 4,
           Base_rx = 0;
reg [9:0] ry_pointer, rx_pointer;
reg rinc_en;//read pointer increasing enable
always @ * begin
    rinc_en = tvalid;
end
always @ (posedge clk) begin
    if(rst) begin
        ry_pointer <= Base_ry;
        rx_pointer <= Base_rx;
    end
    else begin
        if(rinc_en) begin
            if(rx_pointer==(img_width-1)) ry_pointer <= (ry_pointer==(BUF_height-1))? 0 : ry_pointer+1;
            rx_pointer <= (rx_pointer==(img_width-1))? 0 : rx_pointer+1;
        end
    end
end
//read pointer end

Img_Buf 
#(
    .img_width(img_width),
    .img_height(BUF_height)
)
u_BUF
(
    .clk(clk),
    .pixel(tdata),
    .w_en(tvalid),
    .wx(wx_pointer),
    .wy(wy_pointer),
    .rx(rx_pointer),
    .ry(ry_pointer),
    .lu(lu),
    .ru(ru),
    .ld(ld),
    .rd(rd)
);



endmodule

