library ieee;

use ieee.std_logic_1164.all;

entity booth_stage_4 is
    port(
        mc          : in  std_logic_vector(7  downto 0);
        code        : in  std_logic;

        p_next      : out std_logic_vector(15 downto 0)
    );
end booth_stage_4;

architecture arch of booth_stage_4 is
begin

    with code select
        p_next <= 
            (others => '0')     when '0',       -- 000
            mc & "00000000"     when others;    -- 001

end arch;