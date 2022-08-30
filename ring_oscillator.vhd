library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--use work.parameters.all;

entity ring_oscillator is
    Port ( enable : in STD_LOGIC;
           output : out STD_LOGIC_VECTOR (3 downto 0));
end ring_oscillator;

architecture struct of ring_oscillator is
    
    attribute dont_touch : string;
    attribute dont_touch of output: signal is "true";
    
begin
    inst_delay_lines: for i in 0 to 3 generate
        begin
            inst_delay_line: entity work.delay_line
                port map(enable => enable,
                         output=> output(i));   
        end generate;

end struct;