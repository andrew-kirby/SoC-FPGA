library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity lzc is
    port (
        clk        : in  std_logic;
        lzc_vector : in  std_logic_vector (15 downto 0);
        lzc_count  : out std_logic_vector ( 3 downto 0)
    );
end lzc;

architecture behavioral of lzc is

    signal b0 : std_logic;
    signal b1 : std_logic;
    signal b2 : std_logic;
    signal b3 : std_logic;
    signal b4 : std_logic;
    signal b5 : std_logic;
    signal b6 : std_logic;
    signal b7 : std_logic;
    signal b8 : std_logic;
    signal b9 : std_logic;
    signal b10 : std_logic;
    signal b11 : std_logic;
    signal b12 : std_logic;
    signal b13 : std_logic;
    signal b14 : std_logic;
    signal b15 : std_logic;

begin

    process (clk)
    begin
        if rising_edge(clk) then
            b0 <= lzc_vector(0);
            b1 <= lzc_vector(1);
            b2 <= lzc_vector(2);
            b3 <= lzc_vector(3);
            b4 <= lzc_vector(4);
            b5 <= lzc_vector(5);
            b6 <= lzc_vector(6);
            b7 <= lzc_vector(7);
            b8 <= lzc_vector(8);
            b9 <= lzc_vector(9);
            b10 <= lzc_vector(10);
            b11 <= lzc_vector(11);
            b12 <= lzc_vector(12);
            b13 <= lzc_vector(13);
            b14 <= lzc_vector(14);
            b15 <= lzc_vector(15);
        end if;
    end process;
 
    process (b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15 )
    begin

        if ((b15 or b14 or b13 or b12 or b11 or b10 or b9 or b8) = '1') then   -- [15   8]
            if ((b15 or b14 or b13 or b12) = '1') then   -- [15  12]
                if ((b15 or b14) = '1') then   -- [15  14]
                    if (b15 = '1') then   -- [15]
                        lzc_count <= "0000";  -- lzc = 0
                    else  -- [14]
                        lzc_count <= "0001";  -- lzc = 1
                    end if;
                else  -- [13  12]
                    if (b13 = '1') then   -- [13]
                        lzc_count <= "0010";  -- lzc = 2
                    else  -- [12]
                        lzc_count <= "0011";  -- lzc = 3
                    end if;
                end if; 
            else  -- [11   8]
                if ((b11 or b10) = '1') then   -- [11  10]
                    if (b11 = '1') then   -- [11]
                        lzc_count <= "0100";  -- lzc = 4
                    else  -- [10]
                        lzc_count <= "0101";  -- lzc = 5
                    end if;
                else  -- [9  8]
                    if (b9 = '1') then   -- [9]
                        lzc_count <= "0110";  -- lzc = 6
                    else  -- [8]
                        lzc_count <= "0111";  -- lzc = 7
                    end if;
                end if; 
            end if; 
        else  -- [7  0]
            if ((b7 or b6 or b5 or b4) = '1') then   -- [7  4]
                if ((b7 or b6) = '1') then   -- [7  6]
                    if (b7 = '1') then   -- [7]
                        lzc_count <= "1000";  -- lzc = 8
                    else  -- [6]
                        lzc_count <= "1001";  -- lzc = 9
                    end if;
                else  -- [5  4]
                    if (b5 = '1') then   -- [5]
                        lzc_count <= "1010";  -- lzc = 10
                    else  -- [4]
                        lzc_count <= "1011";  -- lzc = 11
                    end if;
                end if; 
            else  -- [3  0]
                if ((b3 or b2) = '1') then   -- [3  2]
                    if (b3 = '1') then   -- [3]
                        lzc_count <= "1100";  -- lzc = 12
                    else  -- [2]
                        lzc_count <= "1101";  -- lzc = 13
                    end if;
                else  -- [1  0]
                    if (b1 = '1') then   -- [1]
                        lzc_count <= "1110";  -- lzc = 14
                    else  -- [0]
                        lzc_count <= "1111";  -- lzc = 15
                    end if;
                end if; 
            end if; 
        end if; 

    end process;

end behavioral;
