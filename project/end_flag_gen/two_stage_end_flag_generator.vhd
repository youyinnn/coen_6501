library ieee;

use ieee.std_logic_1164.all;

entity two_stage_end_flag_generator is
    port(
        clk  : in std_logic;
        load : in std_logic;
        clr  : in std_logic;

        stage_end_flag          : out std_logic
    );
end two_stage_end_flag_generator;

architecture arch of two_stage_end_flag_generator is
    type state is (idle, done);
    signal state_reg, state_next: state;
begin

    -- control path: register for state
    process(clk, clr)
    begin
        if clr = '1' then
            state_reg <= idle;
        elsif falling_edge(clk) then
            state_reg <= state_next;
        end if;
    end process;

    -- control path: next state logic
    process(state_reg, clr, load)
    begin
        -- state_next <= state_reg;
        case state_reg is
            when idle =>
                if clr = '0' and falling_edge(load) then
                    state_next <= done;
                end if;           
            when done =>
                if clr = '1' then
                    state_next <= idle;
                end if;
        end case;
    end process;

    -- data path: routing for stage_for_operating
    process(state_reg, load)
    begin
        case state_reg is
            when idle =>
                stage_end_flag <= '0';
            when done =>
                stage_end_flag <= '1';
        end case;
    end process;

end arch;