library ieee;

use ieee.std_logic_1164.all;

entity booth_stage_0_8b is
    port(
        mc          : in  std_logic_vector(7  downto 0);
        mc_neg      : in  std_logic_vector(8  downto 0);

        code        : in  std_logic_vector(1 downto 0);

        extended_pp : out std_logic_vector(15 downto 0)
    );
end booth_stage_0_8b;

architecture arch of booth_stage_0_8b is
    signal extended_sign_bits   : std_logic_vector(5 downto 0);
    signal partical_product     : std_logic_vector(9 downto 0);
begin

    with code select
        partical_product <= 
            (others => '0')     when "00",      -- 000
            "00" & mc           when "01",      -- 010
            mc_neg & "0"        when "10",      -- 100
            mc_neg(8) & mc_neg  when others;    -- 110 (will only be

    extended_sign_bits <= (others => partical_product(9));
    extended_pp <= extended_sign_bits & partical_product;

end arch;