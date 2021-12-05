library ieee;

use ieee.std_logic_1164.all;

entity pipelining_circuit_8b_nega_out is
    port(
        clk  : in std_logic;
        load : in std_logic;
        clr  : in std_logic;

        a           : in std_logic_vector(7 downto 0);
        b           : in std_logic_vector(7 downto 0);

        end_flag    : out std_logic;
        z           : out std_logic_vector(15 downto 0)
    );
end pipelining_circuit_8b_nega_out;

architecture arch of pipelining_circuit_8b_nega_out is

    -- register for input a and b
    component operating_circuit_8b is
        port(
            clk  : in std_logic;
            clr  : in std_logic;
            a           : in std_logic_vector(7 downto 0);
            b           : in std_logic_vector(7 downto 0);
            z           : out std_logic_vector(23 downto 0)
        );
    end component operating_circuit_8b;

    -- overflow handling circuit
    component overflow_as_negation_16b is
        port(
            data_in      : in    std_logic_vector(23 downto 0);
            data_out     : out   std_logic_vector(15 downto 0)
        );
    end component overflow_as_negation_16b;

    component negative_edge_register_8b is
        port(
           clr, clk     : in std_logic;
           d            : in std_logic_vector(7 downto 0);
           q            : out std_logic_vector(7 downto 0)
        );
    end component negative_edge_register_8b;

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

    -- circuit unit for stage 1
    component tri_multiplier_8b is
        port(
            a       : in std_logic_vector(7 downto 0);
            b       : in std_logic_vector(7 downto 0);
            p       : out std_logic_vector(23 downto 0)
        );
    end component tri_multiplier_8b;

    -- circuit unit for stage 2
    component right_2b_shifter_24b is
        port(
           data          : in std_logic_vector(21 downto 0);
           result        : out std_logic_vector(23 downto 0)
        );
    end component right_2b_shifter_24b;

    -- circuit unit for stage 3
    component csa_24b_incrementer is
        port(
          in_a : in std_logic_vector (23 downto 0);
          sum : out std_logic_vector (23 downto 0);
          carryout : out std_logic);
    end component csa_24b_incrementer;

    signal a_reg : std_logic_vector(7 downto 0);
    signal b_reg : std_logic_vector(7 downto 0);

    -- stage 3 : (stage 2) + 1
    signal stage_3_result_before_reg   : std_logic_vector(23 downto 0);

    signal stage_3_result_after_reg     : std_logic_vector(23 downto 0);
    signal stage_4_result_before_reg    : std_logic_vector(15 downto 0);
    signal stage_4_result_after_reg     : std_logic_vector(15 downto 0);

    component four_stage_end_flag_generator is
        port(
            clk  : in std_logic;
            load : in std_logic;
            clr  : in std_logic;
    
            stage_end_flag          : out std_logic
        );
    end component four_stage_end_flag_generator;
begin

    a_register: negative_edge_register_8b port map(
        clr, load, a, a_reg
    );    
    
    b_register: negative_edge_register_8b port map(
        clr, load, b, b_reg
    );

    -- 3 clock cycles
    operating: operating_circuit_8b port map(
        clk, clr, a_reg, b_reg, stage_3_result_after_reg
    );

    stage_4_overflow_handling: overflow_as_negation_16b port map(
        stage_3_result_after_reg, stage_4_result_before_reg
    );

    -- 1 clock cycle for saving the overflow handling result.
    stage_4_register: negative_edge_register_16b port map(
        clr, clk, stage_4_result_before_reg, stage_4_result_after_reg
    );

    -- end_flag generation
    end_flag_generate: four_stage_end_flag_generator 
    port map(
        clk, load, clr, end_flag
    );

    z <= stage_4_result_after_reg;

end arch;