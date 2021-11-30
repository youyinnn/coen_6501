library ieee;

use ieee.std_logic_1164.all;

entity booth_stage_8_16b is
    port(
        mc          : in  std_logic_vector(15  downto 0);
        code        : in  std_logic;

        p_next      : out std_logic_vector(31 downto 0)
    );
end booth_stage_8_16b;

architecture arch of booth_stage_8_16b is
begin

    with code select
        p_next <= 
            (others => '0')     when '0',       -- 000
            mc & "0000000000000000"     when others;    -- 001

end arch;