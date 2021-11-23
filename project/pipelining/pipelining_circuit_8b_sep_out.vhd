library ieee;

use ieee.std_logic_1164.all;

entity pipelining_circuit_8b_sep_out is
    port(
        clk  : in std_logic;
        load : in std_logic;
        clr  : in std_logic;

        a           : in std_logic_vector(7 downto 0);
        b           : in std_logic_vector(7 downto 0);

        end_flag    : out std_logic;
        z           : out std_logic_vector(15 downto 0)
    );
end pipelining_circuit_8b_sep_out;

architecture arch of pipelining_circuit_8b_sep_out is

    component operating_circuit_8b is
        port(
            clk  : in std_logic;
            load : in std_logic;
            clr  : in std_logic;
            a           : in std_logic_vector(7 downto 0);
            b           : in std_logic_vector(7 downto 0);
            z           : out std_logic_vector(23 downto 0)
        );
    end component operating_circuit_8b;

    -- overflow handling circuit
    component overflow_as_separation is
        port(
            data_in      : in    std_logic_vector(23 downto 0);
    
            lower_data_out      : out   std_logic_vector(15 downto 0);
            higher_data_out     : out   std_logic_vector(15 downto 0)
        );
    end component overflow_as_separation;

    component negative_edge_register_16b is
        port(
           clr, clk     : in std_logic;
           d            : in std_logic_vector(15 downto 0);
           q            : out std_logic_vector(15 downto 0)
        );
    end component negative_edge_register_16b;

    signal stage_3_result_after_reg     : std_logic_vector(23 downto 0);

    signal stage_4_higher_result_before_reg    : std_logic_vector(15 downto 0);
    signal stage_4_lower_result_before_reg    : std_logic_vector(15 downto 0);
    signal stage_4_higher_result_after_reg     : std_logic_vector(15 downto 0);
    signal stage_4_lower_result_after_reg     : std_logic_vector(15 downto 0);

    component n_stage_end_flag_generator is
        generic (
            STAGE_LENGTH : natural
        );
        port(
            clk  : in std_logic;
            load : in std_logic;
            clr  : in std_logic;
    
            five_stage_end_flag     : out std_logic;
            stage_vector            : out std_logic_vector(STAGE_LENGTH - 1 downto 0)
        );
    end component n_stage_end_flag_generator;

    constant SIX_STAGE : natural := 6;
    signal stage : std_logic_vector(SIX_STAGE - 1 downto 0);

    component display_z_separation is
        port(
            clk         : in std_logic;
            clr         : in std_logic;
            lower_data  : in    std_logic_vector(15 downto 0);
            higher_data : in    std_logic_vector(15 downto 0);
    
            z_out       : out   std_logic_vector(15 downto 0)
        );
    end component display_z_separation;
begin

    -- 3 clock cycles
    operating: operating_circuit_8b port map(
        clk, load, clr, a, b, stage_3_result_after_reg
    );

    overflow_handling: overflow_as_separation port map(
        data_in =>          stage_3_result_after_reg, 
        lower_data_out =>   stage_4_lower_result_before_reg, 
        higher_data_out =>  stage_4_higher_result_before_reg
    );

    -- 1 clock cycle for saving the overflow handling result.
    stage_4_register_lower: negative_edge_register_16b port map(
        clr, clk, stage_4_lower_result_before_reg, stage_4_lower_result_after_reg
    );
    stage_4_register_higher: negative_edge_register_16b port map(
        clr, clk, stage_4_higher_result_before_reg, stage_4_higher_result_after_reg
    );

    -- end_flag generation
    end_flag_generate: n_stage_end_flag_generator 
    generic map (SIX_STAGE)
    port map(
        clk, load, clr, end_flag, stage
    );

    -- display z higher first, then z lower
    display_z_separately: display_z_separation port map(
        clk, clr,
        stage_4_lower_result_after_reg,
        stage_4_higher_result_after_reg,
        z
    );


end arch;