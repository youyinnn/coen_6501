library ieee;
use ieee.std_logic_1164.all;

-- Output the source data as higher 15 bit part and lower 15 bit part
entity overflow_as_separation is
    port(
        data_in      : in    std_logic_vector(23 downto 0);

        lower_data_out      : out   std_logic_vector(15 downto 0);
        higher_data_out     : out   std_logic_vector(15 downto 0)
    );
end overflow_as_separation;

architecture structure_arch of overflow_as_separation is
begin

    lower_data_out  <= "0" & data_in(14 downto 0);
    higher_data_out <= "1000000" & data_in(23 downto 15);

end structure_arch;