library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity ClkDiv is
  port (
	  ClkIn   : in  STD_LOGIC; 
	  Rst     : in std_logic;	  
	  ClkOut  : out std_logic
	  );
end ClkDiv;

architecture rtl of ClkDiv is
  -- Signal and constants used by the Frequency Divider
  -- Embedded signals declaration
  -- Used by Frequency Divider (FreqDiv)

  -- Define a value that contains the desired Frequency
  constant DesiredFreq : natural := 4;  -- Once per second changes in the FSM
  -- Frequency for a DE2-Lite board is 50MHz
  constant BoardFreq   : natural := 50_000_000;
  -- Calculate the value the counter should reach to obtain desired Freq.
  constant MaxOscCount : natural := BoardFreq / DesiredFreq;
  -- Pulse counter for the oscillator
  signal OscCount      : natural range 0 to MaxOscCount;  

  begin
    Freq_Div: process(Rst,ClkIn)
	 begin
	   if (Rst = '0') then
        OscCount <= 0;
		elsif rising_edge(ClkIn) then
        if (OscCount = 	MaxOscCount) then
		     ClkOut    <= '1';
			  OscCount <= 0;
		  else
		     ClkOut    <= '0';
			  OscCount <= OscCount + 1;
		  end if;
		end if;
	 end process Freq_Div;
	 
end rtl;