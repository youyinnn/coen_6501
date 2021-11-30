library ieee;

use ieee.std_logic_1164.all;

entity pipelining_circuit_16b_nega_out is
    port(
        clk  : in std_logic;
        load : in std_logic;
        clr  : in std_logic;

        a           : in std_logic_vector(15 downto 0);
        b           : in std_logic_vector(15 downto 0);

        end_flag    : out std_logic;
        z           : out std_logic_vector(31 downto 0)
    );
end pipelining_circuit_16b_nega_out;

architecture arch of pipelining_circuit_16b_nega_out is


    -- register for input a and b
    component operating_circuit_16b is
        port(
            clk  : in std_logic;
            load : in std_logic;
            clr  : in std_logic;
            a           : in std_logic_vector(15 downto 0);
            b           : in std_logic_vector(15 downto 0);
            z           : out std_logic_vector(47 downto 0)
        );
    end component operating_circuit_16b;

    -- overflow handling circuit
    component overflow_as_negation_32b is
        port(
            data_in      : in    std_logic_vector(47 downto 0);
            data_out     : out   std_logic_vector(31 downto 0)
        );
    end component overflow_as_negation_32b;

    component negative_edge_register_16b is
        port(
           clr, clk     : in std_logic;
           d            : in std_logic_vector(15 downto 0);
           q            : out std_logic_vector(15 downto 0)
        );
    end component negative_edge_register_16b;

    component negative_edge_register_32b is
        port(
           clr, clk     : in std_logic;
           d            : in std_logic_vector(31 downto 0);
           q            : out std_logic_vector(31 downto 0)
        );
    end component negative_edge_register_32b;

    signal a_reg : std_logic_vector(15 downto 0);
    signal b_reg : std_logic_vector(15 downto 0);
    signal stage_3_result_after_reg     : std_logic_vector(47 downto 0);
    signal stage_4_result_before_reg    : std_logic_vector(31 downto 0);
    signal stage_4_result_after_reg     : std_logic_vector(31 downto 0);

    component n_stage_end_flag_generator is
        generic (
            STAGE_LENGTH : natural
        );
        port(
            clk  : in std_logic;
            load : in std_logic;
            clr  : in std_logic;
    
            stage_end_flag          : out std_logic
        );
    end component n_stage_end_flag_generator;
begin

    a_register: negative_edge_register_16b port map(
        clr, load, a, a_reg
    );    
    
    b_register: negative_edge_register_16b port map(
        clr, load, b, b_reg
    );

    -- 3 clock cycles
    stage_1_to_3_operating: operating_circuit_16b port map(
        clk, load, clr, a_reg, b_reg, stage_3_result_after_reg
    );

    stage_4_overflow_handling: overflow_as_negation_32b port map(
        stage_3_result_after_reg, stage_4_result_before_reg
    );

    -- 1 clock cycle for saving the overflow handling result.
    stage_4_register: negative_edge_register_32b port map(
        clr, clk, stage_4_result_before_reg, stage_4_result_after_reg
    );

    -- end_flag generation
    end_flag_generate: n_stage_end_flag_generator 
    generic map (4)
    port map(
        clk, load, clr, end_flag
    );

    z <= stage_4_result_after_reg;

end arch;