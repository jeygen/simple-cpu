  library ieee;
  use ieee.std_logic_1164.all;
  
  entity machine is
	port
	(
		clk						: in std_logic;
		data_in 					: in std_logic;
		reset 					: in std_logic;
		student_id 				: out std_logic_vector(3 downto 0);
		current_state 			: out std_logic_vector(3 downto 0)
	);
  end entity;
  
  architecture fsm of machine is 
		-- build an enumerate type with 9 states for sthe state machine (9 states for parsing
		-- 9 digits of stud id)
  type state_type is (s0, s1, s2, s3, s4, s5, s6, s7, s8);
		--resister to hold the current state
  signal ysfm : state_type;
		
  begin	
	process (clk, reset)
	begin	
		if reset = '1' then
			ysfm <= s0;
		elsif (clk'Event AND clk = '1') then 
		-- determine the next state synch based on current state and input
			case ysfm is 
				when s0 =>
					if data_in = '1' then
						ysfm <= s3;
					else
						ysfm <= s0;
					end if;
				when s3 => 
					if data_in = '1' then
						ysfm <= s7; 
					else
						ysfm <= s3;
					end if;
				when s7 =>
					if data_in = '1' then
						ysfm <= s6;
					else
						ysfm <= s7;
					end if;
				when s6 =>
					if data_in = '1' then
						ysfm <= s2;
					else
						ysfm <= s6;
					end if;
				when s2 =>
					if data_in = '1' then
						ysfm <= s4;
					else
						ysfm <= s2;
					end if;
				when s4 =>
					if data_in = '1' then
						ysfm <= s8;
					else
						ysfm <= s4;
					end if;
				when s8 =>
					if data_in = '1' then
						ysfm <= s5;
					else
						ysfm <= s8;
					end if;	
				when s5 =>
					if data_in = '1' then
						ysfm <= s1;
					else
						ysfm <= s5;
					end if;
				when s1 =>
					if data_in = '1' then
						ysfm <= s0;
					else
						ysfm <= s1;
					end if;
				end case;
				
			end if;
			
			end process;
		
		
		--implement moore or mealy logic here
		process (ysfm, data_in) --data_in if required only
		begin	
			case ysfm is 
				when s0 =>
					if data_in = '1' then
						student_id <= "0010"; --"0000"
						current_state <= "0001";
						--current_state <= "0101";
					else
						current_state <= "0101";
						--student_id <= "0000";
					end if;
			
				when s3 =>
					if data_in = '1' then
						student_id <= "0101"; --"0001"
						current_state <= "0000";
						--current_state <= "0000";
					else
						current_state <= "0000";
						--student_id <= "0001";
					end if;
			
				when s7 =>
					if data_in = '1' then
						student_id <= "0000";
						current_state <= "0011";
						--current_state <= "0001";
					else
						current_state <= "0001";
						--student_id <= "0000";
					end if;
			
				when s6 =>
					if data_in = '1' then
						student_id <= "0001";  --"0011"
						current_state <= "0111";
						--current_state <= "0000";
					else
						current_state <= "0000";
						--student_id <= "0011";
					end if;
			
				when s2 =>
					if data_in = '1' then
						student_id <= "0000";
						current_state <= "0110";
						--current_state <= "0011";
					else
						current_state <= "0011";
						--student_id <= "0000";
					end if;
			
				when s4 =>
					if data_in = '1' then
						student_id <= "0011";--"1001"
						current_state <= "0010";
						--current_state <= "0110";
					else
						current_state <= "0110";
						--student_id <= "1001";
					end if;
			
				when s8 =>
					if data_in = '1' then
						student_id <= "0000"; --"0110"
						current_state <= "0100";
						--current_state <= "1001";
					else
						current_state <= "1001";
						--student_id <= "0110";
					end if;
			
				when s5 =>
					if data_in = '1' then
						student_id <= "1001"; --"0010"
						current_state <= "1000";
						--current_state <= "0110";
					else
						current_state <= "0110";
						--student_id <= "0010";
					end if;
			
				when s1 =>
					if data_in = '1' then
						student_id <= "0110"; --"0101"
						current_state <= "0101";
						--current_state <= "0010";
					else
						current_state <= "0010";
						--student_id <= "0101";
					end if;
			
			end case;
			end process;
			end fsm;
	
	
	
		