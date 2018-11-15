
`timescale 1 ns / 1 ps

module fetch_v1_0 #
(
    // Parameters of Axi Master Bus Interface M_AXI
    parameter  C_M_AXI_TARGET_SLAVE_BASE_ADDR	= 32'h40000000,
    parameter integer C_M_AXI_BURST_LEN	= 16,
    parameter integer C_M_AXI_ID_WIDTH	= 8,
    parameter integer C_M_AXI_ADDR_WIDTH	= 32,
    parameter integer C_M_AXI_DATA_WIDTH	= 32,
    parameter integer C_M_AXI_AWUSER_WIDTH	= 0,
    parameter integer C_M_AXI_ARUSER_WIDTH	= 0,
    parameter integer C_M_AXI_WUSER_WIDTH	= 0,
    parameter integer C_M_AXI_RUSER_WIDTH	= 0,
    parameter integer C_M_AXI_BUSER_WIDTH	= 0,

    // Parameters of Axi Master Bus Interface M_AXIS
    parameter integer C_M_AXIS_TDATA_WIDTH	= 32,
    parameter integer C_M_AXIS_START_COUNT	= 32
)
(
    input start,
    input wire  m_axi_aclk,
    input wire  m_axi_aresetn,
    
    
    //output reg [C_M_AXI_ID_WIDTH-1:0] m_axi_awid = 0,
    //output reg [C_M_AXI_ADDR_WIDTH-1:0] m_axi_awaddr = 0,
    //output reg [7:0] m_axi_awlen = 0,
    //output reg [2:0] m_axi_awsize = 0,
    //output reg [1:0] m_axi_awburst = 0,
    //output wire  m_axi_awlock,
    //output wire [3 : 0] m_axi_awcache,
    //output wire [2 : 0] m_axi_awprot,
    //output wire [3 : 0] m_axi_awqos,
    //output reg m_axi_awvalid = 0,
    //output reg [C_M_AXI_DATA_WIDTH-1:0] m_axi_wdata = 0,
    //output reg [C_M_AXI_DATA_WIDTH/8-1:0] m_axi_wstrb = 0,
    //output reg m_axi_wlast = 0,
    //output reg m_axi_wvalid = 0,
    //output reg m_axi_bready = 0,
    output reg [C_M_AXI_ID_WIDTH-1:0] m_axi_arid = 0,
    output reg [C_M_AXI_ADDR_WIDTH-1:0] m_axi_araddr = 0,
    output reg [7:0] m_axi_arlen = 0,
    output reg [2:0] m_axi_arsize = 0,
    output reg [1:0] m_axi_arburst = 0,
    output reg m_axi_arlock = 0,
    output reg [3:0] m_axi_arcache = 0,
    output reg [2:0] m_axi_arprot = 0,

    output reg m_axi_arvalid,
    output wire m_axi_rready,
    
    //input wire m_axi_awready,
    //input wire m_axi_wready,
    //input wire [C_M_AXI_ID_WIDTH-1:0] m_axi_bid,
    //input wire [1:0] m_axi_bresp,
    //input wire m_axi_bvalid,
    input wire m_axi_arready,
    input wire [C_M_AXI_ID_WIDTH-1:0] m_axi_rid,
    input wire [C_M_AXI_DATA_WIDTH-1:0] m_axi_rdata,
    input wire [1:0] m_axi_rresp,
    input wire m_axi_rlast,
    input wire m_axi_rvalid,
    // Ports of Axi Master Bus Interface M_AXIS
    input wire  m_axis_aclk,
    input wire  m_axis_aresetn,
    output wire  m_axis_tvalid,
    output wire [C_M_AXIS_TDATA_WIDTH-1 : 0] m_axis_tdata,
    //output wire [(C_M_AXIS_TDATA_WIDTH/8)-1 : 0] m_axis_tstrb,
    output wire  m_axis_tlast,
    input wire  m_axis_tready
);







localparam [3:0] IDEL = 0,
                 READ_ADDR = 1,
                 READ_DATA = 2,
                 TRANmm_axis_tDATA = 3,
                 DONE = 4;

//wire [1:0] lane_add_next,
//assign lane_add_next = lane + 1, // (lane==3)? 0 : lane + 1,
reg [3:0] state;
always @(posedge m_axi_aclk)
    if(!m_axi_aresetn) begin
        state <= IDEL;
        m_axi_arvalid <=  0;
        m_axi_araddr <= 0;
        m_axi_arlen <= 8'd1;
        m_axi_arsize <= 3'b000;//8bit
        m_axi_arburst <= 2'b01;//INCR
    end
    else begin

        case(state)
            IDEL: begin
                if(start)
                    state <= READ_ADDR;
            end
            READ_ADDR: begin
                m_axi_arsize <= 3'b010;//32bit
                m_axi_arlen <= 8'd5;
                m_axi_arvalid <=  1;
                m_axi_araddr <= 0;
                //m_axi_rready <= 0;
                if(m_axi_arvalid && m_axi_arready) begin
                    m_axi_arvalid <= 0;
                    state <= READ_DATA;
                    //m_axi_rready <= 1;
                end
            end
            READ_DATA: begin
                if(m_axis_tvalid && m_axis_tready && m_axis_tlast) begin
                    state <= DONE;
                end
            end
            DONE: begin
                state <= IDEL;
            end

        endcase
    end


assign m_axis_tdata =   m_axi_rdata;
assign m_axis_tlast=   m_axi_rlast;
assign m_axis_tvalid = m_axi_rvalid;
assign m_axi_rready = m_axis_tready;


endmodule
