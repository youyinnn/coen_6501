library ieee;

use ieee.std_logic_1164.all;

entity n_stage_end_flag_generator is
    generic (
        constant STAGE_LENGTH : natural
    );
    port(
        clk  : in std_logic;
        load : in std_logic;
        clr  : in std_logic;

        stage_end_flag     : out std_logic;
        stage_vector            : out std_logic_vector(STAGE_LENGTH - 1 downto 0)
    );
end n_stage_end_flag_generator;

architecture arch of n_stage_end_flag_generator is
    constant FIRST_STAGE : std_logic_vector(STAGE_LENGTH - 1 downto 0) := (0 => '1', others => '0');
    type state is (idle, start, operating, done);
    signal stage_for_operating: std_logic_vector(STAGE_LENGTH - 1 downto 0) := (others => '0');
    signal state_reg, state_next: state;
begin

    stage_vector <= stage_for_operating;

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
    process(state_reg, stage_for_operating, load)
    begin
        state_next <= state_reg;
        case state_reg is
            when idle =>
                if falling_edge(load) then
                    state_next <= start;
                end if;           
            when start =>
                state_next <= operating;
            when operating =>
                if falling_edge(load) then
                    state_next <= start;
                elsif stage_for_operating(STAGE_LENGTH - 1) = '1' then
                    state_next <= done;
                end if;
            when done =>
                if falling_edge(load) then
                    state_next <= start;
                end if;
        end case;
    end process;

    -- datapath: register for the stage_for_operating
    process(clk, load)
    begin
        if falling_edge(load) then               -- load acts like a preset
            stage_for_operating <= FIRST_STAGE;
        elsif falling_edge(clk) then
            if state_reg = operating then
                stage_for_operating <= 
                    stage_for_operating(STAGE_LENGTH - 2 downto 0) & stage_for_operating(STAGE_LENGTH - 1);
            end if;
        end if;
    end process;

    -- data path: routing for stage_for_operating
    process(state_reg, stage_for_operating, load)
    begin
        case state_reg is
            when idle =>
                stage_end_flag <= '0';
            when start =>
                stage_end_flag <= '0';
            when operating =>
                stage_end_flag <= '0';
            when done =>
                stage_end_flag <= '1';
        end case;
    end process;

end arch;