library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity hoe1_tb is

end hoe1_tb;

architecture Behavioral of hoe1_tb is

component hoe1_sim is
    Port (
        clk : in STD_LOGIC;
        pulse_out : out STD_LOGIC
    );
end component;

signal clk :  STD_LOGIC := '0';
signal pulse_out :  STD_LOGIC := '0';
constant clk_period: time  := 10ns;

begin

DUT : hoe1_sim
port map(
clk			=> clk		 ,
pulse_out	=> pulse_out
);

P_CLKGEN : process begin
clk	<= '0';
wait for clk_period/2;
clk	<= '1';
wait for clk_period/2;
end process;

end Behavioral;
