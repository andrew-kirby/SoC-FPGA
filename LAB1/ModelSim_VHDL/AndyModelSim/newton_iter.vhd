library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity newton_iter is

	generic (W_bits		: positive := 16;
		 F_bits		: positive := 8;
		 N_iterations	: positive := 3);

	port	(clk  : in  std_logic;
		 x    : in  std_logic_vector(W_bits-1 downto 0);
		 yn   : in  std_logic_vector(W_bits-1 downto 0);
		 yn_1 : out std_logic_vector(W_bits-1 downto 0));

end entity newton_iter;

architecture newton_iter_arch of newton_iter is

	signal x_uns    : unsigned(W_bits-1 downto 0);
	signal yn_uns   : unsigned(W_bits-1 downto 0);
	signal yn_1_out : std_logic_vector(W_bits-1 downto 0);
	
begin

	process(clk)
	begin
	   if rising_edge(clk) then
		x_uns  <= unsigned(x(W_bits-1 downto 0));
		yn_uns <= unsigned(yn(W_bits-1 downto 0));
	   end if;
	end process;

	process(x_uns, yn_uns)
	   --variable ynpow2_uns 		: unsigned((W_bits*2)-1 downto 0);
	   --variable ynx_uns    		: unsigned((W_bits*3)-1 downto 0);
	   --variable ynx_min_3_uns 	: unsigned((W_bits*3)-1 downto 0);
	   --variable ynx_min_3_32_uns 	: unsigned((W_bits*2)-1 downto 0);
	   --variable ynx_32_uns		: unsigned((W_bits*2)-1 downto 0);
	   --variable ynynx_uns  		: unsigned((W_bits*2)-1 downto 0);
	   --variable yn_1_uns   		: unsigned((W_bits*2)-1 downto 0);

		variable ynpow2		: unsigned((W_bits*2)-1 downto 0);
		variable ynx		: unsigned((W_bits*3)-1 downto 0);
		variable ynx_min_3	: unsigned((W_bits*3)-1 downto 0);
		variable ynynx		: unsigned((W_bits*4)-1 downto 0);
		variable yn_1_large	: unsigned((W_bits*4)-1 downto 0);
	


	begin
		
		ynpow2		:= yn_uns*yn_uns; -- yn^2;
		ynx 		:= ynpow2*x_uns; -- x*yn^2;
		ynx_min_3	:= shift_left(to_unsigned(3, W_bits*3), F_bits*3) - ynx; -- 3 - x*yn^2
		ynynx		:= yn_uns*ynx_min_3;
		yn_1_large	:= shift_right(ynynx, 1); --(yn*(3-x*yn^2))/2
		


	   --ynpow2_uns 		:= yn_uns*yn_uns;            --yn^2
	   --ynx_uns    		:= ((ynpow2_uns*x_uns)); -- x*y^2	   
   	   --ynx_32_uns 		:= ynx_uns((W_bits*2)+F_bits-1 downto F_bits); -- Cast back
	   --ynx_min_3_uns 	:= 3 - ynx_uns;	-- 3 - x*yn^2
	   --ynx_min_3_32_uns	:= ynx_min_3_uns((W_bits*2)+F_bits-1 downto F_bits); -- Cast back
	   --ynynx_uns 		:= yn_uns*ynx_min_3_32_uns;  --yn*(3-x*yn^2)
	   --yn_1_uns   		:= shift_right(ynynx_uns, 1);--(yn*(3-x*yn^2))/2
	   
	   --yn_1_out <= std_logic_vector( yn_1_large( (W_bits+3*F_bits)-1 downto (3*F_bits) ) ); --output
	   yn_1_out <= std_logic_vector( yn_1_large( ( (W_bits+3*F_bits)-1) downto ((3*F_bits)) ) ); --output
	end process;
	
	yn_1 <= yn_1_out; --std_logic_vector(yn_1_out((W_bits+2*F_bits)-1 downto (2*F_bits)));

end newton_iter_arch;