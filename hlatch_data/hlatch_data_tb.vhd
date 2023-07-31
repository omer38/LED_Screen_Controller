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
    component hlatch_data is
        port(
		clk    : in std_logic;
		load   : in std_logic;
		--
		hlatch : out std_logic := '1';
		dataout   : out std_logic:= '0'
	);
end component;
    
    --input signals - with initial values
    signal clk,load: std_logic;
    --output signals
    signal hlatch,dataout: std_logic := '0';
    
begin
    
     uut: hlatch_data PORT MAP (
     clk => clk,
     load => load,
     hlatch => hlatch,
     dataout => dataout);
     
       -- Stimulus process
    clock_process :process
     begin
     clk <= '0';
     wait for 10 ns;
     clk <= '1';
     wait for 10 ns;
    end process;
    
      -- Stimulus process
  stim_proc: process
  begin        
      load <= '0';
      wait for 10 ns;
      load <= '0';
      wait for 10 ns;
      load <= '1';
      wait for 10 ns;
      load <= '0';
      wait for 100 ns;
      load <= '0';
      wait for 50 ns;
      load <= '1';
      wait;
      end process;
    
end Behavioral;
