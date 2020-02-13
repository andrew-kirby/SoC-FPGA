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
        lzc_count  : out std_logic_vector ( 3 downto 0) --!!HAVE TO CHANGE IF REGENERATED!!
    );
end component lzc;

component rsqrt_LUT is
    port (
	address		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	clock		: IN STD_LOGIC  := '1';
	q		: OUT STD_LOGIC_VECTOR (12 DOWNTO 0)
    );

end component rsqrt_LUT;

-- CONSTANTS --
constant two_exp : unsigned(15 downto 0) := "1011010100000100";

-- SIGNALS --
signal x1 	: std_logic_vector(W_bits-1 downto 0);
signal x2 	: std_logic_vector(W_bits-1 downto 0);
signal x3 	: std_logic_vector(W_bits-1 downto 0);
signal x4 	: std_logic_vector(W_bits-1 downto 0);
signal x5 	: std_logic_vector(W_bits-1 downto 0);
signal x6 	: std_logic_vector(W_bits-1 downto 0);
signal x7 	: std_logic_vector(W_bits-1 downto 0);
signal x8 	: std_logic_vector(W_bits-1 downto 0);
signal x9 	: std_logic_vector(W_bits-1 downto 0);
signal x10 	: std_logic_vector(W_bits-1 downto 0);
signal x11 	: std_logic_vector(W_bits-1 downto 0);
signal Z 	: std_logic_vector(3 downto 0); --!!HAVE TO CHANGE IF REGENERATED!!
signal Z_int	: integer;
signal B_int 	: integer;
signal B2_int 	: integer;
signal B3_int 	: integer;
signal B4_int 	: integer;
signal B5_int 	: integer;
signal A_int	: integer;
signal x_a	: std_logic_vector(W_bits-1 downto 0);
signal x_a2	: std_logic_vector(W_bits-1 downto 0);
signal x_a3	: std_logic_vector(W_bits-1 downto 0);
signal x_a4	: std_logic_vector(W_bits-1 downto 0);
signal x_b	: std_logic_vector(W_bits-1 downto 0);
signal y0_big   : std_logic_vector((W_bits+16+13)-1 downto 0); --13 from LUT value output bits 16 from the potential of 2^1/2 fraction

-- LUT SIGNALS --
signal num_in	: std_logic_vector(7 downto 0); -- hard coded due to LUT premade
signal x_b_exp	: std_logic_vector(12 downto 0);

begin

	-- INSTANTIATE THE COMPONENTS --
	LZC_1 : lzc port map(
		clk => clk,
		lzc_vector => x1,
		lzc_count => Z);

	ROM_1 : rsqrt_LUT
    	    port map(
		address => num_in,
		clock   => clk,
		q       => x_b_exp);

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
			B2_int <= B_int;
			if((B2_int mod 2) = 0) then -- B even
				A_int <= (-2 * B2_int) + (B2_int / 2); --always negative
			else -- B odd
				A_int <= -2*B2_int + B2_int/2 + 1; --always negative
			end if;
			-- Compute Xa and Xb
			x4 <= x3;
			x5 <= x4;
			x6 <= x5;
			x7 <= x6;
			x8 <= x7;
			x9 <= x8;
			x10 <= x9;
			x11 <= x10;
			B3_int <= B2_int;
			x_a <= std_logic_vector(shift_left(unsigned(x6), A_int)); -- replaced previous -- only need the fractional bits so don't need to worry about size, radix stays in same place
			x_b <= std_logic_vector(shift_right(unsigned(x6), B3_int)); -- replaced previous -- only need the fractional bits so don't need to worry about size, radix stays in same place
			-- Use lookup table to get XB to the -3/2
			--! need to append 0s if F < 8
			num_in <= std_logic_vector(x_b(F_bits-1 downto F_bits-8)); -- only need the fractional bits so don't need to worry about size, radix stays in same place

			B4_int <= B3_int;
			x_a2 <= x_a;
			--num_in <= std_logic_vector(x_b(F_bits-1 downto F_bits-8)); -- only need the fractional bits so don't need to worry about size, radix stays in same place
			-- compute Y0

			B5_int <= B4_int;
			x_a3 <= x_a2;
			x_a4 <= x_a3;
			if((B5_int mod 2) = 0) then -- B even
			    y0_big(y0_big'length-1 downto y0_big'length-W_bits-13) <= std_logic_vector(unsigned(x_b_exp) * unsigned(x_a4)); -- this step adds 12 fractional bits
			else -- B odd
			    y0_big <= (std_logic_vector(unsigned(x_b_exp) * unsigned(x_a4) * two_exp)); -- this step adds 12 fractional bits
			end if;				

			y0 <= y0_big(y0_big'length-2 downto y0_big'length-W_bits-1);
			x_out <= x11;


		end if;		
	end process;


end architecture;