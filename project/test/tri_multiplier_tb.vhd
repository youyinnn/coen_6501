library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tri_multiplier_tb is
end entity;

architecture Behavioural of tri_multiplier_tb is

    -- integer mc & mp & pd
    signal r_input_a   : integer  := 0;
    signal r_input_b   : integer  := 0;
    signal r_output_pd   : integer  := 0;
    
    -- std_logic_vector mc & mp
    signal r_input_a_slv   : std_logic_vector(7 downto 0)  := (OTHERS => '0');
    signal r_input_b_slv   : std_logic_vector(7 downto 0)  := (OTHERS => '0');    
    
    -- std_logic_vector pd
    signal r_output_p_slv       : std_logic_vector(23 downto 0)  := (OTHERS => '0');

    -- booth multiplier implementation
    component tri_multiplier is
        port(
            a       : in std_logic_vector(7 downto 0);
            b       : in std_logic_vector(7 downto 0);

            p       : out std_logic_vector(23 downto 0)
        );
    end component tri_multiplier;    

    -- output assertion
    component assert_output_24b is
        port(
            opt         : in std_logic_vector(23 downto 0);
            assert_int  : in integer;
            dl          : in time
        );
    end component assert_output_24b;

begin

        r_input_a_slv <= std_logic_vector(to_unsigned(r_input_a, 8));
        r_input_b_slv <= std_logic_vector(to_unsigned(r_input_b, 8));

        r_output_pd <= r_input_a * r_input_a * r_input_b;

        tri : tri_multiplier
        port map (
            a => r_input_a_slv,
            b => r_input_b_slv,
            p => r_output_p_slv
        );

        r_input_a <=
            21 after 500 ns,
            32 after 1000 ns,
            3 after 1500 ns,
            1 after 2000 ns,
            80 after 2500 ns,
            32 after 3000 ns,
            13 after 3500 ns,
            255 after 4000 ns,
            0 after 10000 ns    
        ;
            
        r_input_b <=
            73 after 500 ns,
            133 after 1000 ns,
            12 after 1500 ns,
            13 after 2000 ns,
            99 after 2500 ns,
            64 after 3000 ns,
            77 after 3500 ns,
            255 after 4000 ns,
            0 after 10000 ns
        ;


        as_1: assert_output_24b port map(r_output_p_slv, r_output_pd, 501 ns);
        as_2: assert_output_24b port map(r_output_p_slv, r_output_pd, 1001 ns);
        as_3: assert_output_24b port map(r_output_p_slv, r_output_pd, 1501 ns);
        as_4: assert_output_24b port map(r_output_p_slv, r_output_pd, 2001 ns);
        as_5: assert_output_24b port map(r_output_p_slv, r_output_pd, 2501 ns);
        as_f: assert_output_24b port map(r_output_p_slv, r_output_pd, 10001 ns);


end Behavioural;
