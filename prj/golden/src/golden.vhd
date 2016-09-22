-------------------------------------------------------------------------
-- Engineer    : Golovachenko Victor
--
-- Create Date : 22.09.2016 10:15:46
-- Module Name : golden
--
-- Description :
--
--------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

entity golden is
port (
p_out_usrled : out std_logic_vector(3 downto 0);
p_in_sys_clk_n : in std_logic;
p_in_sys_clk_p : in std_logic
);
end entity golden;

architecture behavioral of golden is

component fpga_test_01 is
generic (
G_BLINK_T05 : integer:=10#125#; -- 1/2 периода мигания светодиода.(время в ms)
G_CLK_T05us : integer:=10#1000# -- кол-во периодов частоты порта p_in_clk
                                -- укладывающиеся в 1/2 периода 1us
);
port (
p_out_test_led  : out std_logic;
p_out_test_done : out std_logic;

p_out_1us : out std_logic;
p_out_1ms : out std_logic;
p_out_1s  : out std_logic;
-------------------------------
--System
-------------------------------
p_in_clken : in std_logic;
p_in_clk   : in std_logic;
p_in_rst   : in std_logic
);
end component fpga_test_01;

signal i_test_led : std_logic;
signal g_sys_clk  : std_logic;


begin --architecture behavioral

m_buf : IBUFGDS port map(I => p_in_sys_clk_p, IB => p_in_sys_clk_n, O => g_sys_clk);

m_led : fpga_test_01
generic map(
G_BLINK_T05 => 10#250#,
G_CLK_T05us => 10#62#
)
port map (
p_out_test_led  => i_test_led,
p_out_test_done => open,

p_out_1us  => open,
p_out_1ms  => open,
p_out_1s   => open,
-------------------------------
--System
-------------------------------
p_in_clken => '1',
p_in_clk   => g_sys_clk,
p_in_rst   => '0'
);

p_out_usrled(0) <= i_test_led;
p_out_usrled(1) <= '0';
p_out_usrled(2) <= '0';
p_out_usrled(3) <= i_test_led;


end architecture behavioral;
