library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity parallel_to_serial is
        port(
		clk    : in std_logic;
		load   : in std_logic;
		--
		dataout : out std_logic
	);
end parallel_to_serial;

architecture Behavioral of parallel_to_serial is

type states is (idle,d0,d1,d2,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15,d16,d17,d18,d19,d20,d21,d22,d23);-- delete p_check
signal state : states := idle;
signal data_sig : std_logic_vector(23 downto 0);

begin

process(clk) begin
if rising_edge(clk) then
    case state is 
        when idle =>
            data_sig <= "100110100000111111110101";
            if load = '0' then
                --data_sig <= "000000000000000000000000";
                dataout <= '0';
                state <= idle;
            elsif load = '1' then
                dataout <= '0';
                state <= d0;
            end if;
       when d0 =>
                dataout <= data_sig(23);
                state <= d1;
       when d1 =>
                dataout <= data_sig(22);
                state <= d2;
       when d2 =>
                dataout <= data_sig(21);
                state <= d3;
       when d3 =>
                dataout <= data_sig(20);
                state <= d4;
       when d4 =>
                dataout <= data_sig(19);
                state <= d5;
       when d5 =>
                dataout <= data_sig(18);
                state <= d6;
       when d6 =>
                dataout <= data_sig(17);
                state <= d7;
       when d7 =>
                dataout <= data_sig(16);
                state <= d8;
	   when d8 =>
                dataout <= data_sig(15);
                state <= d9; 

	   when d9 =>
                dataout <= data_sig(14);
                state <= d10; 

       when d10 =>
                dataout <= data_sig(13);
                state <= d11;
       when d11 =>
                dataout <= data_sig(12);
                state <= d12;
       when d12 =>
                dataout <= data_sig(11);
                state <= d13;
       when d13 =>
                dataout <= data_sig(10);
                state <= d14;
       when d14 =>
                dataout <= data_sig(9);
                state <= d15;
       when d15 =>
                dataout <= data_sig(8);
                state <= d16;
       when d16 =>
                dataout <= data_sig(7);
                state <= d17;
       when d17 =>
                dataout <= data_sig(6);
                state <= d18;
	   when d18 =>
                dataout <= data_sig(5);
                state <= d19; 

	   when d19 =>
                dataout <= data_sig(4);
                state <= d20;
		
	   when d20 =>
                dataout <= data_sig(3);
                state <= d21;
       when d21 =>
                dataout <= data_sig(2);
                state <= d22;
       when d22 =>
                dataout <= data_sig(1);
                state <= d23;
	   when d23 =>
                dataout <= data_sig(0);
                state <= idle; 

       end case;
end if;
end process;
                                                         
end Behavioral;
