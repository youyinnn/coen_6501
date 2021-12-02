library ieee;
use ieee.std_logic_1164.all;

entity r4b_multiplier_16b is
    port(
        -- unsigned number 
        mc    : in std_logic_vector(15 downto 0);
        mp    : in std_logic_vector(15 downto 0);
        p     : out std_logic_vector(31 downto 0)
    );
end r4b_multiplier_16b;

architecture arch of r4b_multiplier_16b is

    signal signal_mc_negative   : std_logic_vector(16  downto 0);

    signal signal_p0            : std_logic_vector(31 downto 0);
    signal signal_p1            : std_logic_vector(31 downto 0);
    signal signal_p2            : std_logic_vector(31 downto 0);
    signal signal_p3            : std_logic_vector(31 downto 0);
    signal signal_p4            : std_logic_vector(31 downto 0);
    signal signal_p5            : std_logic_vector(31 downto 0);
    signal signal_p6            : std_logic_vector(31 downto 0);
    signal signal_p7            : std_logic_vector(31 downto 0);
    signal signal_p8            : std_logic_vector(31 downto 0);

    signal sum_1 : std_logic_vector(31 downto 0);
    signal sum_2 : std_logic_vector(31 downto 0);
    signal sum_3 : std_logic_vector(31 downto 0);
    signal sum_4 : std_logic_vector(31 downto 0);
    signal sum_5 : std_logic_vector(31 downto 0);
    signal sum_6 : std_logic_vector(31 downto 0);
    signal sum_7 : std_logic_vector(31 downto 0);

    component seventeen_bit_negation_in_2c is
        port(
            x    : in std_logic_vector(15 downto 0);
            c    : out std_logic_vector(16 downto 0)
        );
    end component seventeen_bit_negation_in_2c;

    component booth_stage_0_16b is
        port(
            mc          : in  std_logic_vector(15  downto 0);
            mc_neg      : in  std_logic_vector(16  downto 0);
    
            code        : in  std_logic_vector(1 downto 0);
    
            extended_pp      : out std_logic_vector(31 downto 0)
        );
    end component booth_stage_0_16b;

    component booth_stage_1_16b is
        port(
            mc          : in  std_logic_vector(15  downto 0);
            mc_neg      : in  std_logic_vector(16  downto 0);
    
            code        : in  std_logic_vector(2 downto 0);
    
            extended_pp      : out std_logic_vector(31 downto 0)
        );
    end component booth_stage_1_16b;

    component booth_stage_2_16b is
        port(
            mc          : in  std_logic_vector(15  downto 0);
            mc_neg      : in  std_logic_vector(16  downto 0);
    
            code        : in  std_logic_vector(2 downto 0);
    
            extended_pp      : out std_logic_vector(31 downto 0)
        );
    end component booth_stage_2_16b;

    component booth_stage_3_16b is
        port(
            mc          : in  std_logic_vector(15  downto 0);
            mc_neg      : in  std_logic_vector(16  downto 0);
    
            code        : in  std_logic_vector(2 downto 0);
    
            extended_pp      : out std_logic_vector(31 downto 0)
        );
    end component booth_stage_3_16b;

    component booth_stage_4_16b is
        port(
            mc          : in  std_logic_vector(15  downto 0);
            mc_neg      : in  std_logic_vector(16  downto 0);
    
            code        : in  std_logic_vector(2 downto 0);
    
            extended_pp      : out std_logic_vector(31 downto 0)
        );
    end component booth_stage_4_16b;

    component booth_stage_5_16b is
        port(
            mc          : in  std_logic_vector(15  downto 0);
            mc_neg      : in  std_logic_vector(16  downto 0);
    
            code        : in  std_logic_vector(2 downto 0);
    
            extended_pp      : out std_logic_vector(31 downto 0)
        );
    end component booth_stage_5_16b;

    component booth_stage_6_16b is
        port(
            mc          : in  std_logic_vector(15  downto 0);
            mc_neg      : in  std_logic_vector(16  downto 0);
    
            code        : in  std_logic_vector(2 downto 0);
    
            extended_pp      : out std_logic_vector(31 downto 0)
        );
    end component booth_stage_6_16b;

    component booth_stage_7_16b is
        port(
            mc          : in  std_logic_vector(15  downto 0);
            mc_neg      : in  std_logic_vector(16  downto 0);
    
            code        : in  std_logic_vector(2 downto 0);
    
            extended_pp      : out std_logic_vector(31 downto 0)
        );
    end component booth_stage_7_16b;

    component booth_stage_8_16b is
        port(
            mc          : in  std_logic_vector(15  downto 0);
            code        : in  std_logic;
    
            extended_pp      : out std_logic_vector(31 downto 0)
        );
    end component booth_stage_8_16b;

    component CSA_32bit is
        port(
          in_a : in std_logic_vector (31 downto 0);
          in_b : in std_logic_vector (31 downto 0);
          sum : out std_logic_vector (31 downto 0);
          carryout : out std_logic);
    end component CSA_32bit;

begin

    negation_in_2_s_complement: seventeen_bit_negation_in_2c
    port map(
        x => mc,
        c => signal_mc_negative
    );

    stage_0: booth_stage_0_16b port map(
        mc => mc,
        mc_neg => signal_mc_negative,
        code => mp(1 downto 0),
        extended_pp => signal_p0
    );    
    
    stage_1: booth_stage_1_16b port map(mc, signal_mc_negative, mp(3 downto 1), signal_p1);    
    stage_2: booth_stage_2_16b port map(mc, signal_mc_negative, mp(5 downto 3), signal_p2);    
    stage_3: booth_stage_3_16b port map(mc, signal_mc_negative, mp(7 downto 5), signal_p3);    
    stage_4: booth_stage_4_16b port map(mc, signal_mc_negative, mp(9 downto 7), signal_p4);    
    stage_5: booth_stage_5_16b port map(mc, signal_mc_negative, mp(11 downto 9), signal_p5);    
    stage_6: booth_stage_6_16b port map(mc, signal_mc_negative, mp(13 downto 11), signal_p6);    
    stage_7: booth_stage_7_16b port map(mc, signal_mc_negative, mp(15 downto 13), signal_p7);    
    stage_8: booth_stage_8_16b port map(mc, mp(15), signal_p8);

    s_1: CSA_32bit port map(signal_p0, signal_p1, sum_1);    
    s_2: CSA_32bit port map(sum_1, signal_p2, sum_2);    
    s_3: CSA_32bit port map(sum_2, signal_p3, sum_3);    
    s_4: CSA_32bit port map(sum_3, signal_p4, sum_4);    
    s_5: CSA_32bit port map(sum_4, signal_p5, sum_5);    
    s_6: CSA_32bit port map(sum_5, signal_p6, sum_6);    
    s_7: CSA_32bit port map(sum_6, signal_p7, sum_7);    
    s_8: CSA_32bit port map(sum_7, signal_p8, p);

end arch;