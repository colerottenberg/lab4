library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.vga_lib.all;

-- VGA: 640x480 
-- Using the clock divider implemented in Lab 0 and your knowledge of generic component inputs, change your clock divider to accept 2 generic inputs: input frequency, and output frequency.
-- As a refresher on how the clock divider works, the clock generator should count to some value that corresponds to the number of clock pulses from the input clock there should be in the output clock
-- The output of this clock divider should be passed into the VGA entity.

-- 2. Using the provided vga_sync_gen entity, create a behavioral entity defining the behavior of the VGA synchronization signals as defined below.
-- Create two counters with equal width outputs of COUNT_RANGE as found in the provided vga_lib.vhd file.

-- h_count_r
-- Continually counts up to the horizontal period (H_MAX – See vga_lib.vhd) and then starts over at 0, using the 25 MHz pixel clock.
-- A value of zero on h_count_r corresponds to the beginning of section D in Figure 1.

-- v_count_r
-- Counts up to the vertical period (V_MAX – See vga_lib.vhd). It will increment at a particular point in the horizontal counters count (Hcount = H_VERT_INC – See vga_lib.vhd).
-- A value of zero on v_count_r corresponds to the beginning of section R in Figure 2.

-- The values of video_on, h_sync, and v_sync are determined by comparing the values of h_count_r and v_count_r with the constants provided in vga_lib.vhd

-- 3. To complete the remaining functionality of the VGA module, you will create an architecture for the provided VGA entity that instantiates the vga_sync_gen from the previous step and uses the outputs to draw a 64x64 pixel square in the center of the monitor with 12-bit hex value of #73b.

-- The VGA implementation partitions the screen into 2x2 pixel-sized blocks, each
-- of which displays a color made from a combination or red, green, and blue. There
-- will be a total of 4096 blocks arranged as a 64x64 grid, which forms a 128x128
-- image. VGA resolution is 640x480, so you must make sure the pixels not used by
-- the image are black.

-- Note that the VGA entity has a video_on output, which is not part of a normal
-- VGA interface. We are including it for verification purposes. The video_on signal
-- should connect to the video_on output of the vga_sync_gen entity. Note in the
-- top-level entity that the video_on output is left open because it is not used
-- outside of the testbench.

-- To properly determine when to draw your image, you will need to implement two
-- logical elements in your design.

-- Row bound logic: Use the v_count signal to determine the position
-- currently being drawn on the monitor. Only enable your vertical output if
-- the v_count value corresponds to the proper rows on screen.

-- Column bound logic: Use the h_count signal to determine the horizontal
-- position currently being drawn on the monitor. Only enable your horizontal
-- output if the h_count value corresponds to the proper columns on screen.

-- I recommend an enable signal that makes the color output all zero
-- if both the row and column logic don’t output one.

-- 4. Run the provided VGA testbench to test the timing of your VGA outputs and adjust your
-- timing as necessary until there are no errors remaining. This testbench will also output a
-- .txt file that can be used to simulate the VGA monitor after verifying in the testbench. It is
-- a fairly strict test for timing to make sure the outputs closely align with Figures 1, 2, & 3.

entity vga is
    port (clk              : in  std_logic;
          rst              : in  std_logic;
          en               : in  std_logic;
		  switch           : in  std_logic_vector(9 downto 0) := (others => '0');
          img_pos          : in  std_logic_vector(2 downto 0) := (others => '0');
          red, green, blue : out std_logic_vector(3 downto 0) := (others => '0');
          h_sync, v_sync   : out std_logic;
          video_on         : out std_logic);
end vga;

architecture default_arch of vga is

    signal v_count : std_logic_vector(COUNT_RANGE);
    signal h_count : std_logic_vector(COUNT_RANGE);
	signal temp_h_sync, temp_v_sync : std_logic := '0';
	signal temp_video_on : std_logic := '0';
  -- VGA_SYNC_GEN Signals
begin 		
	-- VGA MAIN BEGINS

	sync: entity work.vga_sync_gen
		port map (clk => clk,
				    rst => rst,
				    h_count => h_count,
				    v_count => v_count,
				    h_sync => temp_h_sync,
					v_sync => temp_v_sync,
					video_on => temp_video_on);
   -- VGA_SYNC_GEN ENDS	

	draw: process(clk, rst)
	begin
		if rising_edge(clk) then
			if rst = '0' then
				if unsigned(h_count) >= CENTERED_X_START and unsigned(h_count) <= CENTERED_X_END and 
                unsigned(v_count) >= CENTERED_Y_START and unsigned(v_count) <= CENTERED_Y_END and 
                temp_video_on = '1' then
					red <= "0111";
					green <= "0011";
					blue <= "1011";
				else
					red <= "0000";
					green <= "0000";
					blue <= "0000";
				end if;
			end if;
		end if;
	end process draw;


	-- VGA MAIN ENDS
	h_sync <= temp_h_sync;
	v_sync <= temp_v_sync;
	video_on <= temp_video_on;
end default_arch;