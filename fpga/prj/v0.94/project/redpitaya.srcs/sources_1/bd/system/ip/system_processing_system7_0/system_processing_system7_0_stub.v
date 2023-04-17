// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
// Date        : Mon Nov 16 15:07:44 2020
// Host        : DESKTOP-A6CUJVB running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/travi/Desktop/FPGA_Research/Code/RedPitaya-master/fpga/prj/v0.94/project/redpitaya.srcs/sources_1/bd/system/ip/system_processing_system7_0/system_processing_system7_0_stub.v
// Design      : system_processing_system7_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "processing_system7_v5_5_processing_system7,Vivado 2020.1" *)
module system_processing_system7_0(GPIO_I, GPIO_O, GPIO_T, SPI0_SCLK_I, SPI0_SCLK_O, 
  SPI0_SCLK_T, SPI0_MOSI_I, SPI0_MOSI_O, SPI0_MOSI_T, SPI0_MISO_I, SPI0_MISO_O, SPI0_MISO_T, 
  SPI0_SS_I, SPI0_SS_O, SPI0_SS1_O, SPI0_SS2_O, SPI0_SS_T, TTC0_WAVE0_OUT, TTC0_WAVE1_OUT, 
  TTC0_WAVE2_OUT, USB0_PORT_INDCTL, USB0_VBUS_PWRSELECT, USB0_VBUS_PWRFAULT, 
  M_AXI_GP0_ARVALID, M_AXI_GP0_AWVALID, M_AXI_GP0_BREADY, M_AXI_GP0_RREADY, 
  M_AXI_GP0_WLAST, M_AXI_GP0_WVALID, M_AXI_GP0_ARID, M_AXI_GP0_AWID, M_AXI_GP0_WID, 
  M_AXI_GP0_ARBURST, M_AXI_GP0_ARLOCK, M_AXI_GP0_ARSIZE, M_AXI_GP0_AWBURST, 
  M_AXI_GP0_AWLOCK, M_AXI_GP0_AWSIZE, M_AXI_GP0_ARPROT, M_AXI_GP0_AWPROT, M_AXI_GP0_ARADDR, 
  M_AXI_GP0_AWADDR, M_AXI_GP0_WDATA, M_AXI_GP0_ARCACHE, M_AXI_GP0_ARLEN, M_AXI_GP0_ARQOS, 
  M_AXI_GP0_AWCACHE, M_AXI_GP0_AWLEN, M_AXI_GP0_AWQOS, M_AXI_GP0_WSTRB, M_AXI_GP0_ACLK, 
  M_AXI_GP0_ARREADY, M_AXI_GP0_AWREADY, M_AXI_GP0_BVALID, M_AXI_GP0_RLAST, 
  M_AXI_GP0_RVALID, M_AXI_GP0_WREADY, M_AXI_GP0_BID, M_AXI_GP0_RID, M_AXI_GP0_BRESP, 
  M_AXI_GP0_RRESP, M_AXI_GP0_RDATA, M_AXI_GP1_ARVALID, M_AXI_GP1_AWVALID, M_AXI_GP1_BREADY, 
  M_AXI_GP1_RREADY, M_AXI_GP1_WLAST, M_AXI_GP1_WVALID, M_AXI_GP1_ARID, M_AXI_GP1_AWID, 
  M_AXI_GP1_WID, M_AXI_GP1_ARBURST, M_AXI_GP1_ARLOCK, M_AXI_GP1_ARSIZE, M_AXI_GP1_AWBURST, 
  M_AXI_GP1_AWLOCK, M_AXI_GP1_AWSIZE, M_AXI_GP1_ARPROT, M_AXI_GP1_AWPROT, M_AXI_GP1_ARADDR, 
  M_AXI_GP1_AWADDR, M_AXI_GP1_WDATA, M_AXI_GP1_ARCACHE, M_AXI_GP1_ARLEN, M_AXI_GP1_ARQOS, 
  M_AXI_GP1_AWCACHE, M_AXI_GP1_AWLEN, M_AXI_GP1_AWQOS, M_AXI_GP1_WSTRB, M_AXI_GP1_ACLK, 
  M_AXI_GP1_ARREADY, M_AXI_GP1_AWREADY, M_AXI_GP1_BVALID, M_AXI_GP1_RLAST, 
  M_AXI_GP1_RVALID, M_AXI_GP1_WREADY, M_AXI_GP1_BID, M_AXI_GP1_RID, M_AXI_GP1_BRESP, 
  M_AXI_GP1_RRESP, M_AXI_GP1_RDATA, S_AXI_HP0_ARREADY, S_AXI_HP0_AWREADY, S_AXI_HP0_BVALID, 
  S_AXI_HP0_RLAST, S_AXI_HP0_RVALID, S_AXI_HP0_WREADY, S_AXI_HP0_BRESP, S_AXI_HP0_RRESP, 
  S_AXI_HP0_BID, S_AXI_HP0_RID, S_AXI_HP0_RDATA, S_AXI_HP0_RCOUNT, S_AXI_HP0_WCOUNT, 
  S_AXI_HP0_RACOUNT, S_AXI_HP0_WACOUNT, S_AXI_HP0_ACLK, S_AXI_HP0_ARVALID, 
  S_AXI_HP0_AWVALID, S_AXI_HP0_BREADY, S_AXI_HP0_RDISSUECAP1_EN, S_AXI_HP0_RREADY, 
  S_AXI_HP0_WLAST, S_AXI_HP0_WRISSUECAP1_EN, S_AXI_HP0_WVALID, S_AXI_HP0_ARBURST, 
  S_AXI_HP0_ARLOCK, S_AXI_HP0_ARSIZE, S_AXI_HP0_AWBURST, S_AXI_HP0_AWLOCK, 
  S_AXI_HP0_AWSIZE, S_AXI_HP0_ARPROT, S_AXI_HP0_AWPROT, S_AXI_HP0_ARADDR, S_AXI_HP0_AWADDR, 
  S_AXI_HP0_ARCACHE, S_AXI_HP0_ARLEN, S_AXI_HP0_ARQOS, S_AXI_HP0_AWCACHE, S_AXI_HP0_AWLEN, 
  S_AXI_HP0_AWQOS, S_AXI_HP0_ARID, S_AXI_HP0_AWID, S_AXI_HP0_WID, S_AXI_HP0_WDATA, 
  S_AXI_HP0_WSTRB, S_AXI_HP1_ARREADY, S_AXI_HP1_AWREADY, S_AXI_HP1_BVALID, S_AXI_HP1_RLAST, 
  S_AXI_HP1_RVALID, S_AXI_HP1_WREADY, S_AXI_HP1_BRESP, S_AXI_HP1_RRESP, S_AXI_HP1_BID, 
  S_AXI_HP1_RID, S_AXI_HP1_RDATA, S_AXI_HP1_RCOUNT, S_AXI_HP1_WCOUNT, S_AXI_HP1_RACOUNT, 
  S_AXI_HP1_WACOUNT, S_AXI_HP1_ACLK, S_AXI_HP1_ARVALID, S_AXI_HP1_AWVALID, 
  S_AXI_HP1_BREADY, S_AXI_HP1_RDISSUECAP1_EN, S_AXI_HP1_RREADY, S_AXI_HP1_WLAST, 
  S_AXI_HP1_WRISSUECAP1_EN, S_AXI_HP1_WVALID, S_AXI_HP1_ARBURST, S_AXI_HP1_ARLOCK, 
  S_AXI_HP1_ARSIZE, S_AXI_HP1_AWBURST, S_AXI_HP1_AWLOCK, S_AXI_HP1_AWSIZE, 
  S_AXI_HP1_ARPROT, S_AXI_HP1_AWPROT, S_AXI_HP1_ARADDR, S_AXI_HP1_AWADDR, 
  S_AXI_HP1_ARCACHE, S_AXI_HP1_ARLEN, S_AXI_HP1_ARQOS, S_AXI_HP1_AWCACHE, S_AXI_HP1_AWLEN, 
  S_AXI_HP1_AWQOS, S_AXI_HP1_ARID, S_AXI_HP1_AWID, S_AXI_HP1_WID, S_AXI_HP1_WDATA, 
  S_AXI_HP1_WSTRB, IRQ_F2P, FCLK_CLK0, FCLK_CLK1, FCLK_CLK2, FCLK_CLK3, FCLK_RESET0_N, 
  FCLK_RESET1_N, FCLK_RESET2_N, FCLK_RESET3_N, MIO, DDR_CAS_n, DDR_CKE, DDR_Clk_n, DDR_Clk, 
  DDR_CS_n, DDR_DRSTB, DDR_ODT, DDR_RAS_n, DDR_WEB, DDR_BankAddr, DDR_Addr, DDR_VRN, DDR_VRP, DDR_DM, 
  DDR_DQ, DDR_DQS_n, DDR_DQS, PS_SRSTB, PS_CLK, PS_PORB)
/* synthesis syn_black_box black_box_pad_pin="GPIO_I[23:0],GPIO_O[23:0],GPIO_T[23:0],SPI0_SCLK_I,SPI0_SCLK_O,SPI0_SCLK_T,SPI0_MOSI_I,SPI0_MOSI_O,SPI0_MOSI_T,SPI0_MISO_I,SPI0_MISO_O,SPI0_MISO_T,SPI0_SS_I,SPI0_SS_O,SPI0_SS1_O,SPI0_SS2_O,SPI0_SS_T,TTC0_WAVE0_OUT,TTC0_WAVE1_OUT,TTC0_WAVE2_OUT,USB0_PORT_INDCTL[1:0],USB0_VBUS_PWRSELECT,USB0_VBUS_PWRFAULT,M_AXI_GP0_ARVALID,M_AXI_GP0_AWVALID,M_AXI_GP0_BREADY,M_AXI_GP0_RREADY,M_AXI_GP0_WLAST,M_AXI_GP0_WVALID,M_AXI_GP0_ARID[11:0],M_AXI_GP0_AWID[11:0],M_AXI_GP0_WID[11:0],M_AXI_GP0_ARBURST[1:0],M_AXI_GP0_ARLOCK[1:0],M_AXI_GP0_ARSIZE[2:0],M_AXI_GP0_AWBURST[1:0],M_AXI_GP0_AWLOCK[1:0],M_AXI_GP0_AWSIZE[2:0],M_AXI_GP0_ARPROT[2:0],M_AXI_GP0_AWPROT[2:0],M_AXI_GP0_ARADDR[31:0],M_AXI_GP0_AWADDR[31:0],M_AXI_GP0_WDATA[31:0],M_AXI_GP0_ARCACHE[3:0],M_AXI_GP0_ARLEN[3:0],M_AXI_GP0_ARQOS[3:0],M_AXI_GP0_AWCACHE[3:0],M_AXI_GP0_AWLEN[3:0],M_AXI_GP0_AWQOS[3:0],M_AXI_GP0_WSTRB[3:0],M_AXI_GP0_ACLK,M_AXI_GP0_ARREADY,M_AXI_GP0_AWREADY,M_AXI_GP0_BVALID,M_AXI_GP0_RLAST,M_AXI_GP0_RVALID,M_AXI_GP0_WREADY,M_AXI_GP0_BID[11:0],M_AXI_GP0_RID[11:0],M_AXI_GP0_BRESP[1:0],M_AXI_GP0_RRESP[1:0],M_AXI_GP0_RDATA[31:0],M_AXI_GP1_ARVALID,M_AXI_GP1_AWVALID,M_AXI_GP1_BREADY,M_AXI_GP1_RREADY,M_AXI_GP1_WLAST,M_AXI_GP1_WVALID,M_AXI_GP1_ARID[11:0],M_AXI_GP1_AWID[11:0],M_AXI_GP1_WID[11:0],M_AXI_GP1_ARBURST[1:0],M_AXI_GP1_ARLOCK[1:0],M_AXI_GP1_ARSIZE[2:0],M_AXI_GP1_AWBURST[1:0],M_AXI_GP1_AWLOCK[1:0],M_AXI_GP1_AWSIZE[2:0],M_AXI_GP1_ARPROT[2:0],M_AXI_GP1_AWPROT[2:0],M_AXI_GP1_ARADDR[31:0],M_AXI_GP1_AWADDR[31:0],M_AXI_GP1_WDATA[31:0],M_AXI_GP1_ARCACHE[3:0],M_AXI_GP1_ARLEN[3:0],M_AXI_GP1_ARQOS[3:0],M_AXI_GP1_AWCACHE[3:0],M_AXI_GP1_AWLEN[3:0],M_AXI_GP1_AWQOS[3:0],M_AXI_GP1_WSTRB[3:0],M_AXI_GP1_ACLK,M_AXI_GP1_ARREADY,M_AXI_GP1_AWREADY,M_AXI_GP1_BVALID,M_AXI_GP1_RLAST,M_AXI_GP1_RVALID,M_AXI_GP1_WREADY,M_AXI_GP1_BID[11:0],M_AXI_GP1_RID[11:0],M_AXI_GP1_BRESP[1:0],M_AXI_GP1_RRESP[1:0],M_AXI_GP1_RDATA[31:0],S_AXI_HP0_ARREADY,S_AXI_HP0_AWREADY,S_AXI_HP0_BVALID,S_AXI_HP0_RLAST,S_AXI_HP0_RVALID,S_AXI_HP0_WREADY,S_AXI_HP0_BRESP[1:0],S_AXI_HP0_RRESP[1:0],S_AXI_HP0_BID[5:0],S_AXI_HP0_RID[5:0],S_AXI_HP0_RDATA[63:0],S_AXI_HP0_RCOUNT[7:0],S_AXI_HP0_WCOUNT[7:0],S_AXI_HP0_RACOUNT[2:0],S_AXI_HP0_WACOUNT[5:0],S_AXI_HP0_ACLK,S_AXI_HP0_ARVALID,S_AXI_HP0_AWVALID,S_AXI_HP0_BREADY,S_AXI_HP0_RDISSUECAP1_EN,S_AXI_HP0_RREADY,S_AXI_HP0_WLAST,S_AXI_HP0_WRISSUECAP1_EN,S_AXI_HP0_WVALID,S_AXI_HP0_ARBURST[1:0],S_AXI_HP0_ARLOCK[1:0],S_AXI_HP0_ARSIZE[2:0],S_AXI_HP0_AWBURST[1:0],S_AXI_HP0_AWLOCK[1:0],S_AXI_HP0_AWSIZE[2:0],S_AXI_HP0_ARPROT[2:0],S_AXI_HP0_AWPROT[2:0],S_AXI_HP0_ARADDR[31:0],S_AXI_HP0_AWADDR[31:0],S_AXI_HP0_ARCACHE[3:0],S_AXI_HP0_ARLEN[3:0],S_AXI_HP0_ARQOS[3:0],S_AXI_HP0_AWCACHE[3:0],S_AXI_HP0_AWLEN[3:0],S_AXI_HP0_AWQOS[3:0],S_AXI_HP0_ARID[5:0],S_AXI_HP0_AWID[5:0],S_AXI_HP0_WID[5:0],S_AXI_HP0_WDATA[63:0],S_AXI_HP0_WSTRB[7:0],S_AXI_HP1_ARREADY,S_AXI_HP1_AWREADY,S_AXI_HP1_BVALID,S_AXI_HP1_RLAST,S_AXI_HP1_RVALID,S_AXI_HP1_WREADY,S_AXI_HP1_BRESP[1:0],S_AXI_HP1_RRESP[1:0],S_AXI_HP1_BID[5:0],S_AXI_HP1_RID[5:0],S_AXI_HP1_RDATA[63:0],S_AXI_HP1_RCOUNT[7:0],S_AXI_HP1_WCOUNT[7:0],S_AXI_HP1_RACOUNT[2:0],S_AXI_HP1_WACOUNT[5:0],S_AXI_HP1_ACLK,S_AXI_HP1_ARVALID,S_AXI_HP1_AWVALID,S_AXI_HP1_BREADY,S_AXI_HP1_RDISSUECAP1_EN,S_AXI_HP1_RREADY,S_AXI_HP1_WLAST,S_AXI_HP1_WRISSUECAP1_EN,S_AXI_HP1_WVALID,S_AXI_HP1_ARBURST[1:0],S_AXI_HP1_ARLOCK[1:0],S_AXI_HP1_ARSIZE[2:0],S_AXI_HP1_AWBURST[1:0],S_AXI_HP1_AWLOCK[1:0],S_AXI_HP1_AWSIZE[2:0],S_AXI_HP1_ARPROT[2:0],S_AXI_HP1_AWPROT[2:0],S_AXI_HP1_ARADDR[31:0],S_AXI_HP1_AWADDR[31:0],S_AXI_HP1_ARCACHE[3:0],S_AXI_HP1_ARLEN[3:0],S_AXI_HP1_ARQOS[3:0],S_AXI_HP1_AWCACHE[3:0],S_AXI_HP1_AWLEN[3:0],S_AXI_HP1_AWQOS[3:0],S_AXI_HP1_ARID[5:0],S_AXI_HP1_AWID[5:0],S_AXI_HP1_WID[5:0],S_AXI_HP1_WDATA[63:0],S_AXI_HP1_WSTRB[7:0],IRQ_F2P[0:0],FCLK_CLK0,FCLK_CLK1,FCLK_CLK2,FCLK_CLK3,FCLK_RESET0_N,FCLK_RESET1_N,FCLK_RESET2_N,FCLK_RESET3_N,MIO[53:0],DDR_CAS_n,DDR_CKE,DDR_Clk_n,DDR_Clk,DDR_CS_n,DDR_DRSTB,DDR_ODT,DDR_RAS_n,DDR_WEB,DDR_BankAddr[2:0],DDR_Addr[14:0],DDR_VRN,DDR_VRP,DDR_DM[3:0],DDR_DQ[31:0],DDR_DQS_n[3:0],DDR_DQS[3:0],PS_SRSTB,PS_CLK,PS_PORB" */;
  input [23:0]GPIO_I;
  output [23:0]GPIO_O;
  output [23:0]GPIO_T;
  input SPI0_SCLK_I;
  output SPI0_SCLK_O;
  output SPI0_SCLK_T;
  input SPI0_MOSI_I;
  output SPI0_MOSI_O;
  output SPI0_MOSI_T;
  input SPI0_MISO_I;
  output SPI0_MISO_O;
  output SPI0_MISO_T;
  input SPI0_SS_I;
  output SPI0_SS_O;
  output SPI0_SS1_O;
  output SPI0_SS2_O;
  output SPI0_SS_T;
  output TTC0_WAVE0_OUT;
  output TTC0_WAVE1_OUT;
  output TTC0_WAVE2_OUT;
  output [1:0]USB0_PORT_INDCTL;
  output USB0_VBUS_PWRSELECT;
  input USB0_VBUS_PWRFAULT;
  output M_AXI_GP0_ARVALID;
  output M_AXI_GP0_AWVALID;
  output M_AXI_GP0_BREADY;
  output M_AXI_GP0_RREADY;
  output M_AXI_GP0_WLAST;
  output M_AXI_GP0_WVALID;
  output [11:0]M_AXI_GP0_ARID;
  output [11:0]M_AXI_GP0_AWID;
  output [11:0]M_AXI_GP0_WID;
  output [1:0]M_AXI_GP0_ARBURST;
  output [1:0]M_AXI_GP0_ARLOCK;
  output [2:0]M_AXI_GP0_ARSIZE;
  output [1:0]M_AXI_GP0_AWBURST;
  output [1:0]M_AXI_GP0_AWLOCK;
  output [2:0]M_AXI_GP0_AWSIZE;
  output [2:0]M_AXI_GP0_ARPROT;
  output [2:0]M_AXI_GP0_AWPROT;
  output [31:0]M_AXI_GP0_ARADDR;
  output [31:0]M_AXI_GP0_AWADDR;
  output [31:0]M_AXI_GP0_WDATA;
  output [3:0]M_AXI_GP0_ARCACHE;
  output [3:0]M_AXI_GP0_ARLEN;
  output [3:0]M_AXI_GP0_ARQOS;
  output [3:0]M_AXI_GP0_AWCACHE;
  output [3:0]M_AXI_GP0_AWLEN;
  output [3:0]M_AXI_GP0_AWQOS;
  output [3:0]M_AXI_GP0_WSTRB;
  input M_AXI_GP0_ACLK;
  input M_AXI_GP0_ARREADY;
  input M_AXI_GP0_AWREADY;
  input M_AXI_GP0_BVALID;
  input M_AXI_GP0_RLAST;
  input M_AXI_GP0_RVALID;
  input M_AXI_GP0_WREADY;
  input [11:0]M_AXI_GP0_BID;
  input [11:0]M_AXI_GP0_RID;
  input [1:0]M_AXI_GP0_BRESP;
  input [1:0]M_AXI_GP0_RRESP;
  input [31:0]M_AXI_GP0_RDATA;
  output M_AXI_GP1_ARVALID;
  output M_AXI_GP1_AWVALID;
  output M_AXI_GP1_BREADY;
  output M_AXI_GP1_RREADY;
  output M_AXI_GP1_WLAST;
  output M_AXI_GP1_WVALID;
  output [11:0]M_AXI_GP1_ARID;
  output [11:0]M_AXI_GP1_AWID;
  output [11:0]M_AXI_GP1_WID;
  output [1:0]M_AXI_GP1_ARBURST;
  output [1:0]M_AXI_GP1_ARLOCK;
  output [2:0]M_AXI_GP1_ARSIZE;
  output [1:0]M_AXI_GP1_AWBURST;
  output [1:0]M_AXI_GP1_AWLOCK;
  output [2:0]M_AXI_GP1_AWSIZE;
  output [2:0]M_AXI_GP1_ARPROT;
  output [2:0]M_AXI_GP1_AWPROT;
  output [31:0]M_AXI_GP1_ARADDR;
  output [31:0]M_AXI_GP1_AWADDR;
  output [31:0]M_AXI_GP1_WDATA;
  output [3:0]M_AXI_GP1_ARCACHE;
  output [3:0]M_AXI_GP1_ARLEN;
  output [3:0]M_AXI_GP1_ARQOS;
  output [3:0]M_AXI_GP1_AWCACHE;
  output [3:0]M_AXI_GP1_AWLEN;
  output [3:0]M_AXI_GP1_AWQOS;
  output [3:0]M_AXI_GP1_WSTRB;
  input M_AXI_GP1_ACLK;
  input M_AXI_GP1_ARREADY;
  input M_AXI_GP1_AWREADY;
  input M_AXI_GP1_BVALID;
  input M_AXI_GP1_RLAST;
  input M_AXI_GP1_RVALID;
  input M_AXI_GP1_WREADY;
  input [11:0]M_AXI_GP1_BID;
  input [11:0]M_AXI_GP1_RID;
  input [1:0]M_AXI_GP1_BRESP;
  input [1:0]M_AXI_GP1_RRESP;
  input [31:0]M_AXI_GP1_RDATA;
  output S_AXI_HP0_ARREADY;
  output S_AXI_HP0_AWREADY;
  output S_AXI_HP0_BVALID;
  output S_AXI_HP0_RLAST;
  output S_AXI_HP0_RVALID;
  output S_AXI_HP0_WREADY;
  output [1:0]S_AXI_HP0_BRESP;
  output [1:0]S_AXI_HP0_RRESP;
  output [5:0]S_AXI_HP0_BID;
  output [5:0]S_AXI_HP0_RID;
  output [63:0]S_AXI_HP0_RDATA;
  output [7:0]S_AXI_HP0_RCOUNT;
  output [7:0]S_AXI_HP0_WCOUNT;
  output [2:0]S_AXI_HP0_RACOUNT;
  output [5:0]S_AXI_HP0_WACOUNT;
  input S_AXI_HP0_ACLK;
  input S_AXI_HP0_ARVALID;
  input S_AXI_HP0_AWVALID;
  input S_AXI_HP0_BREADY;
  input S_AXI_HP0_RDISSUECAP1_EN;
  input S_AXI_HP0_RREADY;
  input S_AXI_HP0_WLAST;
  input S_AXI_HP0_WRISSUECAP1_EN;
  input S_AXI_HP0_WVALID;
  input [1:0]S_AXI_HP0_ARBURST;
  input [1:0]S_AXI_HP0_ARLOCK;
  input [2:0]S_AXI_HP0_ARSIZE;
  input [1:0]S_AXI_HP0_AWBURST;
  input [1:0]S_AXI_HP0_AWLOCK;
  input [2:0]S_AXI_HP0_AWSIZE;
  input [2:0]S_AXI_HP0_ARPROT;
  input [2:0]S_AXI_HP0_AWPROT;
  input [31:0]S_AXI_HP0_ARADDR;
  input [31:0]S_AXI_HP0_AWADDR;
  input [3:0]S_AXI_HP0_ARCACHE;
  input [3:0]S_AXI_HP0_ARLEN;
  input [3:0]S_AXI_HP0_ARQOS;
  input [3:0]S_AXI_HP0_AWCACHE;
  input [3:0]S_AXI_HP0_AWLEN;
  input [3:0]S_AXI_HP0_AWQOS;
  input [5:0]S_AXI_HP0_ARID;
  input [5:0]S_AXI_HP0_AWID;
  input [5:0]S_AXI_HP0_WID;
  input [63:0]S_AXI_HP0_WDATA;
  input [7:0]S_AXI_HP0_WSTRB;
  output S_AXI_HP1_ARREADY;
  output S_AXI_HP1_AWREADY;
  output S_AXI_HP1_BVALID;
  output S_AXI_HP1_RLAST;
  output S_AXI_HP1_RVALID;
  output S_AXI_HP1_WREADY;
  output [1:0]S_AXI_HP1_BRESP;
  output [1:0]S_AXI_HP1_RRESP;
  output [5:0]S_AXI_HP1_BID;
  output [5:0]S_AXI_HP1_RID;
  output [63:0]S_AXI_HP1_RDATA;
  output [7:0]S_AXI_HP1_RCOUNT;
  output [7:0]S_AXI_HP1_WCOUNT;
  output [2:0]S_AXI_HP1_RACOUNT;
  output [5:0]S_AXI_HP1_WACOUNT;
  input S_AXI_HP1_ACLK;
  input S_AXI_HP1_ARVALID;
  input S_AXI_HP1_AWVALID;
  input S_AXI_HP1_BREADY;
  input S_AXI_HP1_RDISSUECAP1_EN;
  input S_AXI_HP1_RREADY;
  input S_AXI_HP1_WLAST;
  input S_AXI_HP1_WRISSUECAP1_EN;
  input S_AXI_HP1_WVALID;
  input [1:0]S_AXI_HP1_ARBURST;
  input [1:0]S_AXI_HP1_ARLOCK;
  input [2:0]S_AXI_HP1_ARSIZE;
  input [1:0]S_AXI_HP1_AWBURST;
  input [1:0]S_AXI_HP1_AWLOCK;
  input [2:0]S_AXI_HP1_AWSIZE;
  input [2:0]S_AXI_HP1_ARPROT;
  input [2:0]S_AXI_HP1_AWPROT;
  input [31:0]S_AXI_HP1_ARADDR;
  input [31:0]S_AXI_HP1_AWADDR;
  input [3:0]S_AXI_HP1_ARCACHE;
  input [3:0]S_AXI_HP1_ARLEN;
  input [3:0]S_AXI_HP1_ARQOS;
  input [3:0]S_AXI_HP1_AWCACHE;
  input [3:0]S_AXI_HP1_AWLEN;
  input [3:0]S_AXI_HP1_AWQOS;
  input [5:0]S_AXI_HP1_ARID;
  input [5:0]S_AXI_HP1_AWID;
  input [5:0]S_AXI_HP1_WID;
  input [63:0]S_AXI_HP1_WDATA;
  input [7:0]S_AXI_HP1_WSTRB;
  input [0:0]IRQ_F2P;
  output FCLK_CLK0;
  output FCLK_CLK1;
  output FCLK_CLK2;
  output FCLK_CLK3;
  output FCLK_RESET0_N;
  output FCLK_RESET1_N;
  output FCLK_RESET2_N;
  output FCLK_RESET3_N;
  inout [53:0]MIO;
  inout DDR_CAS_n;
  inout DDR_CKE;
  inout DDR_Clk_n;
  inout DDR_Clk;
  inout DDR_CS_n;
  inout DDR_DRSTB;
  inout DDR_ODT;
  inout DDR_RAS_n;
  inout DDR_WEB;
  inout [2:0]DDR_BankAddr;
  inout [14:0]DDR_Addr;
  inout DDR_VRN;
  inout DDR_VRP;
  inout [3:0]DDR_DM;
  inout [31:0]DDR_DQ;
  inout [3:0]DDR_DQS_n;
  inout [3:0]DDR_DQS;
  inout PS_SRSTB;
  inout PS_CLK;
  inout PS_PORB;
endmodule
