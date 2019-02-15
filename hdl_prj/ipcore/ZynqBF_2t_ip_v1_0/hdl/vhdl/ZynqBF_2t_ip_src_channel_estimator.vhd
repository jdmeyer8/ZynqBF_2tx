-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\ZynqBF_2tx_fpga\ZynqBF_2t_ip_src_channel_estimator.vhd
-- Created: 2019-02-08 23:33:52
-- 
-- Generated by MATLAB 9.5 and HDL Coder 3.13
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ZynqBF_2t_ip_src_channel_estimator
-- Source Path: ZynqBF_2tx_fpga/channel_estimator
-- Hierarchy Level: 1
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ZynqBF_2t_ip_src_ZynqBF_2tx_fpga_pkg.ALL;

ENTITY ZynqBF_2t_ip_src_channel_estimator IS
  PORT( clk                               :   IN    std_logic;
        clk200                            :   IN    std_logic;
        reset                             :   IN    std_logic;
        reset200                          :   IN    std_logic;
        enb_1_128_0                       :   IN    std_logic;
        enb                               :   IN    std_logic;
        enb200                            :   IN    std_logic;
        enb_1_128_1                       :   IN    std_logic;
        enb_1_1_1                         :   IN    std_logic;
        rx_i                              :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
        rx_q                              :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
        rx_v                              :   IN    std_logic;
        ch1_i                             :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
        ch1_q                             :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
        ch2_i                             :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
        ch2_q                             :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
        probe_xcorr1                      :   OUT   std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
        probe_xcorr2                      :   OUT   std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
        probe_state                       :   OUT   std_logic_vector(7 DOWNTO 0);  -- uint8
        probe_ch1i                        :   OUT   std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
        probe_ch1q                        :   OUT   std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
        probe_ch1r                        :   OUT   std_logic_vector(31 DOWNTO 0);  -- sfix32_En14
        probe                             :   OUT   std_logic_vector(14 DOWNTO 0)  -- ufix15
        );
END ZynqBF_2t_ip_src_channel_estimator;


ARCHITECTURE rtl OF ZynqBF_2t_ip_src_channel_estimator IS

  -- Component Declarations
  COMPONENT ZynqBF_2t_ip_src_goldSequences
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          gs_addr                         :   IN    std_logic_vector(11 DOWNTO 0);  -- ufix12
          gs1                             :   OUT   vector_of_std_logic_vector16(0 TO 1);  -- sfix16_En15 [2]
          gs2                             :   OUT   vector_of_std_logic_vector16(0 TO 1)  -- sfix16_En15 [2]
          );
  END COMPONENT;

  COMPONENT ZynqBF_2t_ip_src_gs_selector
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          pd1                             :   IN    std_logic;
          pd2                             :   IN    std_logic;
          en                              :   IN    std_logic;
          gs_sel                          :   OUT   std_logic_vector(0 TO 1)  -- boolean [2]
          );
  END COMPONENT;

  COMPONENT ZynqBF_2t_ip_src_peakdetect_ch1
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          rst                             :   IN    std_logic;
          din                             :   IN    vector_of_std_logic_vector16(0 TO 1);  -- sfix16_En15 [2]
          vin                             :   IN    std_logic;
          en                              :   IN    std_logic;
          addr                            :   IN    std_logic_vector(14 DOWNTO 0);  -- ufix15
          index                           :   OUT   std_logic_vector(14 DOWNTO 0);  -- ufix15
          step                            :   OUT   std_logic;
          peak_found                      :   OUT   std_logic;
          probe                           :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En16
          );
  END COMPONENT;

  COMPONENT ZynqBF_2t_ip_src_ram_rd_counter
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          addr1                           :   IN    std_logic_vector(14 DOWNTO 0);  -- ufix15
          addr2                           :   IN    std_logic_vector(14 DOWNTO 0);  -- ufix15
          gs_sel                          :   IN    std_logic_vector(0 TO 1);  -- boolean [2]
          rst                             :   IN    std_logic;
          load                            :   IN    std_logic;
          pd_init                         :   IN    std_logic;
          pd_step                         :   IN    std_logic;
          est_step                        :   IN    std_logic;
          rx_addr_out                     :   OUT   std_logic_vector(14 DOWNTO 0);  -- ufix15
          re                              :   OUT   std_logic;
          gs_addr_out                     :   OUT   std_logic_vector(11 DOWNTO 0)  -- ufix12
          );
  END COMPONENT;

  COMPONENT ZynqBF_2t_ip_src_ram_counter
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          rst                             :   IN    std_logic;
          ram_we                          :   IN    std_logic;
          ram_re                          :   IN    std_logic;
          pd_en                           :   IN    std_logic;
          corr_en                         :   OUT   std_logic;
          pd_init                         :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ZynqBF_2t_ip_src_peakdetect_ch2
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          rst                             :   IN    std_logic;
          din                             :   IN    vector_of_std_logic_vector16(0 TO 1);  -- sfix16_En15 [2]
          vin                             :   IN    std_logic;
          en                              :   IN    std_logic;
          addr                            :   IN    std_logic_vector(14 DOWNTO 0);  -- ufix15
          index                           :   OUT   std_logic_vector(14 DOWNTO 0);  -- ufix15
          step                            :   OUT   std_logic;
          peak_found                      :   OUT   std_logic;
          probe                           :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En16
          );
  END COMPONENT;

  COMPONENT ZynqBF_2t_ip_src_state_machine
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          peak_found                      :   IN    std_logic;
          est_done                        :   IN    std_logic;
          cf_done                         :   IN    std_logic;
          --pd_en                           :   OUT   std_logic;
          --est_en                          :   OUT   std_logic;
          --cf_en                           :   OUT   std_logic;
          state_out                       :   OUT   std_logic_vector(3 downto 0)
          --probe_state                     :   OUT   std_logic_vector(7 DOWNTO 0)  -- uint8
          );
  END COMPONENT;

  COMPONENT ZynqBF_2t_ip_src_in_fifo
    PORT( clk                             :   IN    std_logic;
          clk200                          :   IN    std_logic;
          reset                           :   IN    std_logic;
          reset200                        :   IN    std_logic;
          enb                             :   IN    std_logic;
          enb200                          :   IN    std_logic;
          rxi_in                          :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
          rxq_in                          :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
          rxv_in                          :   IN    std_logic;
          pd_en                           :   IN    std_logic;
          cf_en                           :   IN    std_logic;
          rxi_out                         :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
          rxq_out                         :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
          rxv_out                         :   OUT   std_logic;
          empty                           :   OUT   std_logic
          );
  END COMPONENT;

  COMPONENT ZynqBF_2t_ip_src_rx_bram
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          din_i                           :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
          din_q                           :   IN    std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
          we                              :   IN    std_logic;
          re                              :   IN    std_logic;
          rd_addr                         :   IN    std_logic_vector(14 DOWNTO 0);  -- ufix15
          rst                             :   IN    std_logic;
          dout                            :   OUT   vector_of_std_logic_vector16(0 TO 1);  -- sfix16_En15 [2]
          valid                           :   OUT   std_logic;
          addr_out                        :   OUT   std_logic_vector(14 DOWNTO 0)  -- ufix15
          );
  END COMPONENT;

  COMPONENT ZynqBF_2t_ip_src_ch_est
    PORT( clk                             :   IN    std_logic;
          reset                           :   IN    std_logic;
          enb                             :   IN    std_logic;
          est_rst                         :   IN    std_logic;
          rx                              :   IN    vector_of_std_logic_vector16(0 TO 1);  -- sfix16_En15 [2]
          gs1                             :   IN    vector_of_std_logic_vector16(0 TO 1);  -- sfix16_En15 [2]
          gs2                             :   IN    vector_of_std_logic_vector16(0 TO 1);  -- sfix16_En15 [2]
          gs_sel                          :   IN    std_logic_vector(0 TO 1);  -- boolean [2]
          en                              :   IN    std_logic;
          step_in                         :   IN    std_logic;
          ch1_i                           :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
          ch1_q                           :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
          ch2_i                           :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
          ch2_q                           :   OUT   std_logic_vector(15 DOWNTO 0);  -- sfix16_En15
          est_done                        :   OUT   std_logic;
          step_out                        :   OUT   std_logic;
          probe_ch1i                      :   OUT   std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
          probe_ch1q                      :   OUT   std_logic_vector(31 DOWNTO 0);  -- sfix32_En16
          probe_ch1r                      :   OUT   std_logic_vector(31 DOWNTO 0)  -- sfix32_En14
          );
  END COMPONENT;

  -- Component Configuration Statements
  FOR ALL : ZynqBF_2t_ip_src_goldSequences
    USE ENTITY work.ZynqBF_2t_ip_src_goldSequences(rtl);

  FOR ALL : ZynqBF_2t_ip_src_gs_selector
    USE ENTITY work.ZynqBF_2t_ip_src_gs_selector(rtl);

  FOR ALL : ZynqBF_2t_ip_src_peakdetect_ch1
    USE ENTITY work.ZynqBF_2t_ip_src_peakdetect_ch1(rtl);

  FOR ALL : ZynqBF_2t_ip_src_ram_rd_counter
    USE ENTITY work.ZynqBF_2t_ip_src_ram_rd_counter(rtl);

  FOR ALL : ZynqBF_2t_ip_src_ram_counter
    USE ENTITY work.ZynqBF_2t_ip_src_ram_counter(rtl);

  FOR ALL : ZynqBF_2t_ip_src_peakdetect_ch2
    USE ENTITY work.ZynqBF_2t_ip_src_peakdetect_ch2(rtl);

  FOR ALL : ZynqBF_2t_ip_src_state_machine
    USE ENTITY work.ZynqBF_2t_ip_src_state_machine(rtl);

  FOR ALL : ZynqBF_2t_ip_src_in_fifo
    USE ENTITY work.ZynqBF_2t_ip_src_in_fifo(rtl);

  FOR ALL : ZynqBF_2t_ip_src_rx_bram
    USE ENTITY work.ZynqBF_2t_ip_src_rx_bram(rtl);

  FOR ALL : ZynqBF_2t_ip_src_ch_est
    USE ENTITY work.ZynqBF_2t_ip_src_ch_est(rtl);

  -- Signals
  SIGNAL gs_addr                          : std_logic_vector(11 DOWNTO 0);  -- ufix12
  SIGNAL goldSequences_out1               : vector_of_std_logic_vector16(0 TO 1);  -- ufix16 [2]
  SIGNAL goldSequences_out2               : vector_of_std_logic_vector16(0 TO 1);  -- ufix16 [2]
  
  SIGNAL current_state                    : std_logic_vector(3 downto 0);  -- current state of fsm
                                                                           -- 0001 = detect peak
                                                                           -- 0010 = estimate channel
                                                                           -- 0100 = clear fifo
                                                                           -- 1000 = restart fsm
                                                                           
  SIGNAL rst_en                           : std_logic;  -- state machine restart state
  SIGNAL cf_en                            : std_logic;
  SIGNAL est_en                           : std_logic;
  SIGNAL clear_fifo                       : std_logic;
  SIGNAL pd_step                          : std_logic;
  SIGNAL pd_en                            : std_logic;
  SIGNAL pd_step_1                        : std_logic;
  SIGNAL pd_step_2                        : std_logic;
  SIGNAL peakdetect_ch1_out3              : std_logic;
  SIGNAL peakdetect_ch2_out3              : std_logic;
  SIGNAL Logical_Operator6_out1           : std_logic;
  SIGNAL gs_sel                           : std_logic_vector(0 TO 1);  -- boolean [2]
  SIGNAL Logical_Operator3_out1           : std_logic;
  SIGNAL ram_dout                         : vector_of_std_logic_vector16(0 TO 1);  -- ufix16 [2]
  SIGNAL ram_valid                        : std_logic;
  SIGNAL xcorr_en                         : std_logic;
  SIGNAL rx_bram_out3                     : std_logic_vector(14 DOWNTO 0);  -- ufix15
  SIGNAL peakdetect_ch1_out1              : std_logic_vector(14 DOWNTO 0);  -- ufix15
  SIGNAL xcorr_ch1                        : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL peakdetect_ch2_out1              : std_logic_vector(14 DOWNTO 0);  -- ufix15
  SIGNAL est_done                         : std_logic;
  SIGNAL pd_init                          : std_logic;
  SIGNAL est_step                         : std_logic;
  SIGNAL rx_addr                          : std_logic_vector(14 DOWNTO 0);  -- ufix15
  SIGNAL ram_re                           : std_logic;
  SIGNAL fifo_rxv                         : std_logic;
  SIGNAL xcorr                            : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL in_fifo_out4                     : std_logic;
  SIGNAL state_machine_out4               : std_logic_vector(7 DOWNTO 0);  -- ufix8
  SIGNAL fifo_rxi                         : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL fifo_rxq                         : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL ch1_i_tmp                        : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL ch_est_out2                      : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL ch_est_out3                      : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL ch_est_out4                      : std_logic_vector(15 DOWNTO 0);  -- ufix16
  SIGNAL ch_est_out7                      : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL ch_est_out8                      : std_logic_vector(31 DOWNTO 0);  -- ufix32
  SIGNAL ch_est_out9                      : std_logic_vector(31 DOWNTO 0);  -- ufix32
  signal peak_found_d1:                     std_logic;
  signal peak_found_d2:                     std_logic;
  signal peak_found_d3:                     std_logic;
  signal ch_est_rst:                        std_logic;

BEGIN
  u_goldSequences : ZynqBF_2t_ip_src_goldSequences
    PORT MAP( clk => clk200,
              reset => reset200,
              enb => enb200,
              gs_addr => gs_addr,  -- ufix12
              gs1 => goldSequences_out1,  -- sfix16_En15 [2]
              gs2 => goldSequences_out2  -- sfix16_En15 [2]
              );

  u_gs_selector : ZynqBF_2t_ip_src_gs_selector
    PORT MAP( clk => clk200,
              reset => reset200,
              enb => enb200,
              pd1 => peakdetect_ch1_out3,
              pd2 => peakdetect_ch2_out3,
              en => Logical_Operator6_out1,
              gs_sel => gs_sel  -- boolean [2]
              );

  u_peakdetect_ch1 : ZynqBF_2t_ip_src_peakdetect_ch1
    PORT MAP( clk => clk200,
              reset => reset200,
              enb => enb200,
              rst => Logical_Operator3_out1,
              din => ram_dout,  -- sfix16_En15 [2]
              vin => ram_valid,
              en => xcorr_en,
              addr => rx_bram_out3,  -- ufix15
              index => peakdetect_ch1_out1,  -- ufix15
              step => pd_step,
              peak_found => peakdetect_ch1_out3,
              probe => xcorr_ch1  -- sfix32_En16
              );

  u_ram_rd_counter : ZynqBF_2t_ip_src_ram_rd_counter
    PORT MAP( clk => clk200,
              reset => reset200,
              enb => enb200,
              addr1 => peakdetect_ch1_out1,  -- ufix15
              addr2 => peakdetect_ch2_out1,  -- ufix15
              gs_sel => gs_sel,  -- boolean [2]
              rst => est_done,
              load => peak_found_d3,
              pd_init => pd_init,
              pd_step => pd_step_2,
              est_step => est_step,
              rx_addr_out => rx_addr,  -- ufix15
              re => ram_re,
              gs_addr_out => gs_addr  -- ufix12
              );

  u_ram_counter : ZynqBF_2t_ip_src_ram_counter
    PORT MAP( clk => clk200,
              reset => reset200,
              enb => enb200,
              rst => Logical_Operator3_out1,
              ram_we => fifo_rxv,
              ram_re => ram_re,
              pd_en => pd_en,
              corr_en => xcorr_en,
              pd_init => pd_init
              );

  u_peakdetect_ch2 : ZynqBF_2t_ip_src_peakdetect_ch2
    PORT MAP( clk => clk200,
              reset => reset200,
              enb => enb200,
              rst => Logical_Operator3_out1,
              din => ram_dout,  -- sfix16_En15 [2]
              vin => ram_valid,
              en => xcorr_en,
              addr => rx_bram_out3,  -- ufix15
              index => peakdetect_ch2_out1,  -- ufix15
              step => pd_step_1,
              peak_found => peakdetect_ch2_out3,
              probe => xcorr  -- sfix32_En16
              );

  u_state_machine : ZynqBF_2t_ip_src_state_machine
    PORT MAP( clk => clk200,
              reset => reset200,
              enb => enb200,
              peak_found => peak_found_d2,
              est_done => est_done,
              cf_done => in_fifo_out4,
              --pd_en => pd_en,
              --est_en => est_en,
              --cf_en => cf_en,
              state_out => current_state
              --probe_state => state_machine_out4  -- uint8
              );
              
  pd_en <= current_state(0);
  est_en <= current_state(1);
  cf_en <= current_state(2);
  rst_en <= current_state(3);
              
              

  u_in_fifo : ZynqBF_2t_ip_src_in_fifo
    PORT MAP( clk => clk,
              clk200 => clk200,
              reset => reset,
              reset200 => reset200,
              enb => enb,
              enb200 => enb200,
              rxi_in => rx_i,  -- sfix16_En15
              rxq_in => rx_q,  -- sfix16_En15
              rxv_in => rx_v,
              pd_en => pd_en,
              cf_en => clear_fifo,
              rxi_out => fifo_rxi,  -- sfix16_En15
              rxq_out => fifo_rxq,  -- sfix16_En15
              rxv_out => fifo_rxv,
              empty => in_fifo_out4
              );

  u_rx_bram : ZynqBF_2t_ip_src_rx_bram
    PORT MAP( clk => clk200,
              reset => reset200,
              enb => enb200,
              din_i => fifo_rxi,  -- sfix16_En15
              din_q => fifo_rxq,  -- sfix16_En15
              we => fifo_rxv,
              re => ram_re,
              rd_addr => rx_addr,  -- ufix15
              rst => est_done,
              dout => ram_dout,  -- sfix16_En15 [2]
              valid => ram_valid,
              addr_out => rx_bram_out3  -- ufix15
              );

  u_ch_est : ZynqBF_2t_ip_src_ch_est
    PORT MAP( clk => clk200,
              reset => reset200,
              enb => enb200,
              est_rst => ch_est_rst,
              rx => ram_dout,  -- sfix16_En15 [2]
              gs1 => goldSequences_out1,  -- sfix16_En15 [2]
              gs2 => goldSequences_out2,  -- sfix16_En15 [2]
              gs_sel => gs_sel,  -- boolean [2]
              en => est_en,
              step_in => ram_valid,
              ch1_i => ch1_i_tmp,  -- sfix16_En15
              ch1_q => ch_est_out2,  -- sfix16_En15
              ch2_i => ch_est_out3,  -- sfix16_En15
              ch2_q => ch_est_out4,  -- sfix16_En15
              est_done => est_done,
              step_out => est_step,
              probe_ch1i => ch_est_out7,  -- sfix32_En16
              probe_ch1q => ch_est_out8,  -- sfix32_En16
              probe_ch1r => ch_est_out9  -- sfix32_En14
              );
              
   ch_est_rst <= not est_en;
              
  peak_found_delay_proc: process(clk200)
  begin
    if clk200'event and clk200 = '1' then
      if reset200 = '1' then
        peak_found_d1 <= '0';
        peak_found_d2 <= '0';
        peak_found_d3 <= '0';
      elsif enb200 = '1' then
        peak_found_d1 <= Logical_Operator6_out1;
        peak_found_d2 <= peak_found_d1;
        peak_found_d3 <= peak_found_d2;
      end if;
    end if;
  end process;

  clear_fifo <= cf_en OR est_en;

  pd_step_2 <= pd_step_1 AND (pd_step AND pd_en);

  Logical_Operator3_out1 <=  NOT pd_en;

  Logical_Operator6_out1 <= peakdetect_ch2_out3 OR peakdetect_ch1_out3;

  ch1_i <= ch1_i_tmp;

  ch1_q <= ch_est_out2;

  ch2_i <= ch_est_out3;

  ch2_q <= ch_est_out4;

  probe_xcorr1 <= xcorr_ch1;

  probe_xcorr2 <= xcorr;

  probe_state <= "0000" & current_state; --state_machine_out4;

  probe_ch1i <= ch_est_out7;

  probe_ch1q <= ch_est_out8;

  probe_ch1r <= ch_est_out9;

  probe <= peakdetect_ch1_out1;

END rtl;

