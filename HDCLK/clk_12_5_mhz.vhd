-- 12.5 MHZ clock
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_12_5_mhz is
    port ( clk : in STD_LOGIC;
           clk_out : out STD_LOGIC
         );
end clk_12_5_mhz;

architecture Behavioral of clk_12_5_mhz is
    constant DIVIDER : integer := 4; -- Divide 100 MHz input clock by 25 to get 4 MHz output
    signal counter : integer range 0 to DIVIDER - 1 := 0;
    signal clk_div : STD_LOGIC := '0';
    
begin
    -- Clock generator process
    process (clk)
    begin
        if rising_edge(clk) then
            if counter = DIVIDER - 1 then
                clk_div <= not clk_div;
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    clk_out <= clk_div;
end Behavioral;
