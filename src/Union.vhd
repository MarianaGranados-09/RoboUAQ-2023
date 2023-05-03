library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;

entity Union is
	port(
		CLK		: in std_logic;  -- Señal de reloj (Baudios).
		RST		: in std_logic;	 -- Reset.
		H 		: in std_logic;	 -- Habilitador. 
		Rx		: in std_logic;	 -- PIN del receptor.
		BTN_R		: in std_logic;	 -- Rx: Recibir un carácter.
		LED    : out std_logic	-- LED indicador 
	);
end entity;



architecture FSM of Union is
signal baud : std_logic;
signal seg : std_logic;	 
signal Dat : std_logic_vector(7 downto 0);

begin	
	
	C1 : entity work.BaseDeTiempo generic map(5209,13)port map(CLK, RST, H, baud);
	C2 : entity work.BaseDeTiempoSeg generic map(49999999,27)port map(CLK, RST, H, seg);
	C3 : entity work.DataIn port map(baud, RST, BTN_R, Rx ,Dat, LED);				
end architecture FSM;