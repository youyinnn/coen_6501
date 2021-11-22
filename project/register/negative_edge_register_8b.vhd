library IEEE;
use IEEE.std_logic_1164.all;

entity negative_edge_register_8b is
   port
   (
      clr, clk : in std_logic;
      d         : in std_logic_vector(7 downto 0);
      q         : out std_logic_vector(7 downto 0)
   );
end negative_edge_register_8b;

architecture arch of negative_edge_register_8b is
begin
   
   PROCESS (clk, clr)                      
   begin
      IF clr = '1' THEN            
         q <= (OTHERS => '0');
      ELSIF falling_edge(clk) THEN
         q <= d;
      end IF;
   end PROCESS;
   
end arch;