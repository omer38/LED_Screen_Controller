-- TOP MODULE 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_module is
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
end top_module;

architecture Behavioral of top_module is

component clk_12_5_mhz is
    port ( clk : in STD_LOGIC;
           clk_out : out STD_LOGIC
         );
end component;


component hoe1 is
    Port (
        clk : in STD_LOGIC;
        pulse_out : out STD_LOGIC := '1'
    );
end component;

component hlatch_data is
    Port (
        clk : in STD_LOGIC;
        load : in std_logic;
        --------
        dataout : out STD_LOGIC := '0';
        hlatch : out std_logic := '1'
    );
end component;

component UP_COUNTER is
    Port ( clk: in std_logic; -- clock input
           ------------------------
           reset: in std_logic; -- reset input 
           counter: out std_logic_vector(4 downto 0) -- output 5-bit counter
     );
end component;


begin

CLKOUT : clk_12_5_mhz port map(
					clk => clk_in,
					clk_out =>clk_out
				);
			
				
HOE : hoe1 	port map(
					clk => clk_in,
					pulse_out => hoe1_out
				);
HLATCHDATA : hlatch_data port map(
                    clk => clk_in,
                    load => load_in,
                    hlatch => hlatch_out,
                    dataout => dataout_out
                );

HA_HE : UP_COUNTER port map(
					clk => clk_in,
					reset => reset_in,
					counter => counter_out
				);				


end Behavioral;
