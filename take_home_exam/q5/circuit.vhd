library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity circuit is
    port(
        clk             : in std_logic;
        start           : in std_logic;
        a_in            : in std_logic_vector(7 downto 0);
        b_in            : in std_logic_vector(7 downto 0);

        ready           : out std_logic;
        data_out        : out std_logic_vector(15 downto 0)
    );
end circuit;

architecture arch of circuit is

    type state_type is (idle, ab0, load, op);
    signal state_reg, state_next    : state_type;

    signal a_is_0   : std_logic;
    signal b_is_0   : std_logic;
    signal count_0  : std_logic;

    signal a : std_logic_vector(7 downto 0);
    signal n : std_logic_vector(7 downto 0);
    signal r : std_logic_vector(15 downto 0);

begin

    a_is_0 <= '1'   when a_in = "00000000" else '0';
    b_is_0 <= '1'   when b_in = "00000000" else '0';
    count_0 <= '1'  when n = "00000000" else '0';

    -- state register
    process(clk, start)
    begin
        if start = '0' then   
            state_reg <= IDLE;
        elsif rising_edge(clk) then        
            state_reg <= state_next;
        end if;
    end process;    

    process(clk, start, n)
    begin        
        if start = '0' then                 -- reset
            a <= a_in;
            n <= b_in;
            r <= "0000000000000000";
        elsif rising_edge(clk) then
            case state_reg is
                when op => 
                    if count_0 = '0' then   -- perform operation when count_0 = '0'
                        n <= std_logic_vector(unsigned(n) - 1);
                        r <= std_logic_vector(unsigned(r) + unsigned(a));
                    end if;
                when others =>              -- default value
                    a <= a_in;
                    n <= b_in;
                    r <= "0000000000000000";
            end case;
        end if;
    end process;
        
    process(state_reg, start, count_0, a_is_0, b_is_0)
    begin
        state_next <= state_reg;
        case state_reg is
            when idle =>
                ready <= '1';               -- ready = '1' when the circuit is at idle state
                if start = '1' then
                    if a_is_0 = '1' or b_is_0 = '1' then
                        state_next <= ab0;
                    else
                        state_next <= load;
                    end if;
                end if;
            when ab0 =>
                ready <= '0';               -- otherwise the ready signal will be assigned as '0'
                state_next <= idle;
            when load =>
                ready <= '0';
                state_next <= op;
            when op =>
                ready <= '0';
                if count_0 = '1' then
                    -- state_next <= idle;                      -- This commented line is the old implementation.
                    if start = '1' then                         -- From this line to the end of this if block
                        if a_is_0 = '1' or b_is_0 = '1' then    -- are the new implementations.
                            state_next <= ab0;
                        else
                            state_next <= load;
                        end if;
                    end if;
                end if;
        end case;
    end process;

    data_out <= r;

end arch;