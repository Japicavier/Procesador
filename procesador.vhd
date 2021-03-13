library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;


entity Procesador is
port (
   Clr 			: in std_logic;
   clk50Mhz 	: in std_logic;
	switches 	: in std_logic_vector(7 downto 0);
	LEDs 			: out std_logic_vector(7 downto 0);
	SegH        : out std_logic_vector(7 downto 0);
	SegL        : out std_logic_vector(7 downto 0);
	TurnOff     : out std_logic_vector(31 downto 0);
	LEDSOFF     : out std_logic_vector(1 downto 0)
	);
end Procesador;

architecture procesador_arch of Procesador is

Component ProgCounter 
Port ( PCIn	: in std_logic_vector(7 downto 0);
		 Cen  : in std_logic;
		 rst  : in std_logic;
		 clk  : in std_logic;
		 PCOut	: out std_logic_vector(7 downto 0)
	  );
end component;

Component Mem 
Port ( Addr		: in std_logic_vector(7 downto 0);
		 Datars	: out std_logic_vector(2 downto 0);
		 Datart	: out std_logic_vector(2 downto 0);
		 Datard	: out std_logic_vector(2 downto 0);
		 DataOp  : out std_logic_vector(3 downto 0);
		 Datai	: out std_logic_vector(7 downto 0)
	  );
end component;

Component CtrUnit 
Port ( oper  			: in std_logic_vector(3 downto 0);
		 RegSrc_Op		: out std_logic_vector(1 downto 0);
		 ALUOp_Op		: out std_logic_vector(2 downto 0);
		 RegWrite_Op	: out std_logic;
		 Write7Seg_Op	: out std_logic;
		 WriteLEDs_Op	: out std_logic;
		 PCInc_Op		: out std_logic;
		 Beq_Op			: out std_logic;
		 JiJr_Op			: out std_logic_vector(1 downto 0)
	  );
end component;

Component Registers 
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
end component;

Component ALU
Port ( InA	: in std_logic_vector(7 downto 0);
		 InB	: in std_logic_vector(7 downto 0);
		 Sel	: in std_logic_vector(2 downto 0);
		 Oper	: out std_logic_vector (7 downto 0);
		 Zero	: out std_logic
		 );
end component;

component FullAdder is 
	port (
	  InA : in  std_logic_vector(7 downto 0);
	  InB : in  std_logic_vector(7 downto 0);
	  S   : out std_logic_vector(7 downto 0));
	end component;

component Increm is 
	port (
	  InA : in  std_logic_vector(7 downto 0);
	  InB : in  std_logic_vector(7 downto 0);
	  Sel : in  std_logic;
	  M   : out std_logic_vector(7 downto 0));
	end component;

component BrEq is 
	port (
	  InA : in  std_logic;
	  InB : in  std_logic;
	  Sel : in  std_logic;
	  M   : out std_logic);
	end component;



component Mux4to1_09 is 
	port (
	  InA : in  std_logic_vector(7 downto 0);
	  InB : in  std_logic_vector(7 downto 0);
	  InC : in  std_logic_vector(7 downto 0);
	  InD : in  std_logic_vector(7 downto 0);
	  Sel : in  std_logic_vector(1 downto 0);
	  M   : out std_logic_vector(7 downto 0));
	end component;
	
--component Mux4to1_10
--  port (
--	  InA   : in  STD_LOGIC_vector(7 downto 0);
--	  InB   : in  STD_LOGIC_vector(7 downto 0);
--	  InC   : in  STD_LOGIC_vector(7 downto 0);
--	  M     : out  STD_LOGIC_vector(7 downto 0)
--	  );
--  end component;
  
component Reg8_11
  port (
	  Inrs   : in  STD_LOGIC_vector(7 downto 0);
	  clk    : in  STD_LOGIC;
	  cen    : in  STD_LOGIC;
	  Rst    : in  STD_LOGIC;
	  En     : in std_logic;
	  OutD   : out std_logic_vector(7 downto 0)
	  );
end component;
  
--component Reg8_12
--  port (
--	  Inrs   : in  STD_LOGIC_vector(7 downto 0);
--	  clk    : in  STD_LOGIC;
--	  cen    : in  STD_LOGIC;
--	  Rst    : in  STD_LOGIC;
--	  En     : in std_logic;
--	  OutD   : out std_logic_vector(7 downto 0)
--	  );
--end component;
  
component Dec7seg_13
  port (
	  Inr   : in  STD_LOGIC_vector(3 downto 0);
	  Seg   : out std_logic_vector(7 downto 0)
	  );
end component;  
  
--component Dec7seg_14
--  port (
--	  Inr   : in  STD_LOGIC_vector(3 downto 0);
--	  Seg   : out std_logic_vector(7 downto 0)
--	  );
--end component;
  
component ClkDiv
  port (
	  ClkIn   : in  STD_LOGIC; 
	  Rst     : in std_logic;	  
	  ClkOut  : out std_logic
	  );
end component;
 
component DispOff
  port (
	  TurnOff  : out std_logic_vector(31 downto 0)
	  );
end component;

signal PC			: std_logic_vector(7 downto 0);
signal BrJiJrM 	: std_logic_vector(7 downto 0);
signal clkEn_emb	: std_logic;
signal opcode		: std_logic_vector(3 downto 0);
signal rs			: std_logic_vector(2 downto 0);
signal rt			: std_logic_vector(2 downto 0);
signal rd			: std_logic_vector(2 downto 0);
signal Imm			: std_logic_vector(7 downto 0);

signal regSrc		: std_logic_vector(1 downto 0);
signal ALUOp		: std_logic_vector(2 downto 0);
signal regWrite	: std_logic;
signal Write7Seg	: std_logic;
signal WriteLeds	: std_logic;
signal PCInc		: std_logic;
signal Beq			: std_logic;
signal JiJr			: std_logic_vector(1 downto 0);
signal DataM		: std_logic_vector(7 downto 0);
signal rsd			: std_logic_vector(7 downto 0);
signal rtd			: std_logic_vector(7 downto 0);
signal ALUOper		: std_logic_vector(7 downto 0);
signal IncremM		: std_logic_vector(7 downto 0);
signal AdderS		: std_logic_vector(7 downto 0);
signal BrEqm		: std_logic;
signal ALUZero		: std_logic;
signal D 			: std_logic_vector(7 downto 0);
---------------constantes-----------------------------------
Constant  plusOne		:  std_logic_vector(7 downto 0) := "00000001";
constant  Zero_emb	:  std_logic_vector(7 downto 0) := "00000000"; ----?????????
begin
--------------mapeo---------------------------------------
	---instanciar componentes---
	C01 : ProgCounter ---------falta clk y rst

	port map (
		PCIn  => BrJiJrM,
		PCOut => PC,
		Cen => ClkEn_emb,
		rst => clr,
		clk => clk50mhz
	);
	
	C02 : Mem

	port map (
		Addr  => PC,
		Datars => rs,
		Datart => rt,
		Datard => rd,
		Datai => imm,
		Dataop => opcode
	);
	
	C03 : CtrUnit

	port map (
		RegSrc_Op    => RegSrc,
		ALUOp_OP     => ALUOp,
		RegWrite_Op  => RegWrite,
		Write7seg_Op => write7seg,
		WriteLEDs_Op => WriteLEDs,
		PCInc_Op     => PCInc,
		Beq_Op       => Beq,
		JiJr_Op      => JiJr,
		OPer         => opcode
	);

	
	C04 : Registers ------------falta clk y rst

	port map (
		SelA  => rs,
		SelB  => rt,
		SelWR => rd,
		Data  => DataM,
		OutA  => rsd,
		OutB  => rtd,
		Cen   => ClkEn_emb,
		WE    => RegWrite,
		clk   => clk50mhz,
		rst   => clr
	);
	
	C05 : ALU

	port map (
		InA  => rsd,
		InB  => rtd,
		Sel  => ALUOp,
		Zero => ALUZero,
		Oper => ALUOper
	);

	
	C06 : FullAdder

	port map (
		InA  => PC,
		InB  => IncremM,
		S    => AdderS
	);

	C07 : Increm

	port map (
		InA  => plusOne,----no seguro-- 
		InB  => Imm,
		Sel  => BrEqM,
		M    => IncremM
	);


	C08 : BrEq

	port map (
		InA  => PCInc,
		InB  => ALUZero,
		Sel  => Beq,
		M    => BrEqM
	);

	C09 : Mux4to1_09

	port map (
		InA  => Imm,
		InB  => PC,
		InC  => ALUOper,
		InD  => Switches,
		Sel  => RegSrc,
		M    => DataM
	);

	
	C10 : Mux4to1_09

	port map (
		InA  => AdderS,
		InB  => rsd,
		InC  => Imm,
		InD  => switches,
		Sel  => JiJr,
		M  => BrJiJrM
	);
	
	C11 : Reg8_11

	port map (
		clk   => clk50Mhz,
		Cen   => clken_emb,
		Rst   => clr,
		En    => write7seg,
		Inrs  => rsd,
		OutD  => D
	);	
	
	C12 : Reg8_11

	port map (
		clk   => clk50Mhz,
		Cen   => clken_emb,
		Rst   => clr,
		En    => writeLEDs,
		Inrs  => rsd,
		OutD  => LEDs
	);		
	
	C13 : Dec7seg_13

	port map (
		InR   => D(7 downto 4),
		Seg   => SegH
		
	);	
	
	C14 : Dec7seg_13

	port map (
		InR   => D(3 downto 0),
		Seg   => SegL
		
	);	

	C15 : ClkDiv

	port map (
		Clkin   =>clk50mhz,
		Rst   => Clr,
		ClkOut => clken_emb
		
	);	
	
	

	TurnOff <= (others => '1');
	LEDSOff <= (others => '0');
	

end procesador_arch;