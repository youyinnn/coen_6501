library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity csa_16b_tb is
end entity;

architecture Behavioural of csa_16b_tb is

    -- integer a & b & sum & c_out
    signal r_input_a   : integer  := 0;
    signal r_input_b   : integer  := 0;
    signal r_output_sum   : integer  := 0;
    signal r_output_c_out   : integer  := 0;

    signal r_input_a_slv        : STD_LOGIC_VECTOR(15 downto 0) := (OTHERS => '0');
    signal r_input_b_slv        : STD_LOGIC_VECTOR(15 downto 0) := (OTHERS => '0');
    signal r_output_sum_slv     : STD_LOGIC_VECTOR(15 downto 0) := (OTHERS => '0');
    signal r_output_c_out_sl    : STD_LOGIC := '0';

    component assert_output_16b is
        port(
            opt         : in std_logic_vector(15 downto 0);
            assert_int  : in integer;
            dl          : in time
        );
    end component assert_output_16b;

    component CSA_16bit is
        port(
          in_a : in std_logic_vector (15 downto 0);
          in_b : in std_logic_vector (15 downto 0);
          sum : out std_logic_vector (15 downto 0);
          carryout : out std_logic);
    end component CSA_16bit;

begin

    r_input_a_slv <= std_logic_vector(to_unsigned(r_input_a, 16));
    r_input_b_slv <= std_logic_vector(to_unsigned(r_input_b, 16));
    r_output_c_out <= 1 when r_output_c_out_sl = '1' else 0;

    r_output_sum <= r_input_a + r_input_b - (r_output_c_out * 65536);

    ad: CSA_16bit port map (
        in_a => r_input_a_slv,
        in_b => r_input_b_slv,
        sum => r_output_sum_slv,
        carryout => r_output_c_out_sl
    );

    r_input_a 
        <= 
        0 after 100 ns,
        65535 after 200 ns,
        12313 after 300 ns,
        0 after 400 ns,
        1 after 500 ns,
        0 after 2000 ns
        ;

    r_input_b 
        <= 
        0 after 100 ns,
        65535 after 200 ns,
        41231 after 300 ns,
        7777 after 400 ns,
        0 after 500 ns,
        0 after 2000 ns
        ;

    as_1: assert_output_16b port map(r_output_sum_slv, r_output_sum, 101 ns);
    as_2: assert_output_16b port map(r_output_sum_slv, r_output_sum, 201 ns);
    as_3: assert_output_16b port map(r_output_sum_slv, r_output_sum, 301 ns);
    as_4: assert_output_16b port map(r_output_sum_slv, r_output_sum, 401 ns);
    as_5: assert_output_16b port map(r_output_sum_slv, r_output_sum, 501 ns);
    as_6: assert_output_16b port map(r_output_sum_slv, r_output_sum, 2001 ns);
 

end Behavioural;