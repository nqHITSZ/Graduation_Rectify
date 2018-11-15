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

reg clk_en;
reg [6-1:0]dx,dy;
reg [7:0] lu,ru,ld,rd;
wire [7:0] p;

localparam PERIOD=10;//100MHz
localparam Tc2o=1;//clock to output delay
initial begin
    clk = 0;
    forever clk = #(PERIOD/2) ~clk;
end


initial begin
    rst = 1'b1;
    clk_en = 1;

    repeat(5)@(posedge clk); rst <= #(Tc2o) 0;
        
    @(posedge clk);
        dx <= #(Tc2o) 27;
        dy <= #(Tc2o) 35;
        lu <= #(Tc2o) 2;
        ru <= #(Tc2o) 4;
        ld <= #(Tc2o) 3;
        rd <= #(Tc2o) 4;
    @(posedge clk);
        dx <= #(Tc2o) 15;
        dy <= #(Tc2o) 27;
        lu <= #(Tc2o) 4;
        ru <= #(Tc2o) 6;
        ld <= #(Tc2o) 4;
        rd <= #(Tc2o) 6;
        
        clk_en <= #(Tc2o) 0;
    @(posedge clk);
        dx <= #(Tc2o) 55;
        dy <= #(Tc2o) 2;
        lu <= #(Tc2o) 129;
        ru <= #(Tc2o) 129;
        ld <= #(Tc2o) 138;
        rd <= #(Tc2o) 138;
        clk_en <= #(Tc2o) 1;

 
    
end






interpolator_raw u_interpo
(
    .clk(clk),
    .rst(rst),
    .clk_en(clk_en),
    .dx(dx),
    .dy(dy),
    .lu(lu),
    .ru(ru),
    .ld(ld),
    .rd(rd),
    .p(p)
);



endmodule
