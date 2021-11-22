library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
entity ethernet_preamble is
    port(
        clk         : in std_logic;
        start       : in std_logic;
        data_out    : out std_logic_vector(7 downto 0)
    );
end ethernet_preamble;

architecture arch of ethernet_preamble is
    -- constant ZERO and the SEQUENCE
    constant ZERO           : std_logic_vector(7 downto 0) := "00000000";
    constant SEQ            : std_logic_vector(7 downto 0) := "10101010";

    -- timer for counting eight cycles
    constant EIGHT_CLOEK    : natural := 7;
    constant CLOEK_RESER    : natural := 0;
    signal t                : natural;

    -- the state of the circuit;
    type state_of_circuit is (IDLE, COUNT, DONE);
    -- register of the state
    signal state_reg, state_next     : state_of_circuit;
begin
    -- state register
    process(clk, start)
    begin
        if start = '0' then   
            state_reg <= IDLE;
        elsif rising_edge(clk) then        
            state_reg <= state_next;
        end if;
    end process;   
    
    -- timer
    process(clk, start)
    begin
        if start = '0' then      
            t <= CLOEK_RESER;
        elsif rising_edge(clk) and state_reg = COUNT then        
            t <= t + 1;
        end if;
    end process;

    process(state_reg, start, t)
    begin
        state_next <= state_reg;
        data_out <= ZERO;
        case state_reg is
            when IDLE =>
                if start = '1' then
                    state_next <= COUNT;
                end if;
            when COUNT =>
                if t = EIGHT_CLOEK then
                    state_next <= DONE;
                end if;
            when DONE =>
                data_out <= SEQ;
        end case;
    end process;
end arch;