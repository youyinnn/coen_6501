library ieee;
use ieee.std_logic_1164.all;

entity CSA_24bit is
  port(
    in_a : in std_logic_vector (23 downto 0);
    in_b : in std_logic_vector (23 downto 0);
    sum : out std_logic_vector (23 downto 0);
    carryout : out std_logic);
end CSA_24bit;
  
architecture rtl of CSA_24bit is
  
    component CSA_4bit
        port(
            in_a : in std_logic_vector (3 downto 0);
            in_b : in std_logic_vector (3 downto 0);
            mux_select : in std_logic;
            sum : out std_logic_vector (3 downto 0);
            carryout : out std_logic);
    end component;

    component RCA_4bit
        port(
            in_a : in std_logic_vector (3 downto 0);
            in_b : in std_logic_vector (3 downto 0);
            in_c : in std_logic;
            sum : out std_logic_vector (3 downto 0);
            carry_out : out std_logic);
    end component;

    signal temp_carry0 : std_logic;
    signal temp_carry1 : std_logic;
    signal temp_carry2 : std_logic;

    signal temp_carry3 : std_logic;
    signal temp_carry4 : std_logic;

begin

  U1: RCA_4bit port map (in_a (3 downto 0), in_b (3 downto 0), '0', sum(3 downto 0), temp_carry0);
  U2: CSA_4bit port map (in_a (7 downto 4), in_b (7 downto 4), temp_carry0, sum(7 downto 4), temp_carry1);
  U3: CSA_4bit port map (in_a (11 downto 8), in_b (11 downto 8), temp_carry1, sum(11 downto 8), temp_carry2);
  U4: CSA_4bit port map (in_a (15 downto 12), in_b (15 downto 12), temp_carry2, sum(15 downto 12), temp_carry3);

  U5: CSA_4bit port map (in_a (19 downto 16), in_b (19 downto 16), temp_carry3, sum(19 downto 16), temp_carry4);
  U6: CSA_4bit port map (in_a (23 downto 20), in_b (23 downto 20), temp_carry4, sum(23 downto 20), carryout);

end rtl;