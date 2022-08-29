--mod ALU -2D

library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity modALU is
port (Clock      : in std_logic; --input clock signal
		A,B        : in unsigned(7 downto 0); --8bit inputs frpm latches A and B
		student_id : in unsigned(3 downto 0); --4bit student id from Machine
		OP			  : in unsigned(15 downto 0); --16but selector for Operation from decoder
		Neg        : out std_logic; --is result neg?
		R1         : out unsigned(3 downto 0); --lower 4bits of 8 bit result output
		R2         : out unsigned(3 downto 0)); --higher 4bits of 8 bit result output
end modALU;

architecture calculation of modALU is --temp signal declarations
signal Reg1,Reg2,Result : unsigned(7 downto 0) := (others => '0');
signal Reg4 : unsigned(0 to 7);
begin
	Reg1 <= A; --temp store A in Reg1 local variable
	Reg2 <= B; --temp store B in Reg2 local variable
   process(Clock, OP)
	begin	
		if(rising_edge(clock)) THEN --Do the calc @ pos edge of clock cycle
			case OP is
				when "0000000000000001" =>
					Result(0) <= A(2);
					Result(1) <= A(2);
					Result(2) <= A(2);
					Result(3) <= A(2);
					Result(4) <= A(2);
					Result(5) <= A(2);
					Result(6) <= A(2);
					Result(7) <= A(2);
					
					Neg <= '0';
					--1 Shift A to the right by two bits, input bit = 1 (SHR)
				when "0000000000000010" =>
					
						--if (A>=B) then
							--Result<= ((A-B)+4);
							--Neg<='0';
						if ((A - B + 4) >= 0) then
							Result<= ((A-B)+4);
							Neg<='0';
						else 
							Result<= (B-(A+4));
							Neg<='1';
						end if;
					--2 Produce the difference of A and B and then increment by 4		
						
				when "0000000000000100" =>
					
						--Result <= Max(a, b);
						if (A>B) then
							Result <= A;
						else
							Result <= B;
						end if;
						Neg <= '0';
					--3 find greater value of A and B and produce the results (Max(A,B))
				when "0000000000001000" => 
					
					Result(0) <= A(0); 
					Result(1) <= A(1);
					Result(2) <= A(2);
					Result(3) <= A(3);
					Result(4) <= B(0);
					Result(5) <= B(1);
					Result(6) <= B(2);
					Result(7) <= B(3);
					Neg <= '0';
					
					--4 Swap upper 4 bits of A by the lower 4 bits of B
				when "0000000000010000" => 
					Result <= A + 00000001;
					Neg <= '0';
					
					--5 Increment A by 1
				when "0000000000100000" => 
					Result <= A and B;
					Neg <= '0';
					
					--6 Produce the result of ANDing A and B
				when "0000000001000000" => 
					Result(7) <= not A(7); --,B(6),B(5),B(4),A(7),A(6),A(5),A(4);
					Result(6) <= not A(6);
					Result(5) <= not A(5);
					Result(4) <= not A(4);
					Result(3) <= A(3);
					Result(2) <= A(2);
					Result(1) <= A(1);
					Result(0) <= A(0);
					Neg <= '0';
					--7 invert the upper 4 bits of A
				when "0000000010000000" => 
					Result <= B rol 3;
					Neg <= '0';
					--8 rotate B to the legt 3 bits (ROL)
				when "0000000100000000" => 
					Result <= NULL;
					Neg <= '0';
					
					--9 show Null
				when others =>
					Result <= "--------";
					
			end case;
		end if;
	end process;
	R1 <= Result(3 downto 0); --Since output seven segsments can
	R2 <= Result(7 downto 4); --only 4bits, split the 8 bit to two 4bit
end calculation;
					
				