`timescale 1ns / 1ps

module sim_video_307200
(
    input clk,rst,start,
    output reg [7:0] vtdata,
    output reg vtvalid,
    output reg vtlast,
    input vtready
);

//write logic
reg [7:0] mem [0:307199];
reg [0:0] mem_last [0:307199];
integer i;
initial begin
    $readmemh("./VIDEO.txt",mem);
    for(i=0;i<307200;i=i+1)
        mem_last[i] = 0;
    mem_last[307199] = 1;
end


reg [31:0] rd_addr;
//read logic

reg addr_updata_en;
always @ (posedge clk) begin
    if(rst) begin
        rd_addr <= 0;
    end
    else if(addr_updata_en) begin
        rd_addr <= rd_addr + 1;
    end
end

localparam IDLE = 0,
           INIT = 1, 
           WORK = 2,
           DONE = 3;


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
                    state <= DONE;
                end
            end
        endcase
    end
end

always @ * begin
    case(state) 
        IDLE: begin
            addr_updata_en = 0;
            vtdata = 0;
            vtlast = 0;
        end
        INIT: begin
            addr_updata_en = 0;
            vtdata = 0;
            vtlast = 0;
        end
        WORK: begin
            addr_updata_en = vtready? 1 : 0;
            vtdata = mem[rd_addr];
            vtlast = mem_last[rd_addr];
        end
        default: begin
            addr_updata_en = 1'bx;
            vtdata = 0;
            vtlast = 0;
        end
    endcase
    
end



endmodule

