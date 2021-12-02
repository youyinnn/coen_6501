library ieee;
use ieee.std_logic_1164.all;

entity r4b_multiplier_8b is
    port(
        -- unsigned number 
        mc    : in std_logic_vector(7 downto 0);
        mp    : in std_logic_vector(7 downto 0);
        p     : out std_logic_vector(15 downto 0)
    );
end r4b_multiplier_8b;

architecture arch of r4b_multiplier_8b is

    signal signal_mc_negative   : std_logic_vector(8  downto 0);

    signal signal_p0            : std_logic_vector(15 downto 0);
    signal signal_p1            : std_logic_vector(15 downto 0);
    signal signal_p2            : std_logic_vector(15 downto 0);
    signal signal_p3            : std_logic_vector(15 downto 0);
    signal signal_p4            : std_logic_vector(15 downto 0);

    signal sum_1 : std_logic_vector(15 downto 0);
    signal sum_2 : std_logic_vector(15 downto 0);
    signal sum_3 : std_logic_vector(15 downto 0);

    component nine_bit_negation_in_2c is
        port(
            x   : in  std_logic_vector(7 downto 0);
            c   : out std_logic_vector(8 downto 0)
        );
    end component nine_bit_negation_in_2c;

    component booth_stage_0_8b is
        port(
            mc      : in std_logic_vector(7 downto 0);
            mc_neg  : in std_logic_vector(8 downto 0);
            code    : in std_logic_vector(1 downto 0);
    
            extended_pp  : out std_logic_vector(15 downto 0)
        );
    end component booth_stage_0_8b;

    component booth_stage_1_8b is
        port(
            mc      : in std_logic_vector(7 downto 0);
            mc_neg  : in std_logic_vector(8 downto 0);
            code    : in std_logic_vector(2 downto 0);
    
            extended_pp  : out std_logic_vector(15 downto 0)
        );
    end component booth_stage_1_8b;

    component booth_stage_2_8b is
        port(
            mc      : in std_logic_vector(7 downto 0);
            mc_neg  : in std_logic_vector(8 downto 0);
            code    : in std_logic_vector(2 downto 0);
    
            extended_pp  : out std_logic_vector(15 downto 0)
        );
    end component booth_stage_2_8b;

    component booth_stage_3_8b is
        port(
            mc      : in std_logic_vector(7 downto 0);
            mc_neg  : in std_logic_vector(8 downto 0);
            code    : in std_logic_vector(2 downto 0);
    
            extended_pp  : out std_logic_vector(15 downto 0)
        );
    end component booth_stage_3_8b;    
    
    component booth_stage_4_8b is
        port(
            mc      : in std_logic_vector(7 downto 0);
            code    : in std_logic;
    
            extended_pp  : out std_logic_vector(15 downto 0)
        );
    end component booth_stage_4_8b;

    component CSA_16bit is
        port(
          in_a : in std_logic_vector (15 downto 0);
          in_b : in std_logic_vector (15 downto 0);
          sum : out std_logic_vector (15 downto 0);
          carryout : out std_logic);
    end component CSA_16bit;

begin

    negation_in_2_s_complement: nine_bit_negation_in_2c
    port map(
        x => mc,
        c => signal_mc_negative
    );

    stage_0: booth_stage_0_8b port map(
        mc => mc,
        mc_neg => signal_mc_negative,
        code => mp(1 downto 0),
        extended_pp => signal_p0
    );    
    
    stage_1: booth_stage_1_8b port map(mc, signal_mc_negative, mp(3 downto 1), signal_p1);    
    stage_2: booth_stage_2_8b port map(mc, signal_mc_negative, mp(5 downto 3), signal_p2);    
    stage_3: booth_stage_3_8b port map(mc, signal_mc_negative, mp(7 downto 5), signal_p3);    
    stage_4: booth_stage_4_8b port map(mc, mp(7), signal_p4);

    s_1: CSA_16bit port map(signal_p0, signal_p1, sum_1);    
    s_2: CSA_16bit port map(sum_1, signal_p2, sum_2);    
    s_3: CSA_16bit port map(sum_2, signal_p3, sum_3);    
    s_4: CSA_16bit port map(sum_3, signal_p4, p);

end arch;