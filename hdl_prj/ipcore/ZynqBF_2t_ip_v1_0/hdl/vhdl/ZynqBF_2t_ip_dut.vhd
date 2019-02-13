-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\ZynqBF_2tx_fpga\ZynqBF_2t_ip_dut.vhd
-- Created: 2019-02-08 23:34:53
-- 
-- Generated by MATLAB 9.5 and HDL Coder 3.13
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ZynqBF_2t_ip_dut
-- Source Path: ZynqBF_2t_ip/ZynqBF_2t_ip_dut
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ZynqBF_2t_ip_dut IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        dut_enable                        :   IN    std_logic;  -- ufix1
        rx_i_in                           :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
        rx_q_in                           :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
        rx_v_in                           :   IN    std_logic;  -- ufix1
        ce_out_0                          :   OUT   std_logic;  -- ufix1
        ce_out_1                          :   OUT   std_logic;  -- ufix1
        rx_i_out                          :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
        rx_q_out                          :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
        rx_v_out                          :   OUT   std_logic;  -- ufix1
        ch1_i                             :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
        ch1_q                             :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
        ch2_i                             :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
        ch2_q                             :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
        probe                             :   OUT   std_logic_vector(14 DOWNTO 0);  -- ufix15
        probe_xcorr1                      :   OUT   std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
        probe_xcorr2                      :   OUT   std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
        probe_state                       :   OUT   std_logic_vector(7 DOWNTO 0);  -- ufix8
        probe_ch1i                        :   OUT   std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
        probe_ch1q                        :   OUT   std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
        probe_ch1r                        :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En14
        );
END ZynqBF_2t_ip_dut;


ARCHITECTURE rtl OF ZynqBF_2t_ip_dut IS

  -- Component Declarations
  COMPONENT ZynqBF_2t_ip_src_ZynqBF_2tx_fpga
    PORT( clk                             :   IN    std_logic;
          clk_enable                      :   IN    std_logic;
          reset                           :   IN    std_logic;
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
  FOR ALL : ZynqBF_2t_ip_src_ZynqBF_2tx_fpga
    USE ENTITY work.ZynqBF_2t_ip_src_ZynqBF_2tx_fpga(rtl);

  -- Signals
  SIGNAL enb                              : std_logic;
  SIGNAL rx_v_in_sig                      : std_logic;  -- ufix1
  SIGNAL ce_out_0_sig                     : std_logic;  -- ufix1
  SIGNAL ce_out_1_sig                     : std_logic;  -- ufix1
  SIGNAL rx_i_out_sig                     : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL rx_q_out_sig                     : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL rx_v_out_sig                     : std_logic;  -- ufix1
  SIGNAL ch1_i_sig                        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL ch1_q_sig                        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL ch2_i_sig                        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL ch2_q_sig                        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL probe_sig                        : std_logic_vector(14 DOWNTO 0);  -- ufix15
  SIGNAL probe_xcorr1_sig                 : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL probe_xcorr2_sig                 : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL probe_state_sig                  : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL probe_ch1i_sig                   : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL probe_ch1q_sig                   : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL probe_ch1r_sig                   : std_logic_vector(31 DOWNTO 0);  -- ufix32

BEGIN
  u_ZynqBF_2t_ip_src_ZynqBF_2tx_fpga : ZynqBF_2t_ip_src_ZynqBF_2tx_fpga
    PORT MAP( clk => clk,
              clk_enable => enb,
              reset => reset,
              rx_i_in => rx_i_in,  -- sfix16_En15
              rx_q_in => rx_q_in,  -- sfix16_En15
              rx_v_in => rx_v_in_sig,  -- ufix1
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

  rx_v_in_sig <= rx_v_in;

  enb <= dut_enable;

  ce_out_0 <= ce_out_0_sig;

  ce_out_1 <= ce_out_1_sig;

  rx_i_out <= rx_i_out_sig;

  rx_q_out <= rx_q_out_sig;

  rx_v_out <= rx_v_out_sig;

  ch1_i <= ch1_i_sig;

  ch1_q <= ch1_q_sig;

  ch2_i <= ch2_i_sig;

  ch2_q <= ch2_q_sig;

  probe <= probe_sig;

  probe_xcorr1 <= probe_xcorr1_sig;

  probe_xcorr2 <= probe_xcorr2_sig;

  probe_state <= probe_state_sig;

  probe_ch1i <= probe_ch1i_sig;

  probe_ch1q <= probe_ch1q_sig;

  probe_ch1r <= probe_ch1r_sig;

END rtl;

