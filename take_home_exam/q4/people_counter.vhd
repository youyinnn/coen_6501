library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity people_counter is
    port(
        x           : in std_logic;
        y           : in std_logic;
        data_out    : out std_logic_vector(7 downto 0)
    );
end people_counter;

architecture arch of people_counter is
    type delta_type is (IDLE, ADD, SUB);
    signal delta    : delta_type;

    constant ZERO   : unsigned(7 downto 0) := "00000000";
    constant MAX    : unsigned(7 downto 0) := "11111111";
    signal count    : unsigned(7 downto 0) := ZERO;
begin

    -- FSM
    delta <= 
        -- go to IDLE state when x and y trigger at the same time
        IDLE    when falling_edge(x) and falling_edge(y) else
        -- go to ADD state
        ADD    when falling_edge(x) else
        -- go to SUB state
        SUB   when falling_edge(y) else
        -- go back to IDLE in other cases
        IDLE;

    -- datapath
    process(delta)
    begin
        if delta = IDLE then
            count <= count;
        elsif delta = ADD then
            if (count /= MAX) then 
                count <= count + 1;
            end if;
        else
            if (count /= ZERO) then 
                count <= count - 1;
            end if;
        end if;
    end process;

    data_out <= std_logic_vector(count);

end arch;