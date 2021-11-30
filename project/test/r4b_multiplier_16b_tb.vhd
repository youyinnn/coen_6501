library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity r4b_multiplier_16b_tb is
end entity;

architecture Behavioural of r4b_multiplier_16b_tb is

    -- integer mc & mp & pd
    signal r_input_mc   : integer  := 0;
    signal r_input_mp   : integer  := 0;
    signal r_output_pd   : integer  := 0;
    
    -- std_logic_vector mc & mp
    signal r_input_mc_slv   : std_logic_vector(15 downto 0)  := (OTHERS => '0');
    signal r_input_mp_slv   : std_logic_vector(15 downto 0)  := (OTHERS => '0');    
    
    -- std_logic_vector pd
    signal r_output_p       : std_logic_vector(31 downto 0)  := (OTHERS => '0');

    -- booth multiplier implementation
    component r4b_multiplier_16b is
        port(
            mc      : in std_logic_vector(15 downto 0);
            mp      : in std_logic_vector(15 downto 0);
            p       : out std_logic_vector(31 downto 0)
        );
    end component r4b_multiplier_16b;    

    -- output assertion
    component assert_output_32b is
        port(
            opt         : in std_logic_vector(31 downto 0);
            assert_int  : in integer;
            dl          : in time
        );
    end component assert_output_32b;

begin

        r_input_mc_slv <= std_logic_vector(to_unsigned(r_input_mc, 16));
        r_input_mp_slv <= std_logic_vector(to_unsigned(r_input_mp, 16));
        r_output_pd <= r_input_mc * r_input_mp;

        booth : r4b_multiplier_16b
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
            48234 after 4000 ns,
            33213 after 4500 ns,
            65525 after 5000 ns,
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
            32130 after 4000 ns,
            312 after 4500 ns,
            0 after 5000 ns,
            0 after 10000 ns
        ;

        as_1: assert_output_32b port map(r_output_p, r_output_pd, 501 ns);
        as_2: assert_output_32b port map(r_output_p, r_output_pd, 1001 ns);
        as_3: assert_output_32b port map(r_output_p, r_output_pd, 1501 ns);
        as_4: assert_output_32b port map(r_output_p, r_output_pd, 2001 ns);
        as_5: assert_output_32b port map(r_output_p, r_output_pd, 2501 ns);
        as_6: assert_output_32b port map(r_output_p, r_output_pd, 3001 ns);
        as_7: assert_output_32b port map(r_output_p, r_output_pd, 3501 ns);
        as_8: assert_output_32b port map(r_output_p, r_output_pd, 4001 ns);
        as_9: assert_output_32b port map(r_output_p, r_output_pd, 4501 ns);
        as_10: assert_output_32b port map(r_output_p, r_output_pd, 5001 ns);
        as_final: assert_output_32b port map(r_output_p, r_output_pd, 10001 ns);

end Behavioural;
