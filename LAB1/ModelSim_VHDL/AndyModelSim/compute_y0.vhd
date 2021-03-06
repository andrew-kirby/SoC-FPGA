library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity compute_y0 is

	generic (W_bits		: positive := 16;
		 F_bits		: positive := 8);

	port	(clk  	: in  std_logic;
		 x    	: in  std_logic_vector(W_bits-1 downto 0);
		 x_out	: out std_logic_vector(W_bits-1 downto 0);
		 y0 	: out std_logic_vector((W_bits)-1 downto 0));

end entity compute_y0;

architecture compute_y0_arch of compute_y0 is

-- DECLARE COMPONENTS -- 
component lzc is
    port (
        clk        : in  std_logic;
        lzc_vector : in  std_logic_vector (15 downto 0);
        lzc_count  : out std_logic_vector ( 3 downto 0)
    );
end component lzc;

-- SIGNALS --
signal x1 	: std_logic_vector(W_bits-1 downto 0);
signal x2 	: std_logic_vector(W_bits-1 downto 0);
signal x3 	: std_logic_vector(W_bits-1 downto 0);
signal x4 	: std_logic_vector(W_bits-1 downto 0);
signal Z 	: std_logic_vector(W_bits-1 downto 0);
signal Z_int	: integer;
signal B_int 	: integer;
signal B2_int 	: integer;
signal B3_int 	: integer;
signal B4_int 	: integer;
signal A_int	: integer;
signal x_a	: std_logic_vector(W_bits-1 downto 0);
signal x_a2	: std_logic_vector(W_bits-1 downto 0);
signal x_b	: std_logic_vector(W_bits-1 downto 0);

signal x_b_exp	: std_logic_vector(W_bits-1 downto 0);


begin

	-- INSTANTIATE THE COMPONENT --
	LZC_1 : lzc port map(
		clk => clk,
		lzc_vector => x1,
		lzc_count => Z);

	main_proc : process(clk)
		begin
		if(rising_edge(clk)) then
			-- propagate values forward
			-- Compute Z
			x1 <= x;
			Z_int <= to_integer(unsigned(Z));
			-- Compute Beta
			x2 <= x1;
			B_int <= W_bits - F_bits - Z_int - 1;
			-- Compute Alpha
			x3 <= x2;
			if((B_int mod 2) = 0) then -- B even
				A_int <= (-2 * B_int) + (B_int / 2);
			else -- B odd
				A_int <= -2*B_int + B_int/2 + 1;
			end if;
			-- Compute Xa and Xb
			x4 <= x3;
			B2_int <= B_int;
			x_a <= std_logic_vector( unsigned(x4) * shift_left(to_unsigned(1, W_bits), (F_bits + A_int)) );
			x_b <= std_logic_vector( unsigned(x4) * shift_left(to_unsigned(1, W_bits), (F_bits + A_int)) );
			-- Use lookup table
			B3_int <= B2_int;
			
			--INSERT STUFF HERE
			
			
		end if;		
	end process;


end architecture;