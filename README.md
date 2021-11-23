## Intro

### Project

#### Structure Reference

``` bash
/project/
		/carry_select_adder/
				/componments/													-- gates fa muxs
				/csa_4b.vhd
        /csa_16b.vhd
        /csa_24b_incrementer.vhd
        /csa_24b.vhd
        /full_adder.vhd
        /rca_4b.vhd
    /end_flag_gen/														-- end flag generator
    /fst/																			-- simulation wave fst file
    /output_handle/
        /overflow_as_negation.vhd
        /overflow_as_separation.vhd
        /zero_dectector_9b.vhd
    /pipelining/															-- pipelining implementation
      	/operating_circuit_8b.vhd
      	/pipelining_circuit_8b.vhd
    /register/																-- n bit negative edge register
    /shifter/																	-- shifter for '1/4' Operation
    /test/																		-- testbenches
    /tri_multipler/														-- multiplier for 'a*a*b' Operation
    		/r4b_multiplier/											-- radix 4 booth multiplier
    				/booth_stage/											-- booth stages
    				/complement/											-- negation complement generator
    				/r4b_multiplier.vhd
    		/left_shifter_8b.vhd
    		/tri_multiplier.vhd
```

#### Break down work

##### Project Code

| Task                                    |        J.H         |        DW.Z        |        YL.Y        |        XS.F        |
| --------------------------------------- | :----------------: | :----------------: | :----------------: | :----------------: |
| 16b/24b/32b Carry Select Adder          |                    | :heavy_check_mark: | :heavy_check_mark: |                    |
| CSA Testbench                           | :heavy_check_mark: | :heavy_check_mark: | :heavy_check_mark: |                    |
| 8b/16b Radix 4 Booth Multiplier         | :heavy_check_mark: |                    |                    |                    |
| Booth Multiplier Testbench              | :heavy_check_mark: |                    |                    |                    |
| 1/4(Right 2 b Shifter) Operation        | :heavy_check_mark: |                    |                    |                    |
| 24b Incrementor                         |                    | :heavy_check_mark: | :heavy_check_mark: |                    |
| Overflow Handler: Negation              | :heavy_check_mark: |                    |                    | :heavy_check_mark: |
| Overflow Handler: Separation            | :heavy_check_mark: |                    |                    | :heavy_check_mark: |
| Pipelining Implementation               | :heavy_check_mark: |                    |                    |                    |
| Pipelining Implementation Testbench     | :heavy_check_mark: |                    |                    |                    |
| Non-Pipelining Implementation           |                    | :heavy_check_mark: | :heavy_check_mark: |                    |
| Non-Pipelining Implementation Testbench |                    | :heavy_check_mark: | :heavy_check_mark: |                    |

##### Project Documentation

| Task        | J.H  | DW.Z | YL.Y | XS.F |
| ----------- | :--: | :--: | :--: | :--: |
| Abstraction |      |      |      |      |
| ...         |      |      |      |      |
| ....        |      |      |      |      |

