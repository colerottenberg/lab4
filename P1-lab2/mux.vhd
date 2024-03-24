library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity mux is 
    generic(
        width : integer := 6
    );
    port(
        input1 : in std_logic_vector(width-1 downto 0);
        input2 : in std_logic_vector(width-1 downto 0);
        sel : in std_logic;
        output : out std_logic_vector(width-1 downto 0)
    );

end entity mux;

architecture rtl of mux is
begin
    process(input1, input2, sel)
    begin
        if sel = '0' then
            output <= input1;
        else
            output <= input2;
        end if;
    end process;
end architecture rtl;