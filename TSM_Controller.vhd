----------------------------------------------------------------------------------
-- Start Date: 09/15/2021 10:12:21 AM
-- Last Modification Date: 11/02/2021 10:46 AM
-- Design Name: Control Unit
-- Module Name: Control_TSM - Logic_Flow
-- Project Name: Ring Oscillator PUF
-- Target Devices: Arty A7
-- Tool Versions: 
-- Description: 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TSM_Controller is
    generic (max_count : integer := 120000);
    Port ( 
        start   : in std_logic;
        clr     : in std_logic;
        clk     : in std_logic;
        enable  : out std_logic;
        reset   : out std_logic
  );
end TSM_Controller;

architecture Logic_Flow of TSM_Controller is
    
    type state_type is (initial, active, idle);
    signal state, next_state : state_type;
    signal timer: natural range 0 to max_count;
    signal en_timer  : std_logic := '0';
    signal clr_timer : std_logic := '0';

begin

-------------First Process--------------
TIMER_UPDATE_PROCESS: process(clk, timer, en_timer, clr_timer) --- Update state timer
begin
    if (clr_timer = '1') then
        timer <= 0;
    elsif (clk'event and clk='1' and timer /= max_count and en_timer = '1') then
        timer <= timer + 1;
    End if;
End Process;

-------------Second Process--------------
STATE_UPDATE_AND_TIMER_PROC : process (clk, clr) --- Update of the present state
begin
    if (clr = '1') then
        state     <= initial;
    elsif (clk'event and clk='1') then
        state     <= next_state;
    End if;
end process;    
-----------------------------------------

-------------Third Process--------------
OUTPUTS_AND_NEXT_STATE_PROC : process (state,start, timer) -- Assign output values and update the next state transition for each state
begin
    case (state) is
        when initial =>
            if (start = '0') then 
                next_state <= initial;
            elsif (start = '1') then
                next_state <= active;
            End if;
            enable    <= '0';
            reset     <= '1';
            en_timer  <= '0';
            clr_timer <= '1';
        when active  =>
            if(timer = max_count-1) then
                next_state <= idle;
            else
                next_state <= active;
            End if;
            enable    <= '1';
            reset     <= '0';
            en_timer  <= '1';
            clr_timer <= '0';
        when idle    =>
            if (start = '1') then
                next_state <= idle;
            elsif (start = '0') then
                next_state <= initial;
            End if;
            enable    <= '0';
            reset     <= '0';
            en_timer  <= '0';
            clr_timer <= '0';
    end case;
end process;

end Logic_Flow;
