library ieee;
use ieee.std_logic_1164.all;

entity CSA_48bit is
  port(
    in_a : in std_logic_vector (47 downto 0);
    in_b : in std_logic_vector (47 downto 0);
    sum : out std_logic_vector (47 downto 0);
    carryout : out std_logic);
end CSA_48bit;
  
architecture rtl of CSA_48bit is
  
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

    signal temp_carry5 : std_logic;
    signal temp_carry6 : std_logic;

    signal temp_carry7 : std_logic;
    signal temp_carry8 : std_logic;
    signal temp_carry9 : std_logic;
    signal temp_carry10 : std_logic;

begin

  U1: RCA_4bit port map (in_a (3 downto 0), in_b (3 downto 0), '0', sum(3 downto 0), temp_carry0);
  U2: CSA_4bit port map (in_a (7 downto 4), in_b (7 downto 4), temp_carry0, sum(7 downto 4), temp_carry1);
  U3: CSA_4bit port map (in_a (11 downto 8), in_b (11 downto 8), temp_carry1, sum(11 downto 8), temp_carry2);
  U4: CSA_4bit port map (in_a (15 downto 12), in_b (15 downto 12), temp_carry2, sum(15 downto 12), temp_carry3);

  U5: CSA_4bit port map (in_a (19 downto 16), in_b (19 downto 16), temp_carry3, sum(19 downto 16), temp_carry4);
  U6: CSA_4bit port map (in_a (23 downto 20), in_b (23 downto 20), temp_carry4, sum(23 downto 20), temp_carry5);

  U7: CSA_4bit port map (in_a (27 downto 24), in_b (27 downto 24), temp_carry5, sum(27 downto 24), temp_carry6);
  U8: CSA_4bit port map (in_a (31 downto 28), in_b (31 downto 28), temp_carry6, sum(31 downto 28), temp_carry7);

  U9:  CSA_4bit port map (in_a (35 downto 32), in_b (35 downto 32), temp_carry7, sum(35 downto 32), temp_carry8);
  U10: CSA_4bit port map (in_a (39 downto 36), in_b (39 downto 36), temp_carry8, sum(39 downto 36), temp_carry9);
  U11: CSA_4bit port map (in_a (43 downto 40), in_b (43 downto 40), temp_carry9, sum(43 downto 40), temp_carry10);
  U12: CSA_4bit port map (in_a (47 downto 44), in_b (47 downto 44), temp_carry10, sum(47 downto 44), carryout);

end rtl;