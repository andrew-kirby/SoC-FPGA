library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity newton_iter_tb is
end entity;

architecture newton_iter_tb_arch of newton_iter_tb is

component newton_iter is

	generic (W_bits		: positive := 16;
		 F_bits		: positive := 8;
		 N_iterations	: positive := 3);

	port	(clk  : in  std_logic;
		 x    : in  std_logic_vector(W_bits-1 downto 0);
		 yn   : in  std_logic_vector(W_bits-1 downto 0);
		 yn_1 : out std_logic_vector((W_bits)-1 downto 0));

end component newton_iter;

--------------------------------------------------------
-- TESTBENCH INTERNAL SIGNALS --------------------------
--------------------------------------------------------
file file_VECTORS : text;
file file_OUTPUT  : text;

constant W 	: natural := 16;
constant F 	: natural := 8;
constant N 	: natural := 3;

signal clk 	: std_logic := '0';
signal num_in	: std_logic_vector(W-1 downto 0);
signal num_out	: std_logic_vector((W)-1 downto 0);
signal y1       : std_logic_vector((W)-1 downto 0);
signal y2       : std_logic_vector((W)-1 downto 0);

begin
--instantiate the newton_iter
NEWTON_ITER_1 : newton_iter
   generic map(
	W_bits => W,
    	F_bits => F,
	N_iterations => N)

   port map(
	clk => clk,
	x   => num_in,
	yn  => "0000000010000000",
	yn_1 => y1);

NEWTON_ITER_2 : newton_iter
   generic map(
	W_bits => W,
    	F_bits => F,
	N_iterations => N)

   port map(
	clk => clk,
	x   => num_in,
	yn  => y1,
	yn_1 => y2);

NEWTON_ITER_3 : newton_iter
   generic map(
	W_bits => W,
    	F_bits => F,
	N_iterations => N)

   port map(
	clk => clk,
	x   => num_in,
	yn  => y2,
	yn_1 => num_out);	

-- Drive the numbers through
stimulus : process
	variable input_line	: line;
	variable output_line	: line;
	variable input_num	: std_logic_vector(W-1 downto 0);

	begin

	clk <= '0'; -- Set the clock low

	file_open(file_VECTORS, "input.txt", read_mode);
	file_open(file_OUTPUT, "vhdl_results.txt", write_mode);

	while not endfile(file_VECTORS) loop
		-- Read in a line from the file
		readline(file_VECTORS, input_line);
		read(input_line, input_num);
		-- Assign the input number to the signal linked to the adder
		num_in <= input_num;

		wait for 10 ns;
		
		clk <= '1'; -- Clock the line so the adder adds

		wait for 50 ns;

		-- Create a line from the output of the adder
		write(output_line, num_out);
		writeline(file_OUTPUT, output_line);	

		clk <= '0'; -- Set the clock low
	end loop;

	file_close(file_VECTORS);
	file_close(file_OUTPUT);

	wait;
end process;

end architecture;
