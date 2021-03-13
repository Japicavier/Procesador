library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity CtrUnit  is 
Port ( oper 			: in std_logic_vector(3 downto 0);
		 RegSrc_Op		: out std_logic_vector(1 downto 0);
		 ALUOp_Op		: out std_logic_vector(2 downto 0);
		 RegWrite_Op	: out std_logic;
		 Write7Seg_Op	: out std_logic;
		 WriteLEDs_Op	: out std_logic;
		 PCInc_Op		: out std_logic;
		 Beq_Op			: out std_logic;
		 JiJr_Op			: out std_logic_vector(1 downto 0)
	  );
end CtrUnit;

architecture ctrUnit_arch of ctrUnit is
begin 
	process(Oper)
	begin
		if (oper(3) = '0') then
			ALUOP_OP <= oper(2 downto 0);  
			regsrc_OP <= "10";
			Regwrite_op <= '1';
			Write7Seg_Op	<= '0';
		   WriteLEDs_Op	<= '0';
		   PCInc_Op		<= '0';
		   Beq_Op		<= '0';
		   JiJr_Op		<= "00";
			
		elsif (oper = "1010") then
			ALUOP_OP <= "001";
			regsrc_OP <= "00";
			Regwrite_op <= '0';
			Write7Seg_Op	<= '0';
		   WriteLEDs_Op	<= '0';
		   PCInc_Op		<= '0';
			JiJr_Op		<= "00";
			
			beq_op <= '1';
		else 
			if (oper = "1000") then 
				ALUOP_OP <= "000";
				regWrite_op <= '1';
				regsrc_OP <= "00";
				Write7Seg_Op	<= '0';
				WriteLEDs_Op	<= '0';
				PCInc_Op		<= '0';
				Beq_Op		<= '0';
				JiJr_Op		<= "00";
			elsif (oper = "1001") then 
				ALUOP_OP <= "000";
				regsrc_op <= "01";
				regwrite_op <= '1';
				
				
				
				Write7Seg_Op	<= '0';
				WriteLEDs_Op	<= '0';
				PCInc_Op		<= '0';
				Beq_Op		<= '0';
		      JiJr_Op		<= "00";
			elsif (oper = "1011") then 
				ALUOP_OP <= "000";
				regsrc_OP <= "00";
				Regwrite_op <= '0';
				Write7Seg_Op	<= '0';
				WriteLEDs_Op	<= '0';
				PCInc_Op		<= '0';
				Beq_Op		<= '0';
				
				jijr_op <= "10";
			elsif (oper = "1100") then 
				ALUOP_OP <= "000";
				regsrc_OP <= "00";
				Regwrite_op <= '0';
				Write7Seg_Op	<= '0';
				WriteLEDs_Op	<= '0';
				PCInc_Op		<= '0';
				Beq_Op		<= '0';
				
				jijr_op <= "01";
			elsif (oper = "1101") then 
				ALUOP_OP <= "000";
				regsrc_OP <= "00";
				Regwrite_op <= '0';
				
				WriteLEDs_Op	<= '0';
				PCInc_Op		<= '0';
				Beq_Op		<= '0';
				JiJr_Op		<= "00";
				write7seg_op <= '1';
			elsif (oper = "1110") then 
				ALUOP_OP <= "000";
			   regsrc_OP <= "00";
				Regwrite_op <= '0';
				Write7Seg_Op	<= '0';
				PCInc_Op		<= '0';
				Beq_Op		<= '0';
				JiJr_Op		<= "00";
				writeLEDs_op <= '1';
			elsif (oper = "1111") then
				ALUOP_OP <= "000";
				Write7Seg_Op	<= '0';
				WriteLEDs_Op	<= '0';
				PCInc_Op		<= '0';
				Beq_Op		<= '0';
				JiJr_Op		<= "00";
				regsrc_op <= "11";
				regwrite_op <= '1';
			end if;
		end if;
	end process;	
end ctrUnit_arch;