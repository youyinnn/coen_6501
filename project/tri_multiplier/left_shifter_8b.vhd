library ieee;

use ieee.std_logic_1164.all;

entity left_shifter_8b is
    port(
        -- unsigned number 
        a       : in std_logic_vector(15 downto 0);
        p       : out std_logic_vector(23 downto 0)
    );
end left_shifter_8b;

architecture arch of left_shifter_8b is 
    constant FIX_HOLDER : std_logic_vector(7 downto 0) := "00000000";
begin

    p <= a & FIX_HOLDER;

end arch;