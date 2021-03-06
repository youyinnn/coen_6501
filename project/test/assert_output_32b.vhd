library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity assert_output_32b is
    port(
        opt         : in std_logic_vector(31 downto 0);
        assert_unsigned  : in unsigned(31 downto 0);
        dl          : in time
    );
end assert_output_32b;

architecture arch of assert_output_32b is
begin

    process
        begin
            wait for dl;
            assert unsigned(opt) = assert_unsigned 
                report "assertion failed";
            wait;
        end process;

end arch;