library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity add1 is
generic(
	width : natural := 8
);
port(
	clk	: in 	std_logic;
	num_in	: in 	unsigned(width-1 downto 0);
	num_out	: out 	unsigned(width-1 downto 0)
);
end entity;

architecture add1_arch of add1 is

begin

process(clk)
	begin
	if(rising_edge(clk)) then
		num_out <= num_in + 1;
	end if;
end process;
	
end architecture;
