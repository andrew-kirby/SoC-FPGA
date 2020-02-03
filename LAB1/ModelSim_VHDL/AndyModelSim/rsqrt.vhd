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

-- COMPONENT DECLARATIONS --
component compute_y0 is

	generic (W_bits		: positive := 16;
		 F_bits		: positive := 8);

	port	(clk  	: in  std_logic;
		 x    	: in  std_logic_vector(W_bits-1 downto 0);
		 x_out	: out std_logic_vector(W_bits-1 downto 0);
		 y0 	: out std_logic_vector((W_bits)-1 downto 0));

end component compute_y0;

component newton_iter_block is

	generic (W_bits		: positive := 16;
		 F_bits		: positive := 8;
		 N_iterations	: positive := 3);

	port	(clk  	: in  std_logic;
		 x    	: in  std_logic_vector(W_bits-1 downto 0);
		 y0   	: in  std_logic_vector(W_bits-1 downto 0);
		 y 	: out std_logic_vector((W_bits)-1 downto 0));

end component newton_iter_block;

-- SIGNALS --
signal x_inbetween 	: std_logic_vector(W_bits-1 downto 0);
signal y0 		: std_logic_vector(W_bits-1 downto 0);

begin

	-- Instantiate components
	Y0_1: compute_y0 
		generic map(
			W_bits => W_bits,
			F_bits => F_bits
		)
		port map(
			clk => clk,
			x => x,
			x_out => x_inbetween,
			y0 => y0			
		);

	NEWTON_BLOCK_1: newton_iter_block
		generic map(
			W_bits => W_bits,
			F_bits => F_bits,
			N_iterations => N_iterations
		)
		port map(
			clk => clk,
			x => x_inbetween,
			y0 => y0,
			y => y
		);
end rsqrt_arch;