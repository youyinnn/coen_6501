library ieee;

use ieee.std_logic_1164.all;
-- TODO: adder
use ieee.numeric_std.all;

entity r4b_multiplier is
    port(
        -- unsigned number 
        mc    : in std_logic_vector(7 downto 0);
        mp    : in std_logic_vector(7 downto 0);
        p     : out std_logic_vector(15 downto 0)
    );
end r4b_multiplier;

architecture arch of r4b_multiplier is

    signal signal_mc_negative   : std_logic_vector(8  downto 0);

    signal signal_p0            : std_logic_vector(15 downto 0);
    signal signal_p1            : std_logic_vector(15 downto 0);
    signal signal_p2            : std_logic_vector(15 downto 0);
    signal signal_p3            : std_logic_vector(15 downto 0);
    signal signal_p4            : std_logic_vector(15 downto 0);

    component nine_bit_negation_in_2c is
        port(
            x   : in  std_logic_vector(7 downto 0);
            c   : out std_logic_vector(8 downto 0)
        );
    end component nine_bit_negation_in_2c;

    component booth_stage_0 is
        port(
            mc      : in std_logic_vector(7 downto 0);
            mc_neg  : in std_logic_vector(8 downto 0);
            code    : in std_logic_vector(1 downto 0);
    
            p_next  : out std_logic_vector(15 downto 0)
        );
    end component booth_stage_0;

    component booth_stage_1 is
        port(
            mc      : in std_logic_vector(7 downto 0);
            mc_neg  : in std_logic_vector(8 downto 0);
            code    : in std_logic_vector(2 downto 0);
    
            p_next  : out std_logic_vector(15 downto 0)
        );
    end component booth_stage_1;

    component booth_stage_2 is
        port(
            mc      : in std_logic_vector(7 downto 0);
            mc_neg  : in std_logic_vector(8 downto 0);
            code    : in std_logic_vector(2 downto 0);
    
            p_next  : out std_logic_vector(15 downto 0)
        );
    end component booth_stage_2;

    component booth_stage_3 is
        port(
            mc      : in std_logic_vector(7 downto 0);
            mc_neg  : in std_logic_vector(8 downto 0);
            code    : in std_logic_vector(2 downto 0);
    
            p_next  : out std_logic_vector(15 downto 0)
        );
    end component booth_stage_3;    
    
    component booth_stage_4 is
        port(
            mc      : in std_logic_vector(7 downto 0);
            code    : in std_logic;
    
            p_next  : out std_logic_vector(15 downto 0)
        );
    end component booth_stage_4;
begin

    neg: nine_bit_negation_in_2c
    port map(
        x => mc,
        c => signal_mc_negative
    );

    sg_0: booth_stage_0
    port map(
        mc => mc,
        mc_neg => signal_mc_negative,
        code => mp(1 downto 0),
        p_next => signal_p0
    );    
    
    sg_1: booth_stage_1
    port map(
        mc => mc,
        mc_neg => signal_mc_negative,
        code => mp(3 downto 1),
        p_next => signal_p1
    );    
    
    sg_2: booth_stage_2
    port map(
        mc => mc,
        mc_neg => signal_mc_negative,
        code => mp(5 downto 3),
        p_next => signal_p2
    );    
    
    sg_3: booth_stage_3
    port map(
        mc => mc,
        mc_neg => signal_mc_negative,
        code => mp(7 downto 5),
        p_next => signal_p3
    );    
    
    sg_4: booth_stage_4
    port map(
        mc => mc,
        code => mp(7),
        p_next => signal_p4
    );


    p <= std_logic_vector(unsigned(signal_p0) + unsigned(signal_p1) + unsigned(signal_p2) + unsigned(signal_p3) + unsigned(signal_p4));

end arch;