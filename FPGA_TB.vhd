LIBRARY IEEE  ; 
LIBRARY STD   ; 
LIBRARY WORK  ; 
USE IEEE.NUMERIC_STD.ALL  ; 
USE IEEE.STD_LOGIC_1164.ALL; 
USE IEEE.STD_LOGIC_TEXTIO.ALL  ; 
USE IEEE.STD_LOGIC_UNSIGNED.ALL  ; 
USE STD.TEXTIO.ALL  ; 
USE WORK.ALL  ; 
ENTITY FPGA_TB  IS 
END ; 
 
ARCHITECTURE FPGA_TB_ATCH OF FPGA_TB IS
	SIGNAL RS232_RX : STD_LOGIC; 
	SIGNAL CLK : STD_LOGIC; 
	SIGNAL RS232_TX : STD_LOGIC; 
	SIGNAL CLKp : time:=20ns;
	SIGNAL CLKp1 : time:=100ns;
	SIGNAL BITRATE : integer:= 84;
	SIGNAL CHAR : std_logic_vector(8 downto 0);
	SIGNAL CHAR_FULL : std_logic_vector(7 downto 0);
	constant dl : integer:=215;
	constant bt : time:=60ns;
	type tablica is array (0 to dl) of std_logic_vector(7 downto 0);
	signal wejscie : tablica:=(
										x"77", 																					 --w
										x"20", x"30",  x"30",  x"30",  x"30",  x"30",  x"30",  x"30",  x"30", -- 111111111111111 //9 elementow
										x"20", x"31",  x"31",  x"31",  x"31",  x"31",  x"31",  x"31",  x"31", x"31",  x"31",  x"31",  x"31",  x"31",  x"31",  x"31",  x"31", -- 01010102 //17 elementow
										
										x"77", 																					 --w
										x"20", x"30",  x"30",  x"30",  x"30",  x"30",  x"30",  x"30",  x"31", -- c6c93339dd7070dd	 //9 elementow
										x"20", x"63",  x"36",  x"63",  x"39",  x"33",  x"33",  x"33",  x"39", x"64",  x"64",  x"37",  x"30",  x"37",  x"30",  x"64",  x"64", -- 01010102 //17 elementow
										
										x"77", 																					 --w
										x"20", x"30",  x"30",  x"30",  x"30",  x"30",  x"30",  x"30",  x"32", -- 00000000 //9 elementow
										x"20", x"30",  x"31",  x"30",  x"30",  x"30",  x"30",  x"30",  x"30", x"30",  x"30",  x"30",  x"30",  x"30",  x"30",  x"30",  x"31", -- 01010102 //17 elementow
										
										x"77", 																					 --w
										x"20", x"30",  x"30",  x"30",  x"30",  x"30",  x"30",  x"30",  x"32", -- 00000000 //9 elementow
										x"20", x"30",  x"32",  x"30",  x"30",  x"30",  x"30",  x"30",  x"30", x"30",  x"30",  x"30",  x"30",  x"30",  x"30",  x"30",  x"66", -- 01010102 //17 elementow
																				
										x"77", 																					 --w
										x"20", x"30",  x"30",  x"30",  x"30",  x"30",  x"30",  x"30",  x"32", -- 00000000 //9 elementow
										x"20", x"30",  x"33",  x"30",  x"30",  x"30",  x"30",  x"30",  x"30", x"30",  x"30",  x"30",  x"30",  x"30",  x"30",  x"30",  x"66", -- 01010102 //17 elementow
										
										x"77", 																					 --w
										x"20", x"30",  x"30",  x"30",  x"30",  x"30",  x"30",  x"30",  x"33", -- 00000000 //9 elementow
										x"20", x"30",  x"31",  x"30",  x"30",  x"30",  x"30",  x"30",  x"30", x"30",  x"30",  x"30",  x"30",  x"30",  x"30",  x"31",  x"30", -- 01010102 //17 elementow
										
										x"77", 																					 --w
										x"20", x"30",  x"30",  x"30",  x"30",  x"30",  x"30",  x"30",  x"33", -- 00000000 //9 elementow
										x"20", x"30",  x"32",  x"30",  x"30",  x"30",  x"30",  x"30",  x"30", x"30",  x"30",  x"30",  x"30",  x"30",  x"30",  x"31",  x"66", -- 01010102 //17 elementow
																				
										x"77", 																					 --w
										x"20", x"30",  x"30",  x"30",  x"30",  x"30",  x"30",  x"30",  x"33", -- 00000000 //9 elementow
										x"20", x"30",  x"33",  x"30",  x"30",  x"30",  x"30",  x"30",  x"30", x"30",  x"30",  x"30",  x"30",  x"30",  x"30",  x"31",  x"66" -- 01010102 //17 elementow

										);
	COMPONENT FPGA  
	PORT 
	( 
		RS232_RX : in STD_LOGIC; 
		CLK : in STD_LOGIC; 
		RS232_TX : out STD_LOGIC 
	); 
	END COMPONENT; 

BEGIN
	DUT : FPGA  
	PORT MAP 
	( 
		RS232_RX   => RS232_RX,
		CLK   => CLK,
		RS232_TX   => RS232_TX   
	); 

	Process
	Begin
		clk  <= '0'  ; wait for CLKp/2;
		clk  <= '1'  ; wait for CLKp/2;
	End Process;


	Process
	Begin		
		for i in 0 to dl loop
			RS232_RX  <= '0'  ; wait for bitrate*CLKp1;
			for j in 0 to 7 loop
				RS232_RX <= wejscie(i)(j); wait for bitrate*CLKp1;
			end loop;
			RS232_RX  <= '1'  ; wait for bitrate*CLKp1;
		end loop;
		wait;
	End Process;
	
	Process
	Begin
		wait until RS232_TX='0';
		wait for bitrate*CLKp1+bt;
		char(0) <= RS232_TX  ; wait for bitrate*CLKp1+bt;
		char(1) <= RS232_TX  ; wait for bitrate*CLKp1+bt;
		char(2) <= RS232_TX  ; wait for bitrate*CLKp1+bt;
		char(3) <= RS232_TX  ; wait for bitrate*CLKp1+bt;
		char(4) <= RS232_TX  ; wait for bitrate*CLKp1+bt;
		char(5) <= RS232_TX  ; wait for bitrate*CLKp1+bt;
		char(6) <= RS232_TX  ; wait for bitrate*CLKp1+bt;
		char(7) <= RS232_TX  ; wait for bitrate*CLKp1+bt;
		char(8) <= RS232_TX  ; wait for bitrate*CLKp1+bt;
		char_full <= char(8 downto 1)	;	--wait for bitrate*CLKp+bt;
	End Process;
END;
