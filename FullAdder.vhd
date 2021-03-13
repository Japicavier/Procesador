library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

Entity FullAdder is 
	port (
	  InA : in  std_logic_vector(7 downto 0);
	  InB : in  std_logic_vector(7 downto 0);
	  S   : out std_logic_vector(7 downto 0));
End Fulladder;
Architecture a of FullAdder is 
Begin 
	S <= InA + InB;
End a;