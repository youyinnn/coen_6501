library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity r4b_multiplier_tb is
end entity;

architecture Behavioural of r4b_multiplier_tb is

    -- integer mc & mp & pd
    signal r_input_mc   : integer  := 0;
    signal r_input_mp   : integer  := 0;
    signal r_output_pd   : integer  := 0;
    
    -- std_logic_vector mc & mp
    signal r_input_mc_slv   : std_logic_vector(7 downto 0)  := (OTHERS => '0');
    signal r_input_mp_slv   : std_logic_vector(7 downto 0)  := (OTHERS => '0');    
    
    -- std_logic_vector pd
    signal r_output_p       : std_logic_vector(15 downto 0)  := (OTHERS => '0');

    -- booth multiplier implementation
    component r4b_multiplier is
        port(
            mc      : in std_logic_vector(7 downto 0);
            mp      : in std_logic_vector(7 downto 0);
            p       : out std_logic_vector(15 downto 0)
        );
    end component r4b_multiplier;    

    -- output assertion
    component assert_output is
        port(
            opt         : in std_logic_vector(15 downto 0);
            assert_int  : in integer;
            dl          : in time
        );
    end component assert_output;

begin

        r_input_mc_slv <= std_logic_vector(to_unsigned(r_input_mc, 8));
        r_input_mp_slv <= std_logic_vector(to_unsigned(r_input_mp, 8));
        r_output_pd <= r_input_mc * r_input_mp;

        booth : r4b_multiplier
        port map (
            mc => r_input_mc_slv,
            mp => r_input_mp_slv,
            p => r_output_p
        );

        r_input_mc <=
            21 after 500 ns,
            32 after 1000 ns,
            3 after 1500 ns,
            1 after 2000 ns,
            80 after 2500 ns,
            0 after 3000 ns,
            32 after 3500 ns,
            0 after 10000 ns    
        ;
            
        r_input_mp <=
            73 after 500 ns,
            133 after 1000 ns,
            12 after 1500 ns,
            13 after 2000 ns,
            99 after 2500 ns,
            12 after 3000 ns,
            0 after 3500 ns,
            0 after 10000 ns
        ;

        as_1: assert_output port map(r_output_p, r_output_pd, 501 ns);
        as_2: assert_output port map(r_output_p, r_output_pd, 1001 ns);
        as_3: assert_output port map(r_output_p, r_output_pd, 1501 ns);
        as_4: assert_output port map(r_output_p, r_output_pd, 2001 ns);
        as_5: assert_output port map(r_output_p, r_output_pd, 2501 ns);
        as_6: assert_output port map(r_output_p, r_output_pd, 3001 ns);
        as_7: assert_output port map(r_output_p, r_output_pd, 3501 ns);
        as_final: assert_output port map(r_output_p, r_output_pd, 10001 ns);

end Behavioural;
