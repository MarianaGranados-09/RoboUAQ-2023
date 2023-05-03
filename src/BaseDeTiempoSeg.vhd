Library IEEE;
Use IEEE.STD_LOGIC_1164.ALL;
Use IEEE.STD_LOGIC_UNSIGNED.ALL;	
Use IEEE.STD_LOGIC_ARITH.ALL;

Entity BaseDeTiempoSeg is
	Generic(
			K: integer:=49999999;  --Constante de la tarjeta.
			N: integer:=27		   --Número de bits del contador.
			);
	Port(
		CLK2 : in std_logic;		--Reloj maestro.
		RST : in std_logic;		--Reset maestro.
		H	: in std_logic;		--Señal de habilitación.
		BT	: out std_logic		--Base de tiempo.
		);
End BaseDeTiempoSeg;

Architecture Tiempo of BaseDeTiempoSeg is
Signal Qp, Qn : std_logic_vector(N-1 downto 0):=(others => '0');	-- Estado presente y siguiente del contador.
Signal BdT	  : std_logic:='0';
Signal BdTconH: std_logic_vector(1 downto 0):=(others =>'0');

Begin  	

	BT <= BdT;
	BdTconH <= BdT & H;
	
	Mux: Process(BdTconH, Qp) is
	begin
		case BdTconH is
			when "01" => Qn <= Qp+1;
			when "11" => Qn <= (others =>'0');
			when others => Qn <= Qp;
		end case;
	end process Mux;
	
	Comparador: Process(Qp) is
	begin
		if Qp = K then
			BdT <= '1';
		else
			BdT <= '0';
		end if;
	end process	Comparador;
	
	Combinacional: Process(CLK2, RST) is
	begin
		if RST = '0' then
			Qp <= (others => '0');
		elsif CLK2'event and CLK2 = '1' then
			Qp <= Qn;
		end if;
	end process Combinacional;
	
end Tiempo;