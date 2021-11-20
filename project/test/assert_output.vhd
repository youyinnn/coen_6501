library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity assert_output is
    port(
        opt         : in std_logic_vector(15 downto 0);
        assert_int  : in integer;
        dl          : in time
    );
end assert_output;

architecture arch of assert_output is
begin

    process
        begin
            wait for dl;
            assert to_integer(unsigned(opt)) = assert_int 
                report "wrong value expect: " & integer'image(assert_int) & ", but: " & integer'image(to_integer(unsigned(opt)));
            wait;
        end process;

end arch;