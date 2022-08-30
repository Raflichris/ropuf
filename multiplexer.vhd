library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multiplexer is
    Port ( data : in STD_LOGIC_VECTOR (3 downto 0);
           sel : in STD_LOGIC_VECTOR (1 downto 0);
           output : out STD_LOGIC);
end multiplexer;

architecture Behavioral of multiplexer is
begin
    with sel select
    output<= data(0) when "00",
             data(1) when "01",
             data(2) when "10",
             data(3) when "11";
end Behavioral;
