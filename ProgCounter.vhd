library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity ProgCounter  is 
Port ( PCIn	: in std_logic_vector(7 downto 0);
       Cen  : in std_logic;
		 Clk  : in std_logic;
		 rst	: in std_logic;
		 PCOut	: out std_logic_vector(7 downto 0)
	  );
end ProgCounter;
architecture PC_arch of ProgCounter is 
begin

process(clk, rst, PCIn)
begin
	if (rst = '0') then 
		PCOut <= "00000000";
	elsif ( rising_edge(clk)) then
			if(cen = '1') then 
				PCOut <= PCIn;
			end if;
	end if;
end process;				
end PC_arch;

