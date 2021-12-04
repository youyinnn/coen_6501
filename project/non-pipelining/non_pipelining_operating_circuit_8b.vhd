library ieee;
use ieee.std_logic_1164.all;

entity non_pipelining_operating_circuit_8b is
    port(
        clk  : in std_logic;
        clr  : in std_logic;

        a           : in std_logic_vector(7 downto 0);
        b           : in std_logic_vector(7 downto 0);

        z           : out std_logic_vector(23 downto 0)
    );
end non_pipelining_operating_circuit_8b;

architecture structure_arch of non_pipelining_operating_circuit_8b is

  component negative_edge_register_8b is
          port(
             clr, clk     : in std_logic;
             d            : in std_logic_vector(7 downto 0);
             q            : out std_logic_vector(7 downto 0)
          );
      end component negative_edge_register_8b;
      
  component tri_multiplier_8b is
        port(
            a       : in std_logic_vector(7 downto 0);
            b       : in std_logic_vector(7 downto 0);
            p       : out std_logic_vector(23 downto 0)
        );
    end component tri_multiplier_8b;
      
  component right_2b_shifter_24b is
    port(
       data          : in std_logic_vector(21 downto 0);
       result        : out std_logic_vector(23 downto 0)
    );
  end component right_2b_shifter_24b;
      
  component csa_24b_incrementer is
          port(
            in_a : in std_logic_vector (23 downto 0);
            sum : out std_logic_vector (23 downto 0);
            carryout : out std_logic);
      end component csa_24b_incrementer;
      
signal a_reg : std_logic_vector (7 downto 0);
signal b_reg : std_logic_vector (7 downto 0);
signal temp_p : std_logic_vector (23 downto 0);
signal temp_result : std_logic_vector (23 downto 0);
  
begin
  
  -- Create operand registers
  U1: negative_edge_register_8b port map(clr, clk, a, a_reg);
  U2: negative_edge_register_8b port map(clr, clk, b, b_reg);
    
  -- Create 1/4 (a * a * b) + 1
  U3: tri_multiplier_8b port map (a_reg, b_reg, temp_p);
  U4: right_2b_shifter_24b port map (temp_p(23 downto 2), temp_result);
  U5: csa_24b_incrementer port map (temp_result, z);

end structure_arch;
