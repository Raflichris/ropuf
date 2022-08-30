library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity And_gate is
    Port ( in1 : in STD_LOGIC;
           in2 : in STD_LOGIC;
           output : out STD_LOGIC);
end And_gate;

architecture Behavioral of And_gate is
begin
	combinational: process(in1,in2)
	begin
		output <= in1 and in2;
	end process combinational;
end Behavioral;