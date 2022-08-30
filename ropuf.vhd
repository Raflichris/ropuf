library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--use work.parameters.all;

entity ropuf is
    Port (enable : in std_logic;
          challenge : in std_logic_vector(3 downto 0); --2 for mux1 2 for mux2
          rst: in std_logic;                           --reset for counters
          finalResult: out std_logic );
end ropuf;

architecture struct of ropuf is 
    attribute dont_touch : string;
    
    signal ro1_output: std_logic_vector (3 downto 0):="0000";
        attribute dont_touch of ro1_output: signal is "true";
    signal ro2_output: std_logic_vector (3 downto 0):="0000";
        attribute dont_touch of ro2_output: signal is "true";
    signal mux1_output: std_logic;
        attribute dont_touch of mux1_output: signal is "true";
    signal mux2_output: std_logic;
        attribute dont_touch of mux2_output: signal is "true";
    signal c1_output: std_logic_vector(7 downto 0);
        attribute dont_touch of c1_output: signal is "true";
    signal c2_output: std_logic_vector(7 downto 0);
        attribute dont_touch of c2_output: signal is "true";
    
    component ring_oscillator
        port(enable : in STD_LOGIC;
             output : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
    
    component multiplexer
        port(data : in STD_LOGIC_VECTOR (3 downto 0);
             sel : in STD_LOGIC_VECTOR (1 downto 0);
             output : out STD_LOGIC);
    end component;
    
    component counter
        port(clk : in STD_LOGIC;
             rst : in STD_LOGIC;
             output : out std_logic_vector(7 downto 0));
    end component;
    
    component comparator
        port(in1 : in STD_LOGIC_VECTOR (7 downto 0);
             in2 : in STD_LOGIC_VECTOR (7 downto 0);
             rst : in STD_LOGIC;
             output : out STD_LOGIC);
    end component;
    
begin
--First half of the circuit
ro1: ring_oscillator
        port map(enable, ro1_output);

mux1: multiplexer
        port map(ro1_output, challenge(1 downto 0),mux1_output);
        
c1: counter
        port map(mux1_output, rst, c1_output);

--Second half of the circuit  
ro2: ring_oscillator
        port map(enable, ro2_output);
        
mux2: multiplexer
        port map(ro2_output, challenge(3 downto 2),mux2_output);
        
c2: counter
        port map(mux2_output, rst, c2_output);
        
--Final comparator
comp: comparator
        port map(c1_output,c2_output, rst, finalResult);
        
end struct;
