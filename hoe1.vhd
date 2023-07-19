library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity hoe1_sim is
    Port (
        clk : in STD_LOGIC;
        pulse_out : out STD_LOGIC := '0'
    );
end entity hoe1_sim;

architecture Behavioral of hoe1_sim is
    constant ON_TIME : integer := 300;   -- 3 microseconds in 10 ns (basys period) units to count clock pulses 
    constant OFF_TIME : integer := 49700; -- 497 microseconds in 10 ns (basys period) units to count clock pulses
    signal counter_on : integer range 0 to ON_TIME - 1 := 299;
    signal counter_off : integer range 0 to OFF_TIME -1 := 49699;
    type t_state is (S_ON,S_OFF);
    signal state : t_state := S_ON;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            case state is 
                when S_ON =>                 
                    if counter_on = 0 then 
                       state <= S_OFF;
                       counter_on <= 299;
                       counter_off <= 49699; 
                    else
                        counter_on <= counter_on - 1;
                        pulse_out <= '1' ;
                    end if;
                    
                when S_OFF => 
                    if counter_off = 0 then
                        state <= S_ON;
                    else
                        counter_off <= counter_off -1 ;
                        pulse_out <= '0';
                    end if; 
                
             end case;
         end if;                  
    end process;
end Behavioral;
