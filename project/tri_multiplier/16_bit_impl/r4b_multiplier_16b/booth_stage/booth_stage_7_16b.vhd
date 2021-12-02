library ieee;

use ieee.std_logic_1164.all;

entity booth_stage_7_16b is
    port(
        mc          : in  std_logic_vector(15  downto 0);
        mc_neg      : in  std_logic_vector(16  downto 0);

        code        : in  std_logic_vector(2 downto 0);

        p_next      : out std_logic_vector(31 downto 0)
    );
end booth_stage_7_16b;

architecture arch of booth_stage_7_16b is
    signal partical_product     : std_logic_vector(17 downto 0);
begin

    with code select
        partical_product <= 
            (others => '0')     when "000" | "111",     -- 000 | 111
            "00" & mc           when "001" | "010",     -- 010 | 001
            "0" & mc & "0"      when "011",             -- 111
            mc_neg & "0"        when "100",             -- 100
            mc_neg(16) & mc_neg  when others;           -- 110 | 101 (will only be

    p_next <= 
        partical_product & "00000000000000";

end arch;