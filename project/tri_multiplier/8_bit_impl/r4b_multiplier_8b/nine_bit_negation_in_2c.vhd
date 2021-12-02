library ieee;

use ieee.std_logic_1164.all;

entity nine_bit_negation_in_2c is
    port(
        x    : in std_logic_vector(7 downto 0);
        c    : out std_logic_vector(8 downto 0)
    );
end nine_bit_negation_in_2c;

architecture arch of nine_bit_negation_in_2c is
    signal flip_x      : std_logic_vector(7 downto 0);
    signal tmp      : std_logic_vector(7 downto 0);

    component csa_8b_incrementer is
      port(
        in_a : in std_logic_vector (7 downto 0);
        sum : out std_logic_vector (7 downto 0);
        carryout : out std_logic
    );
    end component csa_8b_incrementer;
begin

    flip_x <= not x;

    inc: csa_8b_incrementer port map(flip_x, tmp);
    
    c <= '0' & x when x = "00000000" else '1' & tmp;

end arch;