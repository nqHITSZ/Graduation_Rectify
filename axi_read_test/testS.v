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


reg tready;
reg start;

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
    .clk(clk),
    .rst(rst),
    .start(start),

    //AxiStream Interface
    ._tready(tready),
    ._tdata(),
    ._tvalid(),
    . _tlast()
);

endmodule
