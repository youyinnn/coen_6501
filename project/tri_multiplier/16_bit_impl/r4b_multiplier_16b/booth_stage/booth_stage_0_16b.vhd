library ieee;

use ieee.std_logic_1164.all;

entity booth_stage_0_16b is
    port(
        mc          : in  std_logic_vector(15  downto 0);
        mc_neg      : in  std_logic_vector(16  downto 0);

        code        : in  std_logic_vector(1 downto 0);

        extended_pp      : out std_logic_vector(31 downto 0)
    );
end booth_stage_0_16b;

architecture arch of booth_stage_0_16b is
    signal msb_of_select        : std_logic;
    signal partical_product     : std_logic_vector(17 downto 0);
begin

    with code select
        partical_product <= 
            (others => '0')     when "00",      -- 000
            "00" & mc           when "01",      -- 010
            mc_neg & "0"        when "10",      -- 100
            mc_neg(16) & mc_neg  when others;    -- 110 (will only be

    msb_of_select <= partical_product(17);

    extended_pp <= 
        msb_of_select & msb_of_select & msb_of_select & msb_of_select & 
        msb_of_select & msb_of_select & msb_of_select & msb_of_select & 
        msb_of_select & msb_of_select & msb_of_select & msb_of_select & 
        msb_of_select & msb_of_select &
        partical_product;

end arch;