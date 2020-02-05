library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

entity rsqrt_LUT_tb is
end entity;

architecture rsqrt_LUT_tb_arch of rsqrt_LUT_tb is

component rsqrt_LUT is

	PORT
	(
		address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		q		: OUT STD_LOGIC_VECTOR (12 DOWNTO 0)
	);

end component rsqrt_LUT;

--------------------------------------------------------
-- TESTBENCH INTERNAL SIGNALS --------------------------
--------------------------------------------------------

signal clk 	: std_logic := '0';
signal num_in	: std_logic_vector(7 downto 0) := "00000000";
signal num_out  : std_logic_vector(12 downto 0);

begin
--instantiate the ROM

ROM_1 : rsqrt_LUT
   port map(
	address => num_in,
	clock   => clk,
	q       => num_out);

-- Drive the numbers through
stimulus : process
	variable input_num	: std_logic_vector(7 downto 0) := "00000000";
	variable input_num_uns  : unsigned(7 downto 0) := "00000000";

	begin

	for num in 0 to 10 loop

	   clk <= '1'; -- clock the line

	   wait for 50 ns;

	   clk <= '0';

	   wait for 50 ns;

           num_in <= input_num;   

	   input_num_uns := unsigned(input_num);
	   input_num_uns := input_num_uns + 25;
	   input_num := std_logic_vector(input_num_uns);	

	end loop;
end process;

end architecture;

