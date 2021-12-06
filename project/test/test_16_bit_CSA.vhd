library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
entity test_16_bit_CSA is 
end entity;

architecture arch_test of test_16_bit_CSA is
    component csa_16bit
        port(
            in_a : in  std_logic_vector (15 downto 0);
    in_b : in  std_logic_vector (15 downto 0);
    sum : out std_logic_vector (15 downto 0);
    carryout : out std_logic
    );
    end component;
    
    signal in_a :  std_logic_vector(15 downto 0):= "0010011000100110";
    signal in_b :  std_logic_vector(15 downto 0):= "0011111000111110";
    signal sum :  std_logic_vector(15 downto 0);
    signal carryout : std_logic;
 
begin
    process
        variable ap :std_logic_vector(15 downto 0) := "0000101000001010";
        variable bp :std_logic_vector(15 downto 0) := "0000101000001010";
        begin
            wait for 100 ns;
            in_a <= std_logic_vector(unsigned(in_a) + unsigned(ap));
            in_b <= std_logic_vector(unsigned(in_b) + unsigned(bp));
    end process;
    
    dut: csa_16bit port map
        (
        in_a => in_a,
        in_b => in_b,
        sum => sum,
        carryout => carryout
        );  
end arch_test;