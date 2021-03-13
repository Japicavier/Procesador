library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity Dec7seg_13  is 
  port (
	  Inr   : in  STD_LOGIC_vector(3 downto 0);
	  Seg   : out std_logic_vector(7 downto 0)
	  );
end Dec7seg_13;

Architecture Dec7seg_13_arch of Dec7seg_13 is 
begin 
					  
		Seg    <= "11000000" when Inr = "0000" else
					  
					 "11111001" when Inr = "0001" else
					  
					 "10100100" when Inr = "0010" else
					  
					 "10110000" when Inr = "0011" else
					  
					 "10011001" when Inr = "0100" else
					  
					 "10010010" when Inr = "0101" else
					  
					 "10000010" when Inr = "0110" else
					  
					 "11111000" when Inr = "0111" else
					  
					 "10000000" when Inr = "1000" else
					  
					 "10011000" when Inr = "1001" else
					  
					 "10001000" when Inr = "1010" else
					  
					 "10000011" when Inr = "1011" else
					  
					 "10100111" when Inr = "1100" else
					  
					 "10100001" when Inr = "1101" else
					  
					 "10000110" when Inr = "1110" else
					  
					 "10001110" when Inr = "1111";
end Dec7seg_13_arch;
