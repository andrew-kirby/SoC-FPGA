library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;
use ieee.std_logic_textio.all;

entity add1_tb is
end entity;

architecture add1_tb_arch of add1_tb is

component add1
	generic(
		width : natural := 8
	);
	port(
		clk	: in 	std_logic;
		num_in	: in 	unsigned(width downto 0);
		num_out	: out 	unsigned(width downto 0)
	);
end component;

--------------------------------------------------------
-- TESTBENCH INTERNAL SIGNALS --------------------------
--------------------------------------------------------
file file_VECTORS : text;
file file_OUTPUT  : text;

constant WIDTH : natural := 16;

signal clk 	: std_logic := '0';
signal num_in	: unsigned(WIDTH-1 downto 0);
signal num_out	: unsigned(WIDTH-1 downto 0);

begin

-- Instantiate the adder
adder : add1 
generic map (
	width => WIDTH
)
port map (
	clk 	=> clk,
	num_in 	=> num_in,
	num_out => num_out
);

-- Drive the numbers through
stimulus : process
	variable input_line	: line;
	variable output_line	: line;
	variable input_num	: std_logic_vector(WIDTH-1 downto 0);


	--file test_vector : text open read_mode is "input"; -- The file to be opened
	--variable row : line; -- One line from the file
	--variable row_counter : integer := 0; -- Tracks the line being read
	--variable num_int : integer; -- The number read from a line

	begin

	clk <= '0'; -- Set the clock low

	file_open(file_VECTORS, "input", read_mode);
	file_open(file_OUTPUT, "output", write_mode);

	while not endfile(file_VECTORS) loop
		-- Read in a line from the file
		readline(file_VECTORS, input_line);
		read(input_line, input_num);
		-- Assign the input number to the signal linked to the adder
		num_in <= unsigned(input_num);

		wait for 10 ns;
		
		clk <= '1'; -- Clock the line so the adder adds

		wait for 50 ns;

		-- Create a line from the output of the adder
		write(output_line, std_logic_vector(num_out));
		--write(output_line, num_out, right, WIDTH);
		writeline(file_OUTPUT, output_line);	

		clk <= '0'; -- Set the clock low
	end loop;

	file_close(file_VECTORS);
	file_close(file_OUTPUT);

	wait;

	--if(rising_edge(clk)) then
		--if(not endfile(test_vector)) then
		--	readline(test_vector, row);
		--	read(row, num_int);
		--	num_in <= to_unsigned(num_int, 16);
		--end if;
	--end if;
end process;


end architecture;