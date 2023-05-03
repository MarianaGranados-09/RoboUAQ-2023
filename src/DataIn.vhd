library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity DataIn is
port(
	BAUD	: in STD_LOGIC;		-- Baudios
	RST 	: in STD_LOGIC;		-- Reset maestro 
	BTN_R		: in std_logic;	  	--btn modo recepcion
	Rx		: in std_logic;		-- Entrada de secuencia
	DAT	: out std_logic_vector(7 downto 0); --dato completo
	LED : out std_logic	 --led que indica que se recibio la letra A
);		
end entity DataIn;								


architecture simple of DataIn is
signal Qp, Qn : std_logic_vector(4 downto 0) := (others => '0');
signal data : std_logic_vector(7 downto 0) := (others =>'0') ;

signal Rx_s : std_logic:='1';
signal start : std_logic:='0';
signal parity : std_logic:='1';
signal stop : std_logic:='1';
begin
	
	DAT <= data;
	Rx_s <= Rx;
	
	secuencial: process	(Qp, Rx_s) is
	begin
		if(BTN_R = '1') then 
		case Qp is
			when "00000"	=> 
				if Rx_s = start then
					Qn <= "00001";
				else
					Qn <= "00000";
				end if;
			
			when "00001"	=>
				data(0) <= Rx_s;
				Qn <= "00010";

			when "00010"	=> 
				data(1) <= Rx_s;
				Qn <= "00011";
				
			when "00011"	=> 
				data(2) <= Rx_s;
				Qn <= "00100";
			
			when "00100"	=> 
				data(3) <= Rx_s;
				Qn <= "00101";
			
			when "00101"	=> 
				data(4) <= Rx_S;
				Qn <= "00110";
			
			when "00110"	=> 
				data(5) <= Rx_s;
				Qn <= "00111";
			
			when "00111"	=> 
				data(6) <= Rx_s;
				Qn <= "01000";
			
			when "01000"	=> 
				data(7) <= Rx_s;
				Qn <= "01001";
				if (data = "01000001") then --Si data 65 en ascii = A
					LED <= '1';
				else
					LED <= '0';
				end if;
			
			when "01001"	=> 
				parity <= Rx_s;
				Qn <= "01010";
			
			when "01010"	=> 
				stop <= Rx_s;
				Qn <= (others => '0');
			
			when others	=>
					Qn <=  (others => '0');
		end case;
		end if;
	end process secuencial;	
	
	
	
	FF: process(RST, BAUD) is
	begin		   
		if RST = '0' then
			Qp <= (others=>'0');
		elsif  BAUD'event and BAUD = '1' then
			Qp <= Qn;
		end if;
	end process FF;
	
	
end architecture simple;