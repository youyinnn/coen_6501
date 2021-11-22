library ieee;

use ieee.std_logic_1164.all;

entity operating_circuit_8b is
    port(
        clk  : in std_logic;
        load : in std_logic;
        clr  : in std_logic;

        a           : in std_logic_vector(7 downto 0);
        b           : in std_logic_vector(7 downto 0);

        z           : out std_logic_vector(23 downto 0)
    );
end operating_circuit_8b;

architecture structure_arch of operating_circuit_8b is

    signal a_reg : std_logic_vector(7 downto 0);
    signal b_reg : std_logic_vector(7 downto 0);

    -- stage 1 : a * a * a
    signal stage_1_result_before_reg   : std_logic_vector(23 downto 0);
    signal stage_1_result_after_reg    : std_logic_vector(23 downto 0);

    -- stage 2 : 1/4 (stage 1)
    signal stage_2_result_before_reg   : std_logic_vector(23 downto 0);
    signal stage_2_result_after_reg    : std_logic_vector(23 downto 0);

    -- stage 3 : (stage 2) + 1
    signal stage_3_result_before_reg   : std_logic_vector(23 downto 0);
    signal stage_3_result_after_reg    : std_logic_vector(23 downto 0);

    component negative_edge_register_8b is
        port(
           clr, clk     : in std_logic;
           d            : in std_logic_vector(7 downto 0);
           q            : out std_logic_vector(7 downto 0)
        );
    end component negative_edge_register_8b;
    
    component negative_edge_register_24b is
        port(
           clr, clk : in std_logic;
           d         : in std_logic_vector(23 downto 0);
           q         : out std_logic_vector(23 downto 0)
        );
    end component negative_edge_register_24b;

    -- circuit unit for stage 1
    component tri_multiplier is
        port(
            a       : in std_logic_vector(7 downto 0);
            b       : in std_logic_vector(7 downto 0);
            p       : out std_logic_vector(23 downto 0)
        );
    end component tri_multiplier;

    -- circuit unit for stage 2
    component right_2b_shifter_24b is
        port(
           data          : in std_logic_vector(23 downto 0);
           result        : out std_logic_vector(23 downto 0)
        );
    end component right_2b_shifter_24b;

    -- circuit unit for stage 3
    component csa_24bit_incrementer is
        port(
          in_a : in std_logic_vector (23 downto 0);
          sum : out std_logic_vector (23 downto 0);
          carryout : out std_logic);
    end component csa_24bit_incrementer;

    -- circuit unit for stage 4
    component overflow_as_negation is
        port(
            data_in      : in    std_logic_vector(23 downto 0);
            data_out     : out   std_logic_vector(15 downto 0)
        );
    end component overflow_as_negation;

begin

    a_register: negative_edge_register_8b port map(
        clr, load, a, a_reg
    );    
    
    b_register: negative_edge_register_8b port map(
        clr, load, b, b_reg
    );

    stage_1: tri_multiplier port map(
        a => a_reg, 
        b => b_reg, 
        p => stage_1_result_before_reg
    );

    stage_1_register: negative_edge_register_24b port map(
        clr, clk, stage_1_result_before_reg, stage_1_result_after_reg
    );

    stage_2: right_2b_shifter_24b port map(
        data    => stage_1_result_after_reg, 
        result  => stage_2_result_before_reg
    );

    stage_2_register: negative_edge_register_24b port map(
        clr, clk, stage_2_result_before_reg, stage_2_result_after_reg
    );

    stage_3: csa_24bit_incrementer port map(
        in_a    => stage_2_result_after_reg, 
        sum     => stage_3_result_before_reg
    );

    stage_3_register: negative_edge_register_24b port map(
        clr, clk, stage_3_result_before_reg, stage_3_result_after_reg
    );

    z <= stage_3_result_after_reg;

end structure_arch;