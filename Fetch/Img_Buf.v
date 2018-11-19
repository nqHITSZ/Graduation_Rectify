`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/11/15 21:08:15
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
module Img_Buf #(
    parameter img_width = 8,    
    parameter img_height = 8    
)
(
    input clk,
    input [7:0] pixel,
    input w_en,
    input [9:0] wx,wy,// coord_nextinate for writing
    input [9:0] rx,ry,// coord_nextiante for reading
    output reg [7:0] lu,ru,ld,rd //4 pixels used in interpoloation l:light r:right u:up d:down
);
localparam half_img_width = img_width/2;
localparam mem_depth = img_width*img_height;
localparam addr_width = 10;
wire [addr_width-1 : 0] waddr;
reg [addr_width-1 : 0] raddr1,raddr2,raddr3,raddr4;
wire we1, we2, we3, we4;
wire [7:0] dout1, dout2, dout3, dout4;

//write logic begin
function iseven;
    input [9:0] a;
    iseven = a[0]==0;
endfunction

assign waddr = (wy>>1)*half_img_width + (wx>>1); 

assign we1 = w_en ? ( iseven(wy)  &&  iseven(wx)) : 0;
assign we2 = w_en ? ( iseven(wy)  && !iseven(wx)) : 0;
assign we3 = w_en ? (!iseven(wy) &&  iseven(wx)) : 0;
assign we4 = w_en ? (!iseven(wy) && !iseven(wx)) : 0;

//write logic end

//read logic begin
wire [addr_width-1 : 0] temp_addr_a;
wire [addr_width-1 : 0] temp_addr_b;
wire [addr_width-1 : 0] temp_addr_c;
wire [addr_width-1 : 0] temp_addr_d;
assign temp_addr_a = (ry>>1)*half_img_width + (rx>>1);
assign temp_addr_b = (ry==(img_height-1)) ? (rx>>1) : (temp_addr_a + half_img_width);
assign temp_addr_c = temp_addr_a + 1;
assign temp_addr_d = temp_addr_b + 1;

//Address Gen begin
//READ ADDR 1
always @ * begin
    case({iseven(ry),iseven(rx)})
        2'b11: raddr1 = temp_addr_a;
        2'b10: raddr1 = temp_addr_c;
        2'b01: raddr1 = temp_addr_b;
        2'b00: raddr1 = temp_addr_d;
    endcase
end
//READ ADDR 2
always @ * begin
    case({iseven(ry),iseven(rx)})
        2'b11: raddr2 = temp_addr_a;
        2'b10: raddr2 = temp_addr_a;
        2'b01: raddr2 = temp_addr_b;
        2'b00: raddr2 = temp_addr_b;
    endcase
end
//READ ADDR 3
always @ * begin
    case({iseven(ry),iseven(rx)})
        2'b11: raddr3 = temp_addr_a;
        2'b10: raddr3 = temp_addr_c;
        2'b01: raddr3 = temp_addr_a;
        2'b00: raddr3 = temp_addr_c;
    endcase
end
//READ ADDR 4
always @ * begin
    case({iseven(ry),iseven(rx)})
        2'b11: raddr4 = temp_addr_a;
        2'b10: raddr4 = temp_addr_a;
        2'b01: raddr4 = temp_addr_a;
        2'b00: raddr4 = temp_addr_a;
    endcase
end
//Address Gen end

//route begin
reg [7:0] lu_next,
          ru_next,
          ld_next,
          rd_next;
reg [1:0] even_odd_delay;
always @ (posedge clk) begin
    even_odd_delay <= {iseven(ry),iseven(rx)};
end
always @* begin
    case(even_odd_delay)
        2'b11: lu_next = dout1;
        2'b10: lu_next = dout2;
        2'b01: lu_next = dout3;
        2'b00: lu_next = dout4;
    endcase
end
always @* begin
    case(even_odd_delay)
        2'b11: ru_next = dout2;
        2'b10: ru_next = dout1;
        2'b01: ru_next = dout4;
        2'b00: ru_next = dout3;
    endcase
end
always @* begin
    case(even_odd_delay)
        2'b11: ld_next = dout3;
        2'b10: ld_next = dout4;
        2'b01: ld_next = dout1;
        2'b00: ld_next = dout2;
    endcase
end
always @* begin
    case(even_odd_delay)
        2'b11: rd_next = dout4;
        2'b10: rd_next = dout3;
        2'b01: rd_next = dout2;
        2'b00: rd_next = dout1;
    endcase
end

//route end

//output buffer begin
always @ (posedge clk) begin
    lu <= lu_next;
    ru <= ru_next;
    ld <= ld_next;
    rd <= rd_next;
end


//output buffer end


//read logic end 


bram_sd #(
    .ADDR_WIDTH(addr_width),
    .DATA_DEPTH(mem_depth),
    .DATA_WIDTH(8)
)Bram1 
(
    .clk(clk),
    .raddr(raddr1),
    .re(1),
    .waddr(waddr),
    .we(we1),
    .din(pixel),
    .dout(dout1)
);
bram_sd #(
    .ADDR_WIDTH(addr_width),
    .DATA_DEPTH(mem_depth),
    .DATA_WIDTH(8)
)Bram2 
(
    .clk(clk),
    .raddr(raddr2),
    .re(1),
    .waddr(waddr),
    .we(we2),
    .din(pixel),
    .dout(dout2)
);
bram_sd #(
    .ADDR_WIDTH(addr_width),
    .DATA_DEPTH(mem_depth),
    .DATA_WIDTH(8)
)Bram3 
(
    .clk(clk),
    .raddr(raddr3),
    .re(1),
    .waddr(waddr),
    .we(we3),
    .din(pixel),
    .dout(dout3)
);
bram_sd #(
    .ADDR_WIDTH(addr_width),
    .DATA_DEPTH(mem_depth),
    .DATA_WIDTH(8)
)Bram4 
(
    .clk(clk),
    .raddr(raddr4),
    .re(1),
    .waddr(waddr),
    .we(we4),
    .din(pixel),
    .dout(dout4)
);

endmodule

