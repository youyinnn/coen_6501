library ieee;

use ieee.std_logic_1164.all;

entity overflow_as_separation is
    port(
        data            : in    std_logic_vector(8 downto 0);
        is_not_zero     : out   std_logic
    );
end overflow_as_separation;

architecture structure_arch of overflow_as_separation is    
begin

    is_not_zero <= 
        data(8) or data(7) or data(6) or data(5) or 
        data(4) or data(3) or data(2) or data(1) or 
        data(0);

end structure_arch;