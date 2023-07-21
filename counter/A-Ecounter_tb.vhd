library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_counters is
end tb_counters;

architecture Behavioral of tb_counters is

component UP_COUNTER 
    Port ( clk: in std_logic; -- clock input
           reset: in std_logic; -- reset input 
           counter: out std_logic_vector(4 downto 0) -- output 4-bit counter
     );
end component;
signal reset,clk: std_logic;
signal counter:std_logic_vector(4 downto 0);

begin
dut: UP_COUNTER port map (clk => clk, reset=>reset, counter => counter);
   -- Clock process definitions
clock_process :process
begin
     clk <= '0';
     wait for 40 ns;
     clk <= '1';
     wait for 40 ns;
end process;


-- Stimulus process
stim_proc: process
begin        
   -- hold reset state for 100 ns.
     reset <= '1';
   wait for 80 ns;    
    reset <= '0';
   wait;
end process;
end Behavioral;
