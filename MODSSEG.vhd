LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY MODSSEG IS
PORT ( bcd : IN STD_LOGIC_VECTOR(3 DOWNTO 0) ;
		neg : IN STD_LOGIC;
		leds : OUT STD_LOGIC_VECTOR(0 TO 6) ;
		--ledss : OUT STD_LOGIC_VECTOR(0 TO 6)	) ;
END MODSSEG ;
  
ARCHITECTURE Behavior OF MODSSEG IS 
BEGIN
	PROCESS ( bcd) 
	BEGIN
		CASE bcd IS --abcdefg
			WHEN "0000" =>leds<= "1110110";
			WHEN "0001" =>leds<= "0110111";
			
			WHEN OTHERS =>leds<= "-------";
		END CASE ; 	
END PROCESS ;

	
END Behavior ;