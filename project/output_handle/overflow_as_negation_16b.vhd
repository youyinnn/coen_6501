library ieee;
use ieee.std_logic_1164.all;

-- Output the source data as negation if it was beyond 16 signed range
entity overflow_as_negation_16b is
    port(
        data_in      : in    std_logic_vector(23 downto 0);

        -- MBS is interpreted as negation sign
        data_out     : out   std_logic_vector(15 downto 0)
    );
end overflow_as_negation_16b;

architecture arch of overflow_as_negation_16b is

    constant overflow_negation : std_logic_vector(15 downto 0) := "1000000000000000";
    signal is_overflow : std_logic;
    
    component zero_detector_9b is
        port(
            data            : in    std_logic_vector(8 downto 0);
            is_not_zero     : out   std_logic
        );
    end component zero_detector_9b; 
begin

    zero_detect: zero_detector_9b port map(
        data => data_in(23 downto 15),
        is_not_zero => is_overflow
    );

    data_out <= overflow_negation when is_overflow = '1' else "0" & data_in(14 downto 0);

end arch;