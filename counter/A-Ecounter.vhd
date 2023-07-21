library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity UP_COUNTER is
    Port ( clk: in std_logic; -- clock input
           ------------------------
           reset: in std_logic; -- reset input 
           counter: out std_logic_vector(4 downto 0) -- output 5-bit counter
     );
end UP_COUNTER;

architecture Behavioral of UP_COUNTER is

signal counter_up: std_logic_vector(4 downto 0);
signal counter_clk : std_logic_vector(1 downto 0) := "11" ;-- to get 4

begin
-- up counter
process(clk)
begin
if(rising_edge(clk)) then
    if(reset='1') then
         counter_up <= "00000";
    else
        if counter_clk = "00" then  
            counter_up <= counter_up + "00001";
            counter_clk <= counter_clk - "01";
        else
            counter_clk <= counter_clk - "01";
        end if;
    end if;
 end if;
end process;
counter <= counter_up;

end Behavioral;
