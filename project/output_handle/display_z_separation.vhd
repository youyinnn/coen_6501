library ieee;
use ieee.std_logic_1164.all;

entity display_z_separation is
    port(
        clk         : in std_logic;
        clr         : in std_logic;
        lower_data  : in    std_logic_vector(15 downto 0);
        higher_data : in    std_logic_vector(15 downto 0);

        z_out       : out   std_logic_vector(15 downto 0)
    );
end display_z_separation;

architecture arch of display_z_separation is
    signal display_higher : std_logic := '0';
begin

    process(clk)
    begin
        if clr = '1' then
            z_out <= (others => '0');
        elsif falling_edge(clk) then
            if display_higher = '0' then
                z_out <= lower_data;
                display_higher <= '1';
            else
                z_out <= higher_data;
                display_higher <= '0';
            end if;
        end if;
    end process;
end arch;