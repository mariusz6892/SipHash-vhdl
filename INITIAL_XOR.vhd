LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
ENTITY INITIAL_XOR IS PORT
(
MESSAGE_0 :IN STD_LOGIC_VECTOR (63 DOWNTO 0);
KEY_0 :IN STD_LOGIC_VECTOR (63 DOWNTO 0);
KEY_1 :IN STD_LOGIC_VECTOR (63 DOWNTO 0);
V_0 :OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
V_1 :OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
V_2 :OUT STD_LOGIC_VECTOR(63 DOWNTO 0);
V_3 :OUT STD_LOGIC_VECTOR(63 DOWNTO 0)
);
END INITIAL_XOR;
ARCHITECTURE ARCH_INITIAL_XOR OF INITIAL_XOR IS
BEGIN
V_0 <= X"736F6D6570736575" xor KEY_0;
V_1 <= X"646F72616E646F6D" xor KEY_1;
V_2 <= X"6C7967656E657261" xor KEY_0;
V_3 <= x"7465646279746573" xor KEY_1 xor MESSAGE_0;
END ARCHITECTURE;