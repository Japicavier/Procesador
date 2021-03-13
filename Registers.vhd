library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity Registers  is 
Port ( Cen  : in std_logic;
		 clk  : in std_logic;
		 rst  : in std_logic;
		 WE   : in std_logic;
		 Data : in std_logic_vector (7 downto 0);
		 SelA	: in std_logic_vector(2 downto 0);
		 SelB	: in std_logic_vector(2 downto 0);
		 SelWr: in std_logic_vector(2 downto 0);
		 OutA	: out std_logic_vector(7 downto 0);
		 OutB	: out std_logic_vector(7 downto 0)
	  );

end Registers;

architecture Registers_arch of Registers is 



signal Reg01 : std_logic_vector(7 downto 0);
signal Reg02 : std_logic_vector(7 downto 0);
signal Reg03 : std_logic_vector(7 downto 0);
signal Reg04 : std_logic_vector(7 downto 0);
signal Reg05 : std_logic_vector(7 downto 0);
signal Reg06 : std_logic_vector(7 downto 0);
signal Reg07 : std_logic_vector(7 downto 0);
signal Reg08 : std_logic_vector(7 downto 0);


begin


process(rst,clk) -----------------------escritura
begin
	if (rst = '0') then
		 Reg01<= "00000000";
		 Reg02<= "00000000";
		 Reg03<= "00000000";
		 Reg04<= "00000000";
		 Reg05<= "00000000";
		 Reg06<= "00000000";
		 Reg07<= "00000000";
		 Reg08<= "00000000";
	elsif (falling_edge(clk) ) then 
		if (cen ='1' and WE ='1')then 
			case selwr is
				when "000" => Reg01 <= data;
				when "001" => Reg02 <= data;
				when "010" => Reg03 <= data;
				when "011" => Reg04 <= data;
				when "100" => Reg05 <= data;
				when "101" => Reg06 <= data;
				when "110" => Reg07 <= data;
				when "111" => Reg08 <= data;
			end case;
		end if;
	end if;
end process;


process(SelA, SelB)                    ----lectura----
begin
case SelA is
	when "000" => OutA <= Reg01;
	when "001" => OutA <= Reg02;
	when "010" => OutA <= Reg03;
	when "011" => OutA <= Reg04;
	when "100" => OutA <= Reg05;
	when "101" => OutA <= Reg06;
	when "110" => OutA <= Reg07;
	when "111" => OutA <= Reg08;
end case;

case SelB is
	when "000" => OutB <= Reg01;
	when "001" => OutB <= Reg02;
	when "010" => OutB <= Reg03;
	when "011" => OutB <= Reg04;
	when "100" => OutB <= Reg05;
	when "101" => OutB <= Reg06;
	when "110" => OutB <= Reg07;
	when "111" => OutB <= Reg08;
end case;


	
end process;
	
end Registers_arch;