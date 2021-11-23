library ieee;
use ieee.std_logic_1164.all;

entity RCA_4bit is
  port(
    in_a : in std_logic_vector (3 downto 0);
    in_b : in std_logic_vector (3 downto 0);
    in_c : in std_logic;
    sum : out std_logic_vector (3 downto 0);
    carry_out : out std_logic);
  end RCA_4bit;

architecture rtl of RCA_4bit is

component full_adder
  port(
    in_a, in_b, in_c : in std_logic;
    carry, sum : out std_logic);
 end component;

signal temp_carry : std_logic_vector (3 downto 0);
begin
  U1: full_adder port map (in_a(0), in_b(0), in_c, temp_carry(0), sum(0));
  full_adder_generate: for i in 1 to 3 generate
  UA: full_adder port map (in_a(i), in_b(i), temp_carry(i-1), temp_carry(i), sum(i));
end generate;

carry_out <= temp_carry(3);

end rtl;