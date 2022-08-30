library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity inverter_gate is
    Port ( input: in std_logic;
           output:out std_logic );
end inverter_gate;

architecture Behavioral of inverter_gate is
begin
    output <= not input;
end Behavioral;