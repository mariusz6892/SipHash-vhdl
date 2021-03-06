LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
ENTITY LASTMESSAGE_XOR IS PORT
(
V0_IN :IN STD_LOGIC_VECTOR (63 DOWNTO 0);
V2_IN :IN STD_LOGIC_VECTOR (63 DOWNTO 0);
MESSAGE_1 :IN STD_LOGIC_VECTOR (63 DOWNTO 0);
V0_OUT :OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
V2_OUT :OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
);
END LASTMESSAGE_XOR;
ARCHITECTURE ARCH_LASTMESSAGE_XOR OF LASTMESSAGE_XOR IS
BEGIN
V0_OUT <= V0_IN XOR MESSAGE_1;
V2_OUT <= V2_IN XOR X"00000000000000FF";
END ARCHITECTURE;