library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ethernet_preamble_tb is
end entity;

architecture Behavioural of ethernet_preamble_tb is
    signal r_input_start    : std_logic := '0';
    signal r_input_clk      : std_logic   := '0';
    
    signal r_output_data_out       : std_logic_vector(7 downto 0);

    component ethernet_preamble is
        port(
            clk         : in std_logic;
            start       : in std_logic;
    
            data_out    : out std_logic_vector(7 downto 0)
        );
    end component ethernet_preamble;    

begin

    -- sync clock
    clock: process is
        begin
            wait for 100 ns;
            r_input_clk <= '1';
            wait for 100 ns;
            r_input_clk <= '0';
    end process;   

    en : ethernet_preamble
    port map (
        clk => r_input_clk,
        start => r_input_start,
        data_out => r_output_data_out
    );

    r_input_start <= '1' after 350 ns, '0' after 700 ns, '1' after 900 ns;

        
end Behavioural;
