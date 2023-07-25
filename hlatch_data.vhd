-- HLATCH code
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- 

entity hlatch_data is
    Port (
        clk : in STD_LOGIC;
        load : in std_logic;
        -----------------------------
        hlatch : out STD_LOGIC := '1';
        dataout : out std_logic := '0'   
    );
end entity hlatch_data;

architecture Behavioral of hlatch_data is



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
	--signal counter_four_loop : integer range 0 to 5 := 4;
	signal counter_four_off_loop : integer range 0 to 5 := 4;
	signal counter_five_loop : integer range 0 to 512 := 511;
	
	signal data_counter: integer range 0 to 4 := 3; -- it helps to divide 540 BCP to 135 cp which is off period 7+16*8=135
	
	signal en_zero_counter : integer range 0 to 24 := 23; -- 7*4 = 28
	
	
    type t_state is (S_1,S_1_0,S_2,S_2_0,S_3,S_3_0,S_4,S_4_0,S_4_TO_5,S_5,S_5_0,OFF_STATE);
    signal state : t_state := S_1;
    signal pulse_mid : std_logic := '1';
    
    type states is (idle,d0,d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15);
    signal d_state : states := idle;
    signal data_sig : std_logic_vector(15 downto 0);
    
    signal en   : std_logic := '0' ;
    --signal en_a   : std_logic := '0';
	signal en_zero : integer range 0 to 2 := 1 ;
	
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
                       en <= '1';
                    else
                        counter_5 <= counter_5 - 1;
                        pulse_mid <= '1' ;
                         ------------- ADD ENABLE TO START DATA PROCESS
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
                        en <= '0';
                    end if;
                
             end case;
         end if;                  
    end process;
 
 process(clk) begin
    if rising_edge(clk) then
        case d_state is 
            when idle =>
                data_sig <= "1111000110011100";
                if load = '0' then
                    --data_sig <= "000000000000000000000000";
                    dataout <= '0';
                    d_state <= idle;
                elsif (load = '1' and en = '1') then
                        dataout <= '0';
                        d_state <= d0;
					end if;
                
           when d0 =>
                    if data_counter = 0 then
                        dataout <= data_sig(15);
                        d_state <= d1;
                        data_counter <= 3;
                    else
                        data_counter <= data_counter - 1;
                    end if;
           when d1 =>
                    if data_counter = 0 then
                        dataout <= data_sig(14);
                        d_state <= d2;
                        data_counter <= 3;
                    else
                        data_counter <= data_counter - 1;
                    end if;
           when d2 =>
                     if data_counter = 0 then
                        dataout <= data_sig(13);
                        d_state <= d3;
                        data_counter <= 3;
                      else
                        data_counter <= data_counter - 1;
                      end if;
           when d3 =>
                    if data_counter = 0 then
                        dataout <= data_sig(12);
                        d_state <= d4;
                        data_counter <= 3;
                    else
                        data_counter <= data_counter - 1;
                     end if;
                     
           when d4 =>
                    if data_counter = 0 then
                        dataout <= data_sig(11);
                        d_state <= d5;
                        data_counter <= 3;
                    else
                        data_counter <= data_counter - 1;
                    end if;
                    
           when d5 =>
                  if data_counter = 0 then
                    dataout <= data_sig(10);
                    d_state <= d6;
                    data_counter <= 3;
                  else
                    data_counter <= data_counter - 1;
                   end if;
           when d6 =>
                  if data_counter = 0 then
                    dataout <= data_sig(9);
                    d_state <= d7;
                    data_counter <= 3;
                   else
                    data_counter <= data_counter - 1;
                   end if;
           when d7 =>
                  if data_counter = 0 then
                    dataout <= data_sig(8);
                    d_state <= d8;
                    data_counter <= 3;
                  else
                    data_counter <= data_counter - 1;
                  end if;
           when d8 =>
                  if data_counter = 0 then
                    dataout <= data_sig(7);
                    d_state <= d9;
                    data_counter <= 3;
                  else
                    data_counter <= data_counter - 1;
                  end if; 
    
           when d9 =>
                 if data_counter = 0 then
                    dataout <= data_sig(6);
                    d_state <= d10;
                    data_counter <= 3;
                  else
                    data_counter <= data_counter - 1;
                  end if; 
    
           when d10 =>
                if data_counter = 0 then
                    dataout <= data_sig(5);
                    d_state <= d11;
                    data_counter <= 3;
                else
                    data_counter <= data_counter -1 ;
                 end if;
           when d11 =>
                if data_counter = 0 then
                    dataout <= data_sig(4);
                    d_state <= d12;
                    data_counter <= 3;
                 else
                    data_counter <= data_counter - 1;
                  end if;
           when d12 =>
                if data_counter = 0 then
                    dataout <= data_sig(3);
                    d_state <= d13;
                    data_counter <= 3;
                 else
                    data_counter <= data_counter - 1;
                  end if;
           when d13 =>
                 if data_counter = 0 then
                    dataout <= data_sig(2);
                    d_state <= d14;
                    data_counter <= 3;
                  else
                    data_counter <= data_counter - 1;
                   end if;
                   
           when d14 =>
                  if data_counter = 0 then
                    dataout <= data_sig(1);
                    d_state <= d15;
                    data_counter <= 3;
                  else
                    data_counter <= data_counter - 1;
                   end if;
           when d15 =>
                  if data_counter = 0 then
                    dataout <= data_sig(0);
                    d_state <= idle;
                    data_counter <= 3;
                  else
                    data_counter <= data_counter - 1;
                   end if;        
           end case;
    end if;
    end process;
	
    hlatch <= pulse_mid;
	
end Behavioral;
