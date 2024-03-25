library ieee;
use ieee.std_logic_1164.all;

-- Testbench for the clk_div module

entity clk_div_tb is
end clk_div_tb;

architecture tb of clk_div_tb is
  signal clk : std_logic := '0';
  signal slow : std_logic := '0';
begin
  U_clk_div : entity work.clk_div
    generic map (
      clk_in_freq => 50e6,
      clk_out_freq => 25e6
    )
    port map (
      clk_in => clk,
      rst => '0',
      clk_out => slow
    );

  clk_process : process
  begin
    clk <= not clk;
    wait for 10 ns;
  end process;

end tb;