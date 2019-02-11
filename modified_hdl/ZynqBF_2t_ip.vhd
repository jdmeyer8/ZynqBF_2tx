-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\ZynqBF_2tx_fpga\ZynqBF_2t_ip.vhd
-- Created: 2019-02-08 23:34:53
-- 
-- Generated by MATLAB 9.5 and HDL Coder 3.13
-- 
-- 
-- -------------------------------------------------------------
-- Rate and Clocking Details
-- -------------------------------------------------------------
-- Model base rate: -1
-- Target subsystem base rate: -1
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ZynqBF_2t_ip
-- Source Path: ZynqBF_2t_ip
-- Hierarchy Level: 0
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ZynqBF_2t_ip IS
  PORT( IPCORE_CLK                        :   IN    std_logic;  -- ufix1
        IPCORE_RESETN                     :   IN    std_logic;  -- ufix1
        baseband_rx0I_in                  :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
        baseband_rx0Q_in                  :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
        baseband_rx_valid_in              :   IN    std_logic;  -- ufix1
        AXI4_Lite_ACLK                    :   IN    std_logic;  -- ufix1
        AXI4_Lite_ARESETN                 :   IN    std_logic;  -- ufix1
        AXI4_Lite_AWADDR                  :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
        AXI4_Lite_AWVALID                 :   IN    std_logic;  -- ufix1
        AXI4_Lite_WDATA                   :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
        AXI4_Lite_WSTRB                   :   IN    std_logic_vector(3 DOWNTO 0);  -- ufix4
        AXI4_Lite_WVALID                  :   IN    std_logic;  -- ufix1
        AXI4_Lite_BREADY                  :   IN    std_logic;  -- ufix1
        AXI4_Lite_ARADDR                  :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
        AXI4_Lite_ARVALID                 :   IN    std_logic;  -- ufix1
        AXI4_Lite_RREADY                  :   IN    std_logic;  -- ufix1
        dma_rx0I_out                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- ufix16
        dma_rx0Q_out                      :   OUT   std_logic_vector(15 DOWNTO 0);  -- ufix16
        dma_rx_valid_out                  :   OUT   std_logic;  -- ufix1
        AXI4_Lite_AWREADY                 :   OUT   std_logic;  -- ufix1
        AXI4_Lite_WREADY                  :   OUT   std_logic;  -- ufix1
        AXI4_Lite_BRESP                   :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
        AXI4_Lite_BVALID                  :   OUT   std_logic;  -- ufix1
        AXI4_Lite_ARREADY                 :   OUT   std_logic;  -- ufix1
        AXI4_Lite_RDATA                   :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
        AXI4_Lite_RRESP                   :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
        AXI4_Lite_RVALID                  :   OUT   std_logic  -- ufix1
        );
END ZynqBF_2t_ip;


ARCHITECTURE rtl OF ZynqBF_2t_ip IS

  -- Component Declarations
  COMPONENT ZynqBF_2t_ip_axi_lite
    PORT( reset                           :   IN    std_logic;
          AXI4_Lite_ACLK                  :   IN    std_logic;  -- ufix1
          AXI4_Lite_ARESETN               :   IN    std_logic;  -- ufix1
          AXI4_Lite_AWADDR                :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
          AXI4_Lite_AWVALID               :   IN    std_logic;  -- ufix1
          AXI4_Lite_WDATA                 :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          AXI4_Lite_WSTRB                 :   IN    std_logic_vector(3 DOWNTO 0);  -- ufix4
          AXI4_Lite_WVALID                :   IN    std_logic;  -- ufix1
          AXI4_Lite_BREADY                :   IN    std_logic;  -- ufix1
          AXI4_Lite_ARADDR                :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16
          AXI4_Lite_ARVALID               :   IN    std_logic;  -- ufix1
          AXI4_Lite_RREADY                :   IN    std_logic;  -- ufix1
          read_ip_timestamp               :   IN    std_logic_vector(31 DOWNTO 0);  -- ufix32
          read_ch1_i                      :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
          read_ch1_q                      :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
          read_ch2_i                      :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
          read_ch2_q                      :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
          AXI4_Lite_AWREADY               :   OUT   std_logic;  -- ufix1
          AXI4_Lite_WREADY                :   OUT   std_logic;  -- ufix1
          AXI4_Lite_BRESP                 :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
          AXI4_Lite_BVALID                :   OUT   std_logic;  -- ufix1
          AXI4_Lite_ARREADY               :   OUT   std_logic;  -- ufix1
          AXI4_Lite_RDATA                 :   OUT   std_logic_vector(31 DOWNTO 0);  -- ufix32
          AXI4_Lite_RRESP                 :   OUT   std_logic_vector(1 DOWNTO 0);  -- ufix2
          AXI4_Lite_RVALID                :   OUT   std_logic;  -- ufix1
          write_axi_enable                :   OUT   std_logic;  -- ufix1
          reset_internal                  :   OUT   std_logic  -- ufix1
          );
  END COMPONENT;

  COMPONENT ZynqBF_2t_ip_dut
    PORT( clk                             :   IN    std_logic;  -- ufix1
          reset                           :   IN    std_logic;
          dut_enable                      :   IN    std_logic;  -- ufix1
          rx_i_in                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
          rx_q_in                         :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
          rx_v_in                         :   IN    std_logic;  -- ufix1
          ce_out_0                        :   OUT   std_logic;  -- ufix1
          ce_out_1                        :   OUT   std_logic;  -- ufix1
          rx_i_out                        :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
          rx_q_out                        :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
          rx_v_out                        :   OUT   std_logic;  -- ufix1
          ch1_i                           :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
          ch1_q                           :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
          ch2_i                           :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
          ch2_q                           :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
          probe                           :   OUT   std_logic_vector(14 DOWNTO 0);  -- ufix15
          probe_xcorr1                    :   OUT   std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
          probe_xcorr2                    :   OUT   std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
          probe_state                     :   OUT   std_logic_vector(7 DOWNTO 0);  -- ufix8
          probe_ch1i                      :   OUT   std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
          probe_ch1q                      :   OUT   std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
          probe_ch1r                      :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En14
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : ZynqBF_2t_ip_axi_lite
    USE ENTITY work.ZynqBF_2t_ip_axi_lite(rtl);

  FOR ALL : ZynqBF_2t_ip_dut
    USE ENTITY work.ZynqBF_2t_ip_dut(rtl);

  -- Signals
  SIGNAL reset                            : std_logic;
  SIGNAL ip_timestamp                     : unsigned(31 DOWNTO 0);  -- ufix32
  SIGNAL reset_cm                         : std_logic;  -- ufix1
  SIGNAL baseband_rx0I_in_unsigned        : unsigned(15 DOWNTO 0);  -- ufix16
  SIGNAL rx_i_in_sig                      : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL baseband_rx0Q_in_unsigned        : unsigned(15 DOWNTO 0);  -- ufix16
  SIGNAL rx_q_in_sig                      : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL reset_internal                   : std_logic;  -- ufix1
  SIGNAL ch1_i_sig                        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL ch1_q_sig                        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL ch2_i_sig                        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL ch2_q_sig                        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL AXI4_Lite_BRESP_tmp              : std_logic_vector(1 DOWNTO 0);  -- ufix2
  SIGNAL AXI4_Lite_RDATA_tmp              : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL AXI4_Lite_RRESP_tmp              : std_logic_vector(1 DOWNTO 0);  -- ufix2
  SIGNAL write_axi_enable                 : std_logic;  -- ufix1
  SIGNAL ce_out_0_sig                     : std_logic;  -- ufix1
  SIGNAL ce_out_1_sig                     : std_logic;  -- ufix1
  SIGNAL rx_i_out_sig                     : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL rx_q_out_sig                     : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL rx_v_out_sig                     : std_logic;  -- ufix1
  SIGNAL probe_sig                        : std_logic_vector(14 DOWNTO 0);  -- ufix15
  SIGNAL probe_xcorr1_sig                 : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL probe_xcorr2_sig                 : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL probe_state_sig                  : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL probe_ch1i_sig                   : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL probe_ch1q_sig                   : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL probe_ch1r_sig                   : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL rx_i_out_sig_signed              : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL dma_rx0I_out_tmp                 : unsigned(15 DOWNTO 0);  -- ufix16
  SIGNAL rx_q_out_sig_signed              : signed(15 DOWNTO 0);  -- sfix16_En15
  SIGNAL dma_rx0Q_out_tmp                 : unsigned(15 DOWNTO 0);  -- ufix16

BEGIN
  u_ZynqBF_2t_ip_axi_lite_inst : ZynqBF_2t_ip_axi_lite
    PORT MAP( reset => reset,
              AXI4_Lite_ACLK => AXI4_Lite_ACLK,  -- ufix1
              AXI4_Lite_ARESETN => AXI4_Lite_ARESETN,  -- ufix1
              AXI4_Lite_AWADDR => AXI4_Lite_AWADDR,  -- ufix16
              AXI4_Lite_AWVALID => AXI4_Lite_AWVALID,  -- ufix1
              AXI4_Lite_WDATA => AXI4_Lite_WDATA,  -- ufix32
              AXI4_Lite_WSTRB => AXI4_Lite_WSTRB,  -- ufix4
              AXI4_Lite_WVALID => AXI4_Lite_WVALID,  -- ufix1
              AXI4_Lite_BREADY => AXI4_Lite_BREADY,  -- ufix1
              AXI4_Lite_ARADDR => AXI4_Lite_ARADDR,  -- ufix16
              AXI4_Lite_ARVALID => AXI4_Lite_ARVALID,  -- ufix1
              AXI4_Lite_RREADY => AXI4_Lite_RREADY,  -- ufix1
              read_ip_timestamp => std_logic_vector(ip_timestamp),  -- ufix32
              read_ch1_i => ch1_i_sig,  -- sfix16_En15
              read_ch1_q => ch1_q_sig,  -- sfix16_En15
              read_ch2_i => ch2_i_sig,  -- sfix16_En15
              read_ch2_q => ch2_q_sig,  -- sfix16_En15
              AXI4_Lite_AWREADY => AXI4_Lite_AWREADY,  -- ufix1
              AXI4_Lite_WREADY => AXI4_Lite_WREADY,  -- ufix1
              AXI4_Lite_BRESP => AXI4_Lite_BRESP_tmp,  -- ufix2
              AXI4_Lite_BVALID => AXI4_Lite_BVALID,  -- ufix1
              AXI4_Lite_ARREADY => AXI4_Lite_ARREADY,  -- ufix1
              AXI4_Lite_RDATA => AXI4_Lite_RDATA_tmp,  -- ufix32
              AXI4_Lite_RRESP => AXI4_Lite_RRESP_tmp,  -- ufix2
              AXI4_Lite_RVALID => AXI4_Lite_RVALID,  -- ufix1
              write_axi_enable => write_axi_enable,  -- ufix1
              reset_internal => reset_internal  -- ufix1
              );

  u_ZynqBF_2t_ip_dut_inst : ZynqBF_2t_ip_dut
    PORT MAP( clk => IPCORE_CLK,  -- ufix1
              reset => reset,
              dut_enable => write_axi_enable,  -- ufix1
              rx_i_in => std_logic_vector(rx_i_in_sig),  -- sfix16_En15
              rx_q_in => std_logic_vector(rx_q_in_sig),  -- sfix16_En15
              rx_v_in => baseband_rx_valid_in,  -- ufix1
              ce_out_0 => ce_out_0_sig,  -- ufix1
              ce_out_1 => ce_out_1_sig,  -- ufix1
              rx_i_out => rx_i_out_sig,  -- sfix16_En15
              rx_q_out => rx_q_out_sig,  -- sfix16_En15
              rx_v_out => rx_v_out_sig,  -- ufix1
              ch1_i => ch1_i_sig,  -- sfix16_En15
              ch1_q => ch1_q_sig,  -- sfix16_En15
              ch2_i => ch2_i_sig,  -- sfix16_En15
              ch2_q => ch2_q_sig,  -- sfix16_En15
              probe => probe_sig,  -- ufix15
              probe_xcorr1 => probe_xcorr1_sig,  -- sfix32_En16
              probe_xcorr2 => probe_xcorr2_sig,  -- sfix32_En16
              probe_state => probe_state_sig,  -- ufix8
              probe_ch1i => probe_ch1i_sig,  -- sfix32_En16
              probe_ch1q => probe_ch1q_sig,  -- sfix32_En16
              probe_ch1r => probe_ch1r_sig  -- sfix32_En14
              );

  ip_timestamp <= to_unsigned(1902082334, 32);

  reset_cm <=  NOT IPCORE_RESETN;

  baseband_rx0I_in_unsigned <= unsigned(baseband_rx0I_in);

  rx_i_in_sig <= signed(baseband_rx0I_in_unsigned);

  baseband_rx0Q_in_unsigned <= unsigned(baseband_rx0Q_in);

  rx_q_in_sig <= signed(baseband_rx0Q_in_unsigned);

  reset <= reset_cm OR reset_internal;

  rx_i_out_sig_signed <= signed(rx_i_out_sig);

  dma_rx0I_out_tmp <= unsigned(rx_i_out_sig_signed);

  dma_rx0I_out <= std_logic_vector(dma_rx0I_out_tmp);

  rx_q_out_sig_signed <= signed(rx_q_out_sig);

  dma_rx0Q_out_tmp <= unsigned(rx_q_out_sig_signed);

  dma_rx0Q_out <= std_logic_vector(dma_rx0Q_out_tmp);

  dma_rx_valid_out <= rx_v_out_sig;

  AXI4_Lite_BRESP <= AXI4_Lite_BRESP_tmp;

  AXI4_Lite_RDATA <= AXI4_Lite_RDATA_tmp;

  AXI4_Lite_RRESP <= AXI4_Lite_RRESP_tmp;

END rtl;

