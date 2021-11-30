library ieee;

use ieee.std_logic_1164.all;

entity left_shifter_16b is
    port(
        -- unsigned number 
        a       : in std_logic_vector(31 downto 0);
        p       : out std_logic_vector(47 downto 0)
    );
end left_shifter_16b;

architecture arch of left_shifter_16b is 
    constant FIX_HOLDER : std_logic_vector(15 downto 0) := (others => '0');
begin

    p <= a & FIX_HOLDER;

end arch;