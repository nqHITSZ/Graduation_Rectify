
`timescale 1 ns / 1 ps

module fetch #
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
    output wire [3:0]  state_out,
    
    output reg [C_M_AXI_ID_WIDTH-1:0] m_axi_arid = 0, 
    output reg [C_M_AXI_ADDR_WIDTH-1:0] m_axi_araddr = 0,
    output reg [7:0] m_axi_arlen = 0,
    output reg [2:0] m_axi_arsize = 0,
    output reg [1:0] m_axi_arburst = 0,
    output reg m_axi_arlock = 0,
    output reg [3:0] m_axi_arcache = 0,
    output reg [2:0] m_axi_arprot = 0,

    output reg m_axi_arvalid,
    output reg m_axi_rready,
    
    input wire m_axi_arready,
    input wire [C_M_AXI_ID_WIDTH-1:0] m_axi_rid,
    input wire [C_M_AXI_DATA_WIDTH-1:0] m_axi_rdata,
    input wire [1:0] m_axi_rresp,
    input wire m_axi_rlast,
    input wire m_axi_rvalid,
    // Ports of Axi Master Bus Interface M_AXIS
    input wire  m_axis_aclk,
    input wire  m_axis_aresetn,
    output reg  m_axis_tvalid,
    output wire [C_M_AXIS_TDATA_WIDTH-1 : 0] m_axis_tdata,
    //output wire [(C_M_AXIS_TDATA_WIDTH/8)-1 : 0] m_axis_tstrb,
    output wire  m_axis_tlast,
    input wire  m_axis_tready,
    // Ports of Axi Master Bus Interface M_AXIS
    input wire  s_axis_aclk,
    input wire  s_axis_aresetn,
    input wire  s_axis_tvalid,
    input wire [C_M_AXIS_TDATA_WIDTH-1 : 0] s_axis_tdata,
    input wire  s_axis_tlast,
    output reg s_axis_tready
);







localparam [3:0] IDEL = 0,
                 READ_ADDR = 1,
                 READ_DATA = 2,
                 READ_DATA_2 = 3,
                 TRAN_DATA = 4,
                 DONE = 5;

//wire [1:0] lane_add_next,
//assign lane_add_next = lane + 1, // (lane==3)? 0 : lane + 1,
reg [31:0] data_buf;
reg [3:0] state;
always @(posedge m_axi_aclk)
    if(!m_axi_aresetn) begin
        state <= IDEL;
        m_axi_arvalid <=  0;
        m_axi_araddr <= C_M_AXI_TARGET_SLAVE_BASE_ADDR;
        m_axi_arlen <= 8'd1;
        m_axi_arsize <= 3'b000;//8bit
        m_axi_arburst <= 2'b01;//INCR
        s_axis_tready <= 0;
        m_axi_rready <= 0;
        data_buf <= 32'bx;
    end
    else begin
        case(state)
            IDEL: begin
                if(start) begin
                    m_axi_arsize <= 3'b010;//32bit
                    m_axi_arlen <= 8'd0;
                    s_axis_tready <= 1;
                    m_axis_tvalid <= 0;
                    state <= READ_ADDR;
                end
            end
            READ_ADDR: begin
                if(s_axis_tvalid && s_axis_tready) begin
                    m_axi_arvalid <= 1;
                    s_axis_tready <= 0;
                    m_axi_araddr <= s_axis_tdata;//note: the data must be decode to address
                end
                if(m_axi_arvalid && m_axi_arready) begin
                    m_axi_arvalid <= 1;
                    m_axi_araddr <= m_axi_araddr + 4;//note: the data must be decode to address
                    //m_axi_arvalid <= 0;
                    //m_axi_araddr <= m_axi_araddr;//note: the data must be decode to address
                    m_axi_rready <= 1;//can receive imgage data into data_buf
                    state <= READ_DATA;
                end
            end
            READ_DATA: begin
                if(m_axi_rvalid && m_axi_rready) begin
                    data_buf[15:0] <= m_axi_rdata[15:0];
                //    state <= READ_ADDR_2;
                    s_axis_tready <= 0;
                    state <= READ_DATA_2;

                    //m_axi_arvalid <= 1;
                    //m_axi_araddr <= m_axi_araddr + 4;//note: the data must be decode to address
                end
                if(m_axi_arvalid && m_axi_arready) begin
                    m_axi_arvalid <= 0;
                    m_axi_araddr <= 32'bx;//note: the data must be decode to address
                    m_axi_rready <= 1;//can receive imgage data into data_buf
                end
            end
            READ_DATA_2: begin
                if(m_axi_rvalid && m_axi_rready) begin
                    data_buf[31:16] <= m_axi_rdata[15:0];
                    m_axis_tvalid <= 1;
                    s_axis_tready <= 1;
                    m_axi_rready <= 0;
                end
                if(m_axis_tvalid && m_axis_tready) begin
                    m_axis_tvalid <= 0;
                    m_axi_rready <= 1;
                    state <= READ_ADDR;
                end
                if(m_axi_arvalid && m_axi_arready) begin
                    m_axi_arvalid <= 0;
                    m_axi_araddr <= 32'bx;//note: the data must be decode to address
                    m_axi_rready <= 1;//can receive imgage data into data_buf
                end
            end
            DONE: begin
                state <= IDEL;
            end

        endcase
    end



assign m_axis_tdata = data_buf;
//assign m_axis_tlast=   m_axi_rlast;
//assign m_axis_tvalid = m_axi_rvalid;
//assign m_axi_rready = m_axis_tready;
assign state_out = state;

endmodule

