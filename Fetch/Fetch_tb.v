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

reg [9:0] wx,wy;
reg [9:0] rx,ry;
wire signed [9:0] xint,yint;
wire [7:0] lu,ru,ld,rd;
reg w_en;
wire Flast;
wire [7:0] pixel;
assign pixel = {wy[3:0],wx[3:0]};
assign Flast = wy==9 && wx==15;
assign xint = wx>8 ? 2 : 3;
assign yint = wy>4 ? 1 : -2;

initial begin
    rst = 1;
    w_en = 0;
    ry = 0;
    rx = 0;
    repeat(5) @(posedge clk);
    rst <= #(Tc2o) 0;
    repeat(5) @(posedge clk);
    w_en <= #(Tc2o) 1;
    repeat(16*10) @(posedge clk);
    w_en <= #(Tc2o) 0;
    repeat(5) @(posedge clk);
    repeat(35) @(posedge clk) begin
        rx <= #(Tc2o) (rx==6) ? 0 : rx+1;
        if(rx==6)
            ry <= #(Tc2o) (ry==4) ? 0 : ry+1;
    end
 
    
end


always @(posedge clk) begin
    if(rst) begin
        wy <= #(Tc2o) 0;
        wx <= #(Tc2o) 0;
    end
    else if(w_en) begin
        wx <= #(Tc2o) (wx==15)? 0 : wx+1;
        if(wx==15)
            wy <= #(Tc2o) (wy==9)? 0 : wy+1;
    end
end


Fetch 
#(.img_width(16))
uF
(
    .clk(clk),
    .rst(rst),
    .tdata(pixel),
    .tvalid(w_en),
    .Flast(Flast),
    .yint(yint),
    .xint(xint),
    .lu(lu),
    .ru(ru),
    .ld(ld),
    .rd(rd)
);



endmodule

