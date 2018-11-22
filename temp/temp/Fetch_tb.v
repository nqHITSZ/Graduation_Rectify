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
wire ptlast,reclast;

initial begin
    rst = 1;
    sv_start = 0;
    sl_start = 0;

    repeat(5) @(posedge clk);
    rst <= #(Tc2o) 0;
    
    
    repeat(5) @(posedge clk);
    sv_start <= #(Tc2o) 1;
    sl_start <= #(Tc2o) 0;
    @(posedge clk);
    sv_start <= #(Tc2o) 0;
    sl_start <= #(Tc2o) 0;
    repeat(355) @(posedge clk);
    sv_start <= #(Tc2o) 0;
    sl_start <= #(Tc2o) 1;
    @(posedge clk);
    sv_start <= #(Tc2o) 0;
    sl_start <= #(Tc2o) 0;

end



wire [7:0] vtdata;
wire vtvalid;
wire vtlast;
wire vtready;

wire [31:0] ltdata;
wire ltvalid;
wire ltlast;
wire ltready;

wire ptvalid;

wire [7:0]recpixel;
wire recvalid;


wire [9:0] py,px;
wire [5:0] dy,dx;


Fetch 
#(.img_width(640))
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
    .rd(rd),
    .yfrac(dy),
    .xfrac(dx),
    .ptlast(ptlast),
    .ptvalid(ptvalid)
);


interpolator_raw uitp
(
    .clk(clk),
    .rst(rst),
    .clk_en(1),
    .din_valid(ptvalid),
    .din_last(ptlast),
    .dy(dy),
    .dx(dx),
    .lu(lu),
    .ru(ru),
    .ld(ld),
    .rd(rd),
    .dout_valid(recvalid),
    .dout_last(reclast),
    .p(recpixel)

);



sim_video_307200 sv
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


CoordinateGen_2 #(
    .ROW(480),
    .COL(640)
) UCG
(
    .clk(clk),
    .rst(rst),
    .din_valid(ptvalid),
    .col_cnt(px), 
    .row_cnt(py)
);


///////////////////////////// WriteData begin

integer fpWD;
task WriteData;
input [128*8-1:0] filename;
begin
    fpWD = $fopen(filename,"w");
    if (!fpWD)
        $display("Could not open the file");
    else
        $display("Open Successfully\n");
              
    //$fwrite(fpWD,"@0000\n");
    forever begin
        @(posedge clk)
            if(recvalid)
                $fwrite(fpWD,"%d\n",recpixel);
    end
end
endtask


initial begin
    WriteData("./rectified_img.txt");
    #(5*1000000);//5ms
    $fclose(fpWD);
end
///////////////////////////// WriteData end


endmodule

