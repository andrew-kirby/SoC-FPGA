library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity newton_iter is

	generic (W_bits		: positive := 16;
		 F_bits		: positive := 8;
		 N_iterations	: positive := 3);

	port	(clk  : in  std_logic
		 x    : in  std_logic_vector(W_bits-1 downto 0);
		 yn   : in  std_logic_vector(W_bits-1 downto 0);
		 yn_1 : out std_logic_vector(W_bits-1 downto 0));

end entity newton_iter;

architecture newton_iter_arch of newton_arch is

	signal x_uns  : unsigned(W-bits-1 downto 0);
	signal yn_uns : unsigned(W-bits-1 downto 0);
	
begin

	process(clk)
	begin
	   if rising_edge(clk) then
		x_uns  <= unsigned(x(W_bits-1 downto 0));
		yn_uns <= unsigned(yn(W_bits-1 downto 0));
	   end if;
	end process;

	process(x_uns, yn_uns)
	   variable ynpow2_uns : unsigned((W_bits*2)-1 downto 0);

	begin
	   ynpow2_uns := yn_uns*yn_uns;
	   
	   
	end process;
	

end newton_iter_arch;