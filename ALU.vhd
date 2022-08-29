library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ALU is
port (Clock      : in std_logic; --input clock signal
		A,B        : in unsigned(7 downto 0); --8bit inputs frpm latches A and B
		student_id : in unsigned(3 downto 0); --4bit student id from Machine
		OP			  : in unsigned(15 downto 0); --16but selector for Operation from decoder
		Neg        : out std_logic; --is result neg?
		R1         : out unsigned(3 downto 0); --lower 4bits of 8 bit result output
		R2         : out unsigned(3 downto 0)); --higher 4bits of 8 bit result output
end ALU;

architecture calculation of AKU is --temp signal declarations
signal Reg1,Reg2,Result : unsigned(7 downto 0) := (others => '0');
signal Reg4 : unsigned(0 to 7);
begin
	Reg1 <= A; --temp store A in Reg1 local variable
	Reg2 <= B; --temp store B in Reg2 local variable
   process(Clk, IO)
	begin	
		if(rising_edge(clock)) THEN --Do the calc @ pos edge of clock cycle
			case OP is
				when "0000000000000001" =>
					--Do addition for reg1 and reg2
				when "0000000000000010" =>
					--Do subtract
					--"Neg" bit set if req.
				when "0000000000000100" =>
					--do inverse
				when "0000000000001000" =>
					--do boolean nand
				when "0000000000010000" =>
					--do boolean nor
				when "0000000000100000" =>
					--do boolean and
				when "0000000001000000" =>
					--do boolean or
				when "0000000010000000" =>
					--do boolean xor
				when "0000000100000000" =>
					--do boolean xnor
				when others =>
					--dont care, do nothing
			end case;
		end if;
	end process;
	R1 <= Result(3 downto 0); --Since output seven segsments can
	R2 <= Result(7 downto 4); --only 4bits, split the 8 bit to two 4bit
end calculation;
					
				
				