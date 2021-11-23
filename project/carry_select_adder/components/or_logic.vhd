library ieee;
use ieee.std_logic_1164.all;

entity OR_logic is
  port(
    in_A, in_B : in std_logic;
    output : out std_logic);
  end OR_logic;

architecture OR_logic_behavior of OR_logic is
  begin
    output <= in_A or in_B;
 end OR_logic_behavior;
