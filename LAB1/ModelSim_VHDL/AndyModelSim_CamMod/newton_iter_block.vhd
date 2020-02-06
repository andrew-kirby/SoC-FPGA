library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity newton_iter_block is

	generic (W_bits		: positive := 16;
		 F_bits		: positive := 8;
		 N_iterations	: positive := 3);

	port	(clk  	: in  std_logic;
		 x    	: in  std_logic_vector(W_bits-1 downto 0);
		 y0   	: in  std_logic_vector(W_bits-1 downto 0);
		 y 	: out std_logic_vector((W_bits)-1 downto 0));

end entity newton_iter_block;

architecture newton_iter_block_arch of newton_iter_block is

-- Component Declarations --
component newton_iter is

	generic (W_bits		: positive := 16;
		 F_bits		: positive := 8);

	port	(clk  	: in  std_logic;
		 x    	: in  std_logic_vector(W_bits-1 downto 0);
		 yn   	: in  std_logic_vector(W_bits-1 downto 0);
		 yn_1	: out std_logic_vector(W_bits-1 downto 0);
		 x_out	: out std_logic_vector(W_bits-1 downto 0));

end component newton_iter;


-- Declare signals that will connect the newton iteration blocks together --
signal x_chain 		: std_logic_vector((W_bits*(N_iterations+1) - 1) downto 0);
signal yn_chain 	: std_logic_vector((W_bits*(N_iterations+1) - 1) downto 0);

begin

	-- Assign inputs --
	x_chain(W_bits*(N_iterations+1)-1 downto W_bits*N_iterations) <= x;
	yn_chain(W_bits*(N_iterations+1)-1 downto W_bits*N_iterations) <= y0;	
	
	-- Assign outputs --
	y <= yn_chain(W_bits-1 downto 0);

	-- GENERATE THE NEWTON ITERATION BLOCKS  --
	ITERATION_LOOP: for i in (N_iterations) downto 1 generate
		ITER: newton_iter
  			generic map(
				W_bits => W_bits,
    				F_bits => F_bits)
			port map(
				clk => clk,
				x   => x_chain(W_bits*(i+1)-1 downto W_bits*i),
				yn  => yn_chain(W_bits*(i+1)-1 downto W_bits*i),
				yn_1 => yn_chain(W_bits*i-1 downto W_bits*(i-1)),
				x_out => x_chain(W_bits*i-1 downto W_bits*(i-1)) );
	end generate ITERATION_LOOP;




end newton_iter_block_arch;