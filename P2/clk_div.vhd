library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Clock Divider turns the 500MHz clock into 50MHz 
-- The 50Mhz clock is used to drive the VGA display
-- 500_000_000 / 10 = 50_000_000 

entity clk_div is
    generic(
        clk_in_freq : integer := 10
        clk_out_freq : integer := 1
    );
    port(
        clk : in std_logic;
        reset : in std_logic;
        clk_out : out std_logic
    );
end clk_div;

architecture Behavioral of clk_div is
    -- Setting COUNTER_MAX to generic input_frequency
    constant COUNTER_MAX : integer := input_frequency;
    signal counter : integer range 0 to COUNTER_MAX := 0;
    signal temp_clk : STD_LOGIC := '0';

begin
    process(clk, reset)
    begin
        if reset = '1' then
            counter <= 0;
            temp_clk <= '0';
        elsif rising_edge(clk) then
            if counter = COUNTER_MAX then
                counter <= 0;
                temp_clk <= not temp_clk;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    clk_out <= temp_clk;

end Behavioral;
