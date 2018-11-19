`timescale 1ns / 1ps

module sim_video
(
    input clk,rst,start,
    output [7:0] vtdata,
    output reg vtvalid,
    output vtlast,
    input vtready
);



reg [9:0] wx,wy;

assign vtdata = {wy[3:0],wx[3:0]};
assign vtlast = wy==9 && wx==15;


localparam IDLE = 0,
           INIT = 1, 
           WORK = 2;
localparam pipeLatency = 5;

reg cnt_en,cnt_rstn;
reg [3:0] state;


reg[3:0] init_cnt;
always @ (posedge clk) begin
    if(rst) begin
        state <= 0;
        vtvalid <= 0;
        init_cnt <= 0;
    end
    else begin
        case(state)
            IDLE:begin
                init_cnt <= 0;
                vtvalid <= 0;
                if(start) begin
                    state <= INIT;
                end
            end
            INIT:begin
                    state <= WORK;
                    vtvalid <= 1;
            end
            WORK:begin
                if(vtvalid && vtready && vtlast) begin
                    vtvalid <= 0;
                    state <= IDLE;
                end
            end
        endcase
    end
end
always @ * begin
    case(state) 
        IDLE: begin
            cnt_en = 0;
            cnt_rstn = 0;
        end
        INIT: begin
            cnt_en = 0;
            cnt_rstn = 1;
        end
        WORK: begin
            cnt_en = vtready? 1 : 0;
            cnt_rstn = 1;
        end
        default: begin
            cnt_en = 1'bx;
            cnt_rstn = 1'bx;
        end
    endcase
    
end

always @(posedge clk) begin
    if(!cnt_rstn) begin
        wy <= 0;
        wx <= 0;
    end
    else if(cnt_en) begin
        wx <= (wx==15)? 0 : wx+1;
        if(wx==15)
            wy <= (wy==9)? 0 : wy+1;
    end
end




endmodule

