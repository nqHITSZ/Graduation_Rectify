`timescale 1ns / 1ps

module rectify(
input clk,
input rst,

`ifdef VIVADO
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 Svideo TDATA" *)
input wire [7:0] vtdata,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 Svideo TVALID" *)
input wire vtvalid,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 Svideo TLAST" *)
input wire vtlast,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 Svideo TREADY" *)
output wire vtready,

(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 Slut TDATA" *)
input wire [31:0] ltdata,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 Slut TVALID" *)
input wire ltvalid,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 Slut TLAST" *)
input wire ltlast,
(* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 Slut TREADY" *)
output wire ltready,
`else
input wire [7:0] vtdata,
input wire vtvalid,
input wire vtlast,
output wire vtready,

input wire [31:0] ltdata,
input wire ltvalid,
input wire ltlast,
output wire ltready,
`endif


output wire [7:0]recpixel,
output wire reclast,
output wire recvalid
);


wire ptvalid;

wire [9:0] py,px;
wire [5:0] dy,dx;

wire [7:0] lu,ru,ld,rd;
wire ptlast;
Fetch 
#(.img_width(640))
uF
(
    .clk(clk),
    .rst(rst),
    //video interface / AXI stream slave
    .vtvalid(vtvalid),
    .vtdata(vtdata),
    .vtlast(vtlast),
    .vtready(vtready),
    
    //LUT interface / AXI stream slave
    .ltdata(ltdata),
    .ltvalid(ltvalid),
    .ltlast(ltlast),
    .ltready(ltready),
    
    .lu(lu),
    .ru(ru),
    .ld(ld),
    .rd(rd),
    .yfrac(dy),
    .xfrac(dx),
    .ptlast(ptlast),
    .ptvalid(ptvalid)
);


interpolator_raw uitp
(
    .clk(clk),
    .rst(rst),
    .clk_en(1),
    .din_valid(ptvalid),
    .din_last(ptlast),
    .dy(dy),
    .dx(dx),
    .lu(lu),
    .ru(ru),
    .ld(ld),
    .rd(rd),
    .dout_valid(recvalid),
    .dout_last(reclast),
    .p(recpixel)

);




CoordinateGen_2 #(
    .ROW(480),
    .COL(640)
) UCG
(
    .clk(clk),
    .rst(rst),
    .din_valid(ptvalid),
    .col_cnt(px), 
    .row_cnt(py)
);




endmodule

