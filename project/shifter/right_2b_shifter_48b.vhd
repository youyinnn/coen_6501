library IEEE;
use IEEE.std_logic_1164.all;

-- Right shifter for 48 bit data, data should be interpreted as unsigned number.
entity right_2b_shifter_48b is
   port
   (
      data          : in std_logic_vector(47 downto 0);
      result        : out std_logic_vector(47 downto 0)
   );
end right_2b_shifter_48b;

architecture arch of right_2b_shifter_48b is
begin
   
   result <= "00" & data(47 downto 2);
   
end arch;