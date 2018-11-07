`timescale 1ns / 1ps

module top
(
    input clk, rst,
    input _tready,
    //AxiStream Interface
    output reg [7:0]_tdata,
    output reg _tvalid, _tlast
);

// Parameters
parameter DATA_WIDTH = 32;
parameter ADDR_WIDTH = 16;
parameter STRB_WIDTH = (DATA_WIDTH/8);
parameter ID_WIDTH = 8;

// Inputs

reg [ID_WIDTH-1:0] s_axi_awid = 0;
reg [ADDR_WIDTH-1:0] s_axi_awaddr = 0;
reg [7:0] s_axi_awlen = 0;
reg [2:0] s_axi_awsize = 0;
reg [1:0] s_axi_awburst = 0;

reg s_axi_awvalid = 0;
reg [DATA_WIDTH-1:0] s_axi_wdata = 0;
reg [STRB_WIDTH-1:0] s_axi_wstrb = 0;
reg s_axi_wlast = 0;
reg s_axi_wvalid = 0;
reg s_axi_bready = 0;
reg [ID_WIDTH-1:0] s_axi_arid = 0;
reg [ADDR_WIDTH-1:0] s_axi_araddr = 0;
reg [7:0] s_axi_arlen = 0;
reg [2:0] s_axi_arsize = 0;
reg [1:0] s_axi_arburst = 0;
reg s_axi_arlock = 0;
reg [3:0] s_axi_arcache = 0;
reg [2:0] s_axi_arprot = 0;
reg s_axi_arvalid = 0;
reg s_axi_rready = 0;

// Outputs
wire s_axi_awready;
wire s_axi_wready;
wire [ID_WIDTH-1:0] s_axi_bid;
wire [1:0] s_axi_bresp;
wire s_axi_bvalid;
wire s_axi_arready;
wire [ID_WIDTH-1:0] s_axi_rid;
wire [DATA_WIDTH-1:0] s_axi_rdata;
wire [1:0] s_axi_rresp;
wire s_axi_rlast;
wire s_axi_rvalid;

localparam [3:0] IDEL = 0,
                 READ_ADDR = 1,
                 READ_DATA = 2,
                 TRANS_TDATA = 3;

reg [3:0] state;
always @(posedge clk)
    if(rst) begin
        state <= IDEL;
        s_axi_arvalid <=  0;
        s_axi_araddr <= 0;
        s_axi_arlen <= 8'd1;
        s_axi_arsize <= 3'b000;//8bit
        s_axi_arburst <= 2'b01;//INCR
        s_axi_rready = 0;
        _tdata = 0;
        _tvalid = 0;
        _tlast = 0;
    end
    else begin
        case(state)
            IDEL: begin
                state <= READ_ADDR;
            end
            READ_ADDR: begin
                s_axi_arvalid <=  1;
                s_axi_araddr <= 0;
                s_axi_rready <= 0;
                if(s_axi_arvalid && s_axi_arready) begin
                    state <= READ_DATA;
                    s_axi_arvalid <= 0; 
                    s_axi_rready <= 1;
                end
            end
            READ_DATA: begin
                s_axi_arvalid <=  0;
                s_axi_araddr <= 0;
                s_axi_rready <= 1;
                if(s_axi_rvalid && s_axi_rready) begin
                    state <= TRANS_TDATA;
                    s_axi_rready <= 0;
                    _tdata <= s_axi_rdata[7:0];
                    _tvalid <= 1;
                    _tlast <= 1;
                end
            end
            TRANS_TDATA: begin
                if(_tvalid && _tready) begin
                    _tvalid <= 0;
                    _tlast <= 0;
                    _tdata <= 8'bx;
                end




            end

        endcase
    end


axi_ram #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .STRB_WIDTH(STRB_WIDTH),
    .ID_WIDTH(ID_WIDTH)
)
UUT (
    .clk(clk),
    .rst(rst),
    .s_axi_awid(s_axi_awid),
    .s_axi_awaddr(s_axi_awaddr),
    .s_axi_awlen(s_axi_awlen),
    .s_axi_awsize(s_axi_awsize),
    .s_axi_awburst(s_axi_awburst),
    .s_axi_awlock(0),
    .s_axi_awcache(0),
    .s_axi_awprot(0),
    .s_axi_awvalid(s_axi_awvalid),
    .s_axi_awready(s_axi_awready),
    
    .s_axi_wdata(s_axi_wdata),
    .s_axi_wstrb(s_axi_wstrb),
    .s_axi_wlast(s_axi_wlast),
    .s_axi_wvalid(s_axi_wvalid),
    .s_axi_wready(s_axi_wready),
    
    .s_axi_bid(s_axi_bid),
    .s_axi_bresp(s_axi_bresp),
    .s_axi_bvalid(s_axi_bvalid),
    .s_axi_bready(s_axi_bready),
    
    .s_axi_arid(s_axi_arid),
    .s_axi_araddr(s_axi_araddr),
    .s_axi_arlen(s_axi_arlen),
    .s_axi_arsize(s_axi_arsize),
    .s_axi_arburst(s_axi_arburst),
    .s_axi_arlock(s_axi_arlock),
    .s_axi_arcache(s_axi_arcache),
    .s_axi_arprot(s_axi_arprot),
    .s_axi_arvalid(s_axi_arvalid),
    .s_axi_arready(s_axi_arready),
    .s_axi_rid(s_axi_rid),
    .s_axi_rdata(s_axi_rdata),
    .s_axi_rresp(s_axi_rresp),
    .s_axi_rlast(s_axi_rlast),
    .s_axi_rvalid(s_axi_rvalid),
    .s_axi_rready(s_axi_rready)
);

endmodule

