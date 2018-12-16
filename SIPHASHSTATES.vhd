LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY SIPHASHSTATES IS 
		PORT
		(
				CLK     :  IN  STD_LOGIC;
				MESSAGE :  IN  STD_LOGIC_VECTOR(63 DOWNTO 0);
				KEY_0   :  IN  STD_LOGIC_VECTOR(63 DOWNTO 0);
				KEY_1   :  IN  STD_LOGIC_VECTOR(63 DOWNTO 0);
				NRBYTES :  IN  STD_LOGIC_VECTOR(3  DOWNTO 0);
				
		
				HASH    		:  OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
				HASH_READY  :  OUT STD_LOGIC
		);
END SIPHASHSTATES;

ARCHITECTURE SIPHASHSTATES_ARCH of SIPHASHSTATES IS
	
	SIGNAL BLOCK_COUNTER  : UNSIGNED(4 DOWNTO 0):=B"00000";
	SIGNAL CURRENT_COUNT  : UNSIGNED(4 DOWNTO 0):=B"00000";
	SIGNAL TOTAL_BYTES    : STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	TYPE STATES IS (ST_IDLE, ST_INIT, ST_COMPRESSION, ST_LAST_BLOCK, ST_FINALIZATION1, ST_FINALIZATION2);
	SIGNAL STATE: STATES:=ST_IDLE;
	
	SIGNAL V0_0, V1_0, V2_0, V3_0, V0_1, V1_1, V2_1, V3_1, V0_2, V1_2, V2_2, V3_2 : STD_LOGIC_VECTOR(63 DOWNTO 0);
	
	SIGNAL THIS_M		:		STD_LOGIC_VECTOR(63 DOWNTO 0);
	SIGNAL LAST_M		:		STD_LOGIC_VECTOR(63 DOWNTO 0);
	
	BEGIN
		SIPROUND1: ENTITY WORK.SIPROUND   			PORT MAP(V0_0,V1_0,V2_0,V3_0,V0_1,V1_1,V2_1,V3_1);
		SIPROUND2: ENTITY WORK.SIPROUND   			PORT MAP(V0_1,V1_1,V2_1,V3_1,V0_2,V1_2,V2_2,V3_2);
		
		CURRENT_COUNT <= BLOCK_COUNTER;
		TOTAL_BYTES <= STD_LOGIC_VECTOR(CURRENT_COUNT) & NRBYTES(2 DOWNTO 0);
		THIS_M <= MESSAGE WHEN NRBYTES(3) = '1' ELSE
					 TOTAL_BYTES & MESSAGE(55 DOWNTO 0);
		
		PROCESS(CLK)
		BEGIN
			IF(CLK'EVENT AND CLK='1') THEN
				LAST_M <= THIS_M;
				BLOCK_COUNTER <= CURRENT_COUNT + 1;
				--HASH_READY <= '0';
				
				CASE STATE IS
					WHEN ST_INIT =>
					V0_0 <= X"736F6D6570736575" XOR KEY_0;
					V1_0 <= X"646F72616E646F6D" XOR KEY_1;
					V2_0 <= X"6C7967656E657261" XOR KEY_0;
					V3_0 <= X"7465646279746573" XOR KEY_1 XOR THIS_M;
					HASH_READY <= '0';
					
					
					WHEN ST_COMPRESSION =>
					V0_0 <= V0_2 XOR LAST_M;
					V1_0 <= V1_2;
					V2_0 <= V2_2;
					V3_0 <= V3_2 XOR THIS_M;
					
					WHEN ST_LAST_BLOCK =>
					V0_0 <= V0_2 XOR LAST_M;
					V1_0 <= V1_2;
					V2_0 <= V2_2 XOR X"00000000000000FF";
					V3_0 <= V3_2;
					
					WHEN ST_FINALIZATION1 =>
					V0_0 <= V0_2;
					V1_0 <= V1_2;
					V2_0 <= V2_2;
					V3_0 <= V3_2;
					
					
					WHEN ST_FINALIZATION2 =>
					HASH <= V0_2 XOR V1_2 XOR V2_2 XOR V3_2;
					HASH_READY <= '1';
					LAST_M        <= (OTHERS => '0');
					BLOCK_COUNTER <= (OTHERS => '0');
					
					WHEN ST_IDLE =>
					
					
				END CASE;
			END IF;
		END PROCESS;
	
		PROCESS(CLK)
		BEGIN
			IF(CLK'EVENT AND CLK='1') THEN
				IF STATE = ST_COMPRESSION THEN
					IF NRBYTES(3) = '1' THEN 
						STATE <= ST_COMPRESSION;
					ELSE
						STATE <= ST_LAST_BLOCK;
					END IF;
				ELSIF STATE = ST_LAST_BLOCK THEN
					STATE <= ST_FINALIZATION1;
				ELSIF STATE = ST_FINALIZATION1 THEN
					STATE <= ST_FINALIZATION2;
				ELSIF STATE = ST_INIT THEN
					STATE <= ST_COMPRESSION;
				ELSIF STATE = ST_FINALIZATION2 THEN
					STATE <= ST_IDLE;
				ELSIF STATE = ST_IDLE THEN
					STATE <= ST_INIT;
				END IF;			
			END IF;
		END PROCESS;
			
END SIPHASHSTATES_ARCH;
				
				