library ieee;
use ieee.std_logic_1164.all;

entity CSA_4bit is
  port(
    in_a : in std_logic_vector (3 downto 0);
    in_b : in std_logic_vector (3 downto 0);
    mux_select : in std_logic;
    sum : out std_logic_vector (3 downto 0);
    carryout : out std_logic);
  end CSA_4bit;
  
architecture rtl of CSA_4bit is
  
component RCA_4bit
  port(
    in_a : in std_logic_vector (3 downto 0);
    in_b : in std_logic_vector (3 downto 0);
    in_c : in std_logic;
    sum : out std_logic_vector (3 downto 0);
    carry_out : out std_logic);
  end component;

component two_to_one_mux
  port(
    a, b, sel : in std_logic;
    y : out std_logic);
  end component;
  
signal temp_sum0 : std_logic_vector (3 downto 0);
signal temp_sum1 : std_logic_vector (3 downto 0);
signal temp_carry0 : std_logic;
signal temp_carry1 : std_logic;

begin
  U1: RCA_4bit port map (in_a, in_b, '0', temp_sum0, temp_carry0);
  U2: RCA_4bit port map (in_a, in_b, '1', temp_sum1, temp_carry1);
  sum_muxes: for i in 3 downto 0 generate
    UA: two_to_one_mux port map (temp_sum0(i), temp_sum1(i), mux_select, sum(i));
  end generate;
  U3: two_to_one_mux port map (temp_carry0, temp_carry1, mux_select, carryout);
end rtl;