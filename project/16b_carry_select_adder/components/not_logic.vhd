library ieee;
use ieee.std_logic_1164.all;

entity NOT_logic is
  port(
    in_A : in std_logic;
    output : out std_logic);
  end NOT_logic;
  
architecture NOT_logic_behavior of NOT_logic is
  begin
    output <= NOT(in_A);
  end NOT_logic_behavior;
