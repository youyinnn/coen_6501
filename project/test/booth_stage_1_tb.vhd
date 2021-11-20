library ieee;

use ieee.std_logic_1164.all;

entity booth_stage_1_tb is
end entity;

architecture Behavioural of booth_stage_1_tb is

    signal r_input_mc       : std_logic_vector(7 downto 0)  := (OTHERS => '0');
    signal r_mc_neg         : std_logic_vector(8 downto 0)  := (OTHERS => '0');
    signal r_input_code     : std_logic_vector(2 downto 0)  := (OTHERS => '0');

    signal r_output_p_next  : std_logic_vector(15 downto 0)  := (OTHERS => '0');

    component booth_stage_1 is
        port(
            mc      : in std_logic_vector(7 downto 0);
            mc_neg  : in std_logic_vector(8 downto 0);

            code    : in std_logic_vector(2 downto 0);
    
            p_next  : out std_logic_vector(15 downto 0)
        );
    end component booth_stage_1;

    component nine_bit_negation_in_2c is
        port(
            x       : in  std_logic_vector(7 downto 0);
            c       : out std_logic_vector(8 downto 0)
        );
    end component nine_bit_negation_in_2c;

    begin

        cplm : nine_bit_negation_in_2c
        port map (
            x => r_input_mc,
            c => r_mc_neg
        );

        st_0 : booth_stage_1
        port map (
            mc => r_input_mc,
            mc_neg => r_mc_neg,
            code => r_input_code,
            p_next => r_output_p_next
        );

        r_input_mc <= "01001001" after 100 ns;
        r_input_code 
            <= "000" after 300 ns, 
                "001" after 500 ns, 
                "010" after 700 ns, 
                "011" after 1000 ns, 
                "100" after 1300 ns, 
                
                "101" after 1500 ns,
                "110" after 1700 ns,
                "111" after 2000 ns;
        

end Behavioural;