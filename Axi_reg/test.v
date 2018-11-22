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

parameter DATA_WIDTH = 32;
reg [DATA_WIDTH-1:0]  s_axis_tdata;
reg                   s_axis_tvalid;
wire                   s_axis_tready;
reg                   s_axis_tlast;


wire [DATA_WIDTH-1:0]  m_axis_tdata;
wire                   m_axis_tvalid;
reg                   m_axis_tready;
wire                   m_axis_tlast;


// Inputs
reg clk = 0;
reg rst = 0;



localparam PERIOD=10;//100MHz
localparam Tc2o=1;//clock to output delay
initial begin
    clk = 0;
    forever clk = #(PERIOD/2) ~clk;
end


integer i = 13;
//SLAVE
initial begin
    rst = 1'b1;
    s_axis_tdata = 32'bx;
    s_axis_tvalid = 0;
    s_axis_tlast = 0;
    repeat(5) @(posedge clk);

    repeat(5) @(posedge clk);//for sync with clock;
        rst <= #(Tc2o) 0;
    @(posedge clk) begin
        s_axis_tdata <= #(Tc2o) 1;
        s_axis_tlast <= #(Tc2o) 0;
        s_axis_tvalid <= #(Tc2o) 1;
    end
    #(2) wait(s_axis_tready);
        @(posedge clk) begin
        s_axis_tdata <= #(Tc2o) 2;
        s_axis_tlast <= #(Tc2o) 0;
        s_axis_tvalid <= #(Tc2o) 1;
    end
    #(2) wait(s_axis_tready);
    @(posedge clk) begin
        s_axis_tdata <= #(Tc2o) 3;
        s_axis_tlast <= #(Tc2o) 0;
        s_axis_tvalid <= #(Tc2o) 1;
    end
    #(2) wait(s_axis_tready);
    @(posedge clk) begin
        s_axis_tdata <= #(Tc2o) 4;
        s_axis_tlast <= #(Tc2o) 0;
        s_axis_tvalid <= #(Tc2o) 1;
    end
    #(2) wait(s_axis_tready);
    @(posedge clk) begin
        s_axis_tdata <= #(Tc2o) 5;
        s_axis_tlast <= #(Tc2o) 0;
        s_axis_tvalid <= #(Tc2o) 1;
    end
    #(2) wait(s_axis_tready);
    @(posedge clk) begin
        s_axis_tdata <= #(Tc2o) 6;
        s_axis_tlast <= #(Tc2o) 1;
        s_axis_tvalid <= #(Tc2o) 1;
    end
    
    
    #(2) wait(s_axis_tready);
    @(posedge clk) begin
        s_axis_tdata <= #(Tc2o) 32'ha;
        s_axis_tlast <= #(Tc2o) 0;
        s_axis_tvalid <= #(Tc2o) 1;
    end
    #(2) wait(s_axis_tready);
    @(posedge clk) begin
        s_axis_tdata <= #(Tc2o) 32'hb;
        s_axis_tlast <= #(Tc2o) 0;
        s_axis_tvalid <= #(Tc2o) 1;
    end
    #(2) wait(s_axis_tready);
    @(posedge clk) begin
        s_axis_tdata <= #(Tc2o) 32'hc;
        s_axis_tlast <= #(Tc2o) 1;
        s_axis_tvalid <= #(Tc2o) 1;
    end
    repeat(10) begin
        #(2) wait(s_axis_tready);
        @(posedge clk) begin
            s_axis_tdata <= #(Tc2o) i;
            i=i+1;
            s_axis_tlast <= #(Tc2o) 0;
            s_axis_tvalid <= #(Tc2o) 1;
        end
    end
    repeat(7) begin
        @(posedge clk)
            s_axis_tvalid <= #(Tc2o) 0;
    end
    
    repeat(10) begin
    #(2) wait(s_axis_tready);
    @(posedge clk) begin
        s_axis_tdata <= #(Tc2o) i;
        i=i+1;
        s_axis_tlast <= #(Tc2o) 0;
        s_axis_tvalid <= #(Tc2o) 1;
    end
    end
    @(posedge clk) begin
        s_axis_tvalid <= #(Tc2o) 0;
    end

end

//MASTER
initial begin
    m_axis_tready = 1'b0;
    repeat(15) @(posedge clk);
    repeat(12) @(posedge clk) begin
        m_axis_tready <= #(Tc2o) 1;
    end
    repeat(10) @(posedge clk) begin
        m_axis_tready <= #(Tc2o) 0;
    end
    @(posedge clk)
        m_axis_tready <= #(Tc2o) 1;

end

axis_register #(.REG_TYPE(2) ) uf
(
    .clk(clk),
    .rst(rst),


    //AxiStream Interface
    .m_axis_tready(m_axis_tready),
    .m_axis_tdata(m_axis_tdata),
    .m_axis_tvalid(m_axis_tvalid),
    .m_axis_tlast(m_axis_tlast),



    .s_axis_tvalid(s_axis_tvalid),
    .s_axis_tdata(s_axis_tdata),
    .s_axis_tlast(s_axis_tlast),
    .s_axis_tready(s_axis_tready)
    
);




endmodule
