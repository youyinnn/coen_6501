library IEEE;
use IEEE.std_logic_1164.all;

-- Right shifter for 24 bit data, data should be interpreted as unsigned number.
entity right_2b_shifter_24b is
   port
   (
      data          : in std_logic_vector(21 downto 0);
      result        : out std_logic_vector(23 downto 0)
   );
end right_2b_shifter_24b;

architecture arch of right_2b_shifter_24b is
begin
   
   result <= "00" & data(21 downto 0);
   
end arch;