library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity lzc is
    port (
        clk        : in  std_logic;
        lzc_vector : in  std_logic_vector (63 downto 0);
        lzc_count  : out std_logic_vector ( 5 downto 0)
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
    signal b16 : std_logic;
    signal b17 : std_logic;
    signal b18 : std_logic;
    signal b19 : std_logic;
    signal b20 : std_logic;
    signal b21 : std_logic;
    signal b22 : std_logic;
    signal b23 : std_logic;
    signal b24 : std_logic;
    signal b25 : std_logic;
    signal b26 : std_logic;
    signal b27 : std_logic;
    signal b28 : std_logic;
    signal b29 : std_logic;
    signal b30 : std_logic;
    signal b31 : std_logic;
    signal b32 : std_logic;
    signal b33 : std_logic;
    signal b34 : std_logic;
    signal b35 : std_logic;
    signal b36 : std_logic;
    signal b37 : std_logic;
    signal b38 : std_logic;
    signal b39 : std_logic;
    signal b40 : std_logic;
    signal b41 : std_logic;
    signal b42 : std_logic;
    signal b43 : std_logic;
    signal b44 : std_logic;
    signal b45 : std_logic;
    signal b46 : std_logic;
    signal b47 : std_logic;
    signal b48 : std_logic;
    signal b49 : std_logic;
    signal b50 : std_logic;
    signal b51 : std_logic;
    signal b52 : std_logic;
    signal b53 : std_logic;
    signal b54 : std_logic;
    signal b55 : std_logic;
    signal b56 : std_logic;
    signal b57 : std_logic;
    signal b58 : std_logic;
    signal b59 : std_logic;
    signal b60 : std_logic;
    signal b61 : std_logic;
    signal b62 : std_logic;
    signal b63 : std_logic;

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
            b16 <= lzc_vector(16);
            b17 <= lzc_vector(17);
            b18 <= lzc_vector(18);
            b19 <= lzc_vector(19);
            b20 <= lzc_vector(20);
            b21 <= lzc_vector(21);
            b22 <= lzc_vector(22);
            b23 <= lzc_vector(23);
            b24 <= lzc_vector(24);
            b25 <= lzc_vector(25);
            b26 <= lzc_vector(26);
            b27 <= lzc_vector(27);
            b28 <= lzc_vector(28);
            b29 <= lzc_vector(29);
            b30 <= lzc_vector(30);
            b31 <= lzc_vector(31);
            b32 <= lzc_vector(32);
            b33 <= lzc_vector(33);
            b34 <= lzc_vector(34);
            b35 <= lzc_vector(35);
            b36 <= lzc_vector(36);
            b37 <= lzc_vector(37);
            b38 <= lzc_vector(38);
            b39 <= lzc_vector(39);
            b40 <= lzc_vector(40);
            b41 <= lzc_vector(41);
            b42 <= lzc_vector(42);
            b43 <= lzc_vector(43);
            b44 <= lzc_vector(44);
            b45 <= lzc_vector(45);
            b46 <= lzc_vector(46);
            b47 <= lzc_vector(47);
            b48 <= lzc_vector(48);
            b49 <= lzc_vector(49);
            b50 <= lzc_vector(50);
            b51 <= lzc_vector(51);
            b52 <= lzc_vector(52);
            b53 <= lzc_vector(53);
            b54 <= lzc_vector(54);
            b55 <= lzc_vector(55);
            b56 <= lzc_vector(56);
            b57 <= lzc_vector(57);
            b58 <= lzc_vector(58);
            b59 <= lzc_vector(59);
            b60 <= lzc_vector(60);
            b61 <= lzc_vector(61);
            b62 <= lzc_vector(62);
            b63 <= lzc_vector(63);
        end if;
    end process;
 
    process (b0, b1, b2, b3, b4, b5, b6, b7, b8, b9, b10, b11, b12, b13, b14, b15, b16, b17, b18, b19, b20, b21, b22, b23, b24, b25, b26, b27, b28, b29, b30, b31, b32, b33, b34, b35, b36, b37, b38, b39, b40, b41, b42, b43, b44, b45, b46, b47, b48, b49, b50, b51, b52, b53, b54, b55, b56, b57, b58, b59, b60, b61, b62, b63 )
    begin

        if ((b63 or b62 or b61 or b60 or b59 or b58 or b57 or b56 or b55 or b54 or b53 or b52 or b51 or b50 or b49 or b48 or b47 or b46 or b45 or b44 or b43 or b42 or b41 or b40 or b39 or b38 or b37 or b36 or b35 or b34 or b33 or b32) = '1') then   -- [63  32]
            if ((b63 or b62 or b61 or b60 or b59 or b58 or b57 or b56 or b55 or b54 or b53 or b52 or b51 or b50 or b49 or b48) = '1') then   -- [63  48]
                if ((b63 or b62 or b61 or b60 or b59 or b58 or b57 or b56) = '1') then   -- [63  56]
                    if ((b63 or b62 or b61 or b60) = '1') then   -- [63  60]
                        if ((b63 or b62) = '1') then   -- [63  62]
                            if (b63 = '1') then   -- [63]
                                lzc_count <= "000000";  -- lzc = 0
                            else  -- [62]
                                lzc_count <= "000001";  -- lzc = 1
                            end if;
                        else  -- [61  60]
                            if (b61 = '1') then   -- [61]
                                lzc_count <= "000010";  -- lzc = 2
                            else  -- [60]
                                lzc_count <= "000011";  -- lzc = 3
                            end if;
                        end if; 
                    else  -- [59  56]
                        if ((b59 or b58) = '1') then   -- [59  58]
                            if (b59 = '1') then   -- [59]
                                lzc_count <= "000100";  -- lzc = 4
                            else  -- [58]
                                lzc_count <= "000101";  -- lzc = 5
                            end if;
                        else  -- [57  56]
                            if (b57 = '1') then   -- [57]
                                lzc_count <= "000110";  -- lzc = 6
                            else  -- [56]
                                lzc_count <= "000111";  -- lzc = 7
                            end if;
                        end if; 
                    end if; 
                else  -- [55  48]
                    if ((b55 or b54 or b53 or b52) = '1') then   -- [55  52]
                        if ((b55 or b54) = '1') then   -- [55  54]
                            if (b55 = '1') then   -- [55]
                                lzc_count <= "001000";  -- lzc = 8
                            else  -- [54]
                                lzc_count <= "001001";  -- lzc = 9
                            end if;
                        else  -- [53  52]
                            if (b53 = '1') then   -- [53]
                                lzc_count <= "001010";  -- lzc = 10
                            else  -- [52]
                                lzc_count <= "001011";  -- lzc = 11
                            end if;
                        end if; 
                    else  -- [51  48]
                        if ((b51 or b50) = '1') then   -- [51  50]
                            if (b51 = '1') then   -- [51]
                                lzc_count <= "001100";  -- lzc = 12
                            else  -- [50]
                                lzc_count <= "001101";  -- lzc = 13
                            end if;
                        else  -- [49  48]
                            if (b49 = '1') then   -- [49]
                                lzc_count <= "001110";  -- lzc = 14
                            else  -- [48]
                                lzc_count <= "001111";  -- lzc = 15
                            end if;
                        end if; 
                    end if; 
                end if; 
            else  -- [47  32]
                if ((b47 or b46 or b45 or b44 or b43 or b42 or b41 or b40) = '1') then   -- [47  40]
                    if ((b47 or b46 or b45 or b44) = '1') then   -- [47  44]
                        if ((b47 or b46) = '1') then   -- [47  46]
                            if (b47 = '1') then   -- [47]
                                lzc_count <= "010000";  -- lzc = 16
                            else  -- [46]
                                lzc_count <= "010001";  -- lzc = 17
                            end if;
                        else  -- [45  44]
                            if (b45 = '1') then   -- [45]
                                lzc_count <= "010010";  -- lzc = 18
                            else  -- [44]
                                lzc_count <= "010011";  -- lzc = 19
                            end if;
                        end if; 
                    else  -- [43  40]
                        if ((b43 or b42) = '1') then   -- [43  42]
                            if (b43 = '1') then   -- [43]
                                lzc_count <= "010100";  -- lzc = 20
                            else  -- [42]
                                lzc_count <= "010101";  -- lzc = 21
                            end if;
                        else  -- [41  40]
                            if (b41 = '1') then   -- [41]
                                lzc_count <= "010110";  -- lzc = 22
                            else  -- [40]
                                lzc_count <= "010111";  -- lzc = 23
                            end if;
                        end if; 
                    end if; 
                else  -- [39  32]
                    if ((b39 or b38 or b37 or b36) = '1') then   -- [39  36]
                        if ((b39 or b38) = '1') then   -- [39  38]
                            if (b39 = '1') then   -- [39]
                                lzc_count <= "011000";  -- lzc = 24
                            else  -- [38]
                                lzc_count <= "011001";  -- lzc = 25
                            end if;
                        else  -- [37  36]
                            if (b37 = '1') then   -- [37]
                                lzc_count <= "011010";  -- lzc = 26
                            else  -- [36]
                                lzc_count <= "011011";  -- lzc = 27
                            end if;
                        end if; 
                    else  -- [35  32]
                        if ((b35 or b34) = '1') then   -- [35  34]
                            if (b35 = '1') then   -- [35]
                                lzc_count <= "011100";  -- lzc = 28
                            else  -- [34]
                                lzc_count <= "011101";  -- lzc = 29
                            end if;
                        else  -- [33  32]
                            if (b33 = '1') then   -- [33]
                                lzc_count <= "011110";  -- lzc = 30
                            else  -- [32]
                                lzc_count <= "011111";  -- lzc = 31
                            end if;
                        end if; 
                    end if; 
                end if; 
            end if; 
        else  -- [31   0]
            if ((b31 or b30 or b29 or b28 or b27 or b26 or b25 or b24 or b23 or b22 or b21 or b20 or b19 or b18 or b17 or b16) = '1') then   -- [31  16]
                if ((b31 or b30 or b29 or b28 or b27 or b26 or b25 or b24) = '1') then   -- [31  24]
                    if ((b31 or b30 or b29 or b28) = '1') then   -- [31  28]
                        if ((b31 or b30) = '1') then   -- [31  30]
                            if (b31 = '1') then   -- [31]
                                lzc_count <= "100000";  -- lzc = 32
                            else  -- [30]
                                lzc_count <= "100001";  -- lzc = 33
                            end if;
                        else  -- [29  28]
                            if (b29 = '1') then   -- [29]
                                lzc_count <= "100010";  -- lzc = 34
                            else  -- [28]
                                lzc_count <= "100011";  -- lzc = 35
                            end if;
                        end if; 
                    else  -- [27  24]
                        if ((b27 or b26) = '1') then   -- [27  26]
                            if (b27 = '1') then   -- [27]
                                lzc_count <= "100100";  -- lzc = 36
                            else  -- [26]
                                lzc_count <= "100101";  -- lzc = 37
                            end if;
                        else  -- [25  24]
                            if (b25 = '1') then   -- [25]
                                lzc_count <= "100110";  -- lzc = 38
                            else  -- [24]
                                lzc_count <= "100111";  -- lzc = 39
                            end if;
                        end if; 
                    end if; 
                else  -- [23  16]
                    if ((b23 or b22 or b21 or b20) = '1') then   -- [23  20]
                        if ((b23 or b22) = '1') then   -- [23  22]
                            if (b23 = '1') then   -- [23]
                                lzc_count <= "101000";  -- lzc = 40
                            else  -- [22]
                                lzc_count <= "101001";  -- lzc = 41
                            end if;
                        else  -- [21  20]
                            if (b21 = '1') then   -- [21]
                                lzc_count <= "101010";  -- lzc = 42
                            else  -- [20]
                                lzc_count <= "101011";  -- lzc = 43
                            end if;
                        end if; 
                    else  -- [19  16]
                        if ((b19 or b18) = '1') then   -- [19  18]
                            if (b19 = '1') then   -- [19]
                                lzc_count <= "101100";  -- lzc = 44
                            else  -- [18]
                                lzc_count <= "101101";  -- lzc = 45
                            end if;
                        else  -- [17  16]
                            if (b17 = '1') then   -- [17]
                                lzc_count <= "101110";  -- lzc = 46
                            else  -- [16]
                                lzc_count <= "101111";  -- lzc = 47
                            end if;
                        end if; 
                    end if; 
                end if; 
            else  -- [15   0]
                if ((b15 or b14 or b13 or b12 or b11 or b10 or b9 or b8) = '1') then   -- [15   8]
                    if ((b15 or b14 or b13 or b12) = '1') then   -- [15  12]
                        if ((b15 or b14) = '1') then   -- [15  14]
                            if (b15 = '1') then   -- [15]
                                lzc_count <= "110000";  -- lzc = 48
                            else  -- [14]
                                lzc_count <= "110001";  -- lzc = 49
                            end if;
                        else  -- [13  12]
                            if (b13 = '1') then   -- [13]
                                lzc_count <= "110010";  -- lzc = 50
                            else  -- [12]
                                lzc_count <= "110011";  -- lzc = 51
                            end if;
                        end if; 
                    else  -- [11   8]
                        if ((b11 or b10) = '1') then   -- [11  10]
                            if (b11 = '1') then   -- [11]
                                lzc_count <= "110100";  -- lzc = 52
                            else  -- [10]
                                lzc_count <= "110101";  -- lzc = 53
                            end if;
                        else  -- [9  8]
                            if (b9 = '1') then   -- [9]
                                lzc_count <= "110110";  -- lzc = 54
                            else  -- [8]
                                lzc_count <= "110111";  -- lzc = 55
                            end if;
                        end if; 
                    end if; 
                else  -- [7  0]
                    if ((b7 or b6 or b5 or b4) = '1') then   -- [7  4]
                        if ((b7 or b6) = '1') then   -- [7  6]
                            if (b7 = '1') then   -- [7]
                                lzc_count <= "111000";  -- lzc = 56
                            else  -- [6]
                                lzc_count <= "111001";  -- lzc = 57
                            end if;
                        else  -- [5  4]
                            if (b5 = '1') then   -- [5]
                                lzc_count <= "111010";  -- lzc = 58
                            else  -- [4]
                                lzc_count <= "111011";  -- lzc = 59
                            end if;
                        end if; 
                    else  -- [3  0]
                        if ((b3 or b2) = '1') then   -- [3  2]
                            if (b3 = '1') then   -- [3]
                                lzc_count <= "111100";  -- lzc = 60
                            else  -- [2]
                                lzc_count <= "111101";  -- lzc = 61
                            end if;
                        else  -- [1  0]
                            if (b1 = '1') then   -- [1]
                                lzc_count <= "111110";  -- lzc = 62
                            else  -- [0]
                                lzc_count <= "111111";  -- lzc = 63
                            end if;
                        end if; 
                    end if; 
                end if; 
            end if; 
        end if; 

    end process;

end behavioral;
