library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipelining_circuit_8b_sep_out_tb is
end entity;

architecture Behavioural of pipelining_circuit_8b_sep_out_tb is

    signal r_input_clk  : STD_LOGIC := '0';
    signal r_input_load : std_logic := '1';
    signal r_input_clr  : std_logic := '0';

    signal r_input_a_slv    : std_logic_vector(7 downto 0)  := (OTHERS => '0');
    signal r_input_b_slv    : std_logic_vector(7 downto 0)  := (OTHERS => '0');

    signal r_output_end_flag        : std_logic := '1';
    signal r_output_z_slv           : std_logic_vector(15 downto 0)  := (OTHERS => '0');

    -- decimal signal

    signal r_input_a            : integer := 0;
    signal r_input_b            : integer := 0;
    signal r_output_stage_1     : integer := 0;
    signal r_output_stage_2     : integer := 0;
    signal r_output_stage_3     : integer := 0;
    signal r_output_z           : integer := 0;

    component pipelining_circuit_8b_sep_out is
        port(
            clk  : in std_logic;
            load : in std_logic;
            clr  : in std_logic;
    
            a           : in std_logic_vector(7 downto 0);
            b           : in std_logic_vector(7 downto 0);
    
            end_flag    : out std_logic;
            z           : out std_logic_vector(15 downto 0)
        );
    end component pipelining_circuit_8b_sep_out;

begin

    r_input_a_slv <= std_logic_vector(to_unsigned(r_input_a, 8));
    r_input_b_slv <= std_logic_vector(to_unsigned(r_input_b, 8));

    r_output_stage_1 <= r_input_a * r_input_a * r_input_b;
    r_output_stage_2 <= (r_output_stage_1 / 4);
    r_output_stage_3 <= r_output_stage_2 + 1;
    r_output_z <= r_output_stage_3;

    -- clock
    clock: process is
        begin
            wait for 100 ns;
            r_input_clk <= '1';
            wait for 100 ns;
            r_input_clk <= '0';
    end process;     

    -- clock2
    clock2: process is
        constant period: time := 100 ns;
        begin
            wait for period;
            wait for period;
            r_input_load <= '0';
            wait for period;
            r_input_load <= '1';
            wait for period;
            r_input_load <= '0';
            wait for period;
            r_input_load <= '1';
            wait for period;
            r_input_load <= '0';
            wait for period;
            r_input_load <= '1';
            wait for period;
            r_input_load <= '0';

            wait for period * 22;
            r_input_load <= '1';
            wait for period;
            r_input_load <= '0';
            wait;
    end process;     
    
    
    circuit : pipelining_circuit_8b_sep_out
    port map (
        clk => r_input_clk,
        load => r_input_load,
        clr => r_input_clr,
        a => r_input_a_slv,
        b => r_input_b_slv,
        end_flag => r_output_end_flag,
        z => r_output_z_slv
    );
    
    r_input_a <=
            4 after 100 ns,
            4 after 300 ns,
            123 after 500 ns,
            12 after 681 ns,
            255 after 4000 ns;

    r_input_b <=
            4 after 100 ns,
            59 after 300 ns,
            32 after 500 ns,
            6 after 810 ns,
            255 after 4000 ns;

    -- r_input_clr <=
    --         '1' after 1420 ns,
    --         '1' after 1430 ns;

end Behavioural;