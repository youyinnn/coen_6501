library ieee;

use ieee.std_logic_1164.all;

entity csa_16b_tb is
end entity;

architecture Behavioural of csa_16b_tb is

    signal r_input_a        : STD_LOGIC_VECTOR(15 downto 0) := (OTHERS => '0');
    signal r_input_b        : STD_LOGIC_VECTOR(15 downto 0) := (OTHERS => '0');
    signal r_output_sum     : STD_LOGIC_VECTOR(15 downto 0) := (OTHERS => '0');
    signal r_output_c_out   : STD_LOGIC := '0';


    component CSA_16bit is
        port(
          in_a : in std_logic_vector (15 downto 0);
          in_b : in std_logic_vector (15 downto 0);
          sum : out std_logic_vector (15 downto 0);
          carryout : out std_logic);
    end component CSA_16bit;

begin

    ad: CSA_16bit port map (
        in_a => r_input_a,
        in_b => r_input_b,
        sum => r_output_sum,
        carryout => r_output_c_out
    );

    r_input_a 
        <= 
        "0000000000000000" after 100 ns,
        "1111111111111111" after 200 ns,
        "0000000000000000" after 2000 ns
        ;

    r_input_b 
        <= 
        "0000000000000000" after 100 ns,
        "1111111111111111" after 200 ns,
        "0000000000000000" after 2000 ns
        ;

end Behavioural;