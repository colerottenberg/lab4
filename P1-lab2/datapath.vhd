library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Datapath for fibonacci sequence

entity datapath is
    generic(
      width : integer := 24
    );
    port(
      -- clk and rst
      clk: in std_logic;
      rst : in std_logic;
      
      -- i/o 
      n : in std_logic_vector(5 downto 0);
      result : out std_logic_vector(23 downto 0);
      -- control inputs
      x_sel : in std_logic;
      y_sel : in std_logic;
      i_sel : in std_logic;
      result_sel : in std_logic;


      n_en : in std_logic;
      result_en : in std_logic;
      x_en : in std_logic;
      y_en : in std_logic;
      i_en : in std_logic;
      n_eq_0 : out std_logic;

      -- status signals
      i_le_n : out std_logic
    );
end datapath;

-- The datapath is composed of registers, fibonacci logic and other components

-- The datapath starts with a register for the input n
-- if n_en is high, the input n is loaded into the register
-- afterwards, the register is connected to the fibonacci logic

architecture rtl of datapath is
    signal i_reg_out, x_reg_out, y_reg_out, n_reg_out : std_logic_vector(width-1 downto 0);
    signal i_mux_out, x_mux_out, y_mux_out, result_mux_out : std_logic_vector(width-1 downto 0);
    signal add1_out, add2_out : std_logic_vector(width-1 downto 0);
    signal n_scaled : std_logic_vector(width-1 downto 0);
  -- Build input register and logic 
    begin
  
  -- Connecting components to impl fibonacci logic using registers,mux, adders and comparators
        I_MUX : entity work.mux
            generic map(
                width => width
            )
            port map(
                input1 => add1_out,
                input2 => std_logic_vector(to_unsigned(2, width)),
                sel => i_sel,
                output => i_mux_out
            );
    
        X_MUX : entity work.mux
            generic map(
                width => width
            )
            port map(
                input1 => y_reg_out,
                input2 => std_logic_vector(to_unsigned(0, width)),
                sel => x_sel,
                output => x_mux_out
            );

        Y_MUX : entity work.mux
            generic map(
                width => width
            )
            port map(
                input1 => add2_out,
                input2 => std_logic_vector(to_unsigned(1, width)),
                sel => y_sel,
                output => y_mux_out
            );

        RESULT_MUX : entity work.mux
            generic map(
                width => width
            )
            port map(
                input1 => y_reg_out,
                input2 => std_logic_vector(to_unsigned(0, width)),
                sel => result_sel,
                output => result
            );

        -- REGISTERS

        I_REG : entity work.reg
            generic map(
                width => width
            )
            port map(
                clk => clk,
                reset => rst,
                d => i_mux_out,
                q => i_reg_out,
                en => i_en
            );

        X_REG : entity work.reg
            generic map(
                width => width
            )
            port map(
                clk => clk,
                reset => rst,
                d => x_mux_out,
                q => x_reg_out,
                en => x_en
            );

        Y_REG : entity work.reg
            generic map(
                width => width
            )
            port map(
                clk => clk,
                reset => rst,
                d => y_mux_out,
                q => y_reg_out,
                en => y_en
            );

        N_REG : entity work.reg
            generic map(
                width => width
            )
            port map(
                clk => clk,
                reset => rst,
                d => (width-1-6 downto 0 => '0') & n,
                q => n_reg_out,
                en => n_en
            );

        -- ADDERS

        ADD1 : entity work.add
            generic map(
                width => width
            )
            port map(
                in1 => std_logic_vector(to_unsigned(1, width)),
                in2 => i_reg_out,
                output => add1_out
            );

        ADD2 : entity work.add
            generic map(
                width => width
            )
            port map(
                in1 => x_reg_out,
                in2 => y_reg_out,
                output => add2_out
            );

        -- COMPARATOR
        N_COMP : entity work.comparator
            generic map(
                width => width
            )
            port map(
                a => n_reg_out,
                b => std_logic_vector(to_unsigned(0, width)),
                eq => n_eq_0
            );
        
        LE_COMP : entity work.comparator
            generic map(
                width => width
            )
            port map(
                a => i_reg_out,
                b => n_reg_out,
                le => i_le_n
            );
end rtl;