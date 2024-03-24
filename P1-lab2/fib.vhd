library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Building a fibonacci sequence generator

entity fib is 
    generic (
       width : positive := 8
    );
    port (
        clk, reset, go: in std_logic;
        n : in std_logic_vector(width-1 downto 0);
        done : out std_logic;
        output : out std_logic_vector(width-1 downto 0)
    );
end entity;

architecture fib_arch of fib is
    type state_type is (S_WAIT, S_INIT, S_LOOP_COND, S_ELSE, S_DONE);
		signal state:	state_type;
		signal regN, i, x, y	: std_logic_vector(width-1 downto 0);
	
begin
	process (clk, reset)
	variable temp:	unsigned(width-1 downto 0);
	begin
		if(reset ='1') then
			done <= '0';
			output <= (others => '0');
			regN <= std_logic_vector(to_unsigned(0, WIDTH));
			x <= std_logic_vector(to_unsigned(0, WIDTH));
			y <= std_logic_vector(to_unsigned(0, WIDTH));
			i <= std_logic_vector(to_unsigned(0, WIDTH));
		
		elsif rising_edge(clk) then
			case state is 
				when S_WAIT =>
				if(go='1') then
					state <= S_INIT;
				end if;
			 
				when S_INIT =>
				done <= '0';
				regN <= n;
				i <= std_logic_vector(to_unsigned(3, WIDTH));
				x <= std_logic_vector(to_unsigned(1, WIDTH));
				y <= std_logic_vector(to_unsigned(1, WIDTH));
				state <= S_LOOP_COND;
				
				when S_LOOP_COND =>
				if (i>regN) then
					state <= S_DONE;
				elsif (i<=regN) then
					state <= S_ELSE;
				end if;
				 
				when S_ELSE =>
				temp := unsigned(x) + unsigned(y);
				x <= y;
				y <= std_logic_vector(temp);
				i <= std_logic_vector(unsigned(i) + 1);
				state <= S_LOOP_COND;
					
				when S_DONE =>
				output <= y;
				done <= '1';
				if(go='0') then
					state <= S_WAIT;
				end if;
				
				when others => null;
				
			end case;
		end if;
	end process;
end fib_arch;