library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.vga_lib.all;

use ieee.std_logic_textio.all;
use std.textio.all;

entity vga_basic_tb is
end vga_basic_tb;

architecture TB of vga_basic_tb is

    constant TIMEOUT            : time := 1 ms;
    constant MIN_ACCEPT_PERCENT : real := 0.8;
    constant MAX_ACCEPT_PERCENT : real := 1.2;

    signal clkEn            : std_logic := '1';
    signal clk              : std_logic := '0';
    signal red, green, blue : std_logic_vector(3 downto 0);
    signal rst, video_on    : std_logic;
    signal h_sync, v_sync   : std_logic;
    signal en               : std_logic;

begin  -- TB

    clk <= not clk and clkEn after 20 ns;

    U_VGA : entity work.vga port map(
        clk      => clk,
        rst      => rst,
        en       => en,
        red      => red,
        green    => green,
        blue     => blue,
        h_sync   => h_sync,
        v_sync   => v_sync,
        video_on => video_on);

    process
    begin

        --------------------------------------------------------------------------------
        -- Begin Running VGA Test
        --------------------------------------------------------------------------------
        clkEn <= '1';
        rst     <= '1';
        en      <= '0';
        for i in 0 to 4 loop
            wait until rising_edge(clk);
        end loop;
        rst <= '0';
        en <= '1';
        for i in 0 to 5000 loop
            wait until rising_edge(clk);
        end loop;
        clkEn <= '0';
        wait;

    end process;
end TB;