`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: HITSZ
// Engineer: NQ
// 
// Create Date: 2018/11/09 19:25:29
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


module  coor_warper #
(
    parameter ROW = 4,
    parameter COL = 6
)
(
    input start,
    // Ports of Axi Master Bus Interface M_AXIS
    input wire  m_axis_aclk,
    input wire  m_axis_aresetn,
    output reg  m_axis_tvalid,
    output reg [31 : 0] m_axis_tdata,
    output reg  m_axis_tlast,
    input wire  m_axis_tready
);
localparam IDLE = 0,
           INIT = 1, 
           WORK = 2;
localparam pipeLatency = 5;
reg [9:0] col_cnt; 
reg [9:0] row_cnt;
reg cnt_en,cnt_rstn;
reg [3:0] state;


reg[3:0] init_cnt;
always @ (posedge m_axis_aclk) begin
    if(~m_axis_aresetn) begin
        state <= 0;
        m_axis_tvalid <= 0;
        init_cnt <= 0;
    end
    else begin
        case(state)
            IDLE:begin
                init_cnt <= 0;
                m_axis_tvalid <= 0;
                if(start) begin
                    state <= INIT;
                end
            end
            INIT:begin
                init_cnt <= init_cnt + 1;
                if(init_cnt == 5) begin
                    state <= WORK;
                    m_axis_tvalid <= 1;
                end
            end
            WORK:begin
                if(m_axis_tvalid && m_axis_tready && m_axis_tlast) begin
                    m_axis_tvalid <= 0;
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
            cnt_en = 1;
            cnt_rstn = 1;
        end
        WORK: begin
            cnt_en = m_axis_tready? 1 : 0;
            cnt_rstn = 1;
        end
        default: begin
            cnt_en = 1'bx;
            cnt_rstn = 1'bx;
        end
    endcase
    
end


always @ (posedge m_axis_aclk) begin
    if(!cnt_rstn)
        col_cnt <= 0;
    else if(cnt_en)
        col_cnt <= (col_cnt==COL-1) ? 0 : col_cnt + 1;
end

always @ (posedge m_axis_aclk) begin
    if(!cnt_rstn)
        row_cnt <= 0;
    else if(cnt_en)
        if(col_cnt==COL-1)
            row_cnt <= (row_cnt==ROW-1) ? 0 : row_cnt + 1;
end






reg [31:0] data_delay[pipeLatency-1:0];
integer i;
always @(posedge m_axis_aclk) begin
    if(cnt_en) begin
        for(i=0; i<pipeLatency-1; i=i+1)
            data_delay[i+1] <= data_delay[i];
        data_delay[0] <= row_cnt*COL + col_cnt;
    end
end

always @ (posedge m_axis_aclk) begin
    if(~m_axis_aresetn) begin
        m_axis_tdata <= 0;
        m_axis_tlast <= 0;
    end
    else if(cnt_en) begin
        m_axis_tdata <= data_delay[pipeLatency-1];
        m_axis_tlast <= data_delay[pipeLatency-1] == (ROW*COL-1);
    end
end


endmodule
