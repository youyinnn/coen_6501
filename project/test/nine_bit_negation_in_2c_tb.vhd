library ieee;

use ieee.std_logic_1164.all;

entity nine_bit_negation_in_2c_tb is
end entity;

architecture Behavioural of nine_bit_negation_in_2c_tb is

    signal r_input_x    : std_logic_vector(7 downto 0)  := (OTHERS => '0');
    signal r_output_c   : std_logic_vector(8 downto 0)  := (OTHERS => '0');

    component nine_bit_negation_in_2c is
        port(
            x    : in  std_logic_vector(7 downto 0);
            c    : out std_logic_vector(8 downto 0)
        );
    end component nine_bit_negation_in_2c;

    begin
    
        u1 : nine_bit_negation_in_2c
        port map (
            x => r_input_x,
            c => r_output_c
        );
        
        r_input_x <= 
            "00000010" after 50 ns, -- 2   should get 1111 1110 (-2 in 2's complement)
            "10001001" after 100 ns, -- -9  should get 0000 1001 (9  in original)
            "11101011" after 150 ns, -- 9   should get 1111 0111 (-9 in 2's complement)
            "11111111" after 200 ns, -- 9   should get 1111 0111 (-9 in 2's complement)
            "00000001" after 250 ns, -- 9   should get 1111 0111 (-9 in 2's complement)
            "01010101" after 300 ns, -- 9   should get 1111 0111 (-9 in 2's complement)
            "10101010" after 700 ns
        ;

end Behavioural;