
`timescale 1 ns / 1 ps

	module myip_v1_0_M_AXI #
	(


		parameter  C_M_TARGET_SLAVE_BASE_ADDR	= 32'h40000000,
		parameter integer C_M_AXI_BURST_LEN	= 16,
		parameter integer C_M_AXI_ID_WIDTH	= 1,
		parameter integer C_M_AXI_ADDR_WIDTH	= 32,
		parameter integer C_M_AXI_DATA_WIDTH	= 32,
		parameter integer C_M_AXI_AWUSER_WIDTH	= 0,
		parameter integer C_M_AXI_ARUSER_WIDTH	= 0,
		parameter integer C_M_AXI_WUSER_WIDTH	= 0,
		parameter integer C_M_AXI_RUSER_WIDTH	= 0,
		parameter integer C_M_AXI_BUSER_WIDTH	= 0
	)
	(

		input wire  INIT_AXI_TXN,
		output wire  TXN_DONE,
		output reg  ERROR,
		input wire  M_AXI_ACLK,
		input wire  M_AXI_ARESETN,
		output wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_AWID,
		output wire [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_AWADDR,
		output wire [7 : 0] M_AXI_AWLEN,
		output wire [2 : 0] M_AXI_AWSIZE,
		output wire [1 : 0] M_AXI_AWBURST,
		output wire  M_AXI_AWLOCK,
		output wire [3 : 0] M_AXI_AWCACHE,
		output wire [2 : 0] M_AXI_AWPROT,
		output wire [3 : 0] M_AXI_AWQOS,
		output wire [C_M_AXI_AWUSER_WIDTH-1 : 0] M_AXI_AWUSER,
		output wire  M_AXI_AWVALID,
		input wire  M_AXI_AWREADY,
		output wire [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_WDATA,
		output wire [C_M_AXI_DATA_WIDTH/8-1 : 0] M_AXI_WSTRB,
		output wire  M_AXI_WLAST,
		output wire [C_M_AXI_WUSER_WIDTH-1 : 0] M_AXI_WUSER,
		output wire  M_AXI_WVALID,
		input wire  M_AXI_WREADY,
		input wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_BID,
		input wire [1 : 0] M_AXI_BRESP,
		input wire [C_M_AXI_BUSER_WIDTH-1 : 0] M_AXI_BUSER,
		input wire  M_AXI_BVALID,
		output wire  M_AXI_BREADY,
		output wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_ARID,
		output wire [C_M_AXI_ADDR_WIDTH-1 : 0] M_AXI_ARADDR,
		output wire [7 : 0] M_AXI_ARLEN,
		output wire [2 : 0] M_AXI_ARSIZE,
		output wire [1 : 0] M_AXI_ARBURST,
		output wire  M_AXI_ARLOCK,
		output wire [3 : 0] M_AXI_ARCACHE,
		output wire [2 : 0] M_AXI_ARPROT,
		output wire [3 : 0] M_AXI_ARQOS,
		output wire [C_M_AXI_ARUSER_WIDTH-1 : 0] M_AXI_ARUSER,
		output wire  M_AXI_ARVALID,
		input wire  M_AXI_ARREADY,
		input wire [C_M_AXI_ID_WIDTH-1 : 0] M_AXI_RID,
		input wire [C_M_AXI_DATA_WIDTH-1 : 0] M_AXI_RDATA,
		input wire [1 : 0] M_AXI_RRESP,
		input wire  M_AXI_RLAST,
		input wire [C_M_AXI_RUSER_WIDTH-1 : 0] M_AXI_RUSER,
		input wire  M_AXI_RVALID,
		output wire  M_AXI_RREADY
	);









