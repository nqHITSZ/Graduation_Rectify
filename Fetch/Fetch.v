`timescale 1ns / 1ps

module Fetch #(
   parameter img_width = 16
) 
(
    input clk, rst,
    input Fsync,
    input [9:0] yint, xint,
    input [7:0] tdata,
    input tvalid,
    input Flast,//
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
reg [9:0] ry, rx;
reg rp_inc_en;//read pointer increasing enable
reg rp_clr;
always @ (posedge clk) begin
    if(rp_clr) begin
        ry_pointer <= 0;
        rx_pointer <= 0;
    end
    else begin
        if(rp_inc_en) begin
            if(rx_pointer==(img_width-1)) ry_pointer <= (ry_pointer==(BUF_height-1))? 0 : ry_pointer+1;
            rx_pointer <= (rx_pointer==(img_width-1))? 0 : rx_pointer+1;
        end
    end
end

//read control FSM begin
localparam IDEL = 0,
           READ = 1,
           READ_TAIL = 2,
           DONE = 7;
reg [3:0]state;

always @ (posedge clk) begin
    if(rst) begin
        state <= IDEL;
        rp_inc_en <= 0;
    end
    else begin
        case(state)
            IDEL: begin
                if(wy_pointer==1 && wx_pointer==15) begin
                    state <= READ;
                end
            end
            READ: begin
                if(Flast && tvalid) begin
                    state <= READ_TAIL;
                end
            end
            READ_TAIL: begin
                if(ry_pointer==3 && rx_pointer==14) begin
                    state <= DONE;
                end
            end
            DONE: begin
            end
        endcase
    end
end
always @ * begin
        case(state)
            IDEL: begin
                rp_inc_en = 0;
                rp_clr = 1;
            end
            READ: begin
                rp_inc_en = tvalid;
                rp_clr = 0;
            end
            READ_TAIL: begin
                rp_inc_en = 1;
                rp_clr = 0;
            end
            DONE: begin
                rp_inc_en = 0;
                rp_clr = 0;
            end
            default: begin
                rp_inc_en = 1'bx;
                rp_clr = 1'bx;
            end
        endcase
end

wire signed [9:0] temp_ry;
assign temp_ry = ry_pointer + yint;
wire signed [9:0] temp_rx;
assign temp_rx = rx_pointer + xint;
always @ * begin
    if(temp_ry>(BUF_height-1))
        ry = temp_ry-(BUF_height-1);
    else if(temp_ry<0)
        ry = temp_ry+BUF_height;
    else
        ry = temp_ry;

    if(temp_rx>(img_width-1))
        rx = temp_rx-(img_width-1);
    else if(temp_rx<0)
        rx = temp_rx+img_width;
    else
        rx = temp_rx;
end

//read control FSM end



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
    .rx(rx),
    .ry(ry),
    .lu(lu),
    .ru(ru),
    .ld(ld),
    .rd(rd)
);



endmodule

