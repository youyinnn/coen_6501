library ieee;
use ieee.std_logic_1164.all;

entity two_to_one_mux is
  port(
    a, b, sel : in std_logic;
    y : out std_logic);
 end two_to_one_mux;

architecture rtl of two_to_one_mux is

component AND_logic
  port(
    in_A, in_B : in std_logic;
    output : out std_logic);
end component;
 
component NOT_logic
  port(
    in_A : in std_logic;
    output : out std_logic);
end component;
 
component OR_logic
  port(
    in_A, in_B : in std_logic;
    output : out std_logic);
end component;

signal temp0, temp1, temp2 : std_logic;
  begin
  U1: AND_logic port map(sel, b, temp0);
  U2: NOT_logic port map (sel, temp1);
  U3: AND_logic port map (temp1,a, temp2);
  U4: OR_logic port map (temp0, temp2, y);
 end rtl;