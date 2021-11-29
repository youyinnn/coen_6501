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
        if falling_edge(clk) then
            if display_higher = '0' then
                display_higher <= '1';
            else
                display_higher <= '0';
            end if;
        end if;
    end process;
    
    z_out <= 
        (others => '0') when clr = '1' else
        higher_data     when display_higher = '1' else
        lower_data;

end arch;