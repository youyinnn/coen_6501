library ieee;

use ieee.std_logic_1164.all;

entity stage_4_end_flag_generator is
    port(
        clk  : in std_logic;
        load : in std_logic;
        clr  : in std_logic;

        stage_4_end_flag    : out std_logic
    );
end stage_4_end_flag_generator;

architecture structure_arch of stage_4_end_flag_generator is
    signal state: std_logic_vector(4 downto 0) := "00000"; 
begin

    stage_4_end_flag <= state(state'length - 1);

    process(clk, load, clr)
    begin
        if clr = '1' then
            state <= "00000";
        elsif falling_edge(load) then
            state <= "00001";
        elsif state(state'length - 1) = '0' then
            if falling_edge(clk) then
                state <= state(state'length - 2 downto 0) & state(state'length - 1);
            end if;
        end if;
    end process;

end structure_arch;