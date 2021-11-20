library ieee;

use ieee.std_logic_1164.all;

entity booth_stage_0_tb is
end entity;

architecture Behavioural of booth_stage_0_tb is

    signal r_input_mc       : std_logic_vector(7 downto 0)  := (OTHERS => '0');
    signal r_mc_neg         : std_logic_vector(8 downto 0)  := (OTHERS => '0');
    signal r_input_code     : std_logic_vector(1 downto 0)  := (OTHERS => '0');

    signal r_output_p_next  : std_logic_vector(15 downto 0)  := (OTHERS => '0');

    component booth_stage_0 is
        port(
            mc      : in std_logic_vector(7 downto 0);
            mc_neg  : in std_logic_vector(8 downto 0);

            code    : in std_logic_vector(1 downto 0);
    
            p_next  : out std_logic_vector(15 downto 0)
        );
    end component booth_stage_0;

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

        st_0 : booth_stage_0
        port map (
            mc => r_input_mc,
            mc_neg => r_mc_neg,
            code => r_input_code,
            p_next => r_output_p_next
        );

        r_input_mc <= "01001001" after 100 ns, "10110000" after 1000 ns;
        r_input_code 
            <= "01" after 300 ns, 
                "10" after 500 ns, 
                "11" after 700 ns, 
                "00" after 1000 ns, 
                
                "01" after 1300 ns, 
                "10" after 1500 ns, 
                "11" after 1700 ns, 
                "00" after 2000 ns;
        

end Behavioural;