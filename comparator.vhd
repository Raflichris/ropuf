library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparator is
    Port ( in1 : in STD_LOGIC_VECTOR (7 downto 0);
           in2 : in STD_LOGIC_VECTOR (7 downto 0);
           rst : in STD_LOGIC;
           output : out STD_LOGIC);
end comparator;

architecture Behavioral of comparator is

begin
process(in1, in2, rst) 
begin
	if rst = '1' then
		output <= '0';
    elsif in2>in1 then
        output <='1';
    else
        output <='0';
	end if;
end process;

end Behavioral;
