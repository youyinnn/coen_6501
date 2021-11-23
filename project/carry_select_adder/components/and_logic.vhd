library ieee;
use ieee.std_logic_1164.all;

entity AND_logic is
  port(
    in_A, in_B : in std_logic;
    output : out std_logic);
  end AND_logic;

architecture AND_logic_behavior of AND_logic is
  begin
    output <= in_A and in_B;
  end AND_logic_behavior;
