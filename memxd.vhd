library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity Mem  is 
Port ( Addr		: in std_logic_vector(7 downto 0);
		 Datars	: out std_logic_vector(2 downto 0);
		 Datart	: out std_logic_vector(2 downto 0);
		 Datard	: out std_logic_vector(2 downto 0);
		 DataOP  : out std_logic_vector(3 downto 0);
		 Datai	: out std_logic_vector(7 downto 0)
	  );

end mem;
architecture Mem_arch of Mem is
begin
end Mem_arch;
