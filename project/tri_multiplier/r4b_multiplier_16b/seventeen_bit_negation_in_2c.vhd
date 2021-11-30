library ieee;

use ieee.std_logic_1164.all;

entity seventeen_bit_negation_in_2c is
    port(
        x    : in std_logic_vector(15 downto 0);
        c    : out std_logic_vector(16 downto 0)
    );
end seventeen_bit_negation_in_2c;

architecture arch of seventeen_bit_negation_in_2c is
    signal sign_bit : std_logic;
    signal flip_x      : std_logic_vector(15 downto 0);
    signal tmp      : std_logic_vector(15 downto 0);

    component csa_16b_incrementer is
      port(
        in_a : in std_logic_vector (15 downto 0);
        sum : out std_logic_vector (15 downto 0);
        carryout : out std_logic
    );
    end component csa_16b_incrementer;
begin

    process(x)
    begin
        if (x = "0000000000000000") then
            sign_bit <= '0';
        else
            sign_bit <= '1';
        end if;
    end process;

    flip_x <= not x;

    inc: csa_16b_incrementer port map(flip_x, tmp);
    
    c <= sign_bit & x when x = "0000000000000000" else sign_bit & tmp;

end arch;