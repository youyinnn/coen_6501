library ieee;

use ieee.std_logic_1164.all;

entity tri_multiplier is
    port(
        -- unsigned number 
        a       : in std_logic_vector(7 downto 0);
        b       : in std_logic_vector(7 downto 0);

        -- a * a * b
        p       : out std_logic_vector(23 downto 0)
    );
end tri_multiplier;

architecture arch of tri_multiplier is

    -- product of a and a
    signal product_aa       : std_logic_vector(15 downto 0);
    -- product of lower aa and b
    signal product_laa_b    : std_logic_vector(15 downto 0);
    -- product of higher aa and b
    signal product_haa_b    : std_logic_vector(15 downto 0);
    
    -- middle part product of aa and b
    signal product_aab_m    : std_logic_vector(23 downto 0);
    signal extended_product_laa_b    : std_logic_vector(23 downto 0);

    signal sum_of_laa_b_and_aab_m    : std_logic_vector(23 downto 0);

    -- booth multiplier implementation
    component r4b_multiplier is
        port(
            mc      : in std_logic_vector(7 downto 0);
            mp      : in std_logic_vector(7 downto 0);
            p       : out std_logic_vector(15 downto 0)
        );
    end component r4b_multiplier;   

    component left_shifter_8b is
        port(
            a       : in std_logic_vector(15 downto 0);
            p       : out std_logic_vector(23 downto 0)
        );
    end component left_shifter_8b;

    component CSA_24bit is
        port(
          in_a : in std_logic_vector (23 downto 0);
          in_b : in std_logic_vector (23 downto 0);
          sum : out std_logic_vector (23 downto 0);
          carryout : out std_logic);
    end component CSA_24bit;

begin

    aa: r4b_multiplier port map(a, a, product_aa);

    lab: r4b_multiplier port map(product_aa(7 downto 0), b, product_laa_b);
    hab: r4b_multiplier port map(product_aa(15 downto 8), b, product_haa_b);

    aab_m: left_shifter_8b port map(product_haa_b, product_aab_m);

    extended_product_laa_b <= "00000000" & product_laa_b;

    sum: CSA_24bit port map(extended_product_laa_b, product_aab_m, p);

    -- p <= std_logic_vector(unsigned(product_laa_b) + unsigned(product_aab_m));

end arch;