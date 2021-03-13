library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity BrEq is 
	port (
	  InA : in  std_logic;
	  InB : in  std_logic;
	  Sel : in  std_logic;
	  M   : out std_logic);
end BrEq;

architecture BrEq_arch of BrEq is 
begin
process(Sel)
begin
	if (Sel = '0') then 
		M <= InA;
	else 
	   M <= InB;
	end if;
end process;
end BrEq_arch;