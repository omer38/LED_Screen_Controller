library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity hoe1 is
    Port (
        clk : in STD_LOGIC;
        pulse_out : out STD_LOGIC := '1'
    );
end entity hoe1;

architecture Behavioral of hoe1 is
    constant ON_TIME : integer := 16;   -- 3 microseconds in 10 ns (basys period) units to count clock pulses 
    constant OFF_TIME : integer := 1520; -- 497 microseconds in 10 ns (basys period) units to count clock pulses
    signal counter_on : integer range 0 to ON_TIME - 1 := 15;
    signal counter_off : integer range 0 to OFF_TIME -1 := 1519;
    type t_state is (S_ON,S_OFF);
    signal state : t_state := S_ON;
    signal pulse_mid : std_logic := '1';
begin
    process(clk)
    begin
        if rising_edge(clk) then
            case state is 
                when S_ON =>                 
                    if counter_on = 0 then 
                       state <= S_OFF;
                       counter_on <= ON_TIME - 1;
                       counter_off <= OFF_TIME - 1; 
                    else
                        counter_on <= counter_on - 1;
                        pulse_mid <= '1' ;
                    end if;
                    
                when S_OFF => 
                    if counter_off = 0 then
                        state <= S_ON;
                    else
                        counter_off <= counter_off -1 ;
                        pulse_mid <= '0';
                    end if; 
                
             end case;
         end if;                  
    end process;
    pulse_out <= pulse_mid;
end Behavioral;
