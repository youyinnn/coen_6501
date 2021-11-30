library ieee;
use ieee.std_logic_1164.all;

entity csa_16b_incrementer is
  port(
    in_a : in std_logic_vector (15 downto 0);
    sum : out std_logic_vector (15 downto 0);
    carryout : out std_logic);
end csa_16b_incrementer;
  
architecture rtl of csa_16b_incrementer is

    component CSA_16bit is
        port(
          in_a : in std_logic_vector (15 downto 0);
          in_b : in std_logic_vector (15 downto 0);
          sum : out std_logic_vector (15 downto 0);
          carryout : out std_logic);
    end component CSA_16bit;
    
    constant one : std_logic_vector (15 downto 0) := (0 => '1', others => '0');

begin

    u1: CSA_16bit port map(in_a, one, sum, carryout);

end rtl;