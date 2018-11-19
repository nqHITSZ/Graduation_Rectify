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

reg clk = 0;
reg rst = 0;
reg m_axis_tready;
reg start;

localparam PERIOD=10;//100MHz
localparam Tc2o=1;//clock to output delay
initial begin
    clk = 0;
    forever clk = #(PERIOD/2) ~clk;
end


initial begin
    rst = 1'b1;
    m_axis_tready = 0;
    start = 0;
    
    #(PERIOD*5);
    @(posedge clk);//for sync with clock;
        rst <= #(Tc2o) 0;
    repeat(3) @(posedge clk);
        start <= #(Tc2o) 1;
        
    repeat(10) @(posedge clk);
        m_axis_tready <= #(Tc2o) 1;
    repeat(3) @(posedge clk);
        m_axis_tready <= #(Tc2o) 0;
    repeat(1) @(posedge clk);
        m_axis_tready <= #(Tc2o) 1;
    repeat(1) @(posedge clk);
        m_axis_tready <= #(Tc2o) 0;
    repeat(1) @(posedge clk);
        m_axis_tready <= #(Tc2o) 1;
    
    
end

sim_video
dut
(
    .start(start),
    // Ports of Axi Master Bus Interface M_AXIS
    .clk(clk),
    .rst(rst),
    .vtvalid(),
    .vtdata(),
    .vtlast(),
    .vtready(m_axis_tready)
);

endmodule
