library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
  port(
    in_A, in_B, in_C : in std_logic;
    carry, sum : out std_logic);
 end full_adder;
 
architecture full_adder_arch of full_adder is
  signal sum_temp1, carry_temp1, carry_temp2 : std_logic;

component XOR_logic
  port(
    in_A, in_B : in std_logic;
    output : out std_logic);
 end component;
 
component OR_logic
  port(
    in_A, in_B : in std_logic;
    output : out std_logic);
 end component;
 
component AND_logic
  port(
    in_A, in_B : in std_logic;
    output : out std_logic);
 end component;
 
 begin
   U1: XOR_logic port map(in_A, in_B, sum_temp1);
   U2: XOR_logic port map(sum_temp1, in_C, sum);
   U3: AND_logic port map (in_A, in_B, carry_temp1);
   U4: AND_logic port map (sum_temp1, in_C, carry_temp2);
   U5: OR_logic  port map (carry_temp1, carry_temp2, carry);
end full_adder_arch;
