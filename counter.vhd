library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter is
    Port (clk : in STD_LOGIC;
          rst : in STD_LOGIC;
          output : out std_logic_vector(7 downto 0) );
end counter;

architecture Behavioral of counter is
    signal count : std_logic_vector(7 downto 0);
begin
    process(rst,clk)
        begin
            if (rst = '1') then 
                count <= (others => '0');
            elsif (rising_edge(clk)) then 
                count <= std_logic_vector( unsigned(count) + 1 );
            end if;
            output <= count;
    end process;

end Behavioral;
