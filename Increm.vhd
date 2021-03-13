library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity Increm is 
	port (
	  InA : in  std_logic_vector(7 downto 0);
	  InB : in  std_logic_vector(7 downto 0);
	  Sel : in  std_logic;
	  M   : out std_logic_vector(7 downto 0));
end Increm;

architecture Increm_arch of Increm is 
begin
process(Sel)
begin
	if (Sel = '0') then 
		M <= InA;
	else 
	   M <= InB;
	end if;
end process;
end Increm_arch;