library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity Reg8_11  is 
  port (
	  Inrs   : in  STD_LOGIC_vector(7 downto 0);
	  clk    : in  STD_LOGIC;
	  cen    : in  STD_LOGIC;
	  Rst    : in  STD_LOGIC;
	  En     : in std_logic;
	  OutD   : out std_logic_vector(7 downto 0)
	  );
end reg8_11;
architecture Reg8_arch of Reg8_11 is 
begin

process(clk, rst, Inrs)
begin
	if (rst = '0') then 
		OutD <= "00000000";
	elsif ( falling_edge(clk)) then
			if(cen = '1') and (En = '1') then 
				OutD <= Inrs;
			end if;
	end if;
end process;				
end Reg8_arch;
