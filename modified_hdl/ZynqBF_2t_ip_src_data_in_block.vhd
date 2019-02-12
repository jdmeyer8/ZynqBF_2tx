-- -------------------------------------------------------------
-- 
-- File Name: hdl_prj\hdlsrc\ZynqBF_2tx_fpga\ZynqBF_2t_ip_src_data_in_block.vhd
-- Created: 2019-02-08 23:33:51
-- 
-- Generated by MATLAB 9.5 and HDL Coder 3.13
-- 
-- -------------------------------------------------------------


-- -------------------------------------------------------------
-- 
-- Module: ZynqBF_2t_ip_src_data_in_block
-- Source Path: ZynqBF_2tx_fpga/channel_estimator/peakdetect_ch2/correlator2/data_in
-- Hierarchy Level: 4
-- 
-- -------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.ZynqBF_2t_ip_src_ZynqBF_2tx_fpga_pkg.ALL;

ENTITY ZynqBF_2t_ip_src_data_in_block IS
  PORT( clk                               :   IN    std_logic;
        reset                             :   IN    std_logic;
        enb                               :   IN    std_logic;
        rst                               :   IN    std_logic;
        valid                             :   IN    std_logic;
        addr                              :   OUT   std_logic_vector(8 DOWNTO 0);  -- ufix9
        we                                :   OUT   std_logic_vector(63 DOWNTO 0)  -- ufix64
        );
END ZynqBF_2t_ip_src_data_in_block;


ARCHITECTURE rtl OF ZynqBF_2t_ip_src_data_in_block IS

  -- Signals
  SIGNAL rst_1                            : std_logic;
  SIGNAL Delay3_out1                      : std_logic;
  SIGNAL ram_counter_out1                 : unsigned(5 DOWNTO 0);  -- ufix6
  SIGNAL Compare_To_Constant_out1         : std_logic;
  SIGNAL Logical_Operator_out1            : std_logic;
  SIGNAL addr_counter_out1                : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL Delay5_reg                       : vector_of_unsigned9(0 TO 2);  -- ufix9 [3]
  SIGNAL Delay5_out1                      : unsigned(8 DOWNTO 0);  -- ufix9
  SIGNAL Delay6_out1                      : std_logic;
  SIGNAL Delay_out1                       : std_logic;
  SIGNAL Delay1_ctrl_const_out            : std_logic;
  SIGNAL Delay1_ctrl_delay_out            : std_logic;
  SIGNAL Delay1_out1                      : unsigned(63 DOWNTO 0);  -- ufix64
  SIGNAL Bit_Rotate_out1                  : unsigned(63 DOWNTO 0);  -- ufix64
  SIGNAL Switch1_out1                     : unsigned(63 DOWNTO 0);  -- ufix64
  SIGNAL Delay1_out                       : unsigned(63 DOWNTO 0);  -- ufix64
  SIGNAL Switch2_out1                     : unsigned(63 DOWNTO 0);  -- ufix64
  SIGNAL Delay2_out1                      : unsigned(63 DOWNTO 0);  -- ufix64
  signal we_i:                              std_logic_vector(63 downto 0);
  signal we_next:                           std_logic_vector(63 downto 0);
  signal valid_d1:                          std_logic;
  signal valid_d2:                          std_logic;

BEGIN
  Delay4_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        rst_1 <= '0';
      ELSIF enb = '1' THEN
        rst_1 <= rst;
      END IF;
    END IF;
  END PROCESS Delay4_process;


  Delay3_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        Delay3_out1 <= '0';
        valid_d1 <= '0';
        valid_d2 <= '0';
      ELSIF enb = '1' THEN
        Delay3_out1 <= valid;
        valid_d1 <= valid;
        valid_d2 <= valid_d1;
      END IF;
    END IF;
  END PROCESS Delay3_process;


  -- Free running, Unsigned Counter
  --  initial value   = 63
  --  step value      = 1
  ram_counter_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        ram_counter_out1 <= to_unsigned(16#3F#, 6);
      ELSIF enb = '1' THEN
        IF rst_1 = '1' THEN 
          ram_counter_out1 <= to_unsigned(16#3F#, 6);
        ELSIF Delay3_out1 = '1' THEN 
          ram_counter_out1 <= ram_counter_out1 + to_unsigned(16#01#, 6);
        END IF;
      END IF;
    END IF;
  END PROCESS ram_counter_process;


  
  Compare_To_Constant_out1 <= '1' WHEN ram_counter_out1 = to_unsigned(16#3F#, 6) ELSE
      '0';

  Logical_Operator_out1 <= Compare_To_Constant_out1 AND Delay3_out1;

  -- Count limited, Unsigned Counter
  --  initial value   = 63
  --  step value      = 1
  --  count to value  = 511
  addr_counter_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        addr_counter_out1 <= to_unsigned(16#03F#, 9);
      ELSIF enb = '1' THEN
        IF rst_1 = '1' THEN 
          addr_counter_out1 <= to_unsigned(16#03F#, 9);
        ELSIF Logical_Operator_out1 = '1' THEN 
          IF addr_counter_out1 = to_unsigned(16#1FF#, 9) THEN 
            addr_counter_out1 <= to_unsigned(16#03F#, 9);
          ELSE 
            addr_counter_out1 <= addr_counter_out1 + to_unsigned(16#001#, 9);
          END IF;
        END IF;
      END IF;
    END IF;
  END PROCESS addr_counter_process;


  Delay5_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        Delay5_reg <= (OTHERS => to_unsigned(16#000#, 9));
      ELSIF enb = '1' THEN
        Delay5_reg(0) <= addr_counter_out1;
        Delay5_reg(1 TO 2) <= Delay5_reg(0 TO 1);
      END IF;
    END IF;
  END PROCESS Delay5_process;

  Delay5_out1 <= Delay5_reg(2);

  addr <= std_logic_vector(Delay5_out1);

  Delay6_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        Delay6_out1 <= '0';
      ELSIF enb = '1' THEN
        Delay6_out1 <= Delay3_out1;
      END IF;
    END IF;
  END PROCESS Delay6_process;


  Delay_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        Delay_out1 <= '0';
      ELSIF enb = '1' THEN
        Delay_out1 <= Delay6_out1;
      END IF;
    END IF;
  END PROCESS Delay_process;


  Delay1_ctrl_const_out <= '1';

  Delay1_ctrl_delay_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        Delay1_ctrl_delay_out <= '0';
      ELSIF enb = '1' THEN
        Delay1_ctrl_delay_out <= Delay1_ctrl_const_out;
      END IF;
    END IF;
  END PROCESS Delay1_ctrl_delay_process;


  Bit_Rotate_out1 <= Delay1_out1 rol 1;

  Delay1_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        Delay1_out <= to_unsigned(0, 64);
      ELSIF enb = '1' THEN
        Delay1_out <= Switch1_out1;
      END IF;
    END IF;
  END PROCESS Delay1_process;


  
  Delay1_out1 <= unsigned'(X"8000000000000000") WHEN Delay1_ctrl_delay_out = '0' ELSE
      Delay1_out;

  
  Switch1_out1 <= Delay1_out1 WHEN Delay6_out1 = '0' ELSE
      Bit_Rotate_out1;

  
  Switch2_out1 <= to_unsigned(0, 64) WHEN Delay_out1 = '0' ELSE
      Switch1_out1;

  Delay2_process : PROCESS (clk)
  BEGIN
    IF clk'EVENT AND clk = '1' THEN
      IF reset = '1' THEN
        Delay2_out1 <= to_unsigned(0, 64);
      ELSIF enb = '1' THEN
        Delay2_out1 <= Switch2_out1;
      END IF;
    END IF;
  END PROCESS Delay2_process;
  
  we_i_process: process(clk)
  begin
    if clk'event and clk = '1' then
      if reset = '1' or rst = '1' then
        we_i <= x"0000000000000001";
      elsif valid_d2 = '1' then
        we_i <= we_next;
      else
        we_i <= we_i;
      end if;
    end if;
  end process;
  
  we_next <= we_i(62 downto 0) & we_i(63);


  --we <= std_logic_vector(Delay2_out1);
  we <= we_i when valid_d1 = '1' else x"0000000000000000";

END rtl;

