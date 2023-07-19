library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_4mhz is
    port ( clk_in : in STD_LOGIC;
           clk_out : out STD_LOGIC
         );
end clk_4mhz;

architecture Behavioral of clk_4mhz is
    constant DIVIDER : integer := 25; -- Divide 100 MHz input clock by 25 to get 4 MHz output
    signal counter : integer range 0 to DIVIDER - 1 := 0;
    signal clk_div : STD_LOGIC := '0';
    
begin
    -- Clock generator process
    process (clk_in)
    begin
        if rising_edge(clk_in) then
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
