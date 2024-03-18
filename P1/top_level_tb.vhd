library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

-- Testbench for the top level of fibonacci

entity top_level_tb is
end top_level_tb;

architecture tb of top_level_tb is
  signal clk    : std_logic := '0';
  signal switch : std_logic_vector(9 downto 0) := (others => '0');
  signal button : std_logic_vector(1 downto 0) := (others => '0');
  signal dbg    : std_logic_vector(23 downto 0) := (others => '0');

  constant clk_period : time := 5 ns;
  begin
  UUT : entity work.top_level(default)
    port map (
      clk    => clk,
      switch => switch,
      button => button,
      dbg    => dbg
    );

  clk <= not clk after clk_period;

  process
  begin
    wait for 10 ns;
    switch <= "0000001011"; -- Input as 11
    wait for 10 ns;

    -- Button to start is second button
    button(0) <= not button(0);
    wait for 50 ns;
    button(0) <= not button(0);

    -- Wait for the fibonacci sequence to be calculated as 89
    wait until dbg = "01011001";
    -- End the simulation
    wait;
  end process;
end tb;

