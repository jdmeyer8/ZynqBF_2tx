----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/02/2019 02:14:07 PM
-- Design Name: 
-- Module Name: ZynqBF_2tx_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use STD.TEXTIO.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ZynqBF_2tx_tb is
end ZynqBF_2tx_tb;

architecture Behavioral of ZynqBF_2tx_tb is

component ZynqBF_2t_ip_src_ZynqBF_2tx_fpga
port(
    clk:            in std_logic;
    reset:          in std_logic;
    clk_enable:     in std_logic;
    rx_i_in:        in std_logic_vector(15 downto 0);
    rx_q_in:        in std_logic_vector(15 downto 0);
    rx_v_in:        in std_logic;
    ce_out_0:       out std_logic;
    ce_out_1:       out std_logic;
    rx_i_out:       out std_logic_vector(15 downto 0);
    rx_q_out:       out std_logic_vector(15 downto 0);
    rx_v_out:       out std_logic;
    ch1_i:          out std_logic_vector(15 downto 0);
    ch1_q:          out std_logic_vector(15 downto 0);
    ch2_i:          out std_logic_vector(15 downto 0);
    ch2_q:          out std_logic_vector(15 downto 0);
    probe:          out std_logic_vector(15 downto 0)
);
end component;

signal clk:         std_logic := '1';   -- 420kHz*128 clock
signal clk420:      std_logic := '1';          -- 420kHz clock
signal clk420_cnt:  std_logic_vector(7 downto 0) := x"00";
signal reset:       std_logic := '1';

signal rx_i_in:     std_logic_vector(15 downto 0);
signal rx_q_in:     std_logic_vector(15 downto 0);
signal rx_v_in:     std_logic;

signal ce_out_0:    std_logic;
signal ce_out_1:    std_logic;

signal rx_i_out:    std_logic_vector(15 downto 0);
signal rx_q_out:    std_logic_vector(15 downto 0);
signal rx_v_out:    std_logic;

signal ch1_i:       std_logic_vector(15 downto 0);
signal ch1_q:       std_logic_vector(15 downto 0);
signal ch2_i:       std_logic_vector(15 downto 0);
signal ch2_q:       std_logic_vector(15 downto 0);
signal probe:       std_logic_vector(15 downto 0);

-- File i/o signals
signal iline:       line;
signal 


begin

-- clock for 420kHz radio sample rate
-- 420kHz * 128 = 53.76 MHz
clk <= not clk after 9.3006 ns;

-- reset for 200 ns
reset <= '1', '0' after 200 ns;

clk420_gen: process(clk) is
begin
    if rising_edge(clk) then
        if clk420_cnt >= x"7F" then
            clk420_cnt <= x"00";
            clk420 <= not clk420;
        else
            clk420_cnt <= clk420_cnt + x"01";
            clk420 <= clk420;
        end if;
    end if;
end process;

rx_i_in <= x"0000";
rx_q_in <= x"0000";
rx_v_in <= '1';


dut: ZynqBF_2t_ip_src_ZynqBF_2tx_fpga
port map(
    clk => clk,
    reset => reset,
    clk_enable => '1',
    rx_i_in => rx_i_in,
    rx_q_in => rx_q_in,
    rx_v_in => rx_v_in,
    ce_out_0 => ce_out_0,
    ce_out_1 => ce_out_1,
    rx_i_out => rx_i_out,
    rx_q_out => rx_q_out,
    rx_v_out => rx_v_out,
    ch1_i => ch1_i,
    ch1_q => ch1_q,
    ch2_i => ch2_i,
    ch2_q => ch2_q,
    probe => probe
);

end Behavioral;
