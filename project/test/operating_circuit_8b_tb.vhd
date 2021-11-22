library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity operating_circuit_8b_tb is
end entity;

architecture Behavioural of operating_circuit_8b_tb is

    signal r_input_clk  : STD_LOGIC := '0';
    signal r_input_load : std_logic := '0';
    signal r_input_clr  : std_logic := '0';

    signal r_input_a_slv    : std_logic_vector(7 downto 0)  := (OTHERS => '0');
    signal r_input_b_slv    : std_logic_vector(7 downto 0)  := (OTHERS => '0');

    signal r_output_end_flag        : std_logic := '0';
    signal r_output_z_slv           : std_logic_vector(23 downto 0)  := (OTHERS => '0');

    -- decimal signal

    signal r_input_a            : integer := 0;
    signal r_input_b            : integer := 0;
    signal r_output_stage_1     : integer := 0;
    signal r_output_stage_2     : integer := 0;
    signal r_output_stage_3     : integer := 0;
    signal r_output_z           : integer := 0;

    component operating_circuit_8b is
        port(
            clk  : in std_logic;
            load : in std_logic;
            clr  : in std_logic;
    
            a           : in std_logic_vector(7 downto 0);
            b           : in std_logic_vector(7 downto 0);
    
            z           : out std_logic_vector(23 downto 0)
        );
    end component operating_circuit_8b;

    -- output assertion
    component assert_output_24b is
        port(
            opt         : in std_logic_vector(23 downto 0);
            assert_int  : in integer;
            dl          : in time
        );
    end component assert_output_24b;

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
    
    
    circuit : operating_circuit_8b
    port map (
        clk => r_input_clk,
        load => r_input_load,
        clr => r_input_clr,
        a => r_input_a_slv,
        b => r_input_b_slv,
        z => r_output_z_slv
    );
    
    r_input_a <=
            4 after 100 ns,
            255 after 900 ns;

    r_input_b <=
            4 after 100 ns,
            255 after 900 ns;

    r_input_load <=
            '1',
            '0' after 200 ns,
            '1' after 800 ns,
            '0' after 1000 ns;

    -- r_input_clr <=
    --         '1' after 1020 ns,
    --         '0' after 1030 ns;

    as_1: assert_output_24b port map(r_output_z_slv, r_output_z, 801 ns);
    as_2: assert_output_24b port map(r_output_z_slv, r_output_z, 1601 ns);

end Behavioural;