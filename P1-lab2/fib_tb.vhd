library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

-- Testbench for the Fibonacci sequence generator

entity fib_tb is
end fib_tb;

architecture tb of fib_tb is
    constant TEST_WIDTH : positive := 8;
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal go : std_logic := '0';
    signal n : std_logic_vector(TEST_WIDTH-1 downto 0) := (others => '0');
    signal done : std_logic := '0';
    signal output : std_logic_vector(TEST_WIDTH-1 downto 0) := (others => '0');

begin

  UUT : entity work.fib(fib_arch)
    generic map (TEST_WIDTH)
    port map (
      clk => clk,
      reset => reset,
      go => go,
      n => n,
      done => done,
      output => output
    );

    clk <= not clk after 10 ns;

    process
    begin 
    
      reset <= '1';
      go <= '0';
      n <= (others => '0');

      wait for 100 ns;

      reset <= '0';
      wait until rising_edge(clk);

      -- Check n = 11 equal to 89
      n <= std_logic_vector(to_unsigned(11, TEST_WIDTH));
      go <= '1';
      wait until done = '1';
      assert output = std_logic_vector(to_unsigned(89, TEST_WIDTH)) report "Test 1 failed" severity error;

      -- Finish the test

      wait;

    end process;

end tb; -- tb