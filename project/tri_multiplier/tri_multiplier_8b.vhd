-- ***************************************
-- A multiplier for triple 8 bits unsigned operands.
-- 
-- Basic logic steps:
--      1. a multiply a and gets product aa in 16 bits;
--      2. aa in 16 bits multiply b in 8 bits can be divided as:
--          2.1 aa(15 downto 8) multiply b then gets haa_b in 16 bits;
--          2.2 aa(7 downto 0)  multiply b then gets laa_b in 16 bits;
--          2.3 haa_b & "00000000" as aa_b_m;
--          2.4 "00000000" & laa_b as aa_b_l;
--          2.5 aa_b_m add aa_b_l then get final answer in 24 bits;
-- 
-- Use radix-4 booth multiply algorithm to perform the multiplication.
-- *************************************** 

library ieee;
use ieee.std_logic_1164.all;

entity tri_multiplier_8b is
    port(
        -- unsigned number 
        a       : in std_logic_vector(7 downto 0);
        b       : in std_logic_vector(7 downto 0);

        -- a * a * b
        p       : out std_logic_vector(23 downto 0)
    );
end tri_multiplier_8b;

architecture arch of tri_multiplier_8b is

    -- product of a * a
    signal product_aa       : std_logic_vector(15 downto 0);
    -- product of (lower aa) * b
    signal product_laa_b    : std_logic_vector(15 downto 0);
    -- product of (higher aa) * b
    signal product_haa_b    : std_logic_vector(15 downto 0);
    
    -- middle part product of (aa * b)
    signal product_aab_m    : std_logic_vector(23 downto 0);

    -- lower part product of (aa * b)
    signal product_aab_l    : std_logic_vector(23 downto 0);

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

    component left_bits_filler_8b is
        port(
            a       : in std_logic_vector(15 downto 0);
            p       : out std_logic_vector(23 downto 0)
        );
    end component left_bits_filler_8b;

    component CSA_24bit is
        port(
          in_a : in std_logic_vector (23 downto 0);
          in_b : in std_logic_vector (23 downto 0);
          sum : out std_logic_vector (23 downto 0);
          carryout : out std_logic);
    end component CSA_24bit;

begin

    a_square: r4b_multiplier port map(a, a, product_aa);

    lower_part_of_a_square_multiply_b: r4b_multiplier port map(product_aa(7 downto 0), b, product_laa_b);
    higher_part_of_a_square_multiply_b: r4b_multiplier port map(product_aa(15 downto 8), b, product_haa_b);

    middle_product_of_a_square_multiply_b: left_shifter_8b port map(product_haa_b, product_aab_m);
    lower_product_of_a_square_multiply_b: left_bits_filler_8b port map(product_laa_b, product_aab_l);

    final_product: CSA_24bit port map(product_aab_l, product_aab_m, p);

end arch;