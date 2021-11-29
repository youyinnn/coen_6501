library ieee;

use ieee.std_logic_1164.all;
-- TODO: adder
use ieee.numeric_std.all;

entity nine_bit_negation_in_2c is
    port(
        x    : in std_logic_vector(7 downto 0);
        c    : out std_logic_vector(8 downto 0)
    );
end nine_bit_negation_in_2c;

architecture arch of nine_bit_negation_in_2c is
    signal the_sign : std_logic;
    signal tmp      : std_logic_vector(7 downto 0);
begin

    process(x)
    begin
        if (x = "00000000") then
            the_sign <= '0';
            tmp <= x;
        else
            the_sign <= '1';
            tmp <= std_logic_vector(unsigned(not x) + 1);
        end if;
    end process;
 
    c <= the_sign & tmp;

end arch;