library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity rsqrt is

	generic (W_bits		: positive := 16;
		 F_bits		: positive := 8;
		 N_iterations	: positive := 3);

	port	(clk : in  std_logic;
		 x   : in  std_logic_vector(W_bits-1 downto 0);
		 y   : out std_logic_vector(W_bits-1 downto 0));

end entity rsqrt;

architecture rsqrt_arch of rsqrt is

begin

end rsqrt_arch;