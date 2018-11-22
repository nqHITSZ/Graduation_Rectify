`timescale 1ns / 1ps

module Fetch #(
    parameter img_width = 640,
    parameter BUF_height = 60
) 
(
    input clk, rst,
    input Fsync,

    //video interface / AXI stream slave
    input [7:0] vtdata,
    input vtvalid,
    input vtlast,
    output reg vtready,
    
    //LUT interface / AXI stream slave
    input [31:0] ltdata,
    input ltvalid,
    input ltlast,
    output reg ltready,

    //output interface
    output [7:0] lu,ru,ld,rd,
    output [5:0] yfrac, xfrac,
    output ptlast,
    output ptvalid,
    input ptready
    
);

//write pointer begin -----------------------------
wire buf_we;
reg [10:0] wy_pointer, wx_pointer;
always @ (posedge clk) begin
    if(rst) begin
        wy_pointer <= 0;
        wx_pointer <= 0;
    end
    else begin
        if(vtvalid && vtready) begin
            if(wx_pointer==(img_width-1)) wy_pointer <= (wy_pointer==(BUF_height-1))? 0 : wy_pointer+1;
            wx_pointer <= (wx_pointer==(img_width-1))? 0 : wx_pointer+1;
        end
    end
end

assign buf_we = vtvalid && vtready;
//write pointer end %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

//read pointer begin -----------------------------
localparam Base_ry = 4,
           Base_rx = 0;
reg [10:0] ry_pointer, rx_pointer;
reg [10:0] ry, rx;
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

//read control FSM begin -----------------------------
localparam IDEL = 0,
           READ = 1,
           READ_TAIL = 2,
           DONE = 7;
reg [3:0]state;
reg bram_ren;
wire [10:0] yint, xint;
assign yint = $signed(ltdata[15:8]);
assign xint = $signed(ltdata[7:0]);

always @ (posedge clk) begin
    if(rst) begin
        state <= IDEL;
    end
    else begin
        case(state)
            IDEL: begin
                if(wy_pointer==26 && wx_pointer==320) begin
                    state <= READ;
                end
            end
            READ: begin
                if(vtready && vtlast && vtvalid) begin
                    state <= READ_TAIL;
                end
                
            end
            READ_TAIL: begin
                if(ry_pointer==11'h3b && rx_pointer==11'h27f) begin
                    state <= DONE;
                end
            end
            DONE: begin
            end
        endcase
    end
end
always @ * begin
        vtready = 0;
        ltready = 0;
        bram_ren = 0;
        rp_inc_en = 0;
        rp_clr = 0;
        case(state)
            IDEL: begin
                rp_inc_en = 0;
                rp_clr = 1;
                vtready = 1;
            end
            READ: begin
                vtready = ltvalid;
                rp_inc_en = (vtready && vtvalid);
                rp_clr = 0;
                ltready = (vtready && vtvalid);
                bram_ren = (vtready && vtvalid);
            end
            READ_TAIL: begin
                rp_inc_en = 1;
                bram_ren = 1;
                rp_clr = 0;
                ltready = 1;
                vtready = 0;
            end
            DONE: begin
                rp_inc_en = 0;
                rp_clr = 0;
            end
        endcase
end

wire signed [10:0] temp_ry;
assign temp_ry = ry_pointer + yint;
wire signed [10:0] temp_rx;
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


//read control FSM end %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//read pointer end %%%%%%%%%%%%%%%%%%%%%%%%%%%%%


//output logic begin -----------------------------
reg [1:0] read_latency_0,read_latency_1,read_latency_2;
always @(posedge clk) begin
    if(rst) begin
        read_latency_0 <= 0;
        read_latency_1 <= 0;
        read_latency_2 <= 0;
    end
    else begin
        read_latency_0[0] <= bram_ren;
        read_latency_0[1] <= (ltready && ltlast && ltvalid);
        read_latency_1 <= read_latency_0;
        read_latency_2 <= read_latency_1;
    end
end
assign ptvalid = read_latency_1[0];
assign ptlast = read_latency_1[1];

//output logic end   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%



wire [7:0] lu_temp,ru_temp,ld_temp,rd_temp;
Img_Buf //the reading latency is 2, write latency is 1
#(
    .img_width(img_width),
    .img_height(BUF_height)
)
u_BUF
(
    .clk(clk),
    .pixel(vtdata),
    .w_en(vtvalid),
    .wx(wx_pointer),
    .wy(wy_pointer),
    .rx(rx),
    .ry(ry),
    .lu(lu_temp),
    .ru(ru_temp),
    .ld(ld_temp),
    .rd(rd_temp)
);
wire _yxint_valid,yxint_valid;
assign _yxint_valid = !(ltdata==16'h8080); //NOTE: when generating the rectification lut by the software(MATLAB or Python), I use 0x8080 to indicate the INVALID coordinate mapping.
_latency #(
    .Latency(2),
    .DATA_Width(1),
    .RST_Enable(1)
) u_yxint_valid
(
    .clk(clk),
    .clk_en(1),
    .rst(rst),
    .din(_yxint_valid),
    .dout(yxint_valid) 
);

assign lu = yxint_valid ? lu_temp : 0;
assign ru = yxint_valid ? ru_temp : 0;
assign ld = yxint_valid ? ld_temp : 0;
assign rd = yxint_valid ? rd_temp : 0;

frac_latency #(
    .Latency(2),
    .DATA_Width(6)
) ufy
(
    .clk(clk),
    .rst(rst),
    .din(ltdata[29:24]),
    .dout(yfrac)
);

frac_latency #(
    .Latency(2),
    .DATA_Width(6)
) ufx
(
    .clk(clk),
    .rst(rst),
    .din(ltdata[21:16]),
    .dout(xfrac)
);



endmodule

