/*

Copyright (c) 2018 Alex Forencich

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
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
reg [7:0] current_test = 0;

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


localparam PERIOD=10;//100MHz
localparam Tc2o=1;//clock to output delay
initial begin
    clk = 0;
    forever clk = #(PERIOD/2) ~clk;
end

//memory initialization
initial begin
    $readmemh("F:/TEST/Graduation_Rectify/axi_read_test/img.txt",dut.UUT.mem);
end


initial begin
    rst = 1'b1;
    s_axi_awid = 0;
    s_axi_awaddr = 0;
    s_axi_awlen = 0;
    s_axi_awburst = 2'b01;
    s_axi_awsize = 3'b000;
    
    s_axi_awvalid = 0;
    
    s_axi_wstrb = {STRB_WIDTH{1'B1}};
    
    
    #(PERIOD*5);
    @(posedge clk);//for sync with clock;
        rst <= #(Tc2o) 0;
        
    repeat(10) @(posedge clk);
    @(posedge clk);//for sync with clock;
        s_axi_awvalid <= #(Tc2o) 1;
        s_axi_wstrb <= #(Tc2o) 4'b0000;
        s_axi_awsize <= #(Tc2o) 3'b000; //8bit
        s_axi_awaddr <= #(Tc2o) 4;
        s_axi_awlen <= #(Tc2o) 3;//4 length
    wait(s_axi_awready);
    @(posedge clk);
        s_axi_awvalid <= #(Tc2o) 0;
    repeat(14) @(posedge clk);
    @(posedge clk);
        s_axi_wdata <= #(Tc2o) 32'hxxxxxx78;
        s_axi_wstrb <= #(Tc2o) 4'b0001;
        s_axi_wvalid <= #(Tc2o) 1;
        s_axi_wlast <= #(Tc2o) 0;
    wait(s_axi_wready);
    @(posedge clk);
        s_axi_wdata <= #(Tc2o) 32'hxxxx56xx;
        s_axi_wstrb <= #(Tc2o) 4'b0010;
        s_axi_wvalid <= #(Tc2o) 1;
        s_axi_wlast <= #(Tc2o) 0;
    wait(s_axi_wready);
    @(posedge clk);
        s_axi_wdata <= #(Tc2o) 32'hxx34xxxx;
        s_axi_wstrb <= #(Tc2o) 4'b0100;
        s_axi_wvalid <= #(Tc2o) 1;
        s_axi_wlast <= #(Tc2o) 0;
    wait(s_axi_wready);
    @(posedge clk);
        s_axi_wdata <= #(Tc2o) 32'h12xxxxxx;
        s_axi_wstrb <= #(Tc2o) 4'b1000;
        s_axi_wvalid <= #(Tc2o) 1;
        s_axi_wlast <= #(Tc2o) 1;
    wait(s_axi_wready);

    @(posedge clk);
        s_axi_wdata <= #(Tc2o) 32'hC;
        s_axi_wvalid <= #(Tc2o) 0;
        s_axi_wlast <= #(Tc2o) 0;
    repeat(6) @(posedge clk);
    s_axi_bready <= #(Tc2o) 1;

    repeat(10) @(posedge clk);
    @(posedge clk);
        s_axi_arvalid <= #(Tc2o) 1;
        s_axi_araddr = 4;
        s_axi_arlen = 8'd3;
        s_axi_arsize = 3'b000;//8bit
        s_axi_arburst = 2'b01;//INCR
    wait(s_axi_arready);
    @(posedge clk);
        s_axi_arvalid <= #(Tc2o) 0;
    repeat(14) @(posedge clk);
        s_axi_rready = 1;
    
    
end

top dut
(
    .clk(clk),
    .rst(rst),

    //AxiStream Interface
    ._tready(1),
    ._tdata(),
    ._tvalid(),
    . _tlast()
);

endmodule
