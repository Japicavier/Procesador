library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity ALU is 
Port ( InA	: in std_logic_vector(7 downto 0);
		 InB	: in std_logic_vector(7 downto 0);
		 Sel	: in std_logic_vector(2 downto 0);
		 Oper	: out std_logic_vector (7 downto 0);
		 Zero	: out std_logic
		 );
end ALU;
architecture ALU_arch of ALU is 
signal aux : std_logic_vector(7 downto 0);
begin 
oper <= aux;
	process(Sel)
	begin
	if (Sel = "000") then 
		aux <= InA + InB;
	elsif (sel = "001") then 
		aux <= InA - InB;
		if (aux < "00000000") then 
			aux <= "00000000";
		end if;
	elsif (sel = "010") then 
		aux <= InA and InB;
	elsif (sel = "011") then 
		aux <= InA or InB;
	elsif (sel = "100") then 
		aux <= InA xor InB;
	elsif (sel = "101") then 
		aux <= not (InA);
	elsif (sel = "110") then 
		aux(0) <= '0';
		aux(7 downto 1) <= InA(6 downto 0);
	elsif (sel = "111") then 
		aux(7) <= '0';
		aux(6 downto 0) <= InA(7 downto 1);
	
	end if;

	end process;
	
	process(aux)
	begin
		if aux = "00000000" then 
			zero <= '1';
		else 
			zero <= '0';
		end if;
	end process;

end ALU_arch;