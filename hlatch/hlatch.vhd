-- HLATCH code
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- 

entity hlatch is
    Port (
        clk : in STD_LOGIC;
        pulse_out : out STD_LOGIC := '1'
    );
end entity hlatch;

architecture Behavioral of hlatch is
	-- CALCULATIONS MADE ACCORDING TO THE BCP 20NS AND CP 80NS (12.5 MHz CLOCK)
    constant ON_TIME_1 : integer := 12;   -- 10 ns (basys period) units to count clock pulses 
    constant OFF_TIME_1 : integer := 48; -- 10 ns (basys period) units to count clock pulses
	constant ON_TIME_2 : integer := 44;   -- 10 ns (basys period) units to count clock pulses 
    constant OFF_TIME_2 : integer := 12; -- 10 ns (basys period) units to count clock pulses
	constant ON_TIME_3 : integer := 56;   -- 10 ns (basys period) units to count clock pulses 
    constant OFF_TIME_3 : integer := 528; -- 10 ns (basys period) units to count clock pulses
	constant ON_TIME_4 : integer := 20;   -- 10 ns (basys period) units to count clock pulses 
    constant OFF_TIME_4 : integer := 524; -- 10 ns (basys period) units to count clock pulses
	constant ON_TIME_5 : integer := 4;   -- 10 ns (basys period) units to count clock pulses 
    constant OFF_TIME_5 : integer := 540; -- SAME FOR "4 TO 5" AND 5
	--signal counter_state_4 : integer range 0 to 5 := 4; --
    --signal counter_state_5 : integer range 0 to 833380 := 833379; --
    signal counter_1 : integer range 0 to ON_TIME_1 - 1 := 11; --
    signal counter_1_0 : integer range 0 to OFF_TIME_1 -1 := 47;
	signal counter_2 : integer range 0 to ON_TIME_2 - 1 := 43;--
    signal counter_2_0 : integer range 0 to OFF_TIME_2 -1 := 11;
	signal counter_3 : integer range 0 to ON_TIME_3 - 1 := 55; --
    signal counter_3_0 : integer range 0 to OFF_TIME_3 -1 := 527;
	signal counter_4 : integer range 0 to ON_TIME_4 - 1 := 19; --
    signal counter_4_0 : integer range 0 to OFF_TIME_4 -1 := 523;
	signal counter_5 : integer range 0 to ON_TIME_5 - 1 := 3; --
    signal counter_5_0 : integer range 0 to OFF_TIME_5 -1 := 539;
	signal counter_off : integer range 0 to 550000 := 549999;
	signal counter_four_loop : integer range 0 to 5 := 4;
	signal counter_four_off_loop : integer range 0 to 5 := 4;
	signal counter_five_loop : integer range 0 to 512 := 511;
	
    type t_state is (S_1,S_1_0,S_2,S_2_0,S_3,S_3_0,S_4,S_4_0,S_4_TO_5,S_5,S_5_0,OFF_STATE);
    signal state : t_state := S_1;
    signal pulse_mid : std_logic := '1';
	
begin
    process(clk)
    begin
        if rising_edge(clk) then
            case state is 
                when S_1 =>                 
                    if counter_1 = 0 then 
                       state <= S_1_0;
                       counter_1 <= ON_TIME_1 - 1;
                       counter_1_0 <= OFF_TIME_1 - 1; 
                    else
                        counter_1 <= counter_1 - 1;
                        pulse_mid <= '1' ;
                    end if;
                    
                when S_1_0 => 
                    if counter_1_0 = 0 then
                        state <= S_2;
                    else
                        counter_1_0 <= counter_1_0 -1 ;
                        pulse_mid <= '0';
                    end if; 
				
				when S_2 =>                 
                    if counter_2 = 0 then 
                       state <= S_2_0;
                       counter_2 <= ON_TIME_2 - 1;
                       counter_2_0 <= OFF_TIME_2 - 1; 
                    else
                        counter_2 <= counter_2 - 1;
                        pulse_mid <= '1' ;
                    end if;
                    
                when S_2_0 => 
                    if counter_2_0 = 0 then
                        state <= S_3;
                    else
                        counter_2_0 <= counter_2_0 - 1 ;
                        pulse_mid <= '0';
                    end if; 
				
				when S_3 =>                 
                    if counter_3 = 0 then 
                       state <= S_3_0;
                       counter_3 <= ON_TIME_3 - 1;
                       counter_3_0 <= OFF_TIME_3 - 1; 
                    else
                        counter_3 <= counter_3 - 1;
                        pulse_mid <= '1' ;
                    end if;
                    
                when S_3_0 => 
                    if counter_3_0 = 0 then
                        state <= S_4;
                    else
                        counter_3_0 <= counter_3_0 -1 ;
                        pulse_mid <= '0';
                    end if;
					
				when S_4 =>                 
                    if counter_4 = 0 then 
                       state <= S_4_0;
                       counter_4 <= ON_TIME_4 - 1;
                       counter_4_0 <= OFF_TIME_4 - 1;
                    else
                        counter_4 <= counter_4 - 1;
                        pulse_mid <= '1' ;
                    end if;
                    
                when S_4_0 => 
                    if (counter_4_0 = 0 and counter_four_off_loop /= 0) then
                        state <= S_4;
						counter_four_off_loop <= counter_four_off_loop - 1;
					elsif (counter_4_0 = 0 and counter_four_off_loop = 0) then 
						state <= S_4_TO_5;
						counter_four_off_loop <= 4;
						counter_4 <= ON_TIME_4 - 1; -- TRY
                        counter_4_0 <= OFF_TIME_4 - 1;	--		
                    else
                        counter_4_0 <= counter_4_0 -1 ;
                        pulse_mid <= '0';
                    end if;
				
				when S_4_TO_5 => 
                    if counter_5_0 = 0 then
                        state <= S_5;
						counter_5_0 <= OFF_TIME_5 - 1;
                    else
                        counter_5_0 <= counter_5_0 - 1;
                        pulse_mid <= '0';
                    end if;
					
				when S_5 =>                 
                    if counter_5 = 0 then 
                       state <= S_5_0;
                       counter_5 <= ON_TIME_5 - 1;
                       counter_5_0 <= OFF_TIME_5 - 1; 
                    else
                        counter_5 <= counter_5 - 1;
                        pulse_mid <= '1' ;
                    end if;
                    
                when S_5_0 => 
                    if (counter_5_0 = 0 and counter_five_loop /= 0) then
                        state <= S_5;
						counter_five_loop <= counter_five_loop - 1;
					elsif (counter_5_0 = 0 and counter_five_loop = 0) then
						state <= OFF_STATE;
						counter_five_loop <= 512;
						counter_5 <= ON_TIME_5 - 1; -- TRY
                        counter_5_0 <= OFF_TIME_5 - 1;    --
                    else
                        counter_5_0 <= counter_5_0 -1 ;
                        pulse_mid <= '0';
                    end if;
				
				when OFF_STATE => 
                    if counter_off = 0 then
                        state <= S_1;
                        counter_off <= 549999;
                    else
                        counter_off <= counter_off -1 ;
                        pulse_mid <= '0';
                    end if;
                
             end case;
         end if;                  
    end process;
	
    pulse_out <= pulse_mid;
	
end Behavioral;
