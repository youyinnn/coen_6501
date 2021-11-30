library ieee;

use ieee.std_logic_1164.all;

entity zero_detector_17b is
    port(
        data            : in    std_logic_vector(16 downto 0);
        is_not_zero     : out   std_logic
    );
end zero_detector_17b;

architecture arch of zero_detector_17b is    
begin

    is_not_zero <= 
        data(16) or data(15) or data(14) or data(13) or 
        data(12) or data(11) or data(10) or data(9) or 
        data(8) or data(7) or data(6) or data(5) or 
        data(4) or data(3) or data(2) or data(1) or 
        data(0);

end arch;