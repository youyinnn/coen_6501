library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity circuit_tb is
end entity;

architecture Behavioural of circuit_tb is

    signal r_input_clk      : std_logic := '0';
    signal r_input_start    : std_logic := '0';
    
    signal r_input_a_in_int       : integer := 0;
    signal r_input_b_in_int       : integer := 0;

    signal r_input_a_in_slv       : std_logic_vector(7 downto 0) := (OTHERS => '0');
    signal r_input_b_in_slv       : std_logic_vector(7 downto 0) := (OTHERS => '0');

    signal r_output_ready           : std_logic;
    signal r_output_data_out_int    : integer;
    signal r_output_data_out_slv    : std_logic_vector(15 downto 0) := (OTHERS => '0');

    component circuit is
        port(
            clk           : in std_logic;
            start           : in std_logic;
            a_in            : in std_logic_vector(7 downto 0);
            b_in            : in std_logic_vector(7 downto 0);
    
            ready           : out std_logic;
            data_out        : out std_logic_vector(15 downto 0)
        );
    end component circuit;    

begin

    r_input_a_in_slv <= std_logic_vector(to_unsigned(r_input_a_in_int, 8));
    r_input_b_in_slv <= std_logic_vector(to_unsigned(r_input_b_in_int, 8));

    r_output_data_out_int <= r_input_a_in_int * r_input_b_in_int;

    -- sync clock
    clock: process is
        begin
            wait for 100 ns;
            r_input_clk <= '1';
            wait for 100 ns;
            r_input_clk <= '0';
    end process;   

    en : circuit
    port map (
        clk => r_input_clk,
        start => r_input_start,
        a_in => r_input_a_in_slv,
        b_in => r_input_b_in_slv,

        ready => r_output_ready,
        data_out => r_output_data_out_slv
    );

    r_input_a_in_int <= 
        0 after 100 ns,
        2 after 400 ns,
        -- 0 after 700 ns,
        20 after 2900 ns;

    r_input_b_in_int <= 
        7 after 100 ns,
        9 after 400 ns,
        -- 132 after 700 ns,
        15 after 2900 ns;

    r_input_start <=
        '1' after 100 ns, '0' after 3000 ns, '1' after 5000 ns;

        
end Behavioural;
