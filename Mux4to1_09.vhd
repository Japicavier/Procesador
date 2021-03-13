library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity Mux4to1_09 is 

	port (
	  InA : in  std_logic_vector(7 downto 0);
	  InB : in  std_logic_vector(7 downto 0);
	  InC : in  std_logic_vector(7 downto 0);
	  InD : in  std_logic_vector(7 downto 0);
	  Sel : in  std_logic_vector(1 downto 0);
	  M   : out std_logic_vector(7 downto 0));
	  
end Mux4to1_09;
architecture Mux4to1_Arch of Mux4to1_09 is
begin 
process(Sel)
begin
	if (Sel = "00") then 
		M <= InA;
	elsif (sel = "01") then 
	   M <= InB;
	elsif (sel = "10") then 
	   M <= InC;
	elsif (sel = "11") then 
	   M <= InD;
	end if;
end process;
end Mux4to1_Arch;
