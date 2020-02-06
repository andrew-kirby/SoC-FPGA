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
signal x4 	: std_logic_vector((W_bits*2)-1 downto 0);
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
signal y0_big   : std_logic_vector((W_bits+13)-1 downto 0); --13 from LUT value output bits

-- LUT SIGNALS --
signal num_in	: std_logic_vector(W_bits-1 downto 0);
signal x_b_exp	: std_logic_vector(W_bits-1 downto 0);

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
			if((B_int mod 2) = 0) then -- B even
				A_int <= (-2 * B_int) + (B_int / 2); --always negative
			else -- B odd
				A_int <= -2*B_int + B_int/2 + 1; --always negative
			end if;
			-- Compute Xa and Xb
			x4(W_bits-1 downto 0) <= x3; -- made x4 bigger so that it can be used for the left shift
			B2_int <= B_int;
			-- Andy, I think these two below can be replaced by what I put in place
				-- x_a <= std_logic_vector( unsigned(x4) * shift_left(to_unsigned(1, W_bits), (F_bits + A_int)) );
				-- x_b <= std_logic_vector( unsigned(x4) * shift_left(to_unsigned(1, W_bits), (F_bits + A_int)) );
			-- but I could be wrong so check me. Look at 4 & 5 on the lab handout
			x_a <= std_logic_vector(shift_left(unsigned(x4), A_int)); -- replaced previous -- only need the fractional bits so don't need to worry about size, radix stays in same place
			x_b <= std_logic_vector(shift_right(unsigned(x4), B_int)); -- replaced previous -- only need the fractional bits so don't need to worry about size, radix stays in same place
			B3_int <= B2_int;
			-- Use lookup table
			num_in <= std_logic_vector(x_b(F_bits-1 downto F_bits-8)); -- only need the fractional bits so don't need to worry about size, radix stays in same place
			B4_int <= B3_int;
			x_a2 <= x_a;
			if((B4_int mod 2) = 0) then -- B even
			    y0_big <= std_logic_vector(unsigned(x_b_exp) * unsigned(x_a2)); -- this step adds 12 fractional bits
			    y0     <= y0_big(W_bits+11 downto F_bits+11); -- +11 because 12-1
			else -- B odd
			    y0_big <= std_logic_vector(unsigned(x_b_exp) * unsigned(x_a2) * two_exp); -- this step adds 12 fractional bits
			    y0     <= y0_bit(W_bits+11 downto F_bits+11);
			end if;						

		end if;		
	end process;


end architecture;