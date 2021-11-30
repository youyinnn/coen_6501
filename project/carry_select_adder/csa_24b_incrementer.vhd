library ieee;
use ieee.std_logic_1164.all;

entity csa_24b_incrementer is
  port(
    in_a : in std_logic_vector (23 downto 0);
    sum : out std_logic_vector (23 downto 0);
    carryout : out std_logic);
end csa_24b_incrementer;
  
architecture rtl of csa_24b_incrementer is

    component CSA_24bit is
        port(
          in_a : in std_logic_vector (23 downto 0);
          in_b : in std_logic_vector (23 downto 0);
          sum : out std_logic_vector (23 downto 0);
          carryout : out std_logic);
    end component CSA_24bit;

    constant one : std_logic_vector (23 downto 0) := (0 => '1', others => '0');

begin

    u1: CSA_24bit port map(in_a, one, sum, carryout);

end rtl;