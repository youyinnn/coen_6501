library ieee;

use ieee.std_logic_1164.all;

entity left_bits_filler_8b is
    port(
        -- unsigned number 
        a       : in std_logic_vector(15 downto 0);
        p       : out std_logic_vector(23 downto 0)
    );
end left_bits_filler_8b;

architecture arch of left_bits_filler_8b is 
    constant FIX_HOLDER : std_logic_vector(7 downto 0) := (others => '0');
begin

    p <= FIX_HOLDER & a;

end arch;