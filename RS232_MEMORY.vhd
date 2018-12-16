----------------------------------
-- Łukasz DZIEŁ (883533374)     --
-- FPGACOMMEXAMPLE-v2           --
-- 01.2016                      --
-- 1.0                          --
----------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;

LIBRARY WORK;
USE WORK.ALL;
USE WORK.RS232_INTERFACE_PKG.ALL;

ENTITY RS232_MEMORY IS PORT
(	
	CLK	:IN STD_LOGIC;
	INIT	:IN STD_LOGIC;
	STORE	:IN STD_LOGIC;
	LOAD	:IN STD_LOGIC;
	DRL	:OUT STD_LOGIC;
	DIN	:IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	DOUT	:OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
);
END ENTITY;

ARCHITECTURE RS232_MEMORY_ARCH OF RS232_MEMORY IS
	
	CONSTANT LAST_ADDR : STD_LOGIC_VECTOR(7 DOWNTO 0) := STD_LOGIC_VECTOR(unsigned(MEM_SIZE) - 1);
	TYPE MEMORY_BLOCK IS ARRAY (0 TO conv_integer(LAST_ADDR)) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL MEM : MEMORY_BLOCK;
	
	SIGNAL CTR :STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL IXS :STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL IXL :STD_LOGIC_VECTOR(7 DOWNTO 0);	
	
BEGIN
	
	PROCESS(CLK, INIT)
	BEGIN
		IF(INIT = '1') THEN CTR <= (others => '0');
		ELSE
			IF (CLK'EVENT AND CLK = '1') THEN
				IF ((STORE = '1' AND LOAD = '0' AND CTR /= MEM_SIZE) OR (STORE = '1' AND LOAD = '1' AND CTR = X"00")) THEN
					CTR <= STD_LOGIC_VECTOR(unsigned(CTR) + 1);
				END IF;
				IF ((STORE = '0' AND LOAD = '1' AND CTR /= X"00") OR (STORE = '1' AND LOAD = '1' AND CTR = MEM_SIZE)) THEN
					CTR <= STD_LOGIC_VECTOR(unsigned(CTR) - 1);
				END IF;
			END IF;
		END IF;
	END PROCESS;
	
	PROCESS(CLK, INIT)
	BEGIN
		IF(INIT = '1') THEN IXS <= (others => '0');
		ELSE
			IF (CLK'EVENT AND CLK = '1') THEN
				IF (STORE = '1' AND CTR /= MEM_SIZE) THEN
					IF(IXS /= LAST_ADDR) THEN
						IXS <= STD_LOGIC_VECTOR(unsigned(IXS) + 1);
					ELSE
						IXS <= (others => '0');
					END IF;
				END IF;
			END IF;
		END IF;
	END PROCESS;
	
	PROCESS(CLK, INIT)
	BEGIN
		IF(INIT = '1') THEN IXL <= (others => '0');
		ELSE
			IF (CLK'EVENT AND CLK = '1') THEN
				IF (LOAD = '1' AND CTR /= X"00") THEN
					IF(IXL /= LAST_ADDR) THEN
						IXL <= STD_LOGIC_VECTOR(unsigned(IXL) + 1);
					ELSE
						IXL <= (others => '0');
					END IF;
				END IF;
			END IF;
		END IF;
	END PROCESS;
	
	PROCESS(CLK)
	BEGIN
		IF (CLK'EVENT AND CLK = '1') THEN
			IF (STORE = '1' AND CTR /= MEM_SIZE) THEN
				MEM(conv_integer(IXS)) <= DIN;
			END IF;
		END IF;
	END PROCESS;
	
	PROCESS(CLK)
	BEGIN
		IF (CLK'EVENT AND CLK = '1') THEN
			IF(LOAD = '1' AND CTR /= X"00") THEN
				DOUT <= MEM(conv_integer(IXL));
			ELSE
				DOUT <= (others => 'Z');
			END IF;
		END IF;
	END PROCESS;
	
	DRL	<= '1' WHEN CTR /= X"00" ELSE '0';
	
END ARCHITECTURE;