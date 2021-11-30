-- ***************************************
-- A multiplier for triple 16 bits unsigned operands.
-- 
-- Basic logic steps: same as we do in 8 bits.
-- 
-- Use radix-4 booth multiply algorithm to perform the multiplication.
-- *************************************** 

library ieee;
use ieee.std_logic_1164.all;

entity tri_multiplier_16b is
    port(
        -- unsigned number 
        a       : in std_logic_vector(15 downto 0);
        b       : in std_logic_vector(15 downto 0);

        -- a * a * b
        p       : out std_logic_vector(47 downto 0)
    );
end tri_multiplier_16b;

architecture arch of tri_multiplier_16b is

    -- product of a * a
    signal product_aa       : std_logic_vector(31 downto 0);
    -- product of (lower aa) * b
    signal product_laa_b    : std_logic_vector(31 downto 0);
    -- product of (higher aa) * b
    signal product_haa_b    : std_logic_vector(31 downto 0);
    
    -- middle part product of (aa * b)
    signal product_aab_m    : std_logic_vector(47 downto 0);

    -- lower part product of (aa * b)
    signal product_aab_l    : std_logic_vector(47 downto 0);

    -- booth multiplier implementation
    component r4b_multiplier_16b is
        port(
            mc      : in std_logic_vector(15 downto 0);
            mp      : in std_logic_vector(15 downto 0);
            p       : out std_logic_vector(31 downto 0)
        );
    end component r4b_multiplier_16b;   

    component left_shifter_16b is
        port(
            a       : in std_logic_vector(31 downto 0);
            p       : out std_logic_vector(47 downto 0)
        );
    end component left_shifter_16b;

    component left_bits_filler_16b is
        port(
            a       : in std_logic_vector(31 downto 0);
            p       : out std_logic_vector(47 downto 0)
        );
    end component left_bits_filler_16b;

    component CSA_48bit is
        port(
          in_a : in std_logic_vector (47 downto 0);
          in_b : in std_logic_vector (47 downto 0);
          sum : out std_logic_vector (47 downto 0);
          carryout : out std_logic);
    end component CSA_48bit;

begin

    a_square: r4b_multiplier_16b port map(a, a, product_aa);

    lower_part_of_a_square_multiply_b: r4b_multiplier_16b port map(product_aa(15 downto 0), b, product_laa_b);
    higher_part_of_a_square_multiply_b: r4b_multiplier_16b port map(product_aa(31 downto 16), b, product_haa_b);

    middle_product_of_a_square_multiply_b: left_shifter_16b port map(product_haa_b, product_aab_m);
    lower_product_of_a_square_multiply_b: left_bits_filler_16b port map(product_laa_b, product_aab_l);

    final_product: CSA_48bit port map(product_aab_l, product_aab_m, p);

end arch;