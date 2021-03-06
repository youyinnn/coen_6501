library ieee;

use ieee.std_logic_1164.all;

entity operating_circuit_16b is
    port(
        clk  : in std_logic;
        load : in std_logic;
        clr  : in std_logic;

        a           : in std_logic_vector(15 downto 0);
        b           : in std_logic_vector(15 downto 0);

        z           : out std_logic_vector(47 downto 0)
    );
end operating_circuit_16b;

architecture arch of operating_circuit_16b is

    -- stage 1 : a * a * b
    signal stage_1_result_before_reg   : std_logic_vector(47 downto 0);
    signal stage_1_result_after_reg    : std_logic_vector(47 downto 0);

    -- stage 2 : 1/4 (stage 1)
    signal stage_2_result_before_reg   : std_logic_vector(47 downto 0);
    signal stage_2_result_after_reg    : std_logic_vector(47 downto 0);

    -- stage 3 : (stage 2) + 1
    signal stage_3_result_before_reg   : std_logic_vector(47 downto 0);
    signal stage_3_result_after_reg    : std_logic_vector(47 downto 0);
    
    component negative_edge_register_48b is
        port(
           clr, clk : in std_logic;
           d         : in std_logic_vector(47 downto 0);
           q         : out std_logic_vector(47 downto 0)
        );
    end component negative_edge_register_48b;

    -- circuit unit for stage 1
    component tri_multiplier_16b is
        port(
            a       : in std_logic_vector(15 downto 0);
            b       : in std_logic_vector(15 downto 0);
            p       : out std_logic_vector(47 downto 0)
        );
    end component tri_multiplier_16b;

    -- circuit unit for stage 2
    component right_2b_shifter_48b is
        port(
           data          : in std_logic_vector(47 downto 0);
           result        : out std_logic_vector(47 downto 0)
        );
    end component right_2b_shifter_48b;

    -- circuit unit for stage 3
    component csa_48b_incrementer is
        port(
          in_a : in std_logic_vector (47 downto 0);
          sum : out std_logic_vector (47 downto 0);
          carryout : out std_logic);
    end component csa_48b_incrementer;

begin

    stage_1_operation: tri_multiplier_16b port map(
        a => a, 
        b => b, 
        p => stage_1_result_before_reg
    );

    stage_1_register: negative_edge_register_48b port map(
        clr, clk, stage_1_result_before_reg, stage_1_result_after_reg
    );

    stage_2_operation: right_2b_shifter_48b port map(
        data    => stage_1_result_after_reg, 
        result  => stage_2_result_before_reg
    );

    stage_2_register: negative_edge_register_48b port map(
        clr, clk, stage_2_result_before_reg, stage_2_result_after_reg
    );

    stage_3_operation: csa_48b_incrementer port map(
        in_a    => stage_2_result_after_reg, 
        sum     => stage_3_result_before_reg
    );

    stage_3_register: negative_edge_register_48b port map(
        clr, clk, stage_3_result_before_reg, stage_3_result_after_reg
    );

    z <= stage_3_result_after_reg;

end arch;