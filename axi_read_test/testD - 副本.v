/*

Copyright (c) 2018 Alex Forencich

Permission is hereby granted; free of charge; to any person obtaining a copy
of this software and associated documentation files (the "Software"); to deal
in the Software without restriction; including without limitation the rights
to use; copy; modify; merge; publish; distribute; sublicense; and/or sell
copies of the Software; and to permit persons to whom the Software is
furnished to do so; subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS"; WITHOUT WARRANTY OF ANY KIND; EXPRESS OR
IMPLIED; INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM; DAMAGES OR OTHER
LIABILITY; WHETHER IN AN ACTION OF CONTRACT; TORT OR OTHERWISE; ARISING FROM;
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/

// Language: Verilog 2001

`timescale 1ns / 1ps

/*
 * Testbench for axi_ram
 */
module test;


// Parameters
parameter DATA_WIDTH = 32;
parameter ADDR_WIDTH = 16;
parameter STRB_WIDTH = (DATA_WIDTH/8);
parameter ID_WIDTH = 8;

// Inputs
reg clk = 0;
reg rst = 0;

//AxiStream Interface
wire [31:0]m_axis_tdata;
wire m_axis_tlast;
wire m_axis_tvalid;
reg tready;
//Axi
wire [ID_WIDTH-1:0] s_axi_awid;
wire [ADDR_WIDTH-1:0] s_axi_awaddr;
wire [7:0] s_axi_awlen;
wire [2:0] s_axi_awsize;
wire [1:0] s_axi_awburst;

wire s_axi_awvalid;
wire [DATA_WIDTH-1:0] s_axi_wdata;
wire [STRB_WIDTH-1:0] s_axi_wstrb;
wire s_axi_wlast;
wire s_axi_wvalid;
wire s_axi_bready;
wire [ID_WIDTH-1:0] s_axi_arid;
wire [ADDR_WIDTH-1:0] s_axi_araddr;
wire [7:0] s_axi_arlen;
wire [2:0] s_axi_arsize;
wire [1:0] s_axi_arburst;
wire s_axi_arlock;
wire [3:0] s_axi_arcache;
wire [2:0] s_axi_arprot;
wire s_axi_arvalid;
wire  s_axi_rready;

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


reg start;

localparam PERIOD=10;//100MHz
localparam Tc2o=1;//clock to output delay
initial begin
    clk = 0;
    forever clk = #(PERIOD/2) ~clk;
end

//memory initialization
initial begin
    $readmemh("F:/TEST/Graduation_Rectify/axi_read_test/img.txt", UUT.mem);
end


initial begin
    rst = 1'b1;
    tready = 0;
    start = 1;
 
    
    #(PERIOD*5);
    @(posedge clk);//for sync with clock;
        rst <= #(Tc2o) 0;
    repeat(50) @(posedge clk);
        tready <= #(Tc2o) 1;
    repeat(2) @(posedge clk);
        tready <= #(Tc2o) 0;
    repeat(2) @(posedge clk);
        tready <= #(Tc2o) 1;
 
    
end


top dut
(
    .aclk(clk),
    .aresetn(!rst),
    .start(start),

    //AxiStream Interface
    .m_axis_tready(tready),
    .m_axis_tdata(m_axis_tdata),
    .m_axis_tvalid(m_axis_tvalid),
    . m_axis_tlast(m_axis_tlast),
    
    //Axi
    .m_axi_awid(s_axi_awid),
    .m_axi_awaddr(s_axi_awaddr),
    .m_axi_awlen(s_axi_awlen),
    .m_axi_awsize(s_axi_awsize),
    .m_axi_awburst(s_axi_awburst),
     
    .m_axi_awvalid(s_axi_awvalid),
    .m_axi_awready(s_axi_awready),
     
    .m_axi_wdata(s_axi_wdata),
    .m_axi_wstrb(s_axi_wstrb),
    .m_axi_wlast(s_axi_wlast),
    .m_axi_wvalid(s_axi_wvalid),
    .m_axi_wready(s_axi_wready),
    
    .m_axi_bid(s_axi_bid),
    .m_axi_bresp(s_axi_bresp),
    .m_axi_bvalid(s_axi_bvalid),
    .m_axi_bready(s_axi_bready),
    
    .m_axi_arid(s_axi_arid),
    .m_axi_araddr(s_axi_araddr),
    .m_axi_arlen(s_axi_arlen),
    .m_axi_arsize(s_axi_arsize),
    .m_axi_arburst(s_axi_arburst),
    .m_axi_arlock(s_axi_arlock),
    .m_axi_arcache(s_axi_arcache),
    .m_axi_arprot(s_axi_arprot),
    .m_axi_arvalid(s_axi_arvalid),
    .m_axi_arready(s_axi_arready),
    .m_axi_rid(s_axi_rid),
    .m_axi_rdata(s_axi_rdata),
    .m_axi_rresp(s_axi_rresp),
    .m_axi_rlast(s_axi_rlast),
    .m_axi_rvalid(s_axi_rvalid),
    .m_axi_rready(s_axi_rready)
    
);


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
