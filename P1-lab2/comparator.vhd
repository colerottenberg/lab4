library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Comparator entity
entity comparator is
    generic(width : integer := 6);
    port (
        a : in std_logic_vector(width-1 downto 0);
        b : in std_logic_vector(width-1 downto 0);
        le : out std_logic;
        eq : out std_logic
    );
end comparator;

-- Comparator architecture

architecture behavioral of comparator is
    begin
        process(a,b)
        begin 
        -- Less than or equal to
        if (unsigned(a) <= unsigned(b)) then
            le <= '1';
        else
            le <= '0';
        end if;
        -- Equal to
        if (unsigned(a) = unsigned(b)) then
            eq <= '1';
        else
            eq <= '0';
        end if;
        end process;
end behavioral;