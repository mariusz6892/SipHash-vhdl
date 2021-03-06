LIBRARY IEEE  ; 
LIBRARY STD   ; 
LIBRARY WORK  ; 
USE IEEE.NUMERIC_STD.ALL  ; 
USE IEEE.STD_LOGIC_1164.ALL; 
USE IEEE.STD_LOGIC_TEXTIO.ALL  ; 
USE IEEE.STD_LOGIC_UNSIGNED.ALL  ; 
USE STD.TEXTIO.ALL  ; 
USE WORK.ALL  ; 
ENTITY FPGAY_TB  IS 
END ; 
 
ARCHITECTURE FPGAY_TB_ATCH OF FPGAY_TB IS
	SIGNAL WR : STD_LOGIC; 
	SIGNAL CLK : STD_LOGIC; 
	SIGNAL RD : STD_LOGIC; 
	SIGNAL ADDR : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL DIN : STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIGNAL DOUT : STD_LOGIC_VECTOR(31 DOWNTO 0);

	SIGNAL CLKp : time:=40ns;
	
	COMPONENT FPGAY IS PORT
(	
	CLK		: IN  STD_LOGIC;
	INT_WR 	: IN  STD_LOGIC; 
	INT_RD 	: IN  STD_LOGIC;
	INT_ADDR : IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
	INT_DIN	: IN  STD_LOGIC_VECTOR(31 DOWNTO 0);
	INT_DOUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
	END COMPONENT;

BEGIN
	DUT : FPGAY  
	PORT MAP 
	( 
		CLK   => CLK,
		INT_WR => WR,
		INT_RD => RD,
		INT_ADDR => ADDR,
		INT_DIN => DIN,
		INT_DOUT => DOUT  
	); 

	Process
	Begin
		clk  <= '0'  ; wait for CLKp/2;
		clk  <= '1'  ; wait for CLKp/2;
	End Process;
	
	PROCESS
	BEGIN
	WR <= '1'; ADDR <= X"00000000"; DIN <= X"00000008"; wait for CLKp;
	WR <= '1'; ADDR <= X"00000001"; DIN <= X"6b6f6c61"; wait for CLKp;
	WR <= '1'; ADDR <= X"00000002"; DIN <= X"626f7261"; wait for CLKp;
	WR <= '1'; ADDR <= X"00000003"; DIN <= X"636a616d"; wait for CLKp;
	WR <= '1'; ADDR <= X"00000004"; DIN <= X"616d6178"; wait for CLKp;
	WR <= '1'; ADDR <= X"00000005"; DIN <= X"68656c6c"; wait for CLKp;
	WR <= '1'; ADDR <= X"00000006"; DIN <= X"6f6d616d"; wait for CLKp;
	WR <= '0'; wait for CLKp;
	--WR <= '1'; ADDR <= X"00000000"; DIN <= X"00000001"; wait for CLKp;
	--WR <= '1'; ADDR <= X"00000005"; DIN <= X"61000000"; wait for CLKp;
	--WR <= '1'; ADDR <= X"00000006"; DIN <= X"00000000"; wait for CLKp;
	--WR <= '0'; wait for CLKp;
	--WR <= '1'; ADDR <= X"00000000"; DIN <=X"00000008"; wait for CLKp;
	WR <= '1'; ADDR <= X"00000000"; DIN <=X"00000007"; wait for CLKp;
	--WR <= '1'; ADDR <= X"00000001"; DIN <=X"07060504"; wait for CLKp;
	--WR <= '1'; ADDR <= X"00000002"; DIN <=X"03020100"; wait for CLKp;
	--WR <= '1'; ADDR <= X"00000003"; DIN <=X"0f0e0d0c"; wait for CLKp;
	--WR <= '1'; ADDR <= X"00000004"; DIN <=X"0b0a0908"; wait for CLKp;
	WR <= '1'; ADDR <= X"00000005"; DIN <=X"726fdb47"; wait for CLKp;
   --WR <= '1'; ADDR <= X"00000006"; DIN <=X"dd0e0ebc"; wait for CLKp;
	WR <= '1'; ADDR <= X"00000006"; DIN <=X"dd0e0e00"; wait for CLKp;
	WR <= '0'; wait for CLKp;
	
	--WR <= '1'; ADDR <= X"00000000"; DIN <=X"00000000"; wait for CLKp;
	--WR <= '1'; ADDR <= X"00000005"; DIN <=X"00000000"; wait for CLKp;
	--WR <= '1'; ADDR <= X"00000006"; DIN <=X"00000000"; wait for CLKp;
	WR <= '0'; wait for CLKp;
	wait for CLKp;
	wait for CLKp;
	wait for CLKp;
	wait for CLKp;
	wait for CLKp;
	wait for CLKp;
	RD <= '1'; ADDR <= X"00000007";wait for CLKp;
	RD <= '0'; wait for CLKp;
	RD <= '1'; ADDR <= X"00000008";wait for CLKp;
	RD <= '0'; wait for CLKp;
	WAIT;
	END PROCESS;
	

END;
