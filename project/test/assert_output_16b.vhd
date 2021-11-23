library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity assert_output_16b is
    port(
        opt         : in std_logic_vector(15 downto 0);
        assert_int  : in integer;
        dl          : in time
    );
end assert_output_16b;

architecture arch of assert_output_16b is
begin

    process
        begin
            wait for dl;
            assert to_integer(unsigned(opt)) = assert_int 
                report "wrong value actually : " & integer'image(to_integer(unsigned(opt))) & ", but expected: " & integer'image(assert_int);
            wait;
        end process;

end arch;