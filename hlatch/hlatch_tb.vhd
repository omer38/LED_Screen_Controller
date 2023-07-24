library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library std;  -- This is added for ''finish'' statement
use std.env.all;
use ieee.numeric_std.all;

entity hlatch_tb is -- testbench top declaration
--  Port ( );
end hlatch_tb;

architecture Behavioral of hlatch_tb is   
    -- Component Declaration for the Unit Under Test (UUT)
    component hlatch is
        port(
		clk    : in std_logic;
		--
		pulse_out : out std_logic
	);
end component;
    
    --input signals - with initial values
    signal clk: std_logic;
    --output signals
    signal pulse_out: std_logic;
    
begin
    
     uut: hlatch PORT MAP (
     clk => clk,
     pulse_out => pulse_out);
     
       -- Stimulus process
    clock_process :process
     begin
     clk <= '0';
     wait for 10 ns;
     clk <= '1';
     wait for 10 ns;
    end process;
    
end Behavioral;
