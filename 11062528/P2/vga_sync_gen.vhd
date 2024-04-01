library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.VGA_LIB.all;

entity vga_sync_gen is
    port (
        clk       : in std_logic;
        rst       : in std_logic;
        h_count   : out std_logic_vector(COUNT_RANGE);
        v_count   : out std_logic_vector(COUNT_RANGE);
        h_sync    : out std_logic;
        v_sync    : out std_logic;
        video_on  : out std_logic
    );
end entity;

architecture bhv of vga_sync_gen is
    -- Counters
    signal h_counter : unsigned(COUNT_RANGE) := (others => '0');
    signal v_counter : unsigned(COUNT_RANGE) := (others => '0');

begin
    -- Counter Loop
    process(clk)
    begin
        if rising_edge(clk) then
            -- reset counters
            if h_counter = H_MAX then
                -- reset horizontal counter
                h_counter <= (others => '0');
                -- reset vertical counter
                if v_counter = V_MAX then
                    v_counter <= (others => '0');
                else
                    v_counter <= v_counter + 1;
                end if;
            else
                h_counter <= h_counter + 1;
            end if;
        end if;
    end process;
    
    -- Output counters
    h_count <= std_logic_vector(h_counter);
    v_count <= std_logic_vector(v_counter);

    -- Output Sync signal logic (active low)
    h_sync <= '0' when h_counter >= HSYNC_BEGIN and h_counter <= HSYNC_END else '1';
    v_sync <= '0' when v_counter >= VSYNC_BEGIN and v_counter <= VSYNC_END else '1';
    video_on <= '1' when h_counter < H_DISPLAY_END and v_counter < V_DISPLAY_END else '0';

end architecture;