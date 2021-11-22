library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity people_counter_tb is
end entity;

architecture Behavioural of people_counter_tb is

    signal r_input_x    : std_logic := '1';
    signal r_input_y    : std_logic := '1';
    signal r_input_clk      : std_logic   := '0';
    
    signal r_output_data_out       : std_logic_vector(7 downto 0);

    component people_counter is
        port(
            x           : in std_logic;
            y           : in std_logic;
            data_out    : out std_logic_vector(7 downto 0)
        );
    end component people_counter; 

begin  

    -- sync clock
    clock: process is
        begin
            wait for 1 ns;
            r_input_clk <= '1';
            wait for 1 ns;
            r_input_clk <= '0';
    end process; 

    en : people_counter
    port map (
        x => r_input_x,
        y => r_input_y,
        data_out => r_output_data_out
    );


    r_input_x <=
        '0' after 100 ns,
        '1' after 200 ns,

        '0' after 300 ns,
        '1' after 400 ns,

        '0' after 500 ns,
        '1' after 600 ns,
    
        '0' after 700 ns,
        '1' after 800 ns;

    r_input_y <=

        '0' after 300 ns,
        '1' after 350 ns,

        '0' after 470 ns,
        '1' after 510 ns,

        '0' after 610 ns,
        '1' after 670 ns,

        '0' after 890 ns,
        '1' after 900 ns;
    
end Behavioural;
