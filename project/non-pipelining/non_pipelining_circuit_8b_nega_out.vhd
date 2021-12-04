library ieee;

use ieee.std_logic_1164.all;

entity nonpipeline_circuit_8b_nega_out is
    port(
        clk  : in std_logic;
        load : in std_logic;
        clr  : in std_logic;

        a           : in std_logic_vector(7 downto 0);
        b           : in std_logic_vector(7 downto 0);

        end_flag    : out std_logic;
        z           : out std_logic_vector(15 downto 0)
    );
end nonpipeline_circuit_8b_nega_out;

architecture arch of nonpipeline_circuit_8b_nega_out is

    component negative_edge_register_8b is
        port(
           clr, clk     : in std_logic;
           d            : in std_logic_vector(7 downto 0);
           q            : out std_logic_vector(7 downto 0)
        );
    end component negative_edge_register_8b;
    
    component non_pipelining_operating_circuit_8b is
        port(
            clk  : in std_logic;
            clr  : in std_logic;
            a           : in std_logic_vector(7 downto 0);
            b           : in std_logic_vector(7 downto 0);
            z           : out std_logic_vector(23 downto 0)
        );
    end component non_pipelining_operating_circuit_8b;

    -- overflow handling circuit
    component overflow_as_negation_16b is
        port(
            data_in      : in    std_logic_vector(23 downto 0);
            data_out     : out   std_logic_vector(15 downto 0)
        );
    end component overflow_as_negation_16b;

    component negative_edge_register_16b is
        port(
           clr, clk     : in std_logic;
           d            : in std_logic_vector(15 downto 0);
           q            : out std_logic_vector(15 downto 0)
        );
    end component negative_edge_register_16b;
    
    component negative_edge_register_24b is
           port(
              clr, clk : in std_logic;
              d         : in std_logic_vector(23 downto 0);
              q         : out std_logic_vector(23 downto 0)
           );
    end component negative_edge_register_24b;
    
    component two_stage_end_flag_generator is
        port(
            clk  : in std_logic;
            load : in std_logic;
            clr  : in std_logic;
    
            stage_end_flag          : out std_logic
        );
    end component two_stage_end_flag_generator;
  
    signal U1_result               : std_logic_vector(23 downto 0);
    signal U2_result_before_reg    : std_logic_vector(15 downto 0);
    signal U2_result_after_reg     : std_logic_vector(15 downto 0);  
    
begin

    U1: non_pipelining_operating_circuit_8b port map(load, clr, a, b, U1_result);

    U2: overflow_as_negation_16b port map(U1_result, U2_result_before_reg);

    U3: negative_edge_register_16b port map(clr, clk, U2_result_before_reg, U2_result_after_reg);

    U4: two_stage_end_flag_generator port map(clk, load, clr, end_flag);

    z <= U2_result_after_reg;

end arch;
