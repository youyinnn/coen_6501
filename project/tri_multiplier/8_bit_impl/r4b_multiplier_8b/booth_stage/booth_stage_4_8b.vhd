library ieee;

use ieee.std_logic_1164.all;

entity booth_stage_4_8b is
    port(
        mc          : in  std_logic_vector(7  downto 0);
        code        : in  std_logic;

        extended_pp      : out std_logic_vector(15 downto 0)
    );
end booth_stage_4_8b;

architecture arch of booth_stage_4_8b is
begin

    with code select
        extended_pp <= 
            (others => '0')     when '0',       -- 000
            mc & "00000000"     when others;    -- 001

end arch;