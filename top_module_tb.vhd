library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_module_tb is
--  Port ( );
end top_module_tb;

architecture Behavioral of top_module_tb is

component top_module is
	port(
		clk_in : in std_logic;
		load_in : in std_logic;
		reset_in : in std_logic;
-------------------------------------------------------------
		dataout_out : out std_logic;
		counter_out : out std_logic_vector(4 downto 0);
		clk_out : out std_logic;
		hlatch_out	: out std_logic;
		hoe1_out	: out std_logic
	);
end component;

--input signals - with initial values
    signal clk_in,load_in,reset_in: std_logic:= '0' ;
    --output signals
    signal dataout_out,clk_out,hlatch_out,hoe1_out: std_logic;
    signal counter_out : std_logic_vector(4 downto 0);


begin

 uut: top_module PORT MAP (
     clk_in => clk_in,
     load_in => load_in,
     reset_in => reset_in,
     ---------------------
     dataout_out => dataout_out,
     counter_out => counter_out,
     clk_out => clk_out,
     hlatch_out => hlatch_out,
     hoe1_out => hoe1_out);

      -- Stimulus process
    clock_process :process
     begin
     clk_in <= '0';
     wait for 10 ns;
     clk_in <= '1';
     wait for 10 ns;
    end process;
    
      -- Stimulus process
  stim_proc: process
  begin        
      load_in <= '0';
      reset_in <= '0';
      wait for 10 ns;
      load_in <= '1';
      reset_in <= '0';
      wait;
      end process;
   
end Behavioral;
