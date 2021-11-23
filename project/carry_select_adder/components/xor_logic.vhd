library ieee;
use ieee.std_logic_1164.all;

entity XOR_logic is
  port(
    in_A, in_B : in std_logic;
    output : out std_logic);
  end XOR_logic;

architecture OR_logic_behavior of XOR_logic is
  begin
    output <= in_A xor in_B;
 end OR_logic_behavior;
