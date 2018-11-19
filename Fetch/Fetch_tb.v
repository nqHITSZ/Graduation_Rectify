`timescale 1ns / 1ps

module test;


reg clk = 0;
reg rst;

localparam PERIOD=10;//100MHz
localparam Tc2o=1;//clock to output delay
initial begin
    clk = 0;
    forever clk = #(PERIOD/2) ~clk;
end


wire [7:0] lu,ru,ld,rd;
reg sv_start,sl_start;

initial begin
    rst = 1;
    sv_start = 0;
    sl_start = 0;

    repeat(5) @(posedge clk);
    rst <= #(Tc2o) 0;
    
    
    repeat(5) @(posedge clk);
    sv_start <= #(Tc2o) 1;
    sl_start <= #(Tc2o) 1;
    @(posedge clk);
    sv_start <= #(Tc2o) 0;
    sl_start <= #(Tc2o) 0;


end



wire [7:0] vtdata;
wire vtvalid;
wire vtlast;
wire vtready;

wire [7:0] ltdata;
wire ltvalid;
wire ltlast;
wire ltready;


Fetch 
#(.img_width(16))
uF
(
    .clk(clk),
    .rst(rst),
    //video interface / AXI stream slave
    .vtvalid(vtvalid),
    .vtdata(vtdata),
    .vtlast(vtlast),
    .vtready(vtready),
    
    //LUT interface / AXI stream slave
    .ltdata(ltdata),
    .ltvalid(ltvalid),
    .ltlast(ltlast),
    .ltready(ltready),
    
    .lu(lu),
    .ru(ru),
    .ld(ld),
    .rd(rd)
);


sim_video sv
(
    .start(sv_start),
    .clk(clk),
    .rst(rst),
    .vtvalid(vtvalid),
    .vtdata(vtdata),
    .vtlast(vtlast),
    .vtready(vtready)
);

sim_lut sl
(
    .start(sl_start),
    .clk(clk),
    .rst(rst),
    .ltdata(ltdata),
    .ltvalid(ltvalid),
    .ltlast(ltlast),
    .ltready(ltready)
);


endmodule

